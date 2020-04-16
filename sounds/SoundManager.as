package sounds
{

	import flash.display.MovieClip;

	import flash.media.SoundChannel;
	import com.greensock.*;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.events.Event;
	import flash.net.SharedObject;
	import common.Commons;


	public class SoundManager extends MovieClip
	{


		public static var sfxVolume:Number = 1;
		private static var queue:LoaderMax;
		private static var sfxs:Array = new Array  ;

		private static var currentlyPlaying:String;
		private static var bgSound:SoundChannel;
		public static var bgVolume:Number = 1;
		private static var sharedData:SharedObject = SharedObject.getLocal("LocalSave");
		private static var soundsArray:Array = new Array  ;
		private static var mergeLoopsArray:Array = new Array  ;
		private static var loopsArray:Array = new Array  ;

		public function SoundManager(Queue:LoaderMax)
		{

			sharedData = SharedObject.getLocal("LocalSave");
			sfxVolume = sharedData.data.fxVolume;
			if (isNaN(sfxVolume))
			{
				sfxVolume = 1;
			}
			bgVolume = sharedData.data.bgVolume;
			if (isNaN(bgVolume))
			{
				bgVolume = 1;
			}
			queue = Queue;
			TweenPlugin.activate([VolumePlugin]);
			setSoundsArray();
			addEventListener(Event.ENTER_FRAME, frameEvent);
		}
		private static function setSoundsArray():void
		{
			//name,currentPlaying,limit,pan?,howmuch?
			soundsArray =
			[
			 ["default",0,29,false],
			 ["flame",0,8,true,.2],
			 ["zapsound",0,5,true,.4],
			 ["swordhit",0,3,true,.3],
			 ["arrowshot",0,5,true,.6],
			 ["cannonfire",0,6,true,.75],
			 ["buildtower",0,2,true,.1],
			 ["icehit",0,3,true,.4],
			 ["bulletshot",0,4,true,.2],
			 ["lavasplash",0,4,true,.4],
			 ["torchSfx",0,4,false],
			 ];
		}
		public static function setSfxVolume(SfxVolume:Number):void
		{
			sfxVolume = SfxVolume;
			changeSfxVolume();
		}
		public static function setMusicVolume(MusicVolume:Number):void
		{
			bgVolume = MusicVolume;

			if (currentlyPlaying != null)
			{
				//var song:MP3Loader = queue.getLoader(currentlyPlaying);
				//TweenLite.to(song,.5,{volume:musicVolume});
				var s:SoundTransform = new SoundTransform(bgVolume);
				bgSound.soundTransform = s;
			}
		}
		private static function changeSfxVolume():void
		{
			//Creating local copy in case sfx_complete occurs while changing volumes
			var copySfx:Array = common.Commons.newTheMap(sfxs);
			if (copySfx.length > 0)
			{
				var trans:SoundTransform = new SoundTransform(sfxVolume);
				for (var i:int=0; i < copySfx.length; i++)
				{
					copySfx[i][0].soundTransform = trans;
				}
			}
			copySfx = [];
		}
		private static function getSoundsArray(fxName:String):Array
		{
			var a:Array = [];
			for (var i:int=0; i < soundsArray.length; i++)
			{
				if (soundsArray[i][0] == fxName)
				{
					a = soundsArray[i];
					break;
				}
			}
			if (a == [])
			{
				trace("getSoundsArray == null.  fxName: ",fxName)
				trace("soundsArray: ",soundsArray);
			}
			return a;
		}
		public static function sfx(fxName:String,tweenIn:Boolean = false,looping:Boolean = false,mergeOverSeconds:Number = 0,soundParent:SoundChannel = null):SoundChannel
		{
			var a:Array = getSoundsArray(fxName);
			//section that controls available sound channels
			if (a.length > 0)
			{
				var numPlay:int = a[1];
				var limit:int = a[2];
			}
			//...
			if (a.length == 0 || (sfxs.length < 26 && numPlay < limit && (fxName != "default" && fxName != null)))
			{
				var song:Sound = queue.getContent(fxName);

				if (a.length > 0)
				{
					a[1]++;
				}
				var p:Number = 0;
				if (a[3] == true)
				{
					p = Math.random() * (2 * a[4]) - a[4];
				}
				var trans:SoundTransform = new SoundTransform(sfxVolume,p);
				var sound:SoundChannel = song.play(0,0,trans);
				if (tweenIn == true)
				{
					TweenLite.from(sound, 1, {volume:0});
				}
				
				var sArray:Array = [sound,fxName,tweenIn,looping,mergeOverSeconds,song,soundParent];
				sfxs.push(sArray);
				
				if (mergeOverSeconds > 0)
				{
					if (sArray[6] == null)
					{
						sArray[6] = sound
					}
					mergeLoopsArray.push(sArray);
				}
				if (sound == null)
				{
					trace("sfx null: ",song,fxName)
					trace("numPlay, limit: ",numPlay,limit,"sfxs.length: ", sfxs.length)
					trace("sounds/trans: ",sound, trans)
					trace("mla: ",mergeLoopsArray)
					trace("loopsArray");
					trace("soundsarray:");
					for (var qp:int=0; qp < soundsArray.length; qp++)
					{
						trace(soundsArray[qp])
					}
				}
				sound.addEventListener(Event.SOUND_COMPLETE, removeSfx);

			}
			return sound;
		}
		private function frameEvent(e:Event):void
		{
			for (var i:int =0; i < mergeLoopsArray.length; i++)
			{
				if (mergeLoopsArray[i][0].position >= mergeLoopsArray[i][5].length - (mergeLoopsArray[i][4] * 1000))
				{
					var fxName:String = sfxs[i][1];
					var tweenIn:Boolean = sfxs[i][2];
					var looping:Boolean = sfxs[i][3];
					var mergeOverSeconds:Number = sfxs[i][4];
					var soundParent:SoundChannel = sfxs[i][6]
					sfx(fxName,tweenIn,looping,mergeOverSeconds,soundParent);
					mergeLoopsArray.splice(i,1);
					i--;
				}
			}
		}
		public static function stopSfx(targetSfx:SoundChannel,easeOut:Boolean = false):void
		{
			var soundsToStop:Array = new Array  ;
			for (var i:int=0; i < sfxs.length; i++)
			{
				if (sfxs[i][0] == targetSfx)
				{
					soundsToStop.push(sfxs[i]);
					
					break;
				}
			}
			for (var k:int=0; k < mergeLoopsArray.length; k++)
			{
				if (mergeLoopsArray[k][6] != null && mergeLoopsArray[k][6] == targetSfx)
				{
					soundsToStop.push(mergeLoopsArray[k]);
					mergeLoopsArray.splice(k,1);
					k--;
				}
			}
			var newE:Event = new Event(Event.SOUND_COMPLETE);
			for (var p:int=0; p < soundsToStop.length; p++)
			{
				soundsToStop[p][3] = false;
			}
			for (var q:int=0; q < soundsToStop.length; q++)
			{
				TweenLite.to(soundsToStop[q][0],1,{volume:0, onComplete:tweenToEnd, onCompleteParams:[soundsToStop[q][0]]})
				soundsToStop[q][0].dispatchEvent(newE);
			}
		}
		private static function tweenToEnd(sc:SoundChannel):void
		{
			sc.stop();
		}
		public static function removeSfx(e:Event):void
		{
			var eventSoundChannel:* = e.currentTarget;
			eventSoundChannel.removeEventListener(Event.SOUND_COMPLETE, removeSfx);
			for (var i:int=0; i < sfxs.length; i++)
			{
				if (sfxs[i][0] == eventSoundChannel)
				{

					var fxName:String = sfxs[i][1];
					var tweenIn:Boolean = sfxs[i][2];
					var looping:Boolean = sfxs[i][3];
					var mergeOverSeconds:Number = sfxs[i][4];
					var soundParent:SoundChannel = sfxs[i][6];

					var a:Array = getSoundsArray(sfxs[i][1]);
					a[1]--;

					if (looping == true && mergeOverSeconds == 0)
					{
						sfx(fxName,tweenIn,looping,mergeOverSeconds,soundParent);
					}
					sfxs.splice(i,1);
					break;
				}
			}
			eventSoundChannel = null;
		}
		private static function removeBgfx(e:Event):void
		{
			endBgfx();
		}
		private static function endBgfx():void
		{
			TweenLite.to(bgSound,2,{volume:0, onComplete:tweenToEnd, onCompleteParams:[bgSound]})
			bgSound.removeEventListener(Event.SOUND_COMPLETE, removeBgfx);
			currentlyPlaying == null;
		}
		public static function bgfx(bgName:String):void
		{
			if (bgName != currentlyPlaying)
			{
				if (currentlyPlaying != null)
				{
					endBgfx();
				}
				var song:Sound = queue.getContent(bgName);
				var trans:SoundTransform = new SoundTransform(bgVolume);
				var sound:SoundChannel = song.play(0,0,trans);
				TweenLite.from(sound,3,{volume:0,ease:Linear.ease})
				sound.addEventListener(Event.SOUND_COMPLETE, removeBgfx);
				currentlyPlaying = bgName;
				bgSound = sound;
			}
		}
	}
}