package towerimg {
	
	import flash.display.MovieClip
	import towers.*
	import flash.events.Event;
	import towers.skills.TowerSkillManager;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class PsuedoTower extends MovieClip{

		public var towerReference:Object;
		public var tRange:int;
		public var tDmg:int;
		public var tAtkSpeed:int;
		public var tType:String;
		public var tDescription:String;
		public var tCost:int;
		public var tName:String;
		private var tId:int;
		private var bmpData:BitmapData;
		private var bmp:Bitmap;
		private var small:Boolean;
		
		public function PsuedoTower(TowerReference:Object,Small:Boolean) {
			
			small = Small;
			stop();
			towerReference = TowerReference;
			addEventListener(Event.ADDED, imgAdded)
			addEventListener(Event.REMOVED_FROM_STAGE, removed)
			// constructor code
		}
		private function imgAdded (e:Event):void
		{
			removeEventListener(Event.ADDED, imgAdded)
			
			var mockTower:Tower = new towerReference(undefined)//tsm);
			tName = mockTower.tName;
			tRange = mockTower.tRange;
			tDmg = mockTower.tDmg;
			tAtkSpeed = mockTower.tAtkSpeed
			tType = mockTower.tType
			tDescription = mockTower.tDescription
			tCost = mockTower.tCost;
			
			if (small == true)
			{
				bmpData = mockTower.bmpData;
			}
			else
			{
				bmpData = mockTower.bmpData45;
			}
			bmp = new Bitmap(bmpData);
			addChild(bmp);

			mockTower.destroyTower();
			mockTower = null;
			
		}
		private function removed(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removed)
			removeChild(bmp)
			bmp=null;
			bmpData = null;
			towerReference = null;
		}

	}
	
}
