package design.UI
{

	import flash.display.MovieClip;
	import sounds.SoundManager;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import towers.MachineGun;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import design.UI.MenuButton;
	import common.Commons;

	public class OptionsWindow extends MovieClip
	{

		private var cTarget:Object;
		private var bound1:Rectangle;
		private var bound2:Rectangle;
		private var b1x:int = 326.5;
		private var b1y:int = 273;
		private var b1w:int = 250;
		private var bMap:Boolean;
		private var sharedObject:SharedObject = SharedObject.getLocal("LocalSave")
		public var restartButton:MenuButton;
		public var backToMap:MenuButton;
		
		public function OptionsWindow(BattleMap:Boolean)
		{
			bMap = BattleMap;
			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		private function added(e:Event):void
		{
			bound1 = new Rectangle(b1x,b1y,b1w,0);
			bgVolume.x = b1x + (SoundManager.bgVolume * b1w);
			bgVolume.y = b1y;
			bgVolume.bRec = bound1;
			bound2 = new Rectangle(b1x,b1y + 60,b1w,0);
			fxVolume.x = b1x + (SoundManager.sfxVolume * b1w)
			fxVolume.y = b1y + 60;
			fxVolume.bRec = bound2;
			if (bMap == true)
			{
				restartButton = new MenuButton();
				restartButton.btnText.text = "Restart Map"
				restartButton.scaleX = .4
				restartButton.scaleY = .4
				restartButton.x = 300
				restartButton.y = 350
				addChild(restartButton)
				restartButton.addEventListener(MouseEvent.CLICK, closeOptions)
				
				backToMap = new MenuButton();
				backToMap.scaleX = .4
				backToMap.scaleY = .4
				backToMap.x = 480
				backToMap.y = 350
				backToMap.btnText.text = "Return to Map"
				backToMap.addEventListener(MouseEvent.CLICK, closeOptions)
				addChild(backToMap);
			}
			removeEventListener(Event.ADDED_TO_STAGE, added);
			bgVolume.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			fxVolume.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			optionsBG.addEventListener(MouseEvent.MOUSE_DOWN,closeOptions);
		}
		private function mouseDownHandler(e:MouseEvent):void
		{
			if (cTarget != null)
			{
				cTarget.removeEventListener(Event.ENTER_FRAME, frameEvent);
			}
			cTarget = e.currentTarget;
			cTarget.startDrag(false,cTarget.bRec);
			cTarget.addEventListener(Event.ENTER_FRAME, frameEvent);
		}
		private function frameEvent(e:Event):void
		{
			switch (cTarget.name)
			{
				case ("bgVolume") :
					SoundManager.setMusicVolume((cTarget.x - b1x) / b1w);
					break;

				case ("fxVolume") :
					
					SoundManager.setSfxVolume((cTarget.x - b1x) / b1w);
					break;
			}

		}
		private function mouseUpHandler(e:MouseEvent):void
		{
			if (cTarget != null)
			{
				cTarget.removeEventListener(Event.ENTER_FRAME, frameEvent);
				cTarget.stopDrag();
				cTarget = null;
			}
		}
		private function closeOptions(e:MouseEvent):void
		{
			sharedObject.data.bgVolume = SoundManager.bgVolume;
			sharedObject.data.fxVolume = SoundManager.sfxVolume;
			sharedObject.flush();
			sharedObject = null;
			optionsBG.removeEventListener(MouseEvent.MOUSE_DOWN,closeOptions);
			if (bMap == true)
			{
				restartButton.removeEventListener(MouseEvent.CLICK, closeOptions)
				backToMap.removeEventListener(MouseEvent.CLICK, closeOptions)
				removeChild(restartButton)
				removeChild(backToMap)
			}
			cTarget = null;
			bound1 = null
			bound2 = null;
			bgVolume.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			fxVolume.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
			parent.removeChild(this)
		}
	}

}