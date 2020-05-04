package design.UI
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import sounds.SoundManager;
	import flash.utils.getQualifiedSuperclassName;
	import flash.filters.GlowFilter;
	import com.greensock.TweenLite;
	import com.greensock.plugins.*;
	import flash.text.TextField;

	public class MenuButton extends MovieClip
	{

		public var soundEnabled: Boolean = true;
		public var clicksEnabled: Boolean = true;
		protected var disableSoundAfterClick: Boolean = true;
		protected var disableClickAfterClick: Boolean = false;
		protected var soundString: String = "clickbutton";
		protected var glowOn: Boolean;
		protected var glowTxt: TextField;
		protected var glow: GlowFilter;
		protected var glowColor: uint = 0xFF0000

		public function MenuButton()
		{
			addEventListener(Event.ADDED_TO_STAGE, added)
			gotoAndStop(1);
			// constructor code
		}
		protected function added(e: Event): void
		{
			if (getQualifiedSuperclassName(this) == "flash.display::MovieClip")
			{
				btnText.mouseEnabled = false;
			}
			if (glowOn == true)
			{
				glow = new GlowFilter(glowColor, 6, 6, 6, 0);
				TweenPlugin.activate([GlowFilterPlugin]);
				glowTxt.filters = [glow];
			}
			removeEventListener(Event.ADDED_TO_STAGE, added)
			addEventListener(MouseEvent.CLICK, clicked)
			addEventListener(MouseEvent.MOUSE_OUT, hoverOff)
			addEventListener(MouseEvent.MOUSE_OVER, hoverOn)
			addEventListener(MouseEvent.MOUSE_DOWN, downClick)
			addEventListener(Event.REMOVED_FROM_STAGE, removed)
		}
		protected function hoverOn(e: MouseEvent): void
		{
			if (glowOn == true)
			{
				TweenLite.to(glowTxt, .8,
				{
					glowFilter:
					{
						strength: 3
					}
				})
			}
		}
		protected function clicked(e: MouseEvent): void
		{
			playSound()
			if (disableClickAfterClick == true)
			{
				removeEventListener(MouseEvent.CLICK, clicked)
				removeEventListener(MouseEvent.MOUSE_DOWN, downClick)
				removeEventListener(Event.REMOVED_FROM_STAGE, removed)
				soundEnabled = false;
			}
			if (getQualifiedSuperclassName(this) == "flash.display::MovieClip")
			{
				btnText.x = 22
				btnText.y = 22
			}
			gotoAndStop(1)
		}
		protected function hoverOff(e: MouseEvent): void
		{
			if (glowOn == true)
			{
				TweenLite.to(glowTxt, 1,
				{
					glowFilter:
					{
						strength: 0
					}
				})
			}
			if (getQualifiedSuperclassName(this) == "flash.display::MovieClip")
			{
				btnText.x = 22
				btnText.y = 22
			}
			gotoAndStop(1)
		}
		protected function downClick(e: MouseEvent): void
		{
			if (getQualifiedSuperclassName(this) == "flash.display::MovieClip")
			{
				btnText.x = 22
				btnText.y = 40
			}
			this.gotoAndStop(2)
		}
		protected function removed(e: Event): void
		{
			removeEventListener(MouseEvent.CLICK, clicked)
			removeEventListener(MouseEvent.MOUSE_OUT, hoverOff)
			removeEventListener(MouseEvent.MOUSE_DOWN, downClick)
			removeEventListener(Event.REMOVED_FROM_STAGE, removed)
		}
		protected function playSound(): void
		{
			if (soundEnabled == true)
			{
				SoundManager.sfx(soundString)
				if (disableSoundAfterClick == true)
				{
					soundEnabled = false;
				}
			}
		}
	}

}