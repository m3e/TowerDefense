package design {
	
	import flash.display.MovieClip;
	import flash.events.*
	
	public class RoundBar extends MovieClip {
		
		
		private var roundsList:Array;
		private var round:int;
		
		public function RoundBar(RoundsList:Array) {
			roundsList = RoundsList
			round = 0
			addEventListener(Event.ADDED_TO_STAGE, added)
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added)
			var r:int = round
			eName.text = roundsList[r][9]
			eArmor.text = roundsList[r][7]
			neName.text = roundsList[r+1][9]
			neArmor.text = roundsList[r+1][7]
		}
		public function updateRoundList():void
		{
			var r:int = round
			eName.text = roundsList[r][9]
			eArmor.text = roundsList[r][7]
			neName.text = roundsList[r+1][9]
			neArmor.text = roundsList[r+1][7]
			round++
			eRound.text = round.toString()
			neRound.text = (round + 1).toString()
			
		}
		
		
	}
	
}
