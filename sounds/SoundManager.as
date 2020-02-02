package sounds
{

	import flash.display.MovieClip;

	import flash.media.SoundChannel;
	import com.greensock.*
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.events.Event;
	import flash.net.SharedObject;


	public class SoundManager extends MovieClip
	{


		public static var sfxVolume:Number=1;
		private static var queue:LoaderMax;
		private static var sfxs:Array;
		
		private static var currentlyPlaying:String;
		private static var bgSound:SoundChannel;
		public static var bgVolume:Number=1;
		private static var sharedData:SharedObject = SharedObject.getLocal("LocalSave")

		public function SoundManager(Queue:LoaderMax)
		{
			
			sharedData = SharedObject.getLocal("LocalSave")
			sfxVolume = sharedData.data.fxVolume
			if (isNaN(sfxVolume))
			{
				sfxVolume = 1;
			}
			bgVolume = sharedData.data.bgVolume
			if (isNaN(bgVolume))
			{
				bgVolume = 1;
			}
			queue = Queue;
			TweenPlugin.activate([VolumePlugin]);
			sfxs = new Array  ;
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
				var s:SoundTransform = new SoundTransform(bgVolume)
				bgSound.soundTransform = s;
			}
		}
		private static function changeSfxVolume():void
		{
			//Creating local copy in case sfx_complete occurs while changing volumes
			var copySfx:Array = newTheMap(sfxs);
			var trans:SoundTransform = new SoundTransform(sfxVolume);
			for (var i:int=0; i < copySfx.length; i++)
			{
				if (sfxs.indexOf(copySfx[i]) >= 0)
				{
					copySfx[i].soundTransform = trans;
				}
			}
			copySfx=[]
		}

		public static function sfx(fxName:String):SoundChannel
		{
			if (sfxs.length < 29)
			{
			var song:Sound = queue.getContent(fxName);
			var trans:SoundTransform = new SoundTransform(sfxVolume);
			var sound:SoundChannel = song.play(0,0,trans)
			sfxs.push(sound);
			sound.addEventListener(Event.SOUND_COMPLETE, removeSfx);
			}
			return sound;
			
		}
		private static function removeSfx(e:Event):void
		{
			var sfx:* = e.currentTarget;
			sfxs.splice(sfxs.indexOf(sfx),1);
			sfx.removeEventListener(Event.SOUND_COMPLETE, removeSfx)
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
				var sound:SoundChannel = song.play(0,0,trans)
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
		private static function newTheMap(array:Array):Array
		{
			var newArray:Array = new Array  ;
			for (var i:int = 0; i < array.length; i++)
			{
				var content:* = array[i];
				if (content is Array)
				{
					newArray[i] = newTheMap(content);
				}
				else
				{
					newArray[i] = content;
				}
			}
			return newArray;
		}
	}

}