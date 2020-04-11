package towers.Projectiles.ProjectileHits
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import common.Commons;


	public class ProjectileHit extends MovieClip
	{

		protected var _root:Object;
		protected var bTarget:Object;
		protected var followT:Boolean;
		protected var eAlivePlay:Boolean;
		public var ended:Boolean;

		public var angleT:Number = 0;

		public function ProjectileHit(eTarget:Object,angle:Number,FollowT:Boolean = true)
		{
			followT = FollowT;
			bTarget = eTarget;
			angleT = angle;
			stop();
			addEventListener(Event.ADDED_TO_STAGE,added);
			// constructor code
		}
		protected function added(e:Event):void
		{
			play();
			common.Commons.addHitList(this)
			removeEventListener(Event.ADDED_TO_STAGE,added);
			_root = common.Commons.getRoot();
			stage.addEventListener(Event.ENTER_FRAME,eFrame,false,8);
			if (followT == false)
			{
				this.rotation = (angleT / Math.PI) * 180;
				this.x = bTarget.x + (common.Commons.tileSide * .5);
				this.y = bTarget.y + (common.Commons.tileSide * .5);
			}
			else
			{
			eFrame(Event(undefined));
			}

		}
		public function pausedGame():void
		{
			stage.removeEventListener(Event.ENTER_FRAME,eFrame);
			trace("stoped");
			stop();
		}
		public function resumedGame():void
		{
			stage.addEventListener(Event.ENTER_FRAME,eFrame,false,8);
			play()
		}
		public function eFrame(e:Event):void
		{
			if (bTarget != null && followT == true)
			{
				this.rotation = (angleT / Math.PI) * 180;
				this.x = bTarget.x + (common.Commons.tileSide * .5);
				this.y = bTarget.y + (common.Commons.tileSide * .5);
				specialFrame();
			}
			if (currentFrame == totalFrames || (eAlivePlay == false && common.Commons.enemyAlive(bTarget) == false))
			{
				endClass();
			}
		}
		protected function specialFrame():void
		{

		}
		public function endClass():void
		{
			ended = true;
			stage.removeEventListener(Event.ENTER_FRAME,eFrame);
			_root.bmAboveTowers.removeChild(this);
			bTarget = null;
			_root = null;
			common.Commons.removeHitList(this);

		}
	}

}