﻿package design
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
	import towers.skills.TowerSkill;
	import com.greensock.easing.Ease;
	import design.SkillsMouseOver;
	import common.Commons;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import design.UI.SellIconToolTip;
	import design.UI.TargetToolTip;


	public class MenuManager extends MovieClip
	{

		private var sellObject:SellObject;
		private var targetingIcon:TargetingIcon;
		private var upgradeIcon:UpgradeIcon;
		private var menuIsDefault:Boolean;
		public var towerBeingBuiltSquare:Shape;

		private var currentMenuSelected:Array;
		private var cellsArray:Array;
		private var towerStatsOver:TowerStatsOver;
		private var skillsMouseOver:SkillsMouseOver;
		private var _root:Object;
		public var selectedTower:Tower;
		private var sellToolTip:SellIconToolTip;
		private var targetToolTip:TargetToolTip;

		public var upgradeCircle:Shape;


		public function MenuManager()
		{

			currentMenuSelected = new Array  ;
			cellsArray = new Array  ;
			_root = common.Commons.getRoot();

			var glow2:GlowFilter = new GlowFilter(0xFF0000,1,6,6,2);
			upgradeCircle = new Shape();
			upgradeCircle.graphics.lineStyle(1,0xFFFFFF,1,false,"none");
			upgradeCircle.graphics.drawCircle(0,0,100);
			upgradeCircle.visible = false;
			upgradeCircle.filters = [glow2];
			addChild(upgradeCircle);

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
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);

			sellObject = new SellObject();
			addChild(sellObject);
			sellObject.visible = false;
			
			sellToolTip = new SellIconToolTip();
			addChild(sellToolTip);
			sellToolTip.visible = false;

			targetingIcon = new TargetingIcon();
			addChild(targetingIcon);
			targetingIcon.visible = false;
			
			targetToolTip = new TargetToolTip();
			addChild(targetToolTip)
			targetToolTip.visible = false;

			upgradeIcon = new UpgradeIcon();
			addChild(upgradeIcon);
			upgradeIcon.visible = false;

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

			skillsMouseOver = new SkillsMouseOver  ;
			addChild(skillsMouseOver);
			skillsMouseOver.visible = false;

			returnToDefaultMenu();
		}
		public function keyDownPress(e:KeyboardEvent):void
		{
		}
		public function returnToDefaultMenu():void
		{
			selectedTower = null;
			emptyOutMenuSelected();
			towerStatsOver.visible = false;
			upgradeCircle.visible = false;
			skillsMouseOver.visible = false;
			sellToolTip.visible = false;
			targetToolTip.visible = false

			currentMenuSelected = [[Warrior,Arrow,FireTower,IceTower],
			   [Splash,Lightning,Demonologist,],
			   [,,,]];
			if (Commons.devMode == true)
			{
				currentMenuSelected[1][3] = Tinkerer
			}
			menuIsDefault = true;
			hideTowerBeingBuiltSquare();
			updateCurrentMenu();
		}
		public function keyDownHandler(e:KeyboardEvent):void
		{
			if (menuIsDefault == true)
			{
				var tower:Object;

				switch (e.keyCode)
				{
					case (Keyboard.NUMBER_1) :
						tower = currentMenuSelected[0][0];
						selectTower(tower);
						break;

					case (Keyboard.NUMBER_2) :
						tower = currentMenuSelected[0][1];
						selectTower(tower);
						break;

					case (Keyboard.NUMBER_3) :
						tower = currentMenuSelected[0][2];
						selectTower(tower);
						break;

					case (Keyboard.NUMBER_4) :
						tower = currentMenuSelected[0][3];
						selectTower(tower);
						break;

					case (Keyboard.NUMBER_5) :
						tower = currentMenuSelected[1][0];
						selectTower(tower);
						break;

					case (Keyboard.NUMBER_6) :
						tower = currentMenuSelected[1][1];
						selectTower(tower);
						break;

					case (Keyboard.NUMBER_7) :
						tower = currentMenuSelected[1][2];
						selectTower(tower);
						break;

					case (Keyboard.NUMBER_8) :
						if (Commons.devMode == true)
						{
						tower = currentMenuSelected[1][3];
						selectTower(tower);
						}
						break;


				}
			}
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

								var psuedoTower:PsuedoTower = new PsuedoTower(ct,false);
								psuedoTower.x = cellsArray[i][p].x;
								psuedoTower.y = cellsArray[i][p].y;
								addChild(psuedoTower);

								currentMenuSelected[i][p] = psuedoTower;

								ct = null;

								currentMenuSelected[i][p].addEventListener(MouseEvent.CLICK, selectTowerMouse);
								currentMenuSelected[i][p].addEventListener(MouseEvent.MOUSE_OVER, mouseHoverOver);
								currentMenuSelected[i][p].addEventListener(MouseEvent.MOUSE_OUT, mouseHoverOut);

								break;

							case (getQualifiedSuperclassName(ct) == getQualifiedClassName(TowerSkill)) :
								ct.x = cellsArray[i][p].x;
								ct.y = cellsArray[i][p].y;
								ct.addEventListener(MouseEvent.MOUSE_OVER, mouseHoverOver);
								ct.addEventListener(MouseEvent.MOUSE_OUT, mouseHoverOut);
								addChild(ct);
								break;

							case (ct is String) :
								switch (true)
								{
									case (ct == "Sell") :
										sellObject.x = cellsArray[2][0].x;
										sellObject.y = cellsArray[2][0].y;
										sellObject.visible = true;
										sellObject.addEventListener(MouseEvent.CLICK, sellObjectClicked);
										sellObject.addEventListener(MouseEvent.MOUSE_OVER, sellHoverOver);
										sellObject.addEventListener(MouseEvent.MOUSE_OUT, sellHoverOut);
										break;

									case (ct == "Targeting") :
										targetingIcon.x = cellsArray[1][0].x;
										targetingIcon.y = cellsArray[1][0].y;
										targetingIcon.visible = true;
										targetingIcon.addEventListener(MouseEvent.CLICK, targetingIconClicked);
										targetingIcon.addEventListener(MouseEvent.MOUSE_OVER, targetHoverOver);
										targetingIcon.addEventListener(MouseEvent.MOUSE_OUT, targetHoverOut);
										break;

									case (ct == "UpgradeMe") :

										upgradeIcon.x = cellsArray[1][3].x + 1;
										upgradeIcon.y = cellsArray[1][0].y + 2;
										upgradeIcon.visible = true;
										upgradeIcon.addEventListener(MouseEvent.CLICK, upgradeIconClicked);
										break;
								}
						}
					}
				}
			}
		}
		private function targetHoverOver(e:Event):void
		{
			targetToolTip.visible = true;
			targetToolTip.x = targetingIcon.x
			targetToolTip.y = targetingIcon.y;
		}
		private function targetHoverOut(e:Event):void
		{
			targetToolTip.visible = false;
		}
		private function sellHoverOver(e:Event):void
		{
			sellToolTip.visible = true;
			sellToolTip.x = sellObject.x
			sellToolTip.y = sellObject.y;
		}
		private function sellHoverOut(e:Event):void
		{
			sellToolTip.visible = false;
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
		public function hideTowerBeingBuiltSquare():void
		{
			towerBeingBuiltSquare.visible = false;
		}
		private function mouseHoverOut(e:Event):void
		{
			switch (true)
			{
				case (getQualifiedClassName(e.currentTarget) == getQualifiedClassName(PsuedoTower)) :
					towerStatsOver.visible = false;
					upgradeCircle.visible = false;
					break;

				case (getQualifiedSuperclassName(e.currentTarget)==getQualifiedClassName(TowerSkill)) :
					skillsMouseOver.visible = false;
					break;
			}

		}
		private function mouseHoverOver(e:Event):void
		{
			switch (true)
			{
				case (getQualifiedClassName(e.currentTarget) == getQualifiedClassName(PsuedoTower)) :

					towerStatsOver.visible = true;
					setChildIndex(towerStatsOver, numChildren -1);
					parent.setChildIndex(this, parent.numChildren - 1);

					towerStatsOver.x = e.currentTarget.x;
					towerStatsOver.y = e.currentTarget.y - towerStatsOver.height - 10;
					if (e.currentTarget.parent.x + towerStatsOver.x + towerStatsOver.width > stage.stageWidth)
					{
						var a:Number = stage.stageWidth;
						var b:Number = e.currentTarget.parent.x + towerStatsOver.x + towerStatsOver.width;
						var c:Number = b - a;
						towerStatsOver.x -=  c + 3;
					}

					towerStatsOver.NameBox.text = e.currentTarget.tName;
					towerStatsOver.DmgBox.text = e.currentTarget.tDmg;
					towerStatsOver.SpdBox.text = String((24 / e.currentTarget.tAtkSpeed).toFixed(2));
					towerStatsOver.RngBox.text = e.currentTarget.tRange;
					towerStatsOver.TypeBox.text = e.currentTarget.tType;
					towerStatsOver.DescBox.text = e.currentTarget.tDescription;
					if (selectedTower != null)
					{
						upgradeCircle.visible = true;
						upgradeCircle.width = e.currentTarget.tRange * 2;
						upgradeCircle.height = e.currentTarget.tRange * 2;

						var topLeftStage:Point = this.localToGlobal(new Point());
						var nextX:int = topLeftStage.x;
						var nextY:int = topLeftStage.y;
						
						//trace("MCT.x: ", _root.mouseclickedTower.x, "nextX: ", nextX, "MCT.y: ", _root.mouseclickedTower.y, "nextY: ", nextY);
						
						upgradeCircle.x = _root.mouseclickedTower.x + (common.Commons.tileSide * .5) - nextX
						upgradeCircle.y = _root.mouseclickedTower.y + (common.Commons.tileSide * .5) - nextY;


					}
					//towerStatsOver.DpsBox.text = String(int((Number(e.currentTarget.tDmg) * Number(24 / Number(e.currentTarget.tAtkSpeed)))*100)/100);
					towerStatsOver.CostBox.text = e.currentTarget.tCost;
					break;

				case (getQualifiedSuperclassName(e.currentTarget) == getQualifiedClassName(TowerSkill)) :
					skillsMouseOver.visible = true;
					setChildIndex(skillsMouseOver, numChildren -1);
					parent.setChildIndex(this, parent.numChildren - 1);

					skillsMouseOver.x = e.currentTarget.x;
					skillsMouseOver.y = e.currentTarget.y - 110;
					if (e.currentTarget.parent.x + skillsMouseOver.x + skillsMouseOver.width > stage.stageWidth)
					{
						var a2:Number = stage.stageWidth;
						var b2:Number = e.currentTarget.parent.x + skillsMouseOver.x + skillsMouseOver.width;
						var c2:Number = b2 - a2;
						skillsMouseOver.x -=  c2 + 3;
					}
					skillsMouseOver.sName.text = e.currentTarget.sName;
					skillsMouseOver.sEffectOneName.text = e.currentTarget.eMenuNameOne;
					skillsMouseOver.sEffectOne.text = e.currentTarget.eMenuStatOne;
					skillsMouseOver.sEffectTwoName.text = e.currentTarget.eMenuNameTwo;
					skillsMouseOver.sEffectTwo.text = e.currentTarget.eMenuStatTwo;
					skillsMouseOver.sEffectThreeName.text = e.currentTarget.eMenuNameThree;
					skillsMouseOver.sEffectThree.text = e.currentTarget.eMenuStatThree;
					skillsMouseOver.sEffectFourName.text = e.currentTarget.eMenuNameFour;
					skillsMouseOver.sEffectFour.text = e.currentTarget.eMenuStatFour
					;
					break;
			}
		}
		public function towerMapClicked(e:Event):void
		{
			updateMenu(e);
			selectedTower = e.currentTarget as Tower;
			targetingIcon.importTower(selectedTower);
			upgradeIcon.importTower(selectedTower);
		}
		private function upgradeIconClicked(e:Event):void
		{
			upgradeIcon.upgradeTower();
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
			_root.sellTower(selectedTower);
		}
		private function targetingIconClicked(e:MouseEvent):void
		{
			targetingIcon.changeTargeting();
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

							case (ct is TowerSkill) :
								ct.removeEventListener(MouseEvent.MOUSE_OVER, mouseHoverOver);
								ct.removeEventListener(MouseEvent.MOUSE_OUT, mouseHoverOut);
								removeChild(ct);
								break;
							case (ct is String) :
								if (ct == "Sell")
								{
									sellObject.visible = false;
									sellObject.removeEventListener(MouseEvent.CLICK, sellObjectClicked);
									sellObject.removeEventListener(MouseEvent.MOUSE_OVER, sellHoverOver);
									sellObject.removeEventListener(MouseEvent.MOUSE_OUT, sellHoverOut);
								}
								else if (ct == "Targeting")
								{
									targetingIcon.visible = false;
									targetingIcon.removeEventListener(MouseEvent.CLICK, targetingIconClicked);
									targetingIcon.removeEventListener(MouseEvent.MOUSE_OVER, targetHoverOver);
									targetingIcon.removeEventListener(MouseEvent.MOUSE_OUT, targetHoverOut);
								}
								else if (ct == "UpgradeMe")
								{
									upgradeIcon.visible = false;
									upgradeIcon.removeEventListener(MouseEvent.CLICK, upgradeIconClicked);
								}
						}
						currentMenuSelected[i][p] = null;
					}
				}
			}
		}
		public function endClass():void
		{

			emptyOutMenuSelected();
			removeChild(sellToolTip);
			removeChild(targetToolTip);
			removeChild(upgradeCircle);
			removeChild(sellObject);
			removeChild(targetingIcon);
			removeChild(upgradeIcon);
			removeChild(towerStatsOver);
			removeChild(skillsMouseOver);
			removeChild(towerBeingBuiltSquare);
			towerBeingBuiltSquare = null;
			sellObject = null;
			sellToolTip = null;
			targetingIcon = null;
			upgradeIcon = null;
			towerStatsOver = null;
			skillsMouseOver = null;

			selectedTower = null;
			_root = null;

			currentMenuSelected = [];
			cellsArray = [];
		}

	}

}