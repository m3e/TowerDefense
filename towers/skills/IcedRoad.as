package towers.skills
{

	import flash.display.MovieClip;
	import towers.Tower;

	public class IcedRoad extends TowerSkill
	{


		public function IcedRoad(ThisTower:Tower,SA:Array)
		{
			super(ThisTower,SA);
			sName = "Iced Roads";
			eMenuNameOne = "Road speed slow: ";
			eMenuStatOne = int(sA[2] * 100) + "%";
			// constructor code
		}
		override protected function doTowerSkill():void
		{
			var roadCheck:Array = checkGridFor(sourceObject,sA[3],"Road",true);
			for (var b:int=0; b < roadCheck.length; b++)
			{
				roadCheck[b].addIceLayer(this,sA[2]);
			}
		}
		override protected function deactivateSkill():void
		{
			var roadCheck:Array = checkGridFor(sourceObject,sA[3],"Road",true);
			for (var i:int=0; i < roadCheck.length; i++)
			{
				if (roadCheck[i].isIced)
				{
					roadCheck[i].removeIceLayer(this);
				}
			}
		}
	}
}