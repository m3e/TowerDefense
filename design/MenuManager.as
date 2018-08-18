package design
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import towers.*;
	import flash.events.Event;
	import flash.utils.getQualifiedSuperclassName;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import towerimg.PsuedoTower;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;


	public class MenuManager extends MovieClip
	{

		private var sellObject:SellObject;
		private var targetingIcon:TargetingIcon;
		private var menuIsDefault:Boolean;
		private var towerBeingBuiltSquare:Shape;
		
		private var currentMenuSelected:Array;
		private var cellsArray:Array;
		private var towerStatsOver:TowerStatsOver;
		private var _root:Object;
		private var selectedTower:Tower;

		public function MenuManager(e:Object)
		{

			currentMenuSelected = new Array  ;
			cellsArray = new Array  ;
			_root = e;

			var menuLength:int = 4;
			var menuHeight:int = 3;
			cellsArray = [[t1,t2,t3,t4],
			  [m1,m2,m3,m4],
			  [b1,b2,b3,b4]];

			for (var i:int = 0; i < menuHeight; i++)
			{
				currentMenuSelected[i] = [];
				for (var p:int=0; p < menuLength; p++)
				{
					currentMenuSelected[i][p] = undefined;
				}
			}
			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			sellObject = new SellObject();
			addChild(sellObject);
			sellObject.visible = false;
			
			targetingIcon = new TargetingIcon();
			addChild(targetingIcon);
			targetingIcon.visible = false;

			towerBeingBuiltSquare = new Shape ();
			towerBeingBuiltSquare.graphics.lineStyle(4,0x665544);
			towerBeingBuiltSquare.graphics.beginFill(665544,0);
			towerBeingBuiltSquare.graphics.drawRect(-1.5,-1.5,t1.width,t1.height);
			towerBeingBuiltSquare.graphics.endFill();
			towerBeingBuiltSquare.visible = false;
			addChild(towerBeingBuiltSquare);

			towerStatsOver = new TowerStatsOver  ;
			addChild(towerStatsOver);
			towerStatsOver.visible = false;

			returnToDefaultMenu();
		}
		public function keyDownPress(e:KeyboardEvent):void
		{

			switch (e.keyCode)
			{
					/*case Keyboard.NUMBER_1 :
					if (menuIsDefault == true)
					{
					}
					else
					{
					returnToDefaultMenu();
					}
					selectTower(currentMenuSelected[0][0]);
					break;
					
					case Keyboard.NUMBER_2 :
					if (menuIsDefault == true)
					{
					}
					else
					{
					returnToDefaultMenu();
					}
					selectTower(currentMenuSelected[0][1]);
					break;
					
					case Keyboard.NUMBER_3 :
					if (menuIsDefault == true)
					{
					}
					else
					{
					returnToDefaultMenu();
					}
					selectTower(currentMenuSelected[0][2]);
					break;
					
					case Keyboard.NUMBER_4 :
					if (menuIsDefault == true)
					{
					}
					else
					{
					returnToDefaultMenu();
					}
					selectTower(currentMenuSelected[0][3]);
					break;
					
					case Keyboard.NUMBER_5 :
					if (menuIsDefault == true)
					{
					}
					else
					{
					returnToDefaultMenu();
					}
					selectTower(currentMenuSelected[1][0]);
					break;*/
			}
		}
		public function returnToDefaultMenu():void
		{
			selectedTower = null;
			emptyOutMenuSelected();
			towerStatsOver.visible = false;

			currentMenuSelected = [[Warrior,Arrow,FireTower,IceTower],
			   [Splash,,,],
			   [,,,]];
			menuIsDefault = true;
			hideTowerBeingBuiltSquare();
			updateCurrentMenu();
		}
		private function updateCurrentMenu():void
		{

			for (var i:int=0; i < currentMenuSelected.length; i++)
			{

				for (var p:int=0; p < currentMenuSelected[i].length; p++)
				{
					var ct = currentMenuSelected[i][p];
					if (ct != null)
					{
						switch (true)
						{
							case (getQualifiedSuperclassName(ct) == getQualifiedClassName(Tower)) :

								var psuedoTower:PsuedoTower = new PsuedoTower(ct);
								psuedoTower.x = cellsArray[i][p].x;
								psuedoTower.y = cellsArray[i][p].y;
								addChild(psuedoTower);

								currentMenuSelected[i][p] = psuedoTower;

								ct = null;

								currentMenuSelected[i][p].addEventListener(MouseEvent.CLICK, selectTowerMouse);
								currentMenuSelected[i][p].addEventListener(MouseEvent.MOUSE_OVER, mouseHoverOver);
								currentMenuSelected[i][p].addEventListener(MouseEvent.MOUSE_OUT, mouseHoverOut);
								break;

							case (ct is String) :
								switch (true)
								{
									case (ct == "Sell") :
										sellObject.x = cellsArray[2][0].x;
										sellObject.y = cellsArray[2][0].y;
										sellObject.visible = true;
										sellObject.addEventListener(MouseEvent.CLICK, sellObjectClicked);
										break;

									case (ct == "Targeting") :
										targetingIcon.x = cellsArray[1][0].x;
										targetingIcon.y = cellsArray[1][0].y;
										targetingIcon.visible = true;
										targetingIcon.addEventListener(MouseEvent.CLICK, targetingIconClicked);
										break;
								}
						}
					}
				}
			}
		}
		private function selectTowerMouse(e:MouseEvent):void
		{
			var tower:Object = e.currentTarget as Object;
			selectTower(tower);
		}
		private function selectTower(tower:Object):void
		{

			switch (true)
			{
				case (selectedTower == null) :

					if ((towerBeingBuiltSquare.x != tower.x || towerBeingBuiltSquare.y != tower.y) || towerBeingBuiltSquare.visible == false)
					{
						towerBeingBuiltSquare.x = tower.x;
						towerBeingBuiltSquare.y = tower.y;
						setChildIndex(towerBeingBuiltSquare, numChildren -1);
						towerBeingBuiltSquare.visible = true;
					}
					else
					{
						towerBeingBuiltSquare.visible = false;
					}
					_root.buildTower(tower);
					break;
				case (selectedTower != null) :

					_root.upgradeTower(tower);
					break;

			}



		}
		public function tileMapClicked(e:Event):void
		{
			returnToDefaultMenu();

		}
		public function hideTowerBeingBuiltSquare():void
		{
			towerBeingBuiltSquare.visible = false;
		}
		private function mouseHoverOut(e:Event):void
		{
			towerStatsOver.visible = false;
		}
		private function mouseHoverOver(e:Event):void
		{
			towerStatsOver.visible = true;
			setChildIndex(towerStatsOver, numChildren -1);
			_root.setChildIndex(this, _root.numChildren - 1);

			towerStatsOver.x = e.currentTarget.x;
			towerStatsOver.y = e.currentTarget.y - 110;
			if (e.currentTarget.parent.x + towerStatsOver.x + towerStatsOver.width > stage.stageWidth)
			{
				var a:Number = stage.stageWidth
				var b:Number = e.currentTarget.parent.x + towerStatsOver.x + towerStatsOver.width
				var c:Number = b - a
				towerStatsOver.x -= c + 3
			}

			towerStatsOver.DmgBox.text = e.currentTarget.tDmg;
			towerStatsOver.SpdBox.text = e.currentTarget.tAtkSpeed//(24 / (e.currentTarget.tAtkSpeed)).toFixed(2);
			towerStatsOver.RngBox.text = e.currentTarget.tRange;
			towerStatsOver.TypeBox.text = e.currentTarget.tType;
			towerStatsOver.DescBox.text = e.currentTarget.tDescription;
			towerStatsOver.DpsBox.text = String(int((Number(e.currentTarget.tDmg) * Number(24 / Number(e.currentTarget.tAtkSpeed)))*100)/100);
			towerStatsOver.CostBox.text = e.currentTarget.tCost;
		}
		public function towerMapClicked(e:Event):void
		{
			updateMenu(e);
			selectedTower = e.currentTarget as Tower;
			sellObject.importTowerToSell(selectedTower);
			targetingIcon.importTower(selectedTower);
		}

		public function updateMenu(e:Event):void
		{
			switch (true)
			{
				case (e.currentTarget is Tower) :

					emptyOutMenuSelected();
					hideTowerBeingBuiltSquare();
					currentMenuSelected = e.currentTarget.tMenu();
					menuIsDefault = false;
					break;
			}
			updateCurrentMenu();
		}
		private function sellObjectClicked(e:MouseEvent):void
		{
			sellObject.sellTower();
		}
		private function targetingIconClicked(e:MouseEvent):void
		{
			targetingIcon.changeTargeting();
		}
		public function sellObjectSelected():void
		{
			sellObject.sellTower();
		}
		private function emptyOutMenuSelected():void
		{

			for (var i:int=0; i < currentMenuSelected.length; i++)
			{
				for (var p:int=0; p < currentMenuSelected[i].length; p++)
				{
					var ct = currentMenuSelected[i][p];

					if (ct != null)
					{

						switch (true)
						{
								//case (getQualifiedSuperclassName(ct) == getQualifiedClassName(Tower)) :
							case (ct is PsuedoTower) :
								currentMenuSelected[i][p].removeEventListener(MouseEvent.CLICK, selectTowerMouse);
								currentMenuSelected[i][p].removeEventListener(MouseEvent.MOUSE_OVER, mouseHoverOver);
								currentMenuSelected[i][p].removeEventListener(MouseEvent.MOUSE_OUT, mouseHoverOut);
								removeChild(ct);
								break;

							case (ct is String) :
								if (ct == "Sell")
								{
									sellObject.visible = false;
									sellObject.removeEventListener(MouseEvent.CLICK, sellObjectClicked);
								}
								else if (ct == "Targeting")
								{
									targetingIcon.visible = false;
									targetingIcon.removeEventListener(MouseEvent.CLICK, sellObjectClicked);
								}
						}
						currentMenuSelected[i][p] = null;
					}
				}
			}
		}

	}

}