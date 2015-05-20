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
	import enemies.*;
	import enemies.enemy1.*
	import enemies.enemy2.*
	import enemies.enemy3.*
	
	import controls.mouse.MouseControls;
	

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

		//tower related
		private var towerSelected:Object;
		private var towerImg:Object;

		//tower ui
		private var towerSelectedSquare:Object;
		private var rangeCircle:Shape;

		//towers
		private var towersInitiate:TowersInitiate;
		
		//controls
		private var mouseControls:MouseControls;
		
		//user
		private var userInfo:UserInfo;


		public function Map()
		{
			enemyList = new Array  ;
			tileArray = new Array  ;
			//1=right 2=down 3=left 4=up
			mapArray = [  
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,1,1,1,1,1,2,0,0,0,0,1,1,1,1,1,1,1,1,1],
			[0,0,0,0,0,0,2,0,0,0,0,4,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,2,0,0,0,0,4,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,2,0,0,0,0,4,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,2,0,0,0,0,4,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,2,0,0,0,0,4,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,2,0,0,0,0,4,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,2,0,0,0,0,4,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,1,1,1,1,1,4,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
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
			
			setupTowers();
			//Creates: towerImgs
			//Displays: towerImgs
			
			setupEnemies();
			//Creates: EnemySpawner (timer)
			//Creates: enemy1
			//Requires: mapArray
			
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
			towersInitiate = new TowersInitiate(_root);
		}
		private function setupKeyboard():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
		}
		private function keyPressed(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.NUMBER_1 :
					selectTower(towersInitiate.towerList[0]);
					break;

				case Keyboard.NUMBER_2 :
					selectTower(towersInitiate.towerList[1]);
					break;

				case Keyboard.NUMBER_3 :
					selectTower(towersInitiate.towerList[2]);
					break;
			}
		}
		private function setupTileListeners():void
		{
			for (var i:int=0;i<tileArray.length;i++)
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
		private function setupSideBar():void
		{

			//BG
			sideBar = new Shape();
			sideBar.graphics.beginFill(0x333333);
			sideBar.graphics.drawRect(0,0,160,480);
			sideBar.graphics.endFill();
			sideBar.x = 640;
			_root.addChild(sideBar);

			//Selected Square
			towerSelectedSquare = new Shape ();
			towerSelectedSquare.graphics.lineStyle(2,0xFF0000);
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
			towerSelectedSquare.x = tower.x;
			towerSelectedSquare.y = tower.y;
			//setup 
			if (towerSelected != tower)
			{
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
					trace(towerImg.x,mapArray[0].length * tileSide);
				}

			}
			else
			{
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
			var numberOfEnemies:int = 999;
			var enemySpawner:Timer = new Timer(550,numberOfEnemies);
			enemySpawner.addEventListener(TimerEvent.TIMER, createEnemies);
			enemySpawner.start();
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
		private function createEnemies(e:TimerEvent):void
		{
			var enemy:Enemy3 = new Enemy3(mapArray);
			_root.addChild(enemy);
			enemy.x = 0;
			enemy.y = 3 * tileSide;
			enemy.pt.x = 0;
			enemy.pt.y = 3;
			enemy.id = Math.random() * 1000;
			enemy.addEventListener(Event.REMOVED_FROM_STAGE,enemyDead);
			enemyList.push(enemy);
		}
		private function enemyDead(e:Event):void
		{
			userInfo.changeGold(e.currentTarget.goldValue);
			enemyList.splice(enemyList.indexOf(e.currentTarget),1);
			e.currentTarget.removeEventListener(Event.REMOVED,enemyDead);
		}
		private function addTower(e:MouseEvent):void
		{
			if (e.currentTarget.occupied == false && towerImg != null)
			{

				var newTower:Tower = new towerImg.towerReference();
				newTower.enemyList = enemyList;
				newTower.x = e.currentTarget.x;
				newTower.y = e.currentTarget.y;
				_root.addChild(newTower);
				newTower.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				newTower.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				newTower.addEventListener(Event.REMOVED_FROM_STAGE, towerRemoved);
				e.currentTarget.occupied = true;
			}
		}
		private function onMouseOver(e:Event):void
		{
			rangeCircle.visible = true;
			rangeCircle.width = e.currentTarget.tRange * 2;
			rangeCircle.height = e.currentTarget.tRange * 2;
			rangeCircle.x = e.currentTarget.x + (tileSide * .5);
			rangeCircle.y = e.currentTarget.y + (tileSide * .5);
		}
		private function onMouseOut(e:Event):void
		{
			rangeCircle.visible = false;
		}
		private function towerRemoved(e:Event):void
		{
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, towerRemoved);
		}

	}

}