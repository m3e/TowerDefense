package towerimg {
	
	import flash.display.Sprite;
	import towers.*
	import flash.events.Event;
	
	public class PsuedoTower extends Sprite{

		public var towerReference:Object;
		public var tRange:int;
		public var tDmg:int;
		public var tAtkSpeed:int;
		public var tType:String;
		public var tDescription:String;
		public var tCost:int;
		private var tFrame:int;
		
		public function PsuedoTower() {
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
			tCost = mockTower.tCost;
			tFrame = mockTower.tFrame;
			
			mockTower.destroyTower();
		}
		private function towerFrame(tFrame):void
		{
			switch (tFrame)
			{
				
			}
		}

	}
	
}
