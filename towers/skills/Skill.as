package towers.skills
{

	import flash.display.Sprite;
	import enemies.Enemy;
	import buffs.*;
	import debuffs.*;
	import towers.Chain;
	import common.Commons;
	public class Skill extends Sprite
	{
		private var sA:Array;
		private var sO:Object;

		private var loaded:Boolean;
		private var loadedTimer:int;
		private var tAtkSpeed:int;
		private var tRange:int;
		private var bAmount:Number;
		private var bSeconds:Number;
		private var towerArray:Array;
		private var tTarget:Array;
		private var _root:Object;

		public function Skill(SkillsArray:Array,SourceObject:Object)
		{
			_root = common.Commons.getRoot();
			sA = SkillsArray;
			sO = SourceObject;
			switch (sA[0])
			{
				case ("time") :
					tAtkSpeed = sA[4];
					loadedTimer = 0;
			}
			switch (sA[1])
			{
				case ("atkSpdBuff") :
					tRange = sA[5];
					bAmount = sA[2];
					bSeconds = sA[3];
					towerArray = common.Commons.getTowerArray();
					tTarget = [];
					break;

				case ("dmgBuff") :
					tRange = sA[5];
					bAmount = sA[2];
					bSeconds = sA[3];
					towerArray = common.Commons.getTowerArray();
					tTarget = [];
					break;
			}
		}
		public function activateSkill(SkillTarget:Object):void
		{
			var sT:Object = SkillTarget;
			var p:Sprite;
			switch (sA[0])
			{
				case ("hit") :
					switch (sA[1])
					{
						case ("poison") :
							p = new Poison(Enemy(sT),sA[2],sA[3],sA[4]);
							break;

						case ("brittle") :
							p = new Brittle(Enemy(sT),sA[2],sA[3]);
							break;

						case ("burn") :
							p = new Burn(Enemy(sT),sA[2],sA[3]);
							break;

						case ("penitence") :
							p = new Penitence(Enemy(sT),sA[2],sA[3]);
							break;

						case ("slow") :
							p = new Slow(Enemy(sT),sA[2],sA[3]);
							break;

						case ("chain") :
							p = new ChainLightning(Enemy(sT),sO.getDmg(),sA[2],sA[3],sA[4],sA[5],sA[6]);
							break;
					}
					break;

				case ("time") :
					tTarget.length = 0;
					if (loaded == false)
					{
						loadedTimer +=  1;
						if (loadedTimer == tAtkSpeed)
						{
							loaded = true;
						}
					}
					if (loaded == true)
					{

						var myX:int;
						var myY:int;
						for (var i:int = -tRange; i <= tRange; i++)
						{

							myY=(sT.y/32) + i;
							for (var q:int = -tRange; q <= tRange; q++)
							{
								myX = (sT.x/32) + q;
								if (common.Commons.checkB(myX,myY))
								{

									if (towerArray[myY][myX] != null && towerArray[myY][myX] != sT)
									{
										if (common.Commons.dist(sT.x / common.Commons.tileSide,sT.y / common.Commons.tileSide,myX,myY) <= tRange)
										{
											tTarget.push(towerArray[myY][myX]);
										}

									}
								}
							}
						}

						if (tTarget.length > 0)
						{
							loaded = false;
							loadedTimer = 0;
							fire();
						}
					}
					break;
			}
		}
		private function fire():void
		{
			for (var i:int=0; i < tTarget.length; i++)
			{
				switch (sA[1])
				{
					case ("dmgBuff") :
						var dmgBuff:DmgBuff = new DmgBuff(tTarget[i],bAmount,bSeconds);
						_root.addChild(dmgBuff);
						break;

					case ("atkSpdBuff") :
						var atkSpdBuff:AtkSpdBuff = new AtkSpdBuff(tTarget[i],bAmount,bSeconds);
						_root.addChild(atkSpdBuff);
						break;
				}
			}
		}
	}
}