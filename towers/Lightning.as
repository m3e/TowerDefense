package towers {
	
	import flash.display.MovieClip;
	import towers.Multishooter;
	
	
	public class Lightning extends Tower {
		
		
		public function Lightning() {
			tName = "Lightning";
			super();
			// constructor code
		}
		override public function upgradeOne():Class
		{
			return Multishooter
		}
	}
	
}
