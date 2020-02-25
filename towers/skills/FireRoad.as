package towers.skills {
	
	import flash.display.MovieClip;
	import towers.Tower;
	
	public class FireRoad extends TowerSkill {
		
		
		public function FireRoad(ThisTower:Tower,SA:Array)
		{
			super(ThisTower,SA);
			sName = "Scorched Road";
			eMenuNameOne = "Burn per second: ";
			eMenuStatOne = sA[2];
		}
		override protected function doTowerSkill():void
		{
			var roadCheck:Array = checkGridFor(sourceObject,sA[3],"Road",true);
			for (var b:int=0; b < roadCheck.length; b++)
			{
				roadCheck[b].addFireLayer(this,sA[2]);
			}
		}
		override protected function deactivateSkill():void
		{
			var roadCheck:Array = checkGridFor(sourceObject,sA[3],"Road",true);
			for (var i:int=0; i < roadCheck.length; i++)
			{
				if (roadCheck[i].isOnFire)
				{
					roadCheck[i].removeFireLayer(this,sA[2]);
				}
			}
		}
	}
	
}
