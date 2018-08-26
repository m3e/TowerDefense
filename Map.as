package 
{
	import flash.display.MovieClip;
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
	
	import common.Commons;

	import design.*;

	import enemies.*;
	import flash.text.TextField;
	import flash.display.DisplayObject;
	import towerimg.PsuedoTower;
	
	import sounds.SoundManager;


	public class Map extends MovieClip
	{

		private var menuManager:MenuManager;
		private var middleInfo:MiddleInfoContent;
		private var towerManager:TowerManager;
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
			tileSide = common.Commons.tileSide;
			

			//1=right 2=down 3=left 4=up
			
			mapArray = common.Commons.getMapArray();

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
			
			
			
			setupBottomBarContent()

			

			
			
			

			setupKeyboard();
			//Requires: towerBeingBuiltSquare
			//Requires: RangeCircle
			//Requires: psuedoTowers

			setupTileListeners();
			
			
			setChildIndex(userInfo,numChildren-1);
			
			
		}
		private function setupBottomBarContent():void
		{
			menuManager = new MenuManager(_root);
			menuManager.x = 677;
			menuManager.y = 423;
			addChild(menuManager);

			middleInfo = new MiddleInfoContent();
			middleInfo.x = 318;
			middleInfo.y = 423;
			addChild(middleInfo);
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
						menuManager.sellObjectSelected();
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
				menuManager.keyDownPress(e);
				/*if (mouseclickedTower != null)
				{
				mouseclickedTowerSquare.visible = false;
				mouseclickedTower = null;
				}*/
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
				var armorType:String = "pure"
				var eFrame:int = 11;
				waveArray = [hp,ms,gold,armor,numSend,freq,eFrame,armorType];
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
				
				psuedoTower.width = tileSide
				psuedoTower.height = tileSide
				
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
				}
			}
		}
		private function tileDown(e:MouseEvent):void
		{
			
			if (mouseclickedTower != null)
			{
				mouseclickedTowerSquare.visible = false;
				rangeCircle.visible = false;
				mouseclickedTower = null;
				menuManager.tileMapClicked(e);
			}
			else if (towerBeingBuilt == null)
			{
				var i:int = (Math.random()*5)+1
				var dirtName:String = "dirt"+i;
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
			var newTower:Tower = new klasa();
			klasa = null;
			if (UserInfo.canAfford(newTower.tCost))
			{

				UserInfo.changeGold(-newTower.tCost);

				newTower.enemyList = enemyList;
				newTower.towerArray = towerArray;
				newTower.x = towerX
				newTower.y = towerY

				towerArray[newTower.y / tileSide][newTower.x / tileSide] = newTower;

				_root.addChild(newTower);
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
					if (_keyDown == true && shiftDown == true)
					{
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

				trace("Can't afford this tower.  Cost: ", newTower.tCost);
				newTower = null;
			}
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
				testTower = new klasa();
				if (UserInfo.canAfford(testTower.tCost))
				{
					mouseclickedTower.destroyTower();

					addTowerToMap(mouseclickedTower.x,mouseclickedTower.y,klasa);

					removeMouseClickedTower();
				}
				else
				{
					trace("Cannot afford upgrade.  Cost: ",testTower.tCost);
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

				middleInfo.updateText(e);
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
			mouseclickedTower = null;
			mouseclickedTowerSquare.visible = false;
			rangeCircle.visible = false;
		}
		private function towerRemoved(e:Event):void
		{
			towerArray[e.currentTarget.y / tileSide][e.currentTarget.x / tileSide] = undefined;
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_DOWN, towerMapClicked);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, towerRemoved);
		}
	}
}