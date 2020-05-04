package towers.skills
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import enemies.Enemy;
	import towers.Chain;
	import common.Commons;
	import flash.utils.*;
	import assets.maptiles.*;
	public class oldSkill extends MovieClip
	{
		public var sA:Array;
		private var sO:Object;

		private var loaded:Boolean;
		private var loadedTimer:int;
		private var tAtkSpeed:int;
		private var tRange:int;
		private var bAmount:Number;
		private var bSeconds:Number;
		private var _root:Object;

		public var bullets:Array = new Array  ;

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

		private var deactivate:Boolean;

		public function oldSkill(SkillsArray:Array,SourceObject:Object)
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
				case ("timer") :
					tAtkSpeed = 4;
					bSeconds = 2;
					bAmount = sA[2];
					tRange = sA[3];
					loadedTimer = 0;
					break;
			}
			switch (sN)
			{
				case ("poison") :
					gotoAndStop(1);
/*					sName = "Poison";
					eMenuNameOne = "Damage per Second: ";
					eMenuNameTwo = "Seconds: ";
					eMenuNameThree = "Slow: ";
					eMenuStatOne = sA[3];
					eMenuStatTwo = sA[4];
					eMenuStatThree = (sA[2] * 100) + "%";*/

					break;

				case ("brittle") :
					gotoAndStop(2);
/*					sName = "Brittle";
					eMenuNameOne = "Armor reduction: ";
					eMenuNameTwo = "Seconds: "
					
					;
					eMenuStatOne = sA[2];
					eMenuStatTwo = sA[3];*/

					break;

				case ("burn") :
					gotoAndStop(3);
/*					sName = "Burn";
					eMenuNameOne = "Damage per Second: ";
					eMenuNameTwo = "Seconds: ";
					eMenuStatOne = sA[2];
					eMenuStatTwo = sA[3];*/

					break;

				case ("penitence") :
					gotoAndStop(4);
/*					sName = "Penitence";
					eMenuNameOne = "Damage taken increase: ";
					eMenuNameTwo = "Seconds: ";
					eMenuStatOne = (sA[2] * 100) + "%";
					eMenuStatTwo = sA[3];*/

					break;

				case ("slow") :
					gotoAndStop(5);
/*					sName = "Slow";
					eMenuNameOne = "Slow: ";
					eMenuNameTwo = "Seconds: ";
					eMenuStatOne = (sA[2] * 100) + "%";
					eMenuStatTwo = sA[3];*/
					break;

				case ("chain") :
					gotoAndStop(6);
/*					sName = "Chain";
					eMenuNameOne = "Number of chains: ";
					eMenuNameTwo = "Damage reduced per bounce: ";
					eMenuStatOne = sA[2];
					eMenuStatTwo = (sA[4] * 100) + "%";*/
					break;

				case ("dmgBuff") :
					gotoAndStop(7);
					//sName = "Tower Damage Bonus";
					//eMenuNameOne = "Damage Increase: ";
					//eMenuStatOne = (sA[2] * 100) + "%";

					break;

				case ("atkSpdBuff") :
					gotoAndStop(8);
					//sName = "Tower Attack Speed Bonus";
					//eMenuNameOne = "Attack Speed Increase: ";
					//eMenuStatOne = (sA[2] * 100) + "%";
					break;

				case ("stun") :
					gotoAndStop(9);

/*					sName = "Stun";
					eMenuNameOne = "Chance to stun: ";
					eMenuNameTwo = "Seconds";
					eMenuStatOne = (sA[2] * 100) + "%";
					eMenuStatTwo = sA[3];*/
					break;

				case ("crit") :
					gotoAndStop(10);

/*					sName = "Crit";
					eMenuNameOne = "Chance to crit: ";
					eMenuNameTwo = "Extra damage %: ";
					eMenuStatOne = (sA[2] * 100) + "%";
					eMenuStatTwo = (sA[3] * 100) + "%";*/
					break;

				case ("icedRoad") :
					gotoAndStop(11);

					//sName = "Iced Roads";
					//eMenuNameOne = "Road speed slow: ";
					//eMenuStatOne = int(sA[2] * 100) + "%";
					break;

				case ("henchant") :
					gotoAndStop(12);
/*					sName = "Holy Enchantment";
					eMenuNameOne = "Adjacent attack speed bonus: ";
					eMenuStatOne = int(sA[2] * 100) + "%";*/
					break;
					
				case ("fireRoad") :
					gotoAndStop(13);
/*					sName = "Scorched Road";
					eMenuNameOne = "Burn per second: ";
					eMenuStatOne = sA[2];*/
					break;
					
				case ("shock") :
					gotoAndStop(14);
/*					sName = "Shock"
					eMenuNameOne = "Shock chance: "
					eMenuNameTwo = "Shock Damage: "
					eMenuNameThree = "Shock length: "
					eMenuStatOne = int(sA[3] * 100) + "%"
					eMenuStatTwo = sA[2]
					eMenuStatThree = sA[4] + "seconds"*/
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
							//p = new Poison(Enemy(sT),sA[2],sA[3],sA[4]);
							break;

						case ("brittle") :
							//p = new Brittle(Enemy(sT),sA[2],sA[3]);
							break;

						case ("burn") :
							//p = new Burn(Enemy(sT),sA[2],sA[3]);
							break;

						case ("penitence") :
							//p = new Penitence(Enemy(sT),sA[2],sA[3]);
							break;

						case ("slow") :
							//p = new Slow(Enemy(sT),sA[2],sA[3]);
							break;

						case ("chain") :

							//p = new ChainLightning(Enemy(sT),sO.getDmg(),sA[2],sA[3],sA[4],sA[5],sA[6]);
							break;

						case ("stun") :
							/*if (Math.floor((Math.random()*100)+1) <= (sA[2] * 100))
							{
								//p = new Stun(Enemy(sT),sA[3]);
							}*/
							break;
						case ("crit") :
							/*if (Math.floor((Math.random()*100)+1) <= (sA[2] * 100))
							{
								//var critTotal:int = sO.getDmg() * sA[3];
								//sT.takeDmg(critTotal,sO.tType);
							}*/
							break;

						case ("henchant") :
							if (sO != null)
							{
								var hEnchantArray:Array = checkGridFor(sO,sA[3],"Tower");
								for (var he:int=0; he < hEnchantArray.length; he++)
								{
									//var hEnchant:HolyEnchant = new HolyEnchant(hEnchantArray[he],sA[2],sA[4]);
									//hEnchantArray[he].addChild(hEnchant);
								}
							}
							break;
							
						case ("shock") :
							if (Math.floor((Math.random()*100)+1) <= (sA[3]*100))
							{
								//p = new Shock(Enemy(sT),sA[2],sA[4])
							}
					}
					break;

				case ("timer") :
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

						switch (sN)
						{
							case ("dmgBuff") :
							case ("atkSpdBuff") :
								var towerCheck:Array = checkGridFor(sT,tRange,"Tower");
								for (var i:int=0; i < towerCheck.length; i++)
								{
									switch (sN)
									{
										/*case ("dmgBuff") :
											var dmgBuff:DmgBuff = new DmgBuff(towerCheck[i],bAmount,bSeconds);
											_root.addChild(dmgBuff);
											break;*/

										/*case ("atkSpdBuff") :
											var AtkCheck:Array = checkGridFor(sT,tRange,"Tower");
											var atkSpdBuff:AtkSpdBuff = new AtkSpdBuff(towerCheck[i],bAmount,bSeconds);
											_root.addChild(atkSpdBuff);
											break;*/
									}
								}


								break;

							case ("icedRoad") :
							case ("fireRoad") :
								var roadCheck:Array = checkGridFor(sT,tRange,"Road",true);
								for (var b:int=0; b < roadCheck.length; b++)
								{
									var rTarget:Object = roadCheck[b];
									switch (sN)
									{
										/*case ("icedRoad") :
												rTarget.addIceLayer(this,sA[2]);
											break;
										case ("fireRoad") :
												rTarget.addFireLayer(this,sA[2]);
											break;*/

									}

								}

								break;
						}
						loaded = false;
						loadedTimer = 0;
					}

					break;

			}
		}
		private function checkGridFor(origin:Object,cRange:int,checkFor:String,corners:Boolean=false):Array
		{
			var tileSide = common.Commons.tileSide;
			var sourceX:int = Math.floor(origin.x / tileSide);
			var sourceY:int = Math.floor(origin.y / tileSide);
			var targetX:int;
			var targetY:int;
			var compiledList:Array = new Array  ;

			for (var i:int= -cRange; i <= cRange; i++)
			{
				targetX = Math.floor(sourceX + i);
				for (var k:int= -cRange; k <= cRange; k++)
				{
					targetY = Math.floor(sourceY + k);

					if (common.Commons.checkB(targetX,targetY) && (corners == true || common.Commons.dist(sourceX,sourceY,targetX,targetY) <= cRange))
					{
						switch (checkFor)
						{
							case ("Enemy") :
								var eList = common.Commons.enemyList;

								for (var p:int=0; p < eList.length; p++)
								{
									var eX = Math.floor((eList[p].x+16) / tileSide);
									var eY = Math.floor((eList[p].y+16) / tileSide);
									if (targetX == eX && targetY == eY)
									{
										compiledList.push(eList[p]);
									}
								}



								break;

							case ("Road") :
								var tileCheck:Object = common.Commons.tileArray[targetY][targetX];
								if (getQualifiedClassName(tileCheck) == "assets.maptiles::Dirt")
								{
									compiledList.push(tileCheck);
								}
								break;

							case ("Tower") :
								var towerCheck:Object = common.Commons.towerArray[targetY][targetX];
								if (towerCheck != null && towerCheck != origin)
								{
									compiledList.push(towerCheck);
								}
						}
					}
				}
			}

			return compiledList;
		}
		public function removeBullet(b:Object):void
		{
			bullets.splice(bullets.indexOf(b),1);
			if (deactivate == true && bullets.length == 0)
			{
				trace("sAsO null");
				sA = null;
				sO = null;
				_root = null;
			}
		}
		public function deactivateSkill(SkillTarget:Object):void
		{
			var sT:Object = SkillTarget;
			deactivate = true;
			var roadCheck:Array = checkGridFor(sT,tRange,"Road",true);
			for (var i:int=0; i < roadCheck.length; i++)
			{
				switch (sN)
				{
					case ("icedRoad") :
						if (roadCheck[i].isIced)
						{
							roadCheck[i].removeIceLayer(this);
						}
						break;

					case ("fireRoad") :
						if (roadCheck[i].isOnFire)
						{
							roadCheck[i].removeFireLayer(this,sA[2]);
						}
						break;
				}

			}
			/*switch (sN)
			{
			case ("icedRoad") :
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
			if (common.Commons.tileArray[sourceY][sourceX] != null)
			{
			if ((getQualifiedClassName(common.Commons.tileArray[sourceY][sourceX])) == "assets.maptiles::Dirt")
			{
			var tile:Tile = common.Commons.tileArray[sourceY][sourceX];
			if (tile.isIced == true)
			{
			tile.removeIceLayer();
			}
			else
			{
			trace("Not iced, but this tower ices?  How?");
			}
			}
			}
			
			}
			}
			}
			break;
			}*/
			if (bullets.length == 0)
			{
				sA = null;
				sO = null;
				_root = null;
			}
		}
	}
}