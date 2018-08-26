package towerimg {
	
	import flash.display.MovieClip
	import towers.*
	import flash.events.Event;
	
	
	public class PsuedoTower extends MovieClip{

		public var towerReference:Object;
		public var tRange:int;
		public var tDmg:int;
		public var tAtkSpeed:int;
		public var tType:String;
		public var tDescription:String;
		public var tCost:int;
		private var tId:int;
		private var tFrame:int;
		
		public function PsuedoTower(TowerReference:Object) {
			towerReference = TowerReference;
			addEventListener(Event.ADDED, imgAdded)
			addEventListener(Event.REMOVED_FROM_STAGE, removed)
			// constructor code
		}
		private function imgAdded (e:Event):void
		{
			removeEventListener(Event.ADDED, imgAdded)
			var mockTower:Tower = new towerReference();
			tRange = mockTower.tRange;
			tDmg = mockTower.tDmg;
			tAtkSpeed = mockTower.tAtkSpeed
			tType = mockTower.tType
			tDescription = mockTower.tDescription
			tCost = mockTower.tCost;
			tFrame = mockTower.tFrame;
			gotoAndStop(tFrame);

			mockTower.destroyTower();
			
		}
		private function removed(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removed)
			towerReference = null;
		}

	}
	
}
