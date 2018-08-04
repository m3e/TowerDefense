package controls.mouse
{

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;


	public class MouseControls extends Sprite
	{

		private var towerList:Array;


		public function MouseControls(TowerList:Array, myParent:Object)
		{

			towerList = new Array  ;
			towerList = TowerList;
			for (var i:int=0; i < towerList.length; i++)
			{
				towerList[i].addEventListener(MouseEvent.CLICK, myParent.selectTowerMouse);
				towerList[i].addEventListener(MouseEvent.MOUSE_OVER, myParent.mouseHoverOver);
				towerList[i].addEventListener(MouseEvent.MOUSE_OUT, myParent.mouseHoverOut);
			}
			// constructor code
		}

	}

}