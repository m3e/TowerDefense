﻿package towers {
	
	import flash.display.MovieClip;
	import flash.events.*
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import towers.*
	import towerimg.*
	
	public class TowersInitiate extends MovieClip {
		
		private var _root:Object;
		
		public var bulletTowerImg:BulletTowerImg;
		public var splashTowerImg:SplashTowerImg;
		public var laserTowerImg:LaserTowerImg;
		public var flameGroundImg:FlameGroundImg;
		
		public var towerList:Array;
		
		public function TowersInitiate(_Root:Object) {
			towerList = new Array;
			
			bulletTowerImg = new BulletTowerImg();
			splashTowerImg = new SplashTowerImg();
			laserTowerImg = new LaserTowerImg();	
			flameGroundImg = new FlameGroundImg();
			
			towerList.push(bulletTowerImg,splashTowerImg,laserTowerImg,flameGroundImg)
			
			_root = _Root
			initiateTowers();
			// constructor code
		}
		private function initiateTowers():void
		{
			var towersPerRow:int = 2
			var towersInRow:int = 0
			var extraRows:int=0;
			for (var i:int=0; i < towerList.length; i++)
			{
				
				var klasa:Class = getDefinitionByName(getQualifiedClassName(towerList[i])) as Class
				towerList[i] = new klasa()
				
				if (towersInRow == towersPerRow)
				{
					extraRows++
					towersInRow = 0;
				}
				
				towerList[i].x = 660 + (50 * towersInRow)
				towerList[i].y = 40 + (50 * extraRows)
				
				towersInRow++;
				
				_root.addChild(towerList[i]);
			}
		}

	}
	
}
