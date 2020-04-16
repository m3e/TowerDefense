package design.UI
{

	import flash.display.MovieClip;
	import design.AnimatedSpriteSheet;

	public class Torch extends AnimatedSpriteSheet
	{


		public function Torch()
		{
			
			super("torchSS",32);
			frameNumber = int((Math.random())*4)
			soundString = "torchSfx";
			tweenIn = true;
			looping = true;
			mergeOverSeconds = 1;
			
			// constructor code
		}
	}

}