package design {
	
	import flash.display.MovieClip;
	import towers.Tower;
	import flash.events.Event;
	
	public class MiddleInfoContent extends MovieClip {
		
		
		public function MiddleInfoContent() {
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
					RangeField.text = sentObject.tRange;
					break;
					
				default :
					gotoAndStop(1);
					break;
			}
		}
	}
	
}
