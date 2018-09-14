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

		private var eList:Array;
		private var bDmg:int;
		private var bounces:int;
		private var pc:Number;
		private var frames:int;
		private var bs:int;
		private var bTarget:Enemy;
		private var enemyList:Array;
		private var _root:MovieClip;
		private var bType:String;
		private var br:int;

		private var alreadyHit:Array;

		public function ChainLightning(Root:*, dmg:int, Bounces:int, bounceSpeed:int, percentChange:Number, bounceRange:int, EnemyList:Array, dTarget:Enemy, BType:String)
		{
			alreadyHit = new Array  ;
			br = bounceRange;
			bType = BType;
			bTarget = dTarget;
			alreadyHit.push(bTarget);
			enemyList = EnemyList;
			updateEnemyList();
			_root = Root;

			bDmg = dmg;
			bounces = Bounces;
			pc = percentChange;
			bs = bounceSpeed;
			// constructor code
			frames = 1;

			addEventListener(Event.ENTER_FRAME, gameTick);
		}
		private function gameTick(e:Event):void
		{
			if (bounces > 0)
			{
				if (frames % bs == 0)
				{
					//trace("my index:",eList.indexOf(bTarget))
					updateEnemyList();
					//trace("my index2:",eList.indexOf(bTarget))
					var bTargetCopy:Enemy = bTarget;
					for (var i:int=0; i < eList.length; i++)
					{
						//trace("Distance:",common.Commons.dist(bTarget.x, bTarget.y, eList[i].x,eList[i].y),"And I:",i)
						if (common.Commons.dist(bTarget.x,bTarget.y,eList[i].x,eList[i].y) < br)
						{
							chainHit(eList[i]);
							//trace("Under:",br, "And I:",i)
							break;
						}

					}
					if (bTargetCopy == bTarget)
					{
						//trace("Copies")
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
			eList = common.Commons.newTheMap(enemyList);
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
				tweenTarget.parent.removeChild(tweenTarget)
			}
			else
			{
				trace("chainlightning");
			}
		}
		private function finish():void
		{
			alreadyHit = null;
			removeEventListener(Event.ENTER_FRAME, gameTick);
			_root = null;
			eList = null;
			bTarget = null;
			enemyList = null;

		}
	}

}