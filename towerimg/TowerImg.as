package towerimg {
	
	import flash.display.Sprite;
	import towers.*
	import flash.events.Event;
	
	public class TowerImg extends Sprite{

		public var towerReference:Object;
		public var tRange:int;
		public var tDmg:int;
		public var tAtkSpeed:int;
		public var tType:String;
		public var tDescription:String;
		
		public function TowerImg() {
			addEventListener(Event.ADDED, imgAdded)
			// constructor code
		}
		private function imgAdded (e:Event):void
		{
			var mockTower:Tower = new towerReference();
			
			tRange = mockTower.tRange;
			tDmg = mockTower.tDmg;
			tAtkSpeed = mockTower.tAtkSpeed
			tType = mockTower.tType
			tDescription = mockTower.tDescription
			
			mockTower.destroyTower();
		}

	}
	
}
