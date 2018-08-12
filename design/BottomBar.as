package design
{

	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.display.Sprite;
	import design.MenuManager;
	public class BottomBar extends Sprite
	{

		private var _root:Object;


		public function BottomBar(e:Object)
		{
			_root = e;

			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, addSelf);
		}
		private function addSelf(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addSelf);
		}

	}

}