package buffs {
	
	import flash.display.MovieClip;
	import enemies.Enemy;
	import towers.Tower;
	import flash.events.Event;
	import common.Commons;
	
	
	public class HolyEnchant extends MovieClip {
		
		private var sTarget:Tower
		private var amt:Number;
		private var sec:int
		private var frames:int;
		
		public function HolyEnchant(t:Tower,amount:Number,seconds:int) {
			frames = 0;
			sTarget = t;
			amt = amount;
			sec = seconds;
			common.Commons.addSkillsList(this)

			
			
			addEventListener(Event.ADDED_TO_STAGE,added)
			
			// constructor code
		}
		private function added(e:Event):void
		{
			sTarget.tAtkSpdBuff += amt;
			removeEventListener(Event.ADDED_TO_STAGE,added)
			addEventListener(Event.ENTER_FRAME, buffTick);
		}
		public function pausedGame():void
		{
			stop()
			removeEventListener(Event.ENTER_FRAME, buffTick);
		}
		public function resumedGame():void
		{
			play();
			addEventListener(Event.ENTER_FRAME, buffTick);
		}
		private function buffTick(e:Event):void
		{
			if (sTarget != null && frames < sec * 24)
			{
				if (currentFrame == totalFrames)
				{
					visible = false;
				}
				//x = sTarget.x
				//y = sTarget.y
				frames++;
			}
			else
			{
				finish();
			}
		}
		private function finish():void
		{
			if (parent != null && parent.contains(this))
			{
			parent.removeChild(this)
			}
			sTarget.tAtkSpdBuff -= amt;
			common.Commons.removeSkillsList(this)
			removeEventListener(Event.ENTER_FRAME, buffTick);
			sTarget = null;
		}
		
	}
	
}
