package Maps.Maps {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import design.LockedMapIcon;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import common.Commons;
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import com.greensock.loading.ImageLoader;
	import com.greensock.events.LoaderEvent;
	import flash.display.Bitmap;
	
	public class MapSelections extends MovieClip {
		
		public var mapArray:Array;
		private var lmi:LockedMapIcon;
		public var mapLocked:Boolean;
		protected var mapID:String;
		protected var gameName:String;
		private var roundsList:Array;
		public var startX:int = 0;
		public var startY:int = 6;
		
		private var loaderURL:String;
		private var imgLoader:ImageLoader;
		
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
			common.Commons.setStartPoints(startX,startY);
			var xmlName:String
			
			switch (gMode)
			{
				case (0):
				xmlName = "Survival.xml"
				//xmlName = mapID + ".xml"
				break;
				
				case (1):
				xmlName = "Survival.xml"
				break;
			}
			loaderURL = "Maps/Maps/"+xmlName
			setupEnemyImages();
			
		}
		private function setupEnemyImages():void
		{
			imgLoader = new ImageLoader("enemies/EnemySpriteSheet.png", {name:"enemySS"});
			imgLoader.addEventListener(Event.COMPLETE,compileEnemyImages);
			imgLoader.load();
			
		}
		private function compileEnemyImages(e:Event):void
		{
			
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
			
			var rect:Rectangle = new Rectangle(0,0,common.Commons.tileSide,common.Commons.tileSide);
			var pt:Point = new Point();
			var bmp:Bitmap = imgLoader.rawContent;
			var bmpData:BitmapData;
			
			var bmpWidth:int = bmp.width / common.Commons.tileSide
			var bmpHeight:int = bmp.height / common.Commons.tileSide
			
			while (i < myXML.Row.length())
			{
				var roundNumber:int = int(myXML.Row[i].currentRound);
				rect.x = (i % bmpWidth) * common.Commons.tileSide
				rect.y = Math.floor(i / bmpWidth) * common.Commons.tileSide
				bmpData = new BitmapData(common.Commons.tileSide,common.Commons.tileSide);
				bmpData.copyPixels(bmp.bitmapData,rect,pt);
				
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
				
				var s1:String = myXML.Row[i].eSkillOne;
				var s2:String = myXML.Row[i].eSkillTwo;
				var s3:String = myXML.Row[i].eSkillThree;
				
				var waveData:Array = [maxHp,maxMoveSpeed,goldValue,maxArmor,numberOfEnemies,freq,roundNumber,armorType,endBonus,eName,s1,s2,s3,bmpData];
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
