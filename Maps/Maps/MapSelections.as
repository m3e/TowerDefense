package Maps.Maps {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import design.LockedMapIcon;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import common.Commons;
	
	public class MapSelections extends MovieClip {
		
		public var mapArray:Array;
		private var lmi:LockedMapIcon;
		public var mapLocked:Boolean;
		protected var mapID:String;
		protected var gameName:String;
		private var roundsList:Array;
		
		public function MapSelections() {
			mapArray = new Array;
			lmi = new LockedMapIcon;
			lmi.mouseEnabled = false
			addEventListener(Event.ADDED, added)
			addEventListener(Event.REMOVED, removed)
			setMapArray();
			//setupRoundsList()
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED, added);
			lmi.alpha = .4
			mapLocked = true;
			addChild(lmi)
		}
		internal function setMapArray():void
		{
		}
		public function unlockMap():void
		{
			mapLocked = false;
			lmi.visible = false;
		}
		public function lockMap():void
		{
			mapLocked = true;
			lmi.visible = true;
		}
		public function startGame(gMode:int):void
		{
			common.Commons.setMapArray(mapArray);
			var xmlName:String
			
			switch (gMode)
			{
				case (0):
				xmlName = mapID + ".xml"
				break;
				
				case (1):
				xmlName = "Survival.xml"
				break;
			}
			var loaderURL:String = "Maps/Maps/"+xmlName
			setupRoundsList(loaderURL);
		}
		private function setupRoundsList(loaderURL:String):void
		{
			var mLoader:URLLoader = new URLLoader();
			mLoader.addEventListener(Event.COMPLETE,compileRoundsList);
			mLoader.load(new URLRequest(loaderURL));
		}
		private function compileRoundsList(e:Event):void
		{
			var myXML = new XML(e.target.data);
			var i:int = 0;
			roundsList = new Array  ;
			while (i < myXML.Row.length())
			{
				var roundNumber:int = int(myXML.Row[i].currentRound);
				var maxHp:int = int(myXML.Row[i].maxHp);
				var maxMoveSpeed:Number = Number(myXML.Row[i].maxMoveSpeed);
				var goldValue:int = int(myXML.Row[i].goldValue);
				//var numberOfEnemies:int = 1;
				var numberOfEnemies:int = int(myXML.Row[i].numberOfEnemies);
				var endBonus:int = int(myXML.Row[i].roundEndBonus);
				var freq:int = int(myXML.Row[i].freq);
				var armorType:String = String(myXML.Row[i].armorType);
				var maxArmor:int = int(myXML.Row[i].maxArmor);
				var eName:String = String(myXML.Row[i].eName);
				var waveData:Array = [maxHp,maxMoveSpeed,goldValue,maxArmor,numberOfEnemies,freq,roundNumber,armorType,endBonus,eName];
				roundsList.push(waveData);
				i++;
			}
			common.Commons.setRoundsList(roundsList);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		private function removed(e:Event):void
		{
			removeEventListener(Event.REMOVED,removed)
			removeChild(lmi);
			lmi = null;
		}
		
	}
	
}
