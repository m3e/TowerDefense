package design {
	
	import flash.display.MovieClip;
	import towers.Tower;
	import flash.events.Event;
	
	public class MiddleInfoContent extends MovieClip {
		
		
		public function MiddleInfoContent() {
			// constructor code
		}
		public function updateText(sentObject:Event):void
		{
			
			switch (true)
			{
				case sentObject.currentTarget is Tower :
					NameField.text = String(sentObject.currentTarget);
					TypeField.text = sentObject.currentTarget.tType
					DmgField.text = sentObject.currentTarget.tDmg
					ApsField.text = String(24 / Number(sentObject.currentTarget.tAtkSpeed ))
					RangeField.text = sentObject.currentTarget.tRange;
					break;
			}
		}
	}
	
}
