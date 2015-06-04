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
			
			var bottomBar:Shape = new Shape();
			bottomBar.graphics.beginFill(0x333333);
			bottomBar.graphics.drawRect(0,0,740,100);
			bottomBar.graphics.endFill();
			bottomBar.y = 416;
			
			_root.addChild(bottomBar);
			
			upgrade1 = new TextField();
			upgrade1.text = "Upgrade One has a full list of effects which includes but is not limited to having the ability to sprew fire from ones mouth and burning the enemy."
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
			upgrade2.text = "Upgrade 2 has a full list of effects which includes but is not limited to having the ability to sprew fire from ones mouth and burning the enemy."
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
			upgrade3.text = "Upgrade 3  has a full list of effects which includes but is not limited to having the ability to sprew fire from ones mouth and burning the enemy."
			upgrade3.wordWrap = true;
			upgrade3.width = 190
			upgrade3.height = 90
			upgrade3.textColor = 0xFFFFFF
			upgrade3.x=400
			upgrade3.y=416
			upgrade3.name = "upgrade3"
			
			
			upgrade3.selectable = false
			
			
			_root.addChild(upgrade3);
		}
	}
	
}
