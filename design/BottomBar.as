package design{
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.text.TextField;
	
	public class BottomBar extends Sprite {
		
		private var _root:MovieClip;
		public var upgrade1:TextField;
		public var upgrade2:TextField;
		public var upgrade3:TextField;
		
		public function BottomBar() {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, addSelf)
		}
		private function addSelf(e:Event):void
		{
			_root = MovieClip(root);
			removeEventListener(Event.ADDED_TO_STAGE, addSelf)
			
			/*var bottomBar:Shape = new Shape();
			bottomBar.graphics.beginFill(0x333333);
			bottomBar.graphics.drawRect(0,0,900,100);
			bottomBar.graphics.endFill();
			bottomBar.y = 416;
			
			_root.addChildAt(bottomBar,_root.getChildIndex(_root.getChildByName("goldBox")) - 1);
			
			upgrade1 = new TextField();
			upgrade1.text = "It's still Alpha so I'm only going to explain this once.  Those squares at the top right are towers.  Q 1x speed, W 2x speed, E 4x, R = 1 frame per second."
			upgrade1.wordWrap = true;
			upgrade1.width = 190
			upgrade1.height = 90
			upgrade1.textColor = 0xFFFFFF
			upgrade1.x=0
			upgrade1.y=416
			upgrade1.name = "upgrade1"
			
			
			upgrade1.selectable = false
			
			
			_root.addChild(upgrade1);
			
			upgrade2 = new TextField();
			upgrade2.text = "Click start.  When enemies stop coming, round is finished, press start again.  DPS test dummy sends an invincible punching bag that displays dps.  Advise don't send during round."
			upgrade2.wordWrap = true;
			upgrade2.width = 190
			upgrade2.height = 90
			upgrade2.textColor = 0xFFFFFF
			upgrade2.x=200;
			upgrade2.y=416
			upgrade2.name = "upgrade2"
			
			
			upgrade2.selectable = false
			
			
			_root.addChild(upgrade2);
			
			upgrade3 = new TextField();
			upgrade3.text = "Press Z to toggle health bars.  Read description below this game.  F5 to restart.  Space to start round.  https://github.com/m3e/TowerDefense"
			upgrade3.wordWrap = true;
			upgrade3.width = 190
			upgrade3.height = 90
			upgrade3.textColor = 0xFFFFFF
			upgrade3.x=400
			upgrade3.y=416
			upgrade3.name = "upgrade3"
			
			
			upgrade3.selectable = false
			
			
			_root.addChild(upgrade3);*/
		}
	}
	
}
