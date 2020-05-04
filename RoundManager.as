package {

	import flash.display.Sprite;
	import flash.events.*;
	import enemies.InitiateEnemies;
	import sounds.SoundManager;
	import enemies.Enemy;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import common.Commons;
	import GameScreens.VictoryScreen;
	import enemies.dpsTestEnemy;
	import User.UserProfile;

	public class RoundManager extends Sprite {

		private var enemyTimer: int = 0;
		private var initEnemies: InitiateEnemies;
		private var frameTimer: int;
		private var waveArray: Array;
		private var roundEndBonus: int;
		private var eWave: Array = new Array;
		private var enemyAlive: Array = new Array;
		private var spawnCount: int;
		private var _root: Object;
		public var fiftyOneKills: int = 0;
		private var gameOver: Boolean = false;
		private var dpsTestEnemyCount:int = 0;

		public function RoundManager() {
			_root = Commons.getRoot();
			Commons.currentRound = 1;
			Commons.roundInProgress = false;
			gameOver = false;
			initEnemies = new InitiateEnemies();
		}
		public function customWave(WaveArray: Array): void {
			waveArray = WaveArray;
			startRound(false);
		}
		public function startRound(realRound: Boolean): void {

			enemyAlive = new Array;
			eWave.push(enemyAlive);

			if (realRound == false) {
				Commons.currentRound = waveArray[6]
			}
			if (realRound) {
				//get wave information like amount, frequency, hp, etc.
				waveArray = Commons.roundsList[Commons.currentRound - 1];

				//add end bonus gold to enemyAlive
				roundEndBonus = waveArray[8];
				enemyAlive.push(roundEndBonus);

				//if it's a real round, increase official round number
				Commons.currentRound++;
				
			} else {
				enemyAlive.push(0);
			}
			//give no end of round money for custom waves;
			spawnCount = waveArray[4];
			frameTimer = 0;
			Commons.roundInProgress = true;

			addEventListener(Event.ENTER_FRAME, spawnTimer);
		}
		public function createDmgDummy(): void {
			if (dpsTestEnemyCount < 5 || Commons.devMode == true)
			{
			var dpsDummy: dpsTestEnemy = initEnemies.createDmgDummy();
			dpsDummy.addEventListener(Event.REMOVED_FROM_STAGE, enemyDead);
			dpsTestEnemyCount++
			}
		}
		private function spawnTimer(e: Event): void {
			if (frameTimer % waveArray[5] == 0) {
				var newEnemy: Enemy = initEnemies.customEnemy(waveArray, true);
				newEnemy.addEventListener(Event.REMOVED_FROM_STAGE, enemyDead, false, 0, true);
				enemyAlive.push(newEnemy);
				spawnCount--;
				if (waveArray[6] == 51) {
					var increaseBy: Number = 1.01
					waveArray[0] = waveArray[0] * increaseBy
				}
			}
			if (spawnCount == 0) {
				endWaveSend();
			} else {
				frameTimer++;
			}
		}
		private function endWaveSend(): void {
			waveArray = [];
			frameTimer = 0;
			removeEventListener(Event.ENTER_FRAME, spawnTimer);
		}
		public function pauseGame(): void {
			if (Commons.roundInProgress == true) {
				removeEventListener(Event.ENTER_FRAME, spawnTimer);
			}
		}
		public function resumeGame(): void {
			if (Commons.roundInProgress == true) {
				addEventListener(Event.ENTER_FRAME, spawnTimer);
			}
		}
		private function enemyDead(e: Event): void {
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, enemyDead);
			if (e.currentTarget.killed) {
				if (waveArray[6] == 51) {
					//trace("Fifty one kills");
					fiftyOneKills++;
				}
				_root.changeGold(e.currentTarget.goldValue);
			} else if (e.currentTarget.removeLife) {
				_root.updateLives(1);
			}
			Commons.enemyList.splice(Commons.enemyList.indexOf(e.currentTarget), 1);
			if (e.currentTarget is dpsTestEnemy) {
				dpsTestEnemyCount--;
			}
			for (var i: int = 0; i < eWave.length; i++) {
				if (eWave[i].indexOf(e.currentTarget) != -1) {
					eWave[i].splice(eWave[i].indexOf(e.currentTarget), 1);
					if (eWave[i].length == 1 && spawnCount == 0) {
						_root.changeGold(eWave[i][0]);
						eWave.splice(i, 1);
					}
				}
			}
			if (enemyAlive.length == 1 && spawnCount == 0) {
				Commons.roundInProgress = false;

				if (Commons.currentRound == 51) {
					if (_root.lives > 0) {
						var victoryScreen: VictoryScreen = new VictoryScreen();
						_root.highPriority.addChild(victoryScreen);
						_root.keysEnabled = false;
						victoryScreen.addEventListener(Event.REMOVED_FROM_STAGE, roundFiftyOne);
					}
				}
			}
			if (_root.lives <= 0 && gameOver == false) {
				gameOver = true;
				//trace("_r.lives: ", _root.lives)
				if (fiftyOneKills > 0) {
					dispatchEvent(new Event("fiftyoneWin"));
				} else {
					dispatchEvent(new Event("gameOver"));
				}
			}
		}
		private function roundFiftyOne(e: Event): void {
			_root.keysEnabled = true;
			SoundManager.playSong("round51");
			startRound(true)
		}
		public function endClass(): void {
			initEnemies.endClass();
			endWaveSend();
			_root = null;
			eWave = null;
			initEnemies = null;
			enemyAlive = null;
		}
	}
}