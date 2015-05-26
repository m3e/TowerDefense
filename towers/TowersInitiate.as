package towers {
	
	import flash.display.MovieClip;
	import flash.events.*
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import towers.*
	import towerimg.*
	
	import debuffs.*;
	
	public class TowersInitiate extends MovieClip {
		
		private var _root:Object;
		
		public var bulletTowerImg:BulletTowerImg;
		public var splashTowerImg:SplashTowerImg;
		public var laserTowerImg:LaserTowerImg;
		public var flameGroundImg:FlameGroundImg;
		public var iceTowerImg:IceTowerImg;
		public var meleeSwordTowerImg:MeleeSwordTowerImg
		public var flameThrowerTowerImg:FlameThrowerTowerImg;
		
		public var towerList:Array;
		
		private var enemyList:Array;
		
		public function TowersInitiate(_Root:Object,EnemyList:Array) {
			enemyList = EnemyList
			_root = _Root
			
			towerList = new Array;
			
			//Add tower IMG
			bulletTowerImg = new BulletTowerImg();
			splashTowerImg = new SplashTowerImg();
			laserTowerImg = new LaserTowerImg();	
			flameGroundImg = new FlameGroundImg();
			iceTowerImg = new IceTowerImg();
			meleeSwordTowerImg = new MeleeSwordTowerImg();
			flameThrowerTowerImg = new FlameThrowerTowerImg();
			
			towerList.push(bulletTowerImg,splashTowerImg,laserTowerImg,flameGroundImg,iceTowerImg,meleeSwordTowerImg,flameThrowerTowerImg)
			
			
			
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
		private function addTower(addedTower:Tower):void
		{
			
		}

	}
	
}
