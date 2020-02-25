package buffs
{

	import flash.display.MovieClip;
	import common.Commons;
	import enemies.Enemy;
	import flash.events.Event;
	import flash.display.Shape;
	import common.Commons;
	import assets.projectiles.ChainLightningGfx;

	import com.greensock.*;
	import com.greensock.easing.*;

	public class ChainLightning extends MovieClip
	{

		private var _root:Object;
		private var eList:Array;
		private var bDmg:int;
		private var bounces:int;
		private var bs:int;
		private var pc:Number;
		private var frames:int;
		private var br:int;
		private var enemyList:Array;
		private var bTarget:Enemy;
		private var bType:String;

		private var alreadyHit:Array;

		public function ChainLightning(dTarget:Enemy, dmg:int, Bounces:int, bounceSpeed:int, percentChange:Number, bounceRange:int, BType:String)
		{
			_root = common.Commons.getRoot();
			bDmg = dmg;
			bounces = Bounces;
			bs = bounceSpeed;
			pc = percentChange;
			br = bounceRange;
			enemyList = common.Commons.getEnemyList();
			bTarget = dTarget;
			bType = BType;

			alreadyHit = new Array  ;
			alreadyHit.push(bTarget);

			updateEnemyList();

			frames = 1;
			common.Commons.addSkillsList(this);
			addEventListener(Event.ENTER_FRAME, gameTick);
		}
		public function pausedGame():void
		{
			removeEventListener(Event.ENTER_FRAME, gameTick);
		}
		public function resumedGame():void
		{
			addEventListener(Event.ENTER_FRAME, gameTick);
		}
		private function gameTick(e:Event):void
		{
			if (bounces > 0)
			{
				if (frames % bs == 0)
				{
					updateEnemyList();
					var bTargetCopy:Enemy = bTarget;
					for (var i:int=0; i < eList.length; i++)
					{
						if (common.Commons.dist(bTarget.x,bTarget.y,eList[i].x,eList[i].y) < br)
						{
							chainHit(eList[i]);
							break;
						}

					}
					if (bTargetCopy == bTarget)
					{
						finish();
					}
					bounces--;
				}
			}
			else
			{
				finish();
			}
			frames++;
		}
		private function updateEnemyList():void
		{
			eList = common.Commons.newTheMap(common.Commons.getEnemyList());
			for (var i:int=0; i < alreadyHit.length; i++)
			{
				if (eList.indexOf(alreadyHit[i]) != -1)
				{
					eList.splice(eList.indexOf(alreadyHit[i]),1);
				}
			}
		}
		private function chainHit(newTarget:Enemy):void
		{
			var yDist:Number = newTarget.y - bTarget.y;//how far this guy is from the enemy (y)
			var xDist:Number = newTarget.x - bTarget.x;//how far it is from the enemy (x)
			var angle:Number = Math.atan2(yDist,xDist);//the angle that it must move
			var distanceBetween:int = common.Commons.dist(bTarget.x,bTarget.y,newTarget.x,newTarget.y);
			var chainGfx:ChainLightningGfx = new ChainLightningGfx  ;
			chainGfx.x = distanceBetween;
			chainGfx.y = 4;
			chainGfx.rotation = (angle / Math.PI) * 180;
			chainGfx.x = bTarget.x + (common.Commons.tileSide * .5);
			chainGfx.y = bTarget.y + (common.Commons.tileSide * .5);


			//TweenMax.to(chainGfx, .1, {alpha:0.0, onComplete:removeChainGfx, onCompleteParams:[parent,aoeVisual]});
			_root.addChild(chainGfx);
			TweenMax.to(chainGfx, .25, {alpha:0.0, onComplete:removeChainGfx, onCompleteParams:[chainGfx]});
			bTarget = newTarget;
			alreadyHit.push(bTarget);



			bDmg -=  bDmg * pc;
			bTarget.takeDmg(bDmg,bType);
		}
		private function removeChainGfx(tweenTarget:MovieClip):void
		{
			if (tweenTarget.parent != null)
			{
				tweenTarget.parent.removeChild(tweenTarget);
			}
			else
			{
				trace("chainlightning");
			}
		}
		private function finish():void
		{
			common.Commons.removeSkillsList(this);
			alreadyHit = null;
			removeEventListener(Event.ENTER_FRAME, gameTick);
			_root = null;
			eList = null;
			bTarget = null;
			enemyList = null;

		}
	}

}