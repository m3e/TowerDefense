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
		
		public var gunTowerImg:GunTowerImg;
		public var splashTowerImg:SplashTowerImg;
		public var laserTowerImg:LaserTowerImg;
		public var iceTowerImg:IceTowerImg;
		public var warriorTowerImg:WarriorTowerImg
		public var flameThrowerTowerImg:FlameThrowerTowerImg;
		public var arrowTowerImg:ArrowTowerImg;
		
		public var towerList:Array;
		
		private var enemyList:Array;
		
		public function TowersInitiate(_Root:Object,EnemyList:Array) {
			enemyList = EnemyList
			_root = _Root
			
			towerList = new Array;
			
			//Add tower IMG
			
			gunTowerImg = new GunTowerImg();
			splashTowerImg = new SplashTowerImg();
			laserTowerImg = new LaserTowerImg();	
			iceTowerImg = new IceTowerImg();
			warriorTowerImg = new WarriorTowerImg();
			flameThrowerTowerImg = new FlameThrowerTowerImg();
			arrowTowerImg = new ArrowTowerImg();
			
			
			
			towerList.push(warriorTowerImg,arrowTowerImg,flameThrowerTowerImg,iceTowerImg,splashTowerImg,gunTowerImg,laserTowerImg)
			
			
			
			
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
				
				//var klasa:Class = getDefinitionByName(getQualifiedClassName(towerList[i])) as Class
				//towerList[i] = new klasa()
				
				if (towersInRow == towersPerRow)
				{
					extraRows++
					towersInRow = 0;
				}
				
				towerList[i].x = 810 + (45 * towersInRow)
				//mapArray.length * tileSide + 10
				towerList[i].y = 10 + (45 * extraRows)
				
				towersInRow++;
				
				_root.addChild(towerList[i]);
			}
		}

	}
	
}
