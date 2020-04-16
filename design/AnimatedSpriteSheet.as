package design
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import common.Commons;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import sounds.SoundManager;
	import flash.media.SoundChannel;


	public class AnimatedSpriteSheet extends MovieClip
	{

		protected var ssArray:Array;
		protected var frameNumber:int = 0;
		public var spriteSize:int;
		private var bmp:Bitmap;
		private var stopLoops:Boolean;

		protected var soundString:String = null;
		protected var tweenIn:Boolean;
		protected var looping:Boolean;
		protected var mergeOverSeconds:Number = 0;
		
		protected var mySC:SoundChannel;
		
		public function AnimatedSpriteSheet(spriteSheetName:String,SpriteSize:int)
		{
			spriteSize = SpriteSize;
			cutSpriteSheet(common.Commons.queue.getContent(spriteSheetName).rawContent);
			addEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
			// constructor code
		}
		private function cutSpriteSheet(spriteSheet:Bitmap):void
		{
			var ssData:BitmapData = spriteSheet.bitmapData;
			var i:int = Math.floor(spriteSheet.width / spriteSize);
			var o:int = Math.floor(spriteSheet.height / spriteSize);
			var rect:Rectangle = new Rectangle(0,0,spriteSize,spriteSize);
			var pt:Point = new Point();
			ssArray = new Array();

			for (var j:int=0; j<o; j++)
			{
				for (var k:int=0; k < i; k++)
				{

					var bd:BitmapData = new BitmapData(spriteSize,spriteSize);

					rect.x = spriteSize * k;
					rect.y = spriteSize * j;
					bd.copyPixels(ssData,rect,pt);
					// cut the frame in a new BitmapData;
					ssArray.push(bd);
				}

			}

		}
		// store the frame;
		private function added(e:Event):void
		{
			if (soundString != null)
			{
				mySC = SoundManager.sfx(soundString,tweenIn,looping,mergeOverSeconds);
			}
			bmp = new Bitmap();
			addChild(bmp);
			removeEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.ENTER_FRAME, eventTimer,false,0,true);
		}
		private function removed(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			SoundManager.stopSfx(mySC,true);
		}
		private function eventTimer(e:Event):void
		{
			if (! ssArray)
			{
				return;
			}

			bmp.bitmapData = ssArray[frameNumber];
			frameNumber++;
			if (frameNumber >= ssArray.length)
			{
				frameNumber = 0;
			}

		}
	}
}