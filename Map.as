package 
{
	import flash.display.MovieClip;
	import com.greensock.TweenLite;

	import assets.maptiles.*;
	import towers.*;
	import flash.utils.Timer;
	import flash.events.*;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import assets.UI.BattleMap.*;
	import design.UI.GameOverWindow;
	import flash.display.Graphics;

	import common.Commons;

	import design.*;

	import enemies.*;
	import flash.text.TextField;
	import flash.display.DisplayObject;
	import towerimg.PsuedoTower;

	import sounds.SoundManager;

	import design.UI.OptionsWindow;
	import towers.skills.TowerSkillManager;
	import flash.filters.GlowFilter;
	import GameScreens.FiftyOneVictoryScreen;
	import User.UserProfile;

	public class Map extends MovieClip
	{
		private var _root:Object;
		private var devMode:Boolean = Commons.devMode;

		//constants
		private var tileSide:int;

		//critical arrays
		private var mapArray:Array;
		private var tileArray:Array;
		private var towerArray:Array;

		//object lists
		private var enemyList:Array;

		//shapes
		private var bottomBar:BottomBar;

		//tower related
		private var towerBeingBuilt:Object;
		private var psuedoTower:PsuedoTower;
		public var mouseclickedTower:Object;
		private var shiftBuildEnabled:Boolean;

		//tower ui
		private var mouseclickedTowerSquare:Shape;
		private var rangeCircle:Shape;
		

		//ui
		private var inputField:InputField;

		//controls
		private var _keyDown:int = 0;
		private var shiftDown:Boolean;
		public var keysEnabled:Boolean;

		//user
		private var cAfford:CantAfford;

		//initEnemy
		private var roundManager:RoundManager;
		public var roundsList:Array;

		//booleans
		public var healthBarOn:Boolean;
		private var finalRoundMode:Boolean;

		private var optionsWindow:OptionsWindow;
		private var pauseBtn:PauseBtn;
		private var gameOverWindow:GameOverWindow;
		private var fiftyoneWins:FiftyOneVictoryScreen;

		private var towerSkillManager:TowerSkillManager;

		public var gold:int;
		public var lives:int;
		private var bmTiles:Sprite = new Sprite  ;
		public var bmTowers:Sprite = new Sprite  ;
		public var bmEnemy:Sprite = new Sprite  ;
		public var bmAboveTowers:Sprite = new Sprite  ;
		public var gameUI:Sprite = new Sprite  ;
		public var highPriority:Sprite = new Sprite  ;

		public function Map()
		{
			enemyList = common.Commons.getEnemyList();
			tileArray = new Array  ;
			towerArray = common.Commons.getTowerArray();
			tileSide = common.Commons.tileSide;
			common.Commons.tileArray = tileArray;
			//1=right 2=down 3=left 4=up
			mapArray = common.Commons.getMapArray();
			roundsList = common.Commons.getRoundsList();
			gold = 100;
			lives = 20;

			for (var row:int=0; row < mapArray.length; row++)
			{

				tileArray[row] = [];
				towerArray[row] = [];

				for (var col:int=0; col < mapArray[0].length; col++)
				{
					tileArray[row][col] = undefined;
					towerArray[row][col] = undefined;
				}
			}

			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code;
		}
		private function added(e:Event):void
		{
			_root = this;
			stage.stageFocusRect = false
			stage.focus = this;
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			SoundManager.setPlaylistIndex("battleMap")
			SoundManager.playNextSongInPlaylist();

			addChild(bmTiles);
			bmTiles.mouseEnabled = false;
			addChild(bmTowers);
			bmTowers.mouseEnabled = false;
			addChild(bmEnemy);
			bmEnemy.mouseEnabled = false;
			addChild(bmAboveTowers);
			bmAboveTowers.mouseEnabled = false;
			//bmAboveTowers.mouseChildren = false;
			addChild(gameUI);
			gameUI.mouseEnabled = false;
			addChild(highPriority);
			highPriority.mouseEnabled = false;



			common.Commons.setRoot(_root);
			cAfford = new CantAfford  ;
			gameUI.addChild(cAfford);
			cAfford.visible = false;
			cAfford.mouseEnabled = false;
			common.Commons.fRate = 24;
			stage.frameRate = 24;

			setupMap();
			//Sets: mapArray
			//Sets: tileArray

			setupTowerSkillManager();

			setupRangeCircle();
			//Creates: rangeCircle shape

			setupTowerSquares();

			setupEnemies();
			//Creates: EnemySpawner (timer), roundManager
			//Requires: mapArray

			setupBottomBar();

			setupKeyboard();
			//Requires: towerBeingBuiltSquare
			//Requires: RangeCircle
			//Requires: psuedoTowers

			setupTileListeners();
			
			if (UserProfile.returnUser == false)
			{
				trace(UserProfile.returnUser);
				bottomBar.helpIcon.openTutorial();
			}
		}
		private function setupTowerSkillManager():void
		{
			towerSkillManager = new TowerSkillManager();
		}
		private function optionsButtonClick(e:MouseEvent):void
		{
			optionsWindow = new OptionsWindow(true);

			highPriority.addChild(optionsWindow);
			pauseGame();

			optionsWindow.addEventListener(Event.REMOVED_FROM_STAGE, optionsWindowClosed);

			optionsWindow.restartButton.addEventListener(MouseEvent.CLICK, restartButtonClicked,false,0,true);
			optionsWindow.backToMap.addEventListener(MouseEvent.CLICK, backToMapClicked,false,0,true);
		}
		private function optionsWindowClosed(e:Event):void
		{
			optionsWindow.removeEventListener(Event.REMOVED_FROM_STAGE, optionsWindowClosed);

			optionsWindow.restartButton.removeEventListener(MouseEvent.CLICK, restartButtonClicked);
			optionsWindow.backToMap.removeEventListener(MouseEvent.CLICK, backToMapClicked);
			optionsWindow.restartButton = null;
			optionsWindow.backToMap = null
			;
			optionsWindow = null;

			enableKeys();
			resumeGame();
		}
		private function pauseGame():void
		{
			common.Commons.pauseGame();
			roundManager.pauseGame();
			keysEnabled = false;
		}
		private function resumeGame():void
		{
			common.Commons.resumeGame();
			roundManager.resumeGame();
			keysEnabled = true;
		}
		private function enableKeys():void
		{
			keysEnabled = true;
		}
		private function setupKeyboard():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
			keysEnabled = true;
		}
		private function keyReleased(e:KeyboardEvent):void
		{

			_keyDown--;
			if (_keyDown < 0 )
			{
				_keyDown = 0;
			}
			else if (_keyDown > 1)
			{
				_keyDown = 1;
			}
			if (shiftDown == true)
			{
				shiftDown = false;
				if (shiftBuildEnabled == true)
				{
					shiftBuildEnabled = false;
					if (keysEnabled == true)
					{
						if (towerBeingBuilt)
						{
							buildTower(towerBeingBuilt);
							removeMouseClickedTower();
						}
					}
				}
			}
		}
		private function keyPressed(e:KeyboardEvent):void
		{
			//Tower selection is handled via MenuManager
			if (_keyDown == 0 && keysEnabled == true)
			{
				_keyDown++;

				switch (e.keyCode)
				{
					case Keyboard.SHIFT :
						shiftDown = true;
						break;

					case Keyboard.Z :
						healthBarToggle();
						break;

					case Keyboard.X :
						if (mouseclickedTower != null)
						{
							sellTower(bottomBar.menuManager.selectedTower);
						}
						break;

					case Keyboard.Q :
						if (towerBeingBuilt != null)
						{
							buildTower(towerBeingBuilt);
						}
						break;

					case Keyboard.W :
						common.Commons.fRate = 24;
						stage.frameRate = common.Commons.fRate;
						break;

					case Keyboard.G :
						if (devMode)
						{
						changeGold(9999);
						}
						break;

					case Keyboard.E :
						common.Commons.fRate = 72;
						stage.frameRate = common.Commons.fRate;
						break;

					case Keyboard.R :
						if (devMode)
						{
							common.Commons.fRate = 1;
							stage.frameRate = common.Commons.fRate;	
						}
						break;

					case Keyboard.U :
						if (devMode)
						{
						inputField.visible = !(inputField.visible);
						}
						break;

					case Keyboard.SPACE :
						startRoundKeyboard();
						break;
				}
				if (inputField != null)
				{
					if (!(inputField.contains(e.target as DisplayObject)) ||  !(e.target is TextField))
					{
						if (bottomBar.menuManager != null)
						{
							bottomBar.menuManager.keyDownHandler(e);
						}
						/*if (mouseclickedTower != null)
						{
						mouseclickedTowerSquare.visible = false;
						mouseclickedTower = null;
						}*/
					}
				}
			}
		}
		public function canAfford(cost:int):Boolean
		{
			var afford:Boolean;
			if (cost <= gold)
			{
				afford = true;
			}
			else
			{
				bottomBar.goldBox._caBox.alpha = 0;
				TweenLite.from(bottomBar.goldBox._caBox,.2,{alpha:1});
			}
			return afford;
		}
		public function changeGold(goldChange:int):void
		{
			gold +=  goldChange;
			bottomBar.goldBox.GoldText.text = gold.toString();
		}
		public function updateLives(subtractedLives:int):void
		{
			lives -=  subtractedLives;
			bottomBar.livesBar.LivesText.text = lives.toString();
		}
		public function getGold():int
		{
			return gold;
		}
		private function healthBarToggle():void
		{
			healthBarOn = !healthBarOn;
			for (var i:int=0; i <enemyList.length; i++)
			{
				enemyList[i].healthBarOnOff();
			}
		}
		private function setupTileListeners():void
		{
			for (var i:int=0; i<tileArray.length; i++)
			{
				for (var o:int=0; o< tileArray[i].length; o++)
				{
					tileArray[i][o].addEventListener(MouseEvent.CLICK, tileClicked);
					tileArray[i][o].addEventListener(MouseEvent.MOUSE_DOWN, tileDown);
					tileArray[i][o].addEventListener(MouseEvent.MOUSE_OVER, hoverOver);
					tileArray[i][o].addEventListener(MouseEvent.MOUSE_OUT, hoverOverOut);
				}
			}
		}
		private function hoverOver(e:MouseEvent):void
		{
			if (towerBeingBuilt != null)
			{
				rangeCircle.visible = true;
				rangeCircle.x = e.currentTarget.x + (tileSide * .5);
				rangeCircle.y = e.currentTarget.y + (tileSide * .5);


				psuedoTower.visible = true;

				psuedoTower.x = e.currentTarget.x;
				psuedoTower.y = e.currentTarget.y;
			}
		}
		private function hoverOverOut(e:MouseEvent):void
		{
			if (psuedoTower != null)
			{
				psuedoTower.visible = false;
			}
			if (mouseclickedTower == null)
			{
				rangeCircle.visible = false;
			}
		}
		private function setupBottomBar():void
		{
			bottomBar = new BottomBar();
			bottomBar.y = 416;
			bottomBar.startRoundButton.addEventListener(MouseEvent.CLICK, startRoundMouse);
			bottomBar.dpsDummyButton.addEventListener(MouseEvent.CLICK, sendDpsDummy);
			bottomBar.optionsButton.addEventListener(MouseEvent.CLICK, optionsButtonClick);
			bottomBar.goldBox.GoldText.text = gold.toString();
			bottomBar.goldBox._caBox.alpha = 0;
			bottomBar.livesBar.LivesText.text = lives.toString();
			gameUI.addChild(bottomBar);
		}
		private function startRound():void
		{
			if (Commons.roundInProgress == false)
			{
				roundManager.startRound(true);
				bottomBar.roundBar.updateRoundList();
			}
		}
		private function sendCustomWave(e:MouseEvent)
		{
			if (Commons.roundInProgress == false)
			{
				var waveArray:Array = new Array  ;
				var hp:int = Number(inputField.hpField.text);
				var ms:int = Number(inputField.msField.text);
				var goldA:int = Number(inputField.goldField.text);
				var armor:int = Number(inputField.armorField.text);
				var numSend:int = Number(inputField.numField.text);
				var freq:int = Number(inputField.freqField.text);
				var roundNumber:int = Number(inputField.roundField.text);
				var armorType:String = "pure";
				var eFrame:int = 11;
				waveArray = [hp,ms,goldA,armor,numSend,freq,roundNumber,armorType,0,"Mikel"];
				//maxHp,maxMoveSpeed,goldValue,maxArmor,numberOfEnemies,freq,roundNumber,armorType,endBonus,eName,s1,s2,s3,bmpData];
				roundManager.customWave(waveArray);
			}
		}
		private function startRoundKeyboard():void
		{
			startRound();
		}
		private function startRoundMouse(e:Event):void
		{
			startRound();
		}
		private function sendDpsDummy(e:Event):void
		{
			if (Commons.roundInProgress == false)
			{
				roundManager.createDmgDummy();
			}
		}
		private function setupTowerSquares():void
		{
			//Upgradeable tower square
			mouseclickedTowerSquare = new Shape ();
			mouseclickedTowerSquare.graphics.lineStyle(2,0x665544);
			mouseclickedTowerSquare.graphics.beginFill(0x665544,0);
			mouseclickedTowerSquare.graphics.drawRect(0,0,tileSide,tileSide);
			mouseclickedTowerSquare.graphics.endFill();
			mouseclickedTowerSquare.visible = false;
			bmAboveTowers.addChild(mouseclickedTowerSquare );

			inputField = new InputField();
			inputField.x = 692;
			inputField.y = 8;
			inputField.sendWave.addEventListener(MouseEvent.CLICK, sendCustomWave);
			inputField.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownAction);
			inputField.addEventListener(MouseEvent.MOUSE_UP, mouseUpAction);
			gameUI.addChild(inputField);
			inputField.visible = false;

		}
		private function mouseDownAction(e:MouseEvent):void
		{
			inputField.startDrag();
		}
		private function mouseUpAction(e:MouseEvent):void
		{
			inputField.stopDrag();
		}
		public function buildTower(tower:Object):void
		{
			//If there was a tower already selected and it does not equal the one you clicked
			if (towerBeingBuilt != tower)
			{
				//towerBeingBuilt = tower sent via constructor
				towerBeingBuilt = tower;

				if (psuedoTower != null && bmTowers.contains(psuedoTower))
				{
					bmTowers.removeChild(psuedoTower);
					psuedoTower = null;
				}
				psuedoTower = new PsuedoTower(tower.towerReference,true);
				psuedoTower.mouseEnabled = false;
				bmTowers.addChild(psuedoTower);
				psuedoTower.visible = false;
				rangeCircle.visible = false;

				psuedoTower.x = Math.floor(mouseX / tileSide) * tileSide;
				psuedoTower.y = Math.floor(mouseY / tileSide) * tileSide
				;
				psuedoTower.width = tileSide;
				psuedoTower.height = tileSide
				;
				rangeCircle.width = psuedoTower.tRange * 2;
				rangeCircle.height = psuedoTower.tRange * 2;
				rangeCircle.x = psuedoTower.x + (tileSide * .5);
				rangeCircle.y = psuedoTower.y + (tileSide * .5);

				//towerBeingBuiltSquare.visible = true;
				if (psuedoTower.x > 0 && psuedoTower.y > 0 && psuedoTower.x <= (mapArray[0].length * tileSide) - psuedoTower.width && psuedoTower.y <= (mapArray.length * tileSide) - psuedoTower.height)
				{

					psuedoTower.visible = true;
					rangeCircle.visible = true;
				}
			}
			else
			{
				//Tower selected is same as tower in memory
				towerBeingBuilt = null;
				bottomBar.menuManager.hideTowerBeingBuiltSquare();
				bmTowers.removeChild(psuedoTower);
				psuedoTower = null;
				rangeCircle.visible = false;
			}
		}
		public function sellTower(tower:Object)
		{
			if (mouseclickedTower != null)
			{
				
				var g:int = tower.totalCost
				g = g * .75
				changeGold(g);

				mouseclickedTower.destroyTower();

				removeMouseClickedTower();

				tileArray[tower.y / tileSide][tower.x / tileSide].occupied = false;

				bottomBar.menuManager.returnToDefaultMenu();
			}
		}
		private function setupRangeCircle():void
		{
			var glow:GlowFilter = new GlowFilter(0x00CCFF,1,6,6,2);
			rangeCircle = new Shape();
			rangeCircle.graphics.lineStyle(1,0xFFFFFF,1,false,"none");
			rangeCircle.graphics.drawCircle(0,0,100);
			rangeCircle.visible = false;
			rangeCircle.filters = [glow];
			bmAboveTowers.addChild(rangeCircle);

			
			
		}
		private function setupEnemies():void
		{
			roundManager = new RoundManager();
			roundManager.addEventListener("gameOver",gameOver);
			roundManager.addEventListener("fiftyoneWin",fiftyoneWin);
		}
		private function fiftyoneWin(e:Event):void
		{
			fiftyoneWins = new FiftyOneVictoryScreen(roundManager.fiftyOneKills);
			fiftyoneWins.x = (stage.width / 2) - (fiftyoneWins.width / 2)
			fiftyoneWins.y = 50
			finalRoundMode = true;
			
			highPriority.addChild(fiftyoneWins);
			pauseGame();
			
			fiftyoneWins.restartButton.addEventListener(MouseEvent.CLICK, restartButtonClicked,false,0,true);
			fiftyoneWins.backToMap.addEventListener(MouseEvent.CLICK, backToMapClicked,false,0,true);
		}
		private function gameOver(e:Event):void
		{
			gameOverWindow = new GameOverWindow();
			keysEnabled = false;

			highPriority.addChild(gameOverWindow);
			pauseGame();
			//gameOverWindow.addEventListener(Event.REMOVED_FROM_STAGE, gameOverWindowClosed);

			gameOverWindow.restartButton.addEventListener(MouseEvent.CLICK, restartButtonClicked,false,0,true);
			gameOverWindow.backToMap.addEventListener(MouseEvent.CLICK, backToMapClicked,false,0,true);
		}
		private function gameOverWindowClosed(e:Event):void
		{
			//gameOverWindow.removeEventListener(Event.REMOVED_FROM_STAGE, gameOverWindowClosed);

			gameOverWindow.restartButton.removeEventListener(MouseEvent.CLICK, restartButtonClicked);
			gameOverWindow.backToMap.removeEventListener(MouseEvent.CLICK, backToMapClicked);
			//gameOverWindow.restartButton = null;
			//gameOverWindow.backToMap = null;

			gameOverWindow = null;
			resumeGame();
		}
		private function restartButtonClicked(e:MouseEvent):void
		{
			endClass();
			dispatchEvent(new Event("restart",true));
			parent.removeChild(this);
		}
		private function backToMapClicked(e:MouseEvent):void
		{
			endClass();
			dispatchEvent(new Event("backtomap",true));
			parent.removeChild(this);
		}
		private function setupMap():void
		{
			var tile:MovieClip;
			for (var i:int=0; i < mapArray.length; i++)
			{
				for (var o:int=0; o < mapArray[i].length; o++)
				{
					switch (mapArray[i][o])
					{
						case 0 :
							tile = new Grass();
							break;

						case 1 :
						case 2 :
						case 3 :
						case 4 :
						case 9 :
							tile = new Dirt();
							tile.occupied = true;
							break;
					}
					bmTiles.addChild(tile);
					tile.x = o * tileSide;
					tile.y = i * tileSide;
					tileArray[i][o] = tile;
				}
			}
		}
		private function tileDown(e:MouseEvent):void
		{
			if (mouseclickedTower != null)
			{
				removeMouseClickedTower();
			}
			else if (towerBeingBuilt == null)
			{
				var i:int = (Math.random()*5)+1;
				var dirtName:String = "dirt" + i;
				SoundManager.sfx(dirtName);
			}
		}
		private function tileClicked(e:MouseEvent):void
		{
			if (e.currentTarget.occupied == false && psuedoTower != null)
			{
				addTowerToMap(e.currentTarget.x,e.currentTarget.y,Class(psuedoTower.towerReference));
			}
		}
		private function addTowerToMap(towerX,towerY,TowerReference:Class):void
		{
			var klasa:Class = TowerReference;
			var newTower:Tower = new klasa(towerSkillManager);//creates new tower
			klasa = null;
			if (canAfford(newTower.tCost))
			{
				changeGold(-newTower.tCost);

				newTower.enemyList = enemyList;
				newTower.towerArray = towerArray;
				newTower.x = towerX;
				newTower.y = towerY;

				common.Commons.addTowerList(newTower);

				towerArray[newTower.y / tileSide][newTower.x / tileSide] = newTower;

				bmTowers.addChild(newTower);
				SoundManager.sfx("buildtower");

				newTower.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				newTower.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				newTower.addEventListener(MouseEvent.MOUSE_DOWN, towerMapClicked);
				newTower.addEventListener(Event.REMOVED_FROM_STAGE, towerRemoved);

				tileArray[newTower.y / tileSide][newTower.x / tileSide].occupied = true;

				if (mouseclickedTower != null)
				{
					removeMouseClickedTower();
				}
				else
				{
					if (_keyDown > 0 && shiftDown == true)
					{
						shiftBuildEnabled = true;
					}
					else
					{
						buildTower(towerBeingBuilt);
						removeMouseClickedTower();
					}
				}
			}
			else
			{
				newTower.destroyTower();
				cAfford.visible = true;
				cAfford.alpha = 0;
				TweenLite.from(cAfford, 1.5, {alpha:1,onStart:startTween,onComplete:endTween});
				newTower = null;
			}
		}
		private function startTween():void
		{
			cAfford.x = mouseX;
			cAfford.y = mouseY;
		}
		private function endTween():void
		{
			cAfford.visible = false;
		}
		public function upgradeTower(tower:PsuedoTower):void
		{
			var klasa:Class;
			var testTower:Tower;

			if (mouseclickedTower != null)
			{
				klasa = Class(getDefinitionByName(getQualifiedClassName(tower.towerReference)));
			}
			if (klasa is Class)
			{
				testTower = new klasa(towerSkillManager);
				if (canAfford(testTower.tCost))
				{
					mouseclickedTower.destroyTower();

					addTowerToMap(mouseclickedTower.x,mouseclickedTower.y,klasa);

					removeMouseClickedTower();
				}
				testTower.destroyTower();
				klasa = null;
			}
		}
		private function onMouseOver(e:Event):void
		{
			if (psuedoTower != null)
			{
				psuedoTower.visible = false;
			}
		}
		private function onMouseOut(e:Event):void
		{
			if (towerBeingBuilt != null)
			{
				rangeCircle.width = towerBeingBuilt.tRange * 2;
				rangeCircle.height = towerBeingBuilt.tRange * 2;
			}
		}
		private function towerMapClicked(e:MouseEvent):void
		{
			if (towerBeingBuilt != null)
			{
				buildTower(towerBeingBuilt);
			}
			if (mouseclickedTower != e.currentTarget)
			{
				mouseclickedTower = e.currentTarget;


				mouseclickedTowerSquare.visible = true;
				mouseclickedTowerSquare.x = mouseclickedTower.x;
				mouseclickedTowerSquare.y = mouseclickedTower.y;

				rangeCircle.visible = true;
				rangeCircle.width = e.currentTarget.tRange * 2;
				rangeCircle.height = e.currentTarget.tRange * 2;
				rangeCircle.x = e.currentTarget.x + (tileSide * .5);
				rangeCircle.y = e.currentTarget.y + (tileSide * .5);

				bottomBar.middleInfo.updateText(mouseclickedTower);
				bottomBar.menuManager.towerMapClicked(e);
			}
			else
			{
				removeMouseClickedTower();
			}
		}
		private function removeMouseClickedTower():void
		{
			bottomBar.menuManager.returnToDefaultMenu();
			bottomBar.middleInfo.updateText(undefined);
			mouseclickedTower = null;
			mouseclickedTowerSquare.visible = false;
			rangeCircle.visible = false;
		}
		private function towerRemoved(e:Event):void
		{
			towerArray[e.currentTarget.y / tileSide][e.currentTarget.x / tileSide] = undefined;
			common.Commons.removeTowerList(e.currentTarget);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_DOWN, towerMapClicked);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, towerRemoved);
		}
		private function removeMap():void
		{
			for (var i:int=0; i < tileArray.length; i++)
			{
				for (var o:int=0; o < tileArray[i].length; o++)
				{
					bmTiles.removeChild(tileArray[i][o]);
					tileArray[i][o] = null;
				}
			}
			tileArray = [];
		}
		private function endClass():void
		{
			common.Commons.endGame();

			roundManager.endClass();
			roundsList = [];

			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyReleased);

			bottomBar.menuManager.endClass();
			bottomBar.startRoundButton.removeEventListener(MouseEvent.CLICK, startRoundMouse);
			bottomBar.dpsDummyButton.removeEventListener(MouseEvent.CLICK, sendDpsDummy);
			bottomBar.optionsButton.removeEventListener(MouseEvent.CLICK, optionsButtonClick);
			bottomBar.roundBar.endClass();
			gameUI.removeChild(bottomBar);
			bottomBar = null;

			bmAboveTowers.removeChild(mouseclickedTowerSquare );
			mouseclickedTowerSquare = null;

			gameUI.removeChild(inputField);
			inputField = null;

			bmAboveTowers.removeChild(rangeCircle);
			rangeCircle = null;

			gameUI.removeChild(cAfford);
			cAfford = null;

			mouseclickedTower = null;
			psuedoTower = null;
			towerBeingBuilt = null;



			for (var i:int=0; i<tileArray.length; i++)
			{
				for (var o:int=0; o< tileArray[i].length; o++)
				{
					tileArray[i][o].removeEventListener(MouseEvent.CLICK, tileClicked);
					tileArray[i][o].removeEventListener(MouseEvent.MOUSE_DOWN, tileDown);
					tileArray[i][o].removeEventListener(MouseEvent.MOUSE_OVER, hoverOver);
					tileArray[i][o].removeEventListener(MouseEvent.MOUSE_OUT, hoverOverOut);
				}
			}
			removeMap();

			trace("bmTiles: ", bmTiles.numChildren, "bmTowers: ", bmTowers.numChildren, "bmEnemy: ", bmEnemy.numChildren, "bmAboveTowers: ", bmAboveTowers.numChildren, "gameUI: ", gameUI.numChildren, "highPriority: ", highPriority.numChildren);
			bmTiles = null;
			bmTowers = null;
			bmEnemy = null;
			bmAboveTowers = null;
			gameUI = null;
			highPriority = null;

			tileArray = [];
			enemyList = [];
			mapArray = [];
		}
	}
}