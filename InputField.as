﻿package  {
	
	import flash.display.MovieClip;
	import flash.events.*
	
	
	public class InputField extends MovieClip {
		
		
		public function InputField() {
			goldField.restrict = "0-9"
			hpField.restrict = "0-9"
			msField.restrict = "0-9"
			armorField.restrict = "0-9"
			numField.restrict = "0-9"
			freqField.restrict = "0-9"
			
			goldField.text = String(99999)
			hpField.text = String(1)
			msField.text = String(8)
			armorField.text = String(0)
			numField.text = String(1)
			freqField.text = String(1)
			
			// constructor code
		}
		/*private function changedText(e:Event)
		{
			if (e.currentTarget.length == 0)
			{
				
				if (e.currentTarget == numField || e.currentTarget == freqField)
				{
					e.currentTarget.text = 1;
				}
				else 
				{
					e.currentTarget.text = 0;
				}
			}
		}*/
	}
	
}
