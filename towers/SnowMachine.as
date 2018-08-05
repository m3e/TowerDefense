package towers
{

	import flash.events.Event;
	import flash.geom.ColorTransform;
	import debuffs.*;

	public class SnowMachine extends Tower
	{

		
		private var firing:Boolean;

		public function SnowMachine()
		{
			super();
			firing = false;
			tBaseColor = 0x66FFFF;
			tRange = 50;
			tDmg = 0;
			tAtkSpeed = 1;
			tCost = 550;
			tType = "ice";
			tDescription = "Slows all units passing through by 30% but deals no damage.  Cost: " + tCost.toString();
			// constructor code
		}
		override internal function eFrame(e:Event):void
		{
			if (_root != undefined)
			{
				tTarget.length = 0;
				//for (var i:int=enemyList.length - 1; i >=0; i--)
				for (var i:int=0; i < enemyList.length; i++)
				{
					
					if (Math.sqrt(Math.pow(enemyList[i].y - y,2) + Math.pow(enemyList[i].x - x,2)) < tRange)
					{
						//if the selected enemy is close enough, then set it as the target
						tTarget.push(enemyList[i]);
					}
					
				}
				if (tTarget.length > 0)
				{
					
					if (firing == false)
					{
						var fireFlash:ColorTransform = new ColorTransform();
						fireFlash.color = 0xFF0000;
						this.transform.colorTransform = fireFlash;
						
						
					}
					firing = true;
					fire();
				}
				else if (tTarget.length == 0)
				{
					if (firing == true)
					{
						var returnFromFireFlash:ColorTransform = new ColorTransform();
						returnFromFireFlash.color = tBaseColor;
						this.transform.colorTransform = returnFromFireFlash;
						
					}
					firing = false;
				}
			}

		}
		override internal function specialFunction():void
		{
			
		}
		override internal function addDebuffs(bullet:Bullet):void
		{
			var debuffsArray:Array = new Array;
			
			var debuffType:Array = new Array;
			
			debuffType.push("slow",.8,.5)
			
			debuffsArray.push(debuffType)
			
			bullet.debuffArray = debuffsArray;
		}
		

	}

}