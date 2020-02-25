package towers.Projectiles {
	
	import flash.display.MovieClip;
	import com.greensock.BlitMask
	import flash.events.Event;
	import com.greensock.TweenLite;
	import com.greensock.core.Animation;
	
	public class LightningShot extends Bullet {
		
		private var blitMask:BlitMask
		
		public function LightningShot() {
			blitMask = new BlitMask(flight,-20,flight.y,20,flight.height,true,true,0x00000000,true)
			flight.x = ((Math.random()*60)*-1) - 20
			stop()
			addEventListener(Event.ADDED_TO_STAGE, bMask)
			// constructor code
		}
		private function bMask(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, bMask);
			
			//TweenLite.to(blitMask, 1, {scrollX:-5})
			TL = new TweenLite(flight, 5, {x:120})
			tweenArray.push(TL);
			
			
		}
		override protected function endBlitMask():void
		{
			blitMask.dispose();
			blitMask = null;
		}
	}
	
}
