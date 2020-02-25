package enemies.skills
{

	import flash.display.MovieClip;
	import enemies.Enemy;
	import flash.events.Event;
	import common.Commons;


	public class EnemySkill extends MovieClip
	{

		public var sName:String;
		protected var isPlayingMC:Boolean;
		protected var sReady:Boolean;
		protected var e:Enemy;
		protected var reloadCounter:int;
		protected var cooldownSeconds:Number;
		protected var sArray:Array;
		protected var timerSkill:Boolean;
		protected var currentlyActive:Array = new Array;

		public function EnemySkill(E:Enemy,SArray:Array)
		{
			e = E;
			sArray = SArray;
			e.addSkill(this,sArray[0]);
			sReady = true
			;
			addEventListener(Event.ADDED_TO_STAGE, added);
			stop();
			visible = false;
			e.addChild(this);
			if (sArray[0] == "timer")
			{
				timerSkill = true;
			}
			common.Commons.addSkillsList(this);
		}
		// constructor code;
		public function pausedGame():void
		{

			if (sReady == false)
			{
				removeEventListener(Event.ENTER_FRAME, cooldownSkill);
			}
			if (isPlayingMC == true)
			{
				removeEventListener(Event.ENTER_FRAME,playMC);
				stop();
			}
			if (currentlyActive.length > 1)
			{
				removeEventListener(Event.ENTER_FRAME, durationTimer)
			}
		}
		public function resumedGame():void
		{
			if (sReady == false)
			{
				addEventListener(Event.ENTER_FRAME, cooldownSkill);
			}
			if (isPlayingMC == true)
			{
				addEventListener(Event.ENTER_FRAME,playMC);
				play();
			}
			if (currentlyActive.length > 1)
			{
				addEventListener(Event.ENTER_FRAME, durationTimer)
			}
		}
		protected function added(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
		}
		protected function reload():void
		{
			addEventListener(Event.ENTER_FRAME, cooldownSkill);
		}
		protected function cooldownSkill(e:Event):void
		{

			reloadCounter++;
			if (reloadCounter >= Math.floor(cooldownSeconds * 24))
			{
				reloadCounter = 0;
				removeEventListener(Event.ENTER_FRAME, cooldownSkill);
				sReady = true;
			}
		}
		protected function playGFX():void
		{
			if (isPlayingMC == false)
			{
			addEventListener(Event.ENTER_FRAME,playMC);
			visible = true;
			isPlayingMC = true;
			play();
			}
		}
		protected function stopGFX():void
		{
			if (isPlayingMC == true)
			{
				removeEventListener(Event.ENTER_FRAME,playMC);
				visible = false;
				isPlayingMC = false;
				stop()
			}
		}
		protected function playMC(e:Event):void
		{
			if (currentFrame == totalFrames)
			{
				stopGFX();
			}
		}
		public function activateSkill():void
		{
			doSkillEffect()
			if (cooldownSeconds != 0)
			{
				sReady = false;
				reload();
			}
			
		}
		protected function doSkillEffect():void
		{
			
		}
		public function deactivateSkill():void
		{

		}
		protected function addDuration(d:Number):void
		{
			currentlyActive.push(int(d * 24))
			if (currentlyActive.length == 1)
			{
				addEventListener(Event.ENTER_FRAME, durationTimer)
			}
		}
		protected function durationTimer(e:Event):void
		{
			for (var i:int=0; i < currentlyActive.length; i++)
			{
				currentlyActive[i]--;
				if (currentlyActive[i] <= 0)
				{
					deactivateSkill();
					currentlyActive.splice(i,1)
					i--
				}
			}
			if (currentlyActive.length == 0)
			{
				removeEventListener(Event.ENTER_FRAME, durationTimer)
			}
		}
		public function endSkill():void
		{
			if (sReady == false)
			{
				removeEventListener(Event.ENTER_FRAME, cooldownSkill);
			}
			if (isPlayingMC == true)
			{
				removeEventListener(Event.ENTER_FRAME,playMC);
			}
			if (currentlyActive.length > 0)
			{
				removeEventListener(Event.ENTER_FRAME, durationTimer)
			}
			if (e.contains(this))
			{
				e.removeChild(this)
			}
			e = null;
			sArray = null;
			common.Commons.removeSkillsList(this)
		}
	}

}