package design {
	
	import flash.display.MovieClip;
	import flash.events.*
	import common.Commons;
	
	public class RoundBar extends MovieClip {
		
		
		private var roundsList:Array;
		
		public function RoundBar() {
			roundsList = common.Commons.getRoundsList();
			addEventListener(Event.ADDED_TO_STAGE, added)
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added)
			eRound.text = String(1);
			neRound.text = String(2);
			eName.text = roundsList[0][9]
			eArmor.text = roundsList[0][7]
			neName.text = roundsList[1][9]
			neArmor.text = roundsList[1][7]
		}
		public function updateRoundList(r:int):void
		{
			r--;
			if (r > 1)
			{
			eRound.text = String(r)
			neRound.text = String(r+1)
			eName.text = roundsList[r-1][9]
			eArmor.text = roundsList[r-1][7]
			neName.text = roundsList[r][9]
			neArmor.text = roundsList[r][7]
			}
		}
		public function endClass():void
		{
			roundsList = [];
		}
	}	
}
