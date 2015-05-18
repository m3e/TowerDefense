package 
{
	import flash.display.MovieClip;
	import flash.events.*

	public class Bullet extends MovieClip
	{

		private var xSpeed:Number;
		private var ySpeed:Number;
		
		public var bSpeed:Number;
		public var bTarget:MovieClip;
		public var bDmg:Number;		
		
		private var _root:MovieClip;
		
		public function Bullet()
		{
			bTarget = null;
			bDmg = 0;

			addEventListener(Event.ADDED_TO_STAGE,beginClass);//this will run every time this guy is made
			addEventListener(Event.ENTER_FRAME,eFrame);//this will run every frame

			// constructor code
		}
		private function beginClass(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,beginClass);
			_root = MovieClip(root);
			
			fire();
		}
		private function eFrame(e:Event):void
		{
			fire();
		}
		private function fire():void
		{
			var yDist:Number = bTarget.y - this.y;//how far this guy is from the enemy (x)
			var xDist:Number = bTarget.x - this.x;//how far it is from the enemy (y)
			var angle:Number = Math.atan2(yDist,xDist);//the angle that it must move
			ySpeed = Math.sin(angle) * bSpeed;//calculate how much it should move the enemy vertically
			xSpeed = Math.cos(angle) * bSpeed;//calculate how much it should move the enemy horizontally
			
			if (Math.abs(xSpeed) > Math.abs(xDist))
			{
				xSpeed = xDist;
				
			}
			if (Math.abs(ySpeed) > Math.abs(yDist))
			{
				ySpeed = yDist;
				
			}
			//move the bullet towards the enemy
			this.x +=  xSpeed;
			this.y +=  ySpeed;

			if (this.hitTestObject(bTarget))
			{//if it touches the enemy
				bTarget.eHp -=  bDmg;//make it lose some health
				trace(bTarget.eHp,bDmg)
				destroyThis();//and destroy this guy
			}
			else if (bTarget == null)
			{
				destroyThis();
			}
		}
		public function destroyThis():void
		{
			//this function will just remove this guy from the stage
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
			_root.removeChild(this);
			_root = null;
			
		}

	}

}