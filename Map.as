package 
{
	import flash.display.MovieClip;
	import assets.maptiles.*;
	import towers.*;
	import flash.utils.Timer;
	import flash.events.*;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	import design.*;

	import enemies.*;
	import flash.text.TextField;
	import flash.display.DisplayObject;
	import towerimg.PsuedoTower;


	public class Map extends MovieClip
	{

		//root
		private var _root:Object;

		//constants
		private var tileSide:int = 32;

		//critical arrays
		private var mapArray:Array;
		private var tileArray:Array;
		private var towerArray:Array;

		//object lists
		private var enemyList:Array;

		//shapes
		private var bottomBar:BottomBar;
		private var startRoundButton:Sprite;
		private var dpsDummyButton:Sprite;

		//tower related
		private var towerBeingBuilt:Object;
		private var psuedoTower:Object;
		private var mouseclickedTower:Object;

		//tower ui
		private var mouseclickedTowerSquare:Shape;
		private var rangeCircle:Shape;

		//ui
		private var inputField:InputField;

		//controls
		private var _keyDown:Boolean;
		private var shiftDown:Boolean;

		//user
		private var userInfo:UserInfo;

		//initEnemy
		private var initEnemies:InitiateEnemies;
		private var roundManager:RoundManager;

		//booleans
		private var healthBarOn:Boolean;

		public function Map()
		{
			enemyList = new Array  ;
			tileArray = new Array  ;
			towerArray = new Array  ;

			//1=right 2=down 3=left 4=up
			mapArray = [  
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,1,1,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,1,1,2,0,4,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,4,0,2,0,4,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,1,2,0,4,0,2,0,4,0,0,0,2,0,0,1,1,1,1,1,1,1,1,1,1],
			[0,0,2,0,4,0,2,0,4,0,2,3,3,0,0,4,0,0,0,0,0,0,0,0,0],
			[0,0,1,1,4,0,1,1,4,0,2,0,0,0,0,4,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,4,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]];

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
			setupMap();
			//Sets: mapArray
			//Sets: tileArray
			//Displays: maps

			setupRangeCircle();
			//Creates: rangeCircle shape

			setupTowerSquares();

			setupUser();
			//Creates: userInfo

			setupEnemies();
			//Creates: EnemySpawner (timer)
			//Requires: mapArray,userInfo

			setupBottomBar();
			//requires initEnemies for buttons

			setupKeyboard();
			//Requires: towerBeingBuiltSquare
			//Requires: RangeCircle
			//Requires: psuedoTowers

			setupTileListeners();
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
		}
		private function keyReleased(e:KeyboardEvent):void
		{
			_keyDown = false;
			shiftDown = false;
		}
		private function keyPressed(e:KeyboardEvent):void
		{
			_keyDown = true;
			switch (e.keyCode)
			{
				case Keyboard.SHIFT :
					shiftDown = true;
					break;

				case Keyboard.ESCAPE :
					if (towerBeingBuilt != null)
					{
						buildTower(towerBeingBuilt);
					}
					break;

				case Keyboard.Z :
					healthBarOn = ! healthBarOn;
					healthBarToggle();
					break;

				case Keyboard.X :
					if (mouseclickedTower != null)
					{
						sellTower(mouseclickedTower);
						bottomBar.keyDownPress(e);
					}
					break;

				case Keyboard.Q :
					stage.frameRate = 24;
					break;

				case Keyboard.W :
					stage.frameRate = 48;
					break;

				case Keyboard.E :
					stage.frameRate = 96;
					break;

				case Keyboard.R :
					stage.frameRate = 1;
					break;

				case Keyboard.U :
					inputField.visible = !(inputField.visible);
					break;

				case Keyboard.SPACE :
					startRoundKeyboard();
					break;

			}
			if (!(inputField.contains(e.target as DisplayObject)) ||  !(e.target is TextField))
			{
				bottomBar.keyDownPress(e);
				if (mouseclickedTower != null)
				{
					mouseclickedTowerSquare.visible = false;
					mouseclickedTower = null;
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
			bottomBar = new BottomBar(this);
			bottomBar.y = 416;
			_root.addChild(bottomBar);

			/*bottomBar.upgrade1.addEventListener(MouseEvent.CLICK, upgradeTower);
			bottomBar.upgrade2.addEventListener(MouseEvent.CLICK, upgradeTower);
			bottomBar.upgrade3.addEventListener(MouseEvent.CLICK, upgradeTower);*/


			startRoundButton = new Sprite();
			startRoundButton.graphics.beginFill(0x990000);
			startRoundButton.graphics.lineStyle(1,0xFFFFFF);
			startRoundButton.graphics.drawRect(0,0,80,20);
			startRoundButton.graphics.endFill();
			startRoundButton.x = 150;
			startRoundButton.y = 426;
			_root.addChild(startRoundButton);

			startRoundButton.addEventListener(MouseEvent.CLICK, startRoundMouse);

			var startRoundText:TextField = new TextField();
			startRoundText.text = "Start";
			startRoundText.width = 80;
			startRoundText.height = 20;
			startRoundText.textColor = 0xFFFFFF;
			startRoundText.x = 175;
			startRoundText.y = 426;
			startRoundText.selectable = false;
			startRoundText.mouseEnabled = false;
			_root.addChild(startRoundText);

			dpsDummyButton = new Sprite();
			dpsDummyButton.graphics.beginFill(0x990000);
			dpsDummyButton.graphics.lineStyle(1,0xFFFFFF);
			dpsDummyButton.graphics.drawRect(0,0,80,20);
			dpsDummyButton.graphics.endFill();
			dpsDummyButton.x = 150;
			dpsDummyButton.y = 460;
			_root.addChild(dpsDummyButton);

			dpsDummyButton.addEventListener(MouseEvent.CLICK, sendDpsDummy);

			var dpsDummyText:TextField = new TextField();
			dpsDummyText.text = "DPS Dummy";
			dpsDummyText.width = 80;
			dpsDummyText.height = 20;
			dpsDummyText.textColor = 0xFFFFFF;
			dpsDummyText.x = 155;
			dpsDummyText.y = 460;
			dpsDummyText.selectable = false;
			dpsDummyText.mouseEnabled = false;
			_root.addChild(dpsDummyText);
		}
		private function startRound():void
		{
			if (roundManager.roundInProgress == false)
			{
				roundManager.startRound(true);
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
				var eFrame:int = 11;
				waveArray = [hp,ms,gold,armor,numSend,freq,eFrame];
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
			initEnemies.createDmgDummy();
		}
		private function setupTowerSquares():void
		{
			//Upgradeable tower square
			mouseclickedTowerSquare = new Shape ();
			mouseclickedTowerSquare.graphics.lineStyle(4,0x665544);
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
				_root.removeChild(psuedoTower);
				psuedoTower = null;
				rangeCircle.visible = false;
			}
		}
		private function sellTower(tower:Object)
		{
			if (mouseclickedTower != null)
			{
				tileArray[tower.y / tileSide][tower.x / tileSide].occupied = false;

				userInfo.changeGold(mouseclickedTower.tCost);

				rangeCircle.visible = false;
				mouseclickedTowerSquare.visible = false;
				mouseclickedTower.destroyTower();
				mouseclickedTower = null;
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
			initEnemies = new InitiateEnemies(mapArray,enemyList,_root,userInfo,tileSide);
			roundManager = new RoundManager(initEnemies);
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
					tileArray[i][o] = tile
					
					;
				}
			}

		}
		private function tileClicked(e:MouseEvent):void
		{
			if (mouseclickedTower != null)
			{
				mouseclickedTowerSquare.visible = false;
				rangeCircle.visible = false;
				mouseclickedTower = null;
				bottomBar.tileMapClicked(e);
			}
			if (e.currentTarget.occupied == false && psuedoTower != null)
			{
				addTowerToMap(e,psuedoTower.towerReference);
			}
		}
		private function addTowerToMap(e:Event, TowerReference:Class):void
		{
			var mEvent:Object = e.currentTarget;
			var klasa:Class = TowerReference;
			var newTower:Tower = new klasa();
			klasa = null;
			if (userInfo.canAfford(newTower.tCost))
			{

				userInfo.changeGold(-newTower.tCost);

				newTower.enemyList = enemyList;
				newTower.towerArray = towerArray;
				newTower.x = mEvent.x;
				newTower.y = mEvent.y;

				towerArray[newTower.y / tileSide][newTower.x / tileSide] = newTower;

				_root.addChild(newTower);

				newTower.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				newTower.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				newTower.addEventListener(MouseEvent.CLICK, towerMapClicked);
				newTower.addEventListener(Event.REMOVED_FROM_STAGE, towerRemoved);
				mEvent.occupied = true;

				if (_keyDown == true && shiftDown == true)
				{
				}
				else
				{
					buildTower(towerBeingBuilt);
					bottomBar.tileMapClicked(e);
					rangeCircle.visible = false;
				}
			}
			else
			{
				newTower.destroyTower();

				trace("Can't afford this tower.  Cost: ", newTower.tCost);
				newTower = null;
			}
		}
		/*private function upgradeTower(e:Event):void
		{
		var klasa:Class;
		var testTower:Tower;
		if (mouseclickedTower != null)
		{
		switch (e.currentTarget.name)
		{
		case ("upgrade1") :
		klasa = mouseclickedTower.upgradeOne();
		break;
		
		case ("upgrade2") :
		klasa = mouseclickedTower.upgradeTwo();
		break;
		
		case ("upgrade3") :
		klasa = mouseclickedTower.upgradeThree();
		break;
		}
		if (klasa is Class)
		{
		testTower = new klasa();
		if (userInfo.canAfford(testTower.tCost))
		{
		
		mouseclickedTower.destroyTower();
		mouseclickedTowerSquare.visible = false;
		
		addTowerToMap(tileArray[mouseclickedTower.y/tileSide][mouseclickedTower.x/tileSide],klasa);
		
		
		mouseclickedTower = null;
		}
		else
		{
		trace("Cannot afford.  Cost: ",testTower.tCost);
		}
		testTower.destroyTower();
		}
		
		
		}
		}*/
		private function onMouseOver(e:Event):void
		{
			if (psuedoTower != null)
			{
				psuedoTower.visible = false;
			}
			/*rangeCircle.visible = true;
			rangeCircle.width = e.currentTarget.tRange * 2;
			rangeCircle.height = e.currentTarget.tRange * 2;
			rangeCircle.x = e.currentTarget.x + (tileSide * .5);
			rangeCircle.y = e.currentTarget.y + (tileSide * .5);*/
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

				bottomBar.towerMapClicked(e);

				/*var klasa:Class;
				var testTower:Tower;
				
				if (mouseclickedTower.upgradeOne() != null)
				{
				klasa = mouseclickedTower.upgradeOne();
				testTower = new klasa();
				bottomBar.upgrade1.text = testTower.tDescription;
				testTower.destroyTower();
				}
				else
				{
				bottomBar.upgrade1.text = "No upgrade available.";
				}
				if (mouseclickedTower.upgradeTwo() != null)
				{
				klasa = mouseclickedTower.upgradeTwo();
				testTower = new klasa();
				bottomBar.upgrade2.text = testTower.tDescription;
				testTower.destroyTower();
				}
				else
				{
				bottomBar.upgrade2.text = "No upgrade available.";
				}
				if (mouseclickedTower.upgradeThree() != null)
				{
				klasa = mouseclickedTower.upgradeThree();
				testTower = new klasa();
				bottomBar.upgrade3.text = testTower.tDescription;
				testTower.destroyTower();
				}
				else
				{
				bottomBar.upgrade3.text = "No upgrade available.";
				}*/
			}
			else
			{
				bottomBar.defaultMenu();
				mouseclickedTower = null;
				mouseclickedTowerSquare.visible = false;
				rangeCircle.visible = false;
			}
		}
		private function towerRemoved(e:Event):void
		{
			towerArray[e.currentTarget.y / tileSide][e.currentTarget.x / tileSide] = undefined;
			e.currentTarget.removeEventListener(MouseEvent.CLICK, towerMapClicked);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, towerRemoved);
		}
	}
}