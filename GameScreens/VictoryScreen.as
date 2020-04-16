package GameScreens
{

	import flash.display.MovieClip;
	import common.Commons;
	import design.UI.Confetti;
	import flash.events.Event;
	import sounds.SoundManager;
	import User.UserProfile;
	import flash.net.SharedObject;
	import flash.filters.GlowFilter;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.events.MouseEvent;

	public class VictoryScreen extends MovieClip
	{
		public function VictoryScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, added);
			// constructor code
		}
		private function added(e:Event):void
		{
			TweenPlugin.activate([GlowFilterPlugin]);
			TweenPlugin.activate([ColorMatrixFilterPlugin]);
			User.UserProfile.round50BeatenCount++;
			r50TextBox.text = String(User.UserProfile.round50BeatenCount);
			common.Commons.saveGame();
			SoundManager.bgfx("victoryMusic");
			//SoundManager.sfx("hooraySfx");
			removeEventListener(Event.ADDED_TO_STAGE, added);
/*			var scaleBy:Number = .6;

			var separation:int = 30;
			var stageHalf:Number = stage.width / 2;
			var confY:int = 30;
			var conf:Confetti = new Confetti();
			conf.scaleX = scaleBy;
			conf.scaleY = scaleBy
			
			conf.x = stageHalf - (conf.spriteSize * scaleBy) - separation;
			conf.y = confY;
			addChild(conf);

			conf = new Confetti();
			conf.scaleX = scaleBy;
			conf.scaleY = scaleBy
			
			conf.x = stageHalf + separation;
			conf.y = confY;

			addChild(conf);*/
			alphaToOne(cont);
			addEventListener(MouseEvent.CLICK,contPressed)
		}
		private function contPressed(e:Event):void
		{
			removeEventListener(MouseEvent.CLICK,contPressed)
			parent.removeChild(this);
		}
		private function alphaToOne(cont:TextField):void
		{
			TweenLite.to(cont, .6, {colorMatrixFilter:{brightness:2.2, contrast:1.5, colorize:0x66FFFF}, glowFilter:{blurX:12, blurY:12, strength:5, alpha:1,colorize:0x66FFFF},onComplete:alphaToZero,onCompleteParams:[cont]})
		}
		private function alphaToZero(cont:TextField):void
		{
			TweenLite.to(cont, .7, {glowFilter:{blurX:4, blurY:4, strength:3}, onComplete:alphaToOne,onCompleteParams:[cont]})
		}
	}

}