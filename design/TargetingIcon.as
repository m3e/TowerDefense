package design {
	
	import flash.display.MovieClip;
	import towers.Tower;
	
	public class TargetingIcon extends MovieClip 
	{
		
		
		private var tower:Tower;
		private var targeting:String;
		
		public function TargetingIcon() 
		{
			// constructor code
		}
		public function importTower(_Tower:Tower)
		{
			tower = _Tower;
			updateTargetText();
		}
		private function updateTargetText():void
		{
			TargetText.text = tower.targeting;
			targeting = tower.targeting;
		}
		public function changeTargeting():void
		{
			switch (true)
			{
				case (targeting == "First"):
				tower.targeting = "Last"
				break;
				
				case (targeting == "Last"):
				tower.targeting = "Strong"
				break;
				
				case (targeting == "Strong"):
				tower.targeting = "Weak"
				break;
				
				case (targeting == "Weak"):
				tower.targeting = "First"
				break;
				
				case (targeting == "All"):
				
				break;
			}
			updateTargetText()
		}
	}
	
}
