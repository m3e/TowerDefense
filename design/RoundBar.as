package design {
	
	import flash.display.MovieClip;
	import flash.events.*
	import common.Commons;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class RoundBar extends MovieClip {
		
		private var roundsList:Array;
		private var crImage:Bitmap;
		private var nrImage:Bitmap;
		private var round:int;
		
		private var roundContainer:Sprite = new Sprite;
		
		public function RoundBar() {
			roundsList = common.Commons.getRoundsList();
			addEventListener(Event.ADDED_TO_STAGE, added)
			// constructor code
		}
		private function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added)
			
			round = 0;
			
			addChildAt(roundContainer,1)
			toolTip.visible = false;
			toolTip.mouseEnabled = false;
			toolTip.mouseChildren = false;
			
			crImage = new Bitmap(common.Commons.getSprite("enemySS",0));
			crImage.x = phA.x
			crImage.y = phA.y;
			roundContainer.addChild(crImage)
			eRound.text = String(1);
			eName.text = roundsList[0][9]
			currentArmor.gotoAndStop(armorIndex(roundsList[round][7]));
			currentArmor.addEventListener(MouseEvent.MOUSE_OVER, mouseHoverOver)
			currentArmor.addEventListener(MouseEvent.MOUSE_OUT, mouseHoverOut)
			
			nrImage = new Bitmap(common.Commons.getSprite("enemySS",1));
			nrImage.x = phB.x
			nrImage.y = phB.y;
			roundContainer.addChild(nrImage)
			neName.text = roundsList[1][9]
			neRound.text = String(2);
			nextArmor.gotoAndStop(armorIndex(roundsList[round+1][7]));
			nextArmor.addEventListener(MouseEvent.MOUSE_OVER, mouseHoverOver)
			nextArmor.addEventListener(MouseEvent.MOUSE_OUT, mouseHoverOut)
		}
		private function mouseHoverOut(e:MouseEvent):void
		{
			toolTip.visible = false;
		}
		private function mouseHoverOver(e:MouseEvent):void
		{
			if (e.currentTarget == currentArmor)
			{
				toolTip.gotoAndStop(armorIndex(roundsList[round][7]))
			}
			else if (e.currentTarget == nextArmor)
			{
				toolTip.gotoAndStop(armorIndex(roundsList[round+1][7]))
			}
			toolTip.visible = true;
			toolTip.x = e.currentTarget.x - toolTip.width + 12
			toolTip.y = e.currentTarget.y - toolTip.height + 12
		}
		private function armorIndex(armor:String):int
		{
			var i:int = 1;
			switch (armor)
			{
				case "light":
				i = 1
				break;
				
				case "medium":
				i = 2
				break;
				
				case "heavy":
				i = 3
				break;
				
				case "siege":
				i = 4
				break;
			}
			return i;
		}
		public function updateRoundList(r:int):void
		{
			trace(r)
			r--;
			round = r;
			if (r > 1)
			{
			roundContainer.removeChild(crImage);
			crImage = new Bitmap(common.Commons.getSprite("enemySS",r-1));
			crImage.x = phA.x
			crImage.y = phA.y;
			roundContainer.addChild(crImage)
			eRound.text = String(r)
			eName.text = roundsList[r-1][9]
			currentArmor.gotoAndStop(armorIndex(roundsList[r-1][7]))
			
			roundContainer.removeChild(nrImage);
			nrImage = new Bitmap(common.Commons.getSprite("enemySS",r));
			nrImage.x = phB.x
			nrImage.y = phB.y;
			roundContainer.addChild(nrImage)
			neRound.text = String(r+1)
			neName.text = roundsList[r][9]
			nextArmor.gotoAndStop(armorIndex(roundsList[r][7]))
			}
		}
		public function endClass():void
		{
			roundsList = [];
		}
	}	
}
