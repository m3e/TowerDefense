package debuffs
{

	import enemies.Enemy;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class Poison extends Debuff
	{

		private var enemy:Enemy;
		private var sAmount:Number;
		private var sSeconds:Number;
		private var pAmount:Number;
		private var pSeconds:Number;

		private var frames:int;


		public function Poison(_enemy:Enemy, _sAmount:Number,_sSeconds:Number, _pAmount:Number)
		{
			sAmount = _sAmount;
			sSeconds = _sSeconds;
			pAmount = _pAmount;
			enemy = _enemy;
			addEventListener(Event.ENTER_FRAME, debuffTick);
			// constructor code
		}
		private function debuffTick(e:Event):void
		{
			if (enemy != null && frames < sSeconds * 24)
			{
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
				finish();
			}
			frames++;
		}
		private function finish():void
		{
			enemy.poisonSlow = 0;
			enemy.determineMoveSpeed();
			removeEventListener(Event.ENTER_FRAME, debuffTick);
			enemy = null;
		}
	}

}