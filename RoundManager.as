package 
{

	import flash.display.Sprite;
	import flash.events.*;
	import enemies.InitiateEnemies;

	public class RoundManager extends Sprite
	{

		public var currentRound:int;
		public var roundInProgress:Boolean;
		private var enemyTimer:int;
		private var initEnemies:InitiateEnemies;
		private var numberToSend:int;

		public function RoundManager(_initEnemies:InitiateEnemies)
		{
			enemyTimer = 0;
			currentRound = 1;
			initEnemies = _initEnemies;
			// constructor code
			compileRoundsData();
		}
		public function startRound():void
		{
			enemyTimer = 0;
			roundInProgress = true;
			addEventListener(Event.ENTER_FRAME, startEnemies);
		}
		private function stopRound():void
		{
			currentRound++;
			compileRoundsData();
			roundInProgress = false;
			removeEventListener(Event.ENTER_FRAME, startEnemies);
		}
		private function startEnemies(e:Event):void
		{



			if (enemyTimer % 24 == 0)
			{
				initEnemies.createEnemy(currentRound);
				numberToSend--;
			}
			//if (enemyTimer % 24 == 0 && enemyTimer != 0 && !(enemyTimer >= 24*12))
			if (numberToSend == 0)
			{
				stopRound();
			}
			else if (numberToSend < 0)
			{
				trace("RoundManager.numberToSend < 0?");
				enemyTimer++;
			}
			else
			{
				enemyTimer++;
			}
			

		}
		public function sendWave(waveArray:Array)
		{
			initEnemies.customEnemy(waveArray)
		}
		private function compileRoundsData():void
		{
			switch (currentRound)
			{
				case 1 :
					numberToSend = 8;
					break;

				case 2 :
					numberToSend = 8;
					break;

				case 3 :
					numberToSend = 15;
					break;

				case 4 :
					numberToSend = 15;
					break;

				case 5 :
					numberToSend = 15;
					break;

				case 6 :
					numberToSend = 15;
					break;
					
				case 12 :
					numberToSend = 99999;
					
				default:
					numberToSend = 15;
			}
		}
	}

}