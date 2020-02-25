package towers.skills {
	
	import flash.display.MovieClip;
	import towers.Tower;
	
	public class ASBuff extends TowerSkill {
		
		
		public function ASBuff(SourceObject:Tower,SA:Array) {
			super(SourceObject,SA)
			sName = "Tower Attack Speed Bonus";
			eMenuNameOne = "Attack Speed Increase: ";
			eMenuStatOne = (sA[2] * 100) + "%";
			// constructor code
		}
		override protected function doTowerSkill():void
		{
			var towerCheck:Array = checkGridFor(sourceObject,sA[3],"Tower");
			//trace("Towercheck: ",towerCheck,"Sa: ",sA[2])
			for (var i:int=0; i < towerCheck.length; i++)
			{
				if (towerCheck[i].tBaseAtkSpdBuff < sA[2])
				{
					//trace("Adding buff: ",towerCheck[i])
					towerCheck[i].tBaseAtkSpdBuff = sA[2];
				}
			}
		}
		override protected function deactivateSkill():void
		{
			var towerCheck:Array = checkGridFor(sourceObject,sA[3],"Tower");
			//trace("ASbuff: deactivate skill");
			for (var i:int=0; i < towerCheck.length; i++)
			{
				if (towerCheck[i].tBaseAtkSpdBuff == sA[2])
				{
					towerCheck[i].tBaseAtkSpdBuff = 0;
				}
			}
		}
	}
	
}
