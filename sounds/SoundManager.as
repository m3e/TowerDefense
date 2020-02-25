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

		private static var arrowShot:int = 0;
		private static var swordHit:int = 0;
		private static var flame:int = 0;

		private static var currentlyPlaying:String;
		private static var bgSound:SoundChannel;
		public static var bgVolume:Number = 1;
		private static var sharedData:SharedObject = SharedObject.getLocal("LocalSave");
		private static var soundsArray:Array = new Array  ;

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
		}
		private static function setSoundsArray():void
		{
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
			 ]
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
			return a;
		};
		public static function sfx(fxName:String):SoundChannel
		{
			var a:Array = getSoundsArray(fxName);
			if (a.length > 0)
			{
				var numPlay:int = a[1];
				var limit:int = a[2];
			}
			if (a.length == 0 || (sfxs.length < 29 && numPlay < limit && (fxName != "default" && fxName != null)))
			{
				var song:Sound = queue.getContent(fxName);
				if (a.length > 0)
				{
					a[1]++;
				}
				var p:Number = 0;
				if (a[3] == true)
				{
					p = Math.random()*(2*a[4])-a[4];
				}
				var trans:SoundTransform = new SoundTransform(sfxVolume,p);
				var sound:SoundChannel = song.play(0,0,trans);
				sfxs.push([sound,fxName]);
				sound.addEventListener(Event.SOUND_COMPLETE, removeSfx);
			}
			return sound;
		}
		private static function removeSfx(e:Event):void
		{
			var sfx:* = e.currentTarget;
			sfx.removeEventListener(Event.SOUND_COMPLETE, removeSfx);
			for (var i:int=0; i < sfxs.length; i++)
			{
				if (sfxs[i][0] == sfx)
				{
					var a:Array = getSoundsArray(sfxs[i][1]);
					a[1]--;

					sfxs.splice(i,1);
					break;
				}
			}
			sfx = null;
		}
		public static function bgfx(fxName:String):void
		{
			if (fxName != currentlyPlaying)
			{
				if (currentlyPlaying != null)
				{
					bgSound.stop();
				}
				var song:Sound = queue.getContent(fxName);
				var trans:SoundTransform = new SoundTransform(bgVolume);
				var sound:SoundChannel = song.play(0,0,trans);
				currentlyPlaying = fxName;
				bgSound = sound;
				/*var song:MP3Loader = queue.getLoader(fxName);
				song.volume = musicVolume;
				currentPlay = fxName;
				switch (fxName)
				{
				case "intro" :
				song.gotoSoundTime(1.5);
				
				TweenLite.from(song,3,{volume:0,ease:Circ.easeIn});
				break;
				
				case "gameMap" :
				song.gotoSoundTime(5);
				
				TweenLite.from(song,5,{volume:0});
				break;
				
				case "battle" :
				song.gotoSoundTime(3);
				
				TweenLite.from(song,8,{volume:0,ease:Circ.easeIn});
				break;
				}
				song.playSound();*/
			}
		}
	}
}