package towers.skills
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import enemies.Enemy;
	import buffs.*;
	import debuffs.*;
	import towers.Chain;
	import common.Commons;
	import flash.utils.*;
	import assets.maptiles.*;

	public class Skill extends MovieClip
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

		private var sN:String;
		public var sName:String;

		public var eMenuNameOne:String;
		public var eMenuNameTwo:String;
		public var eMenuNameThree:String;
		public var eMenuNameFour:String;
		public var eMenuStatOne:String;
		public var eMenuStatTwo:String;
		public var eMenuStatThree:String;
		public var eMenuStatFour:String;

		public function Skill(SkillsArray:Array,SourceObject:Object)
		{
			_root = common.Commons.getRoot();
			sA = SkillsArray;
			sO = SourceObject;
			sN = sA[1];
			eMenuNameOne = "";
			eMenuNameTwo = "";
			eMenuNameThree = "";
			eMenuNameFour = ""
			;
			eMenuStatOne = "";
			eMenuStatTwo = "";
			eMenuStatThree = "";
			eMenuStatFour = "";
			switch (sA[0])
			{
				case ("time") :
				case ("diagGrid") :
					tAtkSpeed = 4;
					bSeconds = 2;
					loadedTimer = 0;
					break;
			}
			switch (sN)
			{
				case ("atkSpdBuff") :
					tRange = sA[3];
					bAmount = sA[2];
					towerArray = common.Commons.getTowerArray();
					tTarget = [];
					break;

				case ("dmgBuff") :
					tRange = sA[3];
					bAmount = sA[2];
					towerArray = common.Commons.getTowerArray();
					tTarget = [];
					break;
			}
			switch (sN)
			{
				case ("poison") :
					gotoAndStop(1);
					sName = "Poison";
					eMenuNameOne = "Damage per Second: ";
					eMenuNameTwo = "Seconds: ";
					eMenuNameThree = "Slow: "
					
					;
					eMenuStatOne = sA[3];
					eMenuStatTwo = sA[4];
					eMenuStatThree = (sA[2] * 100) + "%";

					break;

				case ("brittle") :
					gotoAndStop(2);
					sName = "Brittle";
					eMenuNameOne = "Armor reduction: ";
					eMenuNameTwo = "Seconds: "
					
					;
					eMenuStatOne = sA[2];
					eMenuStatTwo = sA[3];

					break;

				case ("burn") :
					gotoAndStop(3);
					sName = "Burn";
					eMenuNameOne = "Damage per Second: ";
					eMenuNameTwo = "Seconds: "
					
					;
					eMenuStatOne = sA[2];
					eMenuStatTwo = sA[3];

					break;

				case ("penitence") :
					gotoAndStop(4);
					sName = "Penitence";
					eMenuNameOne = "Damage taken increase: ";
					eMenuNameTwo = "Seconds: "
					
					;
					eMenuStatOne = (sA[2] * 100) + "%";
					eMenuStatTwo = sA[3];

					break;

				case ("slow") :
					gotoAndStop(5);
					sName = "Slow";
					eMenuNameOne = "Slow: ";
					eMenuNameTwo = "Seconds: "
					
					;
					eMenuStatOne = (sA[2] * 100) + "%";
					eMenuStatTwo = sA[3];
					break;

				case ("chain") :
					gotoAndStop(6);
					sName = "Chain";
					eMenuNameOne = "Number of chains: ";
					eMenuNameTwo = "Damage reduced per bounce: "
					;
					eMenuStatOne = sA[2];
					eMenuStatTwo = (sA[4] * 100) + "%";
					break;

				case ("dmgBuff") :
					gotoAndStop(7);
					sName = "Tower Damage Bonus";
					eMenuNameOne = "Damage Increase: "
					;
					eMenuStatOne = (sA[2] * 100) + "%";

					break;

				case ("atkSpdBuff") :
					gotoAndStop(8);
					sName = "Tower Attack Speed Bonus";
					eMenuNameOne = "Attack Speed Increase: "
					;
					eMenuStatOne = (sA[2] * 100) + "%";
					break;

				case ("stun") :
					gotoAndStop(9);

					sName = "Stun";
					eMenuNameOne = "Chance to stun: ";
					eMenuNameTwo = "Seconds"
					;
					eMenuStatOne = (sA[2] * 100) + "%";
					eMenuStatTwo = sA[3];
					break;

				case ("crit") :
					gotoAndStop(10);

					sName = "Crit";
					eMenuNameOne = "Chance to crit: ";
					eMenuNameTwo = "Extra damage %: "
					;
					eMenuStatOne = (sA[2] * 100) + "%";
					eMenuStatTwo = (sA[3] * 100) + "%";
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
					switch (sN)
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

						case ("stun") :
							if (Math.floor((Math.random()*100)+1) <= (sA[2] * 100))
							{
								p = new Stun(Enemy(sT),sA[3]);
							}
							break;
						case ("crit") :
							if (Math.floor((Math.random()*100)+1) <= (sA[2] * 100))
							{
								var critTotal:int = sO.getDmg() * sA[3];
								sT.takeDmg(critTotal,sO.tType);
								trace("CritTotal: ", critTotal);
							}
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

							myY=(sT.y/32) + i;//sT is assumed to be the tower calling the function
							for (var q:int = -tRange; q <= tRange; q++)
							{
								myX = (sT.x/32) + q;
								if (common.Commons.checkB(myX,myY))
								{

									//for every tower that isn't this tower in towerArray
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

				case ("diagGrid") :
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
						var sourceX:int;
						var sourceY:int;
						for (var b:int = -tRange; b <= tRange; b++)
						{
							sourceY = (sT.y/32) + b;
							for (var n:int = -tRange; n <= tRange; n++)
							{
								sourceX = (sT.x/32) + n;
								if (common.Commons.checkB(sourceX,sourceY))
								{
									switch (sA[1])
									{
										case ("icedroad") :
											if (common.Commons.tileArray[sourceY][sourceX] != null)
											{
												if ((getQualifiedClassName(common.Commons.tileArray[sourceY][sourceX])) == "assets.maptiles::Dirt")
												{
													//common.Commons.tileArray[sourceY][sourceX]).
												}
											}
											break;
									}
								}
							}
						}
					}
					break;
			}
		}
		private function fire():void
		{
			for (var i:int=0; i < tTarget.length; i++)
			{
				switch (sN)
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