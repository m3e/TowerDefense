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

	import common.Commons;

	import design.*;

	import enemies.*;
	import flash.text.TextField;
	import flash.display.DisplayObject;
	import towerimg.PsuedoTower;

	import sounds.SoundManager;

	import design.UI.OptionsButton;
	import design.UI.OptionsWindow;
	import towers.skills.TowerSkillManager;


	public class Map extends MovieClip
	{

		private var menuManager:MenuManager;
		private var middleInfo:MiddleInfoContent;
		//root
		private var _root:Object;

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
		private var startRoundButton:StartRoundButton;
		private var dpsDummyButton:DpsDummyButton;

		//tower related
		private var towerBeingBuilt:Object;
		private var psuedoTower:Object;
		private var mouseclickedTower:Object;
		private var shiftBuildEnabled:Boolean;

		//tower ui
		private var mouseclickedTowerSquare:Shape;
		private var rangeCircle:Shape;

		//ui
		private var inputField:InputField;
		private var roundBar:RoundBar;

		//controls
		private var _keyDown:int = 0;
		private var shiftDown:Boolean;
		private var keysEnabled:Boolean;

		//user
		private var userInfo:UserInfo;
		private var cAfford:CantAfford;

		//initEnemy
		private var initEnemies:InitiateEnemies;
		private var roundManager:RoundManager;
		public var roundsList:Array;

		//booleans
		private var healthBarOn:Boolean;

		private var optionsButton:OptionsButton;
		private var optionsWindow:OptionsWindow;
		private var fastForward:FastForward;
		private var normalSpeed:NormalSpeed;
		private var pauseBtn:PauseBtn;
		private var gameOverWindow:GameOverWindow;

		private var towerSkillManager:TowerSkillManager;

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
			common.Commons.setRoot(_root);
			cAfford = new CantAfford  ;
			addChild(cAfford);
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

			setupUser();
			//Creates: userInfo

			setupEnemies();
			//Creates: EnemySpawner (timer)
			//Requires: mapArray

			setupBottomBar();
			//requires initEnemies for buttons

			setupBottomBarContent();

			setupKeyboard();
			//Requires: towerBeingBuiltSquare
			//Requires: RangeCircle
			//Requires: psuedoTowers

			setupTileListeners();

			setChildIndex(userInfo,numChildren-1);
		}
		private function setupTowerSkillManager():void
		{
			towerSkillManager = new TowerSkillManager();
		}
		private function setupBottomBarContent():void
		{
			roundBar = new RoundBar();
			roundBar.y = 416;
			_root.addChild(roundBar);

			menuManager = new MenuManager();
			menuManager.x = 677;
			menuManager.y = 423;
			_root.addChild(menuManager);

			middleInfo = new MiddleInfoContent();
			middleInfo.x = 333;
			middleInfo.y = 431;
			_root.addChild(middleInfo);

			optionsButton = new OptionsButton();
			optionsButton.scaleX = .5;
			optionsButton.scaleY = .5;
			optionsButton.x = 298;
			optionsButton.y = 440;
			_root.addChild(optionsButton);
			optionsButton.addEventListener(MouseEvent.CLICK, optionsButtonClick);

			normalSpeed = new NormalSpeed();
			normalSpeed.x = 298;
			normalSpeed.y = 485;
			_root.addChild(normalSpeed);

			fastForward = new FastForward();
			fastForward.x = 298;
			fastForward.y = 530;
			_root.addChild(fastForward);

		}
		private function optionsButtonClick(e:MouseEvent):void
		{
			optionsWindow = new OptionsWindow(true);
			keysEnabled = false;

			addChild(optionsWindow);
			pauseGame();

			optionsWindow.addEventListener(Event.REMOVED_FROM_STAGE, optionsWindowClosed);

			optionsWindow.restartButton.addEventListener(MouseEvent.CLICK, restartButtonClicked);
			optionsWindow.backToMap.addEventListener(MouseEvent.CLICK, backToMapClicked);
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
		private function setupUser():void
		{
			userInfo = new UserInfo();
			_root.addChild(userInfo);
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
						healthBarOn = ! healthBarOn;
						healthBarToggle();
						break;

					case Keyboard.X :
						if (mouseclickedTower != null)
						{
							menuManager.sellObjectSelected();
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
						UserInfo.changeGold(99999);
						break;

					case Keyboard.E :
						common.Commons.fRate = 96;
						stage.frameRate = common.Commons.fRate;
						break;

					case Keyboard.R :
						common.Commons.fRate = 1;
						stage.frameRate = common.Commons.fRate;
						break;

					case Keyboard.U :
						inputField.visible = !(inputField.visible);
						break;

					case Keyboard.SPACE :
						startRoundKeyboard();
						break;
				}
				if (inputField != null)
				{
					if (!(inputField.contains(e.target as DisplayObject)) ||  !(e.target is TextField))
					{
						if (menuManager != null)
						{
							menuManager.keyDownHandler(e);
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
		private function healthBarToggle():void
		{
			initEnemies.healthBarOn = healthBarOn;
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
				setChildIndex(rangeCircle,numChildren-1);
				setChildIndex(DisplayObject(psuedoTower),numChildren-1);
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
			_root.addChild(bottomBar);

			startRoundButton = new StartRoundButton();
			startRoundButton.x = 593;
			startRoundButton.y = 426;
			_root.addChild(startRoundButton);
			startRoundButton.addEventListener(MouseEvent.CLICK, startRoundMouse);

			dpsDummyButton = new DpsDummyButton();
			dpsDummyButton.x = 593;
			dpsDummyButton.y = 450;
			_root.addChild(dpsDummyButton);
			dpsDummyButton.addEventListener(MouseEvent.CLICK, sendDpsDummy);
		}
		private function startRound():void
		{
			if (roundManager.roundInProgress == false)
			{
				roundManager.startRound(true);
				roundBar.updateRoundList(roundManager.getCurrentRound());
			}
		}
		private function sendWave(e:MouseEvent)
		{
			if (roundManager.roundInProgress == false)
			{
				var waveArray:Array = new Array  ;
				var hp:int = Number(inputField.hpField.text);
				var ms:int = Number(inputField.msField.text);
				var gold:int = Number(inputField.goldField.text);
				var armor:int = Number(inputField.armorField.text);
				var numSend:int = Number(inputField.numField.text);
				var freq:int = Number(inputField.freqField.text);
				var armorType:String = "pure";
				var eFrame:int = 11;
				waveArray = [hp,ms,gold,armor,numSend,freq,eFrame,armorType,0,"Mikel"];
				//maxHp,maxMoveSpeed,goldValue,maxArmor,numberOfEnemies,freq,roundNumber,armorType,endBonus,eName,s1,s2,s3,bmpData];
				roundManager.sendWave(waveArray);
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
			if (roundManager.roundInProgress == false)
			{
				initEnemies.createDmgDummy();
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
			_root.addChild(mouseclickedTowerSquare );

			inputField = new InputField();
			inputField.x = 692;
			inputField.y = 8;
			inputField.sendWave.addEventListener(MouseEvent.CLICK, sendWave);
			inputField.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownAction);
			inputField.addEventListener(MouseEvent.MOUSE_UP, mouseUpAction);
			_root.addChild(inputField);
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

				if (psuedoTower != null && _root.contains(psuedoTower))
				{
					_root.removeChild(psuedoTower);
					psuedoTower = null;
				}

				psuedoTower = new PsuedoTower(tower.towerReference);
				psuedoTower.mouseEnabled = false;
				_root.addChild(psuedoTower);
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
					setChildIndex(rangeCircle,numChildren-1);
					setChildIndex(DisplayObject(psuedoTower),numChildren-1);
					rangeCircle.visible = true;
				}
			}
			else
			{
				//Tower selected is same as tower in memory
				towerBeingBuilt = null;
				menuManager.hideTowerBeingBuiltSquare();
				_root.removeChild(psuedoTower);
				psuedoTower = null;
				rangeCircle.visible = false;
			}
		}
		public function sellTower(tower:Object)
		{
			if (mouseclickedTower != null)
			{
				UserInfo.changeGold(mouseclickedTower.tCost);

				mouseclickedTower.destroyTower();

				removeMouseClickedTower();

				tileArray[tower.y / tileSide][tower.x / tileSide].occupied = false;

				menuManager.returnToDefaultMenu();
			}
		}
		private function setupRangeCircle():void
		{
			rangeCircle = new Shape();
			rangeCircle.graphics.beginFill(0xFF0000,.5);
			rangeCircle.graphics.drawCircle(0,0,100);
			rangeCircle.graphics.endFill();
			rangeCircle.visible = false;
			_root.addChild(rangeCircle);

		}
		private function setupEnemies():void
		{
			initEnemies = new InitiateEnemies();
			initEnemies.addEventListener("gameOver",gameOver);
			roundManager = new RoundManager(initEnemies);
		}
		private function gameOver(e:Event):void
		{
			gameOverWindow = new GameOverWindow();
			keysEnabled = false;

			addChild(gameOverWindow);
			pauseGame();
			//gameOverWindow.addEventListener(Event.REMOVED_FROM_STAGE, gameOverWindowClosed);

			gameOverWindow.restartButton.addEventListener(MouseEvent.CLICK, restartButtonClicked);
			gameOverWindow.backToMap.addEventListener(MouseEvent.CLICK, backToMapClicked);
		}
		private function gameOverWindowClosed(e:Event):void
		{
			gameOverWindow.removeEventListener(Event.REMOVED_FROM_STAGE, gameOverWindowClosed);

			gameOverWindow.restartButton.removeEventListener(MouseEvent.CLICK, restartButtonClicked);
			gameOverWindow.backToMap.removeEventListener(MouseEvent.CLICK, backToMapClicked);
			gameOverWindow.restartButton = null;
			gameOverWindow.backToMap = null;

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
					_root.addChildAt(tile,0);
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
				addTowerToMap(e.currentTarget.x,e.currentTarget.y,psuedoTower.towerReference);
			}
		}
		private function addTowerToMap(towerX,towerY,TowerReference:Class):void
		{
			var klasa:Class = TowerReference;
			var newTower:Tower = new klasa(towerSkillManager);//creates new tower
			klasa = null;
			if (UserInfo.canAfford(newTower.tCost))
			{
				UserInfo.changeGold(-newTower.tCost);

				newTower.enemyList = enemyList;
				newTower.towerArray = towerArray;
				newTower.x = towerX;
				newTower.y = towerY;

				common.Commons.addTowerList(newTower);

				towerArray[newTower.y / tileSide][newTower.x / tileSide] = newTower;

				_root.addChildAt(newTower,numChildren-2);
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
				setChildIndex(cAfford,_root.numChildren-1);
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
				if (UserInfo.canAfford(testTower.tCost))
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

				setChildIndex(rangeCircle,numChildren-1);
				setChildIndex(DisplayObject(mouseclickedTower),numChildren-1);
				setChildIndex(mouseclickedTowerSquare,numChildren-1);


				middleInfo.updateText(mouseclickedTower);
				menuManager.towerMapClicked(e);
			}
			else
			{
				removeMouseClickedTower();
			}
		}
		private function removeMouseClickedTower():void
		{
			menuManager.returnToDefaultMenu();
			middleInfo.updateText(undefined);
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
					_root.removeChild(tileArray[i][o]);
					tileArray[i][o] = null;
				}
			}
			tileArray = [];
		}
		private function endClass():void
		{
			common.Commons.endGame();

			initEnemies.endClass();
			roundManager.endClass();
			roundsList = [];

			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyReleased);

			roundBar.endClass();
			_root.removeChild(roundBar);
			roundBar = null;

			menuManager.endClass();
			_root.removeChild(menuManager);
			menuManager = null;

			_root.removeChild(middleInfo);
			middleInfo = null;

			_root.removeChild(bottomBar);
			bottomBar = null;

			optionsButton.removeEventListener(MouseEvent.CLICK, optionsButtonClick);
			_root.removeChild(optionsButton);
			optionsButton = null;

			startRoundButton.removeEventListener(MouseEvent.CLICK, startRoundMouse);
			_root.removeChild(startRoundButton);
			startRoundButton = null;

			dpsDummyButton.removeEventListener(MouseEvent.CLICK, sendDpsDummy);
			_root.removeChild(dpsDummyButton);
			dpsDummyButton = null;

			_root.removeChild(userInfo);
			userInfo = null;

			_root.removeChild(mouseclickedTowerSquare );
			mouseclickedTowerSquare = null;

			_root.removeChild(inputField);
			inputField = null;

			_root.removeChild(rangeCircle);
			rangeCircle = null
			;
			removeChild(cAfford);
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

			_root.removeChild(fastForward);
			_root.removeChild(normalSpeed);
			fastForward = null;
			normalSpeed = null;

			tileArray = [];
			enemyList = [];
			mapArray = [];
		}
	}
}