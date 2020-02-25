package debuffs
{

	import enemies.Enemy;
	import flash.events.Event;
	import flash.display.MovieClip;
	import common.Commons;
	
	public class Poison extends MovieClip
	{

		private var enemy:Enemy;
		private var sAmount:Number;
		private var sSeconds:Number;
		private var pAmount:Number;

		private var frames:int;
		
		private var clipPlaying:Boolean;


		public function Poison(_enemy:Enemy, _sAmount:Number,_pAmount:Number, _sSeconds:Number)
		{
			sAmount = _sAmount;
			sSeconds = _sSeconds;
			pAmount = _pAmount;
			enemy = _enemy;
			common.Commons.addSkillsList(this)
			stop();
			addEventListener(Event.ENTER_FRAME, debuffTick);
			// constructor code
		}
		public function pausedGame():void
		{
			removeEventListener(Event.ENTER_FRAME, debuffTick);
		}
		public function resumedGame():void
		{
			addEventListener(Event.ENTER_FRAME, debuffTick);
		}
		private function debuffTick(e:Event):void
		{
			if (enemy != null && frames < sSeconds * 24)
			{
				if (enemy.poisoned == false)
				{
					enemy.poisoned = true;
					enemy.addChild(this);
					clipPlaying = true;
					play()
				}
				if (sAmount > enemy.poisonSlow)
				{
					enemy.poisonSlow = sAmount;
					enemy.determineMoveSpeed();
				}
				else
				{
					
				}
				if (frames % 12 == 0 && enemy._root != null)
				{
					enemy.takeDmg(pAmount * .5,"earth");
				}
			}
			else
			{
				if (enemy == null)
				{trace("Enemy null in Poison");}
				finish();
			}
			frames++;
		}
		private function finish():void
		{
			
			if (clipPlaying)
			{
				stop()
				clipPlaying = false;
				enemy.removeChild(this)
				stop()
			}
			enemy.poisoned = false;
			common.Commons.removeSkillsList(this)
			enemy.poisonSlow = 0;
			enemy.determineMoveSpeed();
			removeEventListener(Event.ENTER_FRAME, debuffTick);
			enemy = null;
		}
	}

}