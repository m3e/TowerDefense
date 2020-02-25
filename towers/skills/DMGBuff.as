package towers.skills {
	
	import flash.display.MovieClip;
	import towers.Tower;
	
	
	public class DMGBuff extends TowerSkill {
		
		
		public function DMGBuff(SourceObject:Tower,SA:Array) {
			super(SourceObject,SA);
			sName = "Tower Damage Bonus";
			eMenuNameOne = "Damage Increase: ";
			eMenuStatOne = (sA[2] * 100) + "%";
			// constructor code
		}
		override protected function doTowerSkill():void
		{
			var towerCheck:Array = checkGridFor(sourceObject,sA[3],"Tower");
			//trace("Towercheck: ",towerCheck,"Sa: ",sA[2])
			for (var i:int=0; i < towerCheck.length; i++)
			{
				if (towerCheck[i].tDmgBuff < sA[2])
				{
					//trace("Adding buff: ",towerCheck[i])
					towerCheck[i].tDmgBuff = sA[2];
				}
			}
		}
		override protected function deactivateSkill():void
		{
			var towerCheck:Array = checkGridFor(sourceObject,sA[3],"Tower");
			//trace("ASbuff: deactivate skill");
			for (var i:int=0; i < towerCheck.length; i++)
			{
				if (towerCheck[i].tDmgBuff == sA[2])
				{
					towerCheck[i].tDmgBuff = 0;
				}
			}
		}
	}
	
}
