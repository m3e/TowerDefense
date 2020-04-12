package design {
	
	import flash.display.MovieClip;
	import towers.Tower;
	import flash.events.Event;
	import flash.display.Bitmap;
	
	public class MiddleInfoContent extends MovieClip {
		
		private var bmp:Bitmap;
		public function MiddleInfoContent() {
			bmp = new Bitmap();
			addChild(bmp)
			gotoAndStop(1);
			// constructor code
		}
		public function updateText(sentObject:Object):void
		{
			
			switch (true)
			{
				case sentObject is Tower :
					gotoAndStop(2);
					NameField.text = String(sentObject.tName);
					TypeField.text = sentObject.tType
					DmgField.text = sentObject.getDmg().toFixed(2);
					ApsField.text = (24 / sentObject.getAtkSpeed()).toFixed(2);
					removeChild(bmp)
					bmp.visible = true;
					bmp = new Bitmap(sentObject.bmpData45)
					bmp.x = phA.x
					bmp.y = phA.y
					addChild(bmp)
					RangeField.text = sentObject.tRange;
					break;
					
				default :
					bmp.visible = false;
					gotoAndStop(1);
					break;
			}
		}
	}
	
}
