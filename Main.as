package  {
	import flash.display.MovieClip;
	import com.greensock.loading.*;
	import com.greensock.events.LoaderEvent;	
	import sounds.SoundManager;
	
	public class Main extends MovieClip{

		private var soundManager:SoundManager;
		private var queue:LoaderMax;
		
		public function Main() {
			queue = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete: completeHandler});
			
			
			/*
			queue.append(new MP3Loader("https://dl.dropboxusercontent.com/s/fkdlcr3e9ge5krb/buttonclick.mp3", {name:"clickbutton", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("https://dl.dropboxusercontent.com/s/oyfhcudrxqvpil4/shblock.mp3", {name:"shieldblock", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("https://dl.dropboxusercontent.com/s/wykubut91hcocgq/swhit.mp3", {name:"swordhit", volume:1, autoPlay:false, estimatedBytes: 2000}));
			*/
			
			queue.append(new MP3Loader("sounds/sfx/buttonclick.mp3", {name:"clickbutton", volume:1, autoPlay:false, estimatedBytes: 2000}));
			
			queue.append(new MP3Loader("sounds/sfx/fire.mp3", {name:"flame", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/shieldBlock.mp3", {name:"shieldblock", volume:1, autoPlay:false, estimatedBytes: 2000}));
			queue.append(new MP3Loader("sounds/sfx/swordStrike.mp3", {name:"swordhit", volume:1, autoPlay:false, estimatedBytes: 50000}));
			queue.append(new MP3Loader("sounds/sfx/arrowShot.mp3", {name:"arrowShot", volume:1, autoPlay:false, estimatedBytes: 50000}));
			
			
			queue.load();
			// constructor code
		}
		private function progressHandler(e:LoaderEvent):void
		{
			
		}
		private function completeHandler(e:LoaderEvent):void
		{
			soundManager = new SoundManager(queue);
			var map:Map = new Map();
			addChild(map);
		}

	}
	
}
