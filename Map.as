﻿package 
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
	import controls.mouse.MouseControls;
	import flash.text.TextField;


	public class Map extends MovieClip
	{

		//root
		private var _root:Object;

		//constants
		private var tileSide:int = 32;

		//critical arrays
		private var mapArray:Array;
		private var tileArray:Array;

		//object lists
		private var enemyList:Array;

		//shapes
		private var sideBar:Shape;
		private var bottomBar:BottomBar;
		private var startRoundButton:Sprite;
		private var dpsDummyButton:Sprite;




		//tower related
		private var towerSelected:Object;
		private var towerImg:Object;
		private var upgradeableTower:Object;

		//tower ui
		private var towerSelectedSquare:Shape;
		private var upgradeableTowerSquare:Shape;
		private var rangeCircle:Shape;

		//towers
		private var towersInitiate:TowersInitiate;

		//controls
		private var mouseControls:MouseControls;
		private var _keyDown:Boolean;
		private var shiftDown:Boolean;

		//user
		private var userInfo:UserInfo;

		//initEnemy
		private var initEnemies:InitiateEnemies;




		public function Map()
		{
			enemyList = new Array  ;
			tileArray = new Array  ;

			//1=right 2=down 3=left 4=up
			mapArray = [  
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,1,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,4,0,2,0,0,1,1,1,1,2,0,0,0,0,0,0],
			[0,0,0,0,4,0,2,0,0,4,0,0,0,2,0,0,0,0,0,0],
			[0,0,0,0,4,0,2,0,0,4,0,0,0,2,0,0,0,0,1,1],
			[1,1,1,1,4,0,1,1,1,4,0,0,0,2,0,0,0,0,4,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,4,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,4,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,4,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,4,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]];

			tileArray = [  
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,],
			[,,,,,,,,,,,,,,,,,,,]];




			addEventListener(Event.ADDED_TO_STAGE, added);




			// constructor code;
		}
		private function added(e:Event):void
		{
			_root = root;
			setupMap();
			//Sets: mapArray
			//Sets: tileArray
			//Displays: maps

			setupRangeCircle();
			//Creates: rangeCircle


			setupSideBar();
			//Creates: towerSelectedSquare
			//Creates: sideBar
			//Displays: sideBar



			setupUser();
			//Creates: userInfo



			setupEnemies();
			//Creates: EnemySpawner (timer)
			//Creates: enemy1
			//Requires: mapArray,userInfo

			setupBottomBar();
			//requires setupEnemies();

			setupTowers();
			//Creates: towerImgs
			//Displays: towerImgs
			//Requires: enemyList

			setupKeyboard();
			//Requires: TowerSelectedSquare
			//Requires: RangeCircle
			//Requires: towerImgs

			setupTileListeners();

			setupMouseControls();

		}
		private function setupUser():void
		{
			userInfo = new UserInfo();
			_root.addChild(userInfo);
		}
		private function setupMouseControls():void
		{
			mouseControls = new MouseControls(towersInitiate.towerList,this);
		}
		private function setupTowers():void
		{
			towersInitiate = new TowersInitiate(_root,enemyList);

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
					if (towerSelected != null)
					{
						selectTower(towerSelected);
					}
					break;

				case Keyboard.NUMBER_1 :
					selectTower(towersInitiate.towerList[0]);
					break;

				case Keyboard.NUMBER_2 :
					selectTower(towersInitiate.towerList[1]);
					break;

				case Keyboard.NUMBER_3 :
					selectTower(towersInitiate.towerList[2]);
					break;

				case Keyboard.NUMBER_4 :
					selectTower(towersInitiate.towerList[3]);
					break;

				case Keyboard.NUMBER_5 :
					selectTower(towersInitiate.towerList[4]);
					break;

				case Keyboard.NUMBER_6 :
					selectTower(towersInitiate.towerList[5]);
					break;

				case Keyboard.NUMBER_7 :
					selectTower(towersInitiate.towerList[6]);
					break;

				case Keyboard.NUMBER_8 :
					selectTower(towersInitiate.towerList[7]);
					break;

				case Keyboard.NUMBER_9 :
					selectTower(towersInitiate.towerList[8]);
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

			}
		}
		private function setupTileListeners():void
		{
			for (var i:int=0; i<tileArray.length; i++)
			{
				for (var o:int=0; o< tileArray[i].length; o++)
				{
					tileArray[i][o].addEventListener(MouseEvent.CLICK, addTower);
					tileArray[i][o].addEventListener(MouseEvent.MOUSE_OVER, hoverOver);
					tileArray[i][o].addEventListener(MouseEvent.MOUSE_OUT, hoverOverOut);
				}
			}
		}
		private function hoverOver(e:MouseEvent):void
		{
			if (towerSelected != null)
			{
				rangeCircle.visible = true;
				rangeCircle.x = e.currentTarget.x + (tileSide * .5);
				rangeCircle.y = e.currentTarget.y + (tileSide * .5);

				towerImg.visible = true;
				towerImg.x = e.currentTarget.x;
				towerImg.y = e.currentTarget.y;
			}
		}
		private function hoverOverOut(e:MouseEvent):void
		{
			if (towerImg != null)
			{
				towerImg.visible = false;
			}
			rangeCircle.visible = false;
		}

		private function setupBottomBar():void
		{
			bottomBar = new BottomBar();

			_root.addChild(bottomBar);

			bottomBar.upgrade1.addEventListener(MouseEvent.CLICK, upgradeTower);
			bottomBar.upgrade2.addEventListener(MouseEvent.CLICK, upgradeTower);
			bottomBar.upgrade3.addEventListener(MouseEvent.CLICK, upgradeTower);


			startRoundButton = new Sprite();
			startRoundButton.graphics.beginFill(0x990000);
			startRoundButton.graphics.lineStyle(1,0xFFFFFF);
			startRoundButton.graphics.drawRect(0,0,80,20);
			startRoundButton.graphics.endFill();
			startRoundButton.y = 426;
			startRoundButton.x = 650;
			_root.addChild(startRoundButton);

			startRoundButton.addEventListener(MouseEvent.CLICK, startRound);

			var startRoundText:TextField = new TextField();
			startRoundText.text = "Start";
			startRoundText.width = 80;
			startRoundText.height = 20;
			startRoundText.textColor = 0xFFFFFF;
			startRoundText.x = 675;
			startRoundText.y = 426;
			startRoundText.selectable = false;
			startRoundText.mouseEnabled = false;
			_root.addChild(startRoundText);
			dpsDummyButton = new Sprite();
			dpsDummyButton.graphics.beginFill(0x990000);
			dpsDummyButton.graphics.lineStyle(1,0xFFFFFF);
			dpsDummyButton.graphics.drawRect(0,0,80,20);
			dpsDummyButton.graphics.endFill();
			dpsDummyButton.y = 460;
			dpsDummyButton.x = 650;
			_root.addChild(dpsDummyButton);

			dpsDummyButton.addEventListener(MouseEvent.CLICK, sendDpsDummy);

			var dpsDummyText:TextField = new TextField();
			dpsDummyText.text = "DPS Dummy";
			dpsDummyText.width = 80;
			dpsDummyText.height = 20;
			dpsDummyText.textColor = 0xFFFFFF;
			dpsDummyText.x = 655;
			dpsDummyText.y = 460;
			dpsDummyText.selectable = false;
			dpsDummyText.mouseEnabled = false;
			_root.addChild(dpsDummyText);
		}
		private function startRound(e:Event):void
		{

			if(initEnemies.roundInProgress == false)
			{
			initEnemies.startRound();
			}
			//startRoundButton.removeEventListener(MouseEvent.CLICK, startRound);
		}
		private function sendDpsDummy(e:Event):void
		{

			initEnemies.createDmgDummy();
		}
		private function setupSideBar():void
		{

			//BG
			sideBar = new Shape();
			sideBar.graphics.beginFill(0x333333);
			sideBar.graphics.drawRect(0,0,100,416);
			sideBar.graphics.endFill();
			sideBar.x = 640;
			_root.addChild(sideBar);



			//Upgradeable tower square
			upgradeableTowerSquare = new Shape ();
			upgradeableTowerSquare.graphics.lineStyle(4,0x000000);
			upgradeableTowerSquare.graphics.beginFill(0xFFFFFF,0);
			upgradeableTowerSquare.graphics.drawRect(0,0,tileSide,tileSide);
			upgradeableTowerSquare.graphics.endFill();
			upgradeableTowerSquare.visible = false;
			_root.addChild(upgradeableTowerSquare );

			//Selected Square
			towerSelectedSquare = new Shape ();
			towerSelectedSquare.graphics.lineStyle(4,0xFFFFFF);
			towerSelectedSquare.graphics.beginFill(0xFFFFFF,0);
			towerSelectedSquare.graphics.drawRect(0,0,tileSide,tileSide);
			towerSelectedSquare.graphics.endFill();
			towerSelectedSquare.visible = false;
			_root.addChild(towerSelectedSquare);

		}

		public function selectTowerMouse(e:MouseEvent):void
		{
			var tower:Sprite = e.currentTarget as Sprite;
			selectTower(tower);
		}
		private function selectTower(tower:Object):void
		{
			//x&y for TowerSelectedSquare
			towerSelectedSquare.x = tower.x;
			towerSelectedSquare.y = tower.y;

			//If there was a tower already selected and it does not equal the one you clicked
			if (towerSelected != tower)
			{
				//towerSelected = tower sent via constructor
				towerSelected = tower;
				if (towerImg != null && _root.contains(towerImg))
				{
					_root.removeChild(towerImg);
					towerImg = null;
				}
				towerImg = getDefinitionByName(getQualifiedClassName(towerSelected));
				towerImg = new towerImg();
				towerImg.mouseEnabled = false;
				towerImg.x = mouseX - (mouseX % tileSide);
				towerImg.y = mouseY - (mouseY % tileSide);
				_root.addChild(towerImg);


				trace(tower.towerReference);
				
				var mockTower:Tower = new tower.towerReference();

				rangeCircle.width = mockTower.tRange * 2;
				rangeCircle.height = mockTower.tRange * 2;
				towerSelectedSquare.visible = true;

				mockTower.destroyTower();

				rangeCircle.visible = true;
				rangeCircle.x = mouseX - (mouseX % tileSide) + (tileSide * .5);
				rangeCircle.y = mouseY - (mouseY % tileSide) + (tileSide * .5);

				if (towerImg.x >= mapArray[0].length * tileSide)
				{
					towerImg.visible = false;
					rangeCircle.visible = false;
				}

			}
			else
			{
				//Tower selected is same as tower in memory
				towerSelectedSquare.visible = ! towerSelectedSquare.visible;
				towerSelected = null;
				_root.removeChild(towerImg);
				towerImg = null;
				rangeCircle.visible = false;
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


		private function addTower(e:MouseEvent):void
		{
			upgradeableTower = null;
			upgradeableTowerSquare.visible = false;
			if (e.currentTarget.occupied == false && towerImg != null)
			{
				addTowerToMap(e.currentTarget,towerImg.towerReference);
				if (_keyDown == true && shiftDown == true)
				{

				}
				else
				{
					selectTower(towerSelected);
				}
			}
		}
		private function addTowerToMap(mEvent:Object, TowerReference:Class):void
		{
			var klasa:Class = TowerReference;
			var newTower:Tower = new klasa();

			if (userInfo.canAfford(newTower.tCost))
			{

				userInfo.changeGold(-newTower.tCost);
				newTower.enemyList = enemyList;
				newTower.x = mEvent.x;
				newTower.y = mEvent.y;
				_root.addChild(newTower);
				newTower.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				newTower.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				newTower.addEventListener(MouseEvent.CLICK, towerWasSelected);
				newTower.addEventListener(Event.REMOVED_FROM_STAGE, towerRemoved);
				mEvent.occupied = true;
			}
			else
			{
				trace("Can't afford this tower.  Cost: ", newTower.tCost);
			}
		}
		private function upgradeTower(e:Event):void
		{
			if (upgradeableTower != null)
			{
				switch (e.currentTarget.name)
				{
					case ("upgrade1") :
						if (userInfo.canAfford(upgradeableTower.upgradeOneCost))
						{
							addTowerToMap(tileArray[upgradeableTower.y/tileSide][upgradeableTower.x/32],upgradeableTower.upgradeOne());
							upgradeableTower.destroyTower();

							upgradeableTowerSquare.visible = false;
							upgradeableTower = null;
						}
						break;

					case ("upgrade2") :
						if (userInfo.canAfford(upgradeableTower.upgradeTwoCost))
						{
							addTowerToMap(tileArray[upgradeableTower.y/tileSide][upgradeableTower.x/32],upgradeableTower.upgradeTwo());
							upgradeableTower.destroyTower();

							upgradeableTowerSquare.visible = false;
							upgradeableTower = null;
						}
						break;
					case ("upgrade3") :
						if (userInfo.canAfford(upgradeableTower.upgradeThreeCost))
						{
							addTowerToMap(tileArray[upgradeableTower.y/tileSide][upgradeableTower.x/32],upgradeableTower.upgradeThree());
							upgradeableTower.destroyTower();

							upgradeableTowerSquare.visible = false;
							upgradeableTower = null;
						}
						break;
				}

			}
		}
		private function onMouseOver(e:Event):void
		{
			if (towerImg != null)
			{
				towerImg.visible = false;
			}

			rangeCircle.visible = true;
			rangeCircle.width = e.currentTarget.tRange * 2;
			rangeCircle.height = e.currentTarget.tRange * 2;
			rangeCircle.x = e.currentTarget.x + (tileSide * .5);
			rangeCircle.y = e.currentTarget.y + (tileSide * .5);
		}
		private function onMouseOut(e:Event):void
		{
			if (towerSelected != null)
			{
				var mockTower:Tower = new towerSelected.towerReference();

				rangeCircle.width = mockTower.tRange * 2;
				rangeCircle.height = mockTower.tRange * 2;

				mockTower.destroyTower();
			}
			rangeCircle.visible = false;
		}
		private function towerWasSelected(e:MouseEvent):void
		{
			if (upgradeableTower != e.currentTarget)
			{

				upgradeableTower = e.currentTarget;

				upgradeableTowerSquare.visible = true;
				upgradeableTowerSquare.x = upgradeableTower.x;
				upgradeableTowerSquare.y = upgradeableTower.y;
			}
			else
			{
				upgradeableTower = null;
				upgradeableTowerSquare.visible = false;
			}
		}
		private function towerRemoved(e:Event):void
		{
			e.currentTarget.removeEventListener(MouseEvent.CLICK, towerWasSelected);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, towerRemoved);
		}

	}

}