package towers.skills
{

	import flash.display.MovieClip;
	import towers.Tower;
	import flash.events.Event;
	import common.Commons;
	import flash.utils.getQualifiedClassName;

	public class TowerSkill extends MovieClip
	{

		protected var sourceObject:Tower;
		protected var sA:Array;
		protected var frameCounter:int;
		protected var cooldownSeconds:Number;

		public var sName:String;
		public var eMenuNameOne:String = ""
		public var eMenuNameTwo:String = ""
		public var eMenuNameThree:String = ""
		public var eMenuNameFour:String = ""
		public var eMenuStatOne:String = ""
		public var eMenuStatTwo:String = ""
		public var eMenuStatThree:String = " "
		public var eMenuStatFour:String = " "

		protected var targetsAffected:Array = new Array  ;
		protected var thisSkillsArray:Array = new Array  ;
		protected var currentlyTicking:Boolean;
		
		protected var bulletList:Array = new Array;
		
		protected var sChance:Number=1;
		protected var tDamage:int;
		protected var tType:String;
		protected var tsaIndex:int;

		protected var bypassDeath:Boolean = false;
		
		public function TowerSkill(SourceObject:Tower,SA:Array)
		{
			sourceObject = SourceObject;
			tDamage = sourceObject.getDmg();
			tType = sourceObject.tType;
			cooldownSeconds = .5;
			sA = SA;
			common.Commons.addSkillsList(this);
			//trace("Sa[0]: ",sA[0]);
			if (sA[0] == "timer")
			{
				sourceObject.timeSkills.push(this);
				addEventListener(Event.ENTER_FRAME, skillTick);
			}
			else if (sA[0] == "hit")
			{
				sourceObject.hitSkills.push(this);
				
				addEventListener(Event.ENTER_FRAME,tickDownSkills);
			}
			sourceObject.allSkills.push(this)
		}
		protected function inTSA(dEnemy:Object):Boolean
		{
			var a:Boolean = false;
			for (var i:int=0; i < thisSkillsArray.length; i++)
			{
				if (thisSkillsArray[i].indexOf(dEnemy) != -1)
				{
					a = true
					break;
				}
			}
			return a;
			
		}
		public function addBullet(b:Object):void
		{
			bulletList.push(b)
		}
		public function removeBullet(b:Object):void
		{
			bulletList.splice(bulletList.indexOf(b),1);
		}
		public function pausedGame():void
		{
			if (sA[0] == "timer")
			{
				removeEventListener(Event.ENTER_FRAME, skillTick);
			}
			else if (sA[0] == "hit")
			{
				removeEventListener(Event.ENTER_FRAME,tickDownSkills);
			}
		}
		public function resumedGame():void
		{
			if (sA[0] == "timer")
			{
				addEventListener(Event.ENTER_FRAME, skillTick);
			}
			else if (sA[0] == "hit")
			{
				addEventListener(Event.ENTER_FRAME,tickDownSkills);
			}
		}
		protected function skillTick(e:Event):void
		{
			if (sourceObject != null)
			{
				frameCounter++;
				if (frameCounter >= (cooldownSeconds * 24))
				{
					doTowerSkill();
					frameCounter = 0;
				}
			}
			else
			{
				endClass();
			}
		}
		public function hitTarget(dEnemy:Object):void
		{
			if (checkChance(dEnemy))
			{
				var NHT:Array = newHitTarget(dEnemy)
				if (NHT != null)
				{
					thisSkillsArray.push(NHT);
				}
				initialEffect(NHT);
				checkOverride(NHT);
			}
		}
		protected function checkChance(dEnemy:Object):Boolean
		{
			var chanceB:Boolean = true
			chanceB = (Math.floor(Math.random()*100+1) <= sChance*100 && chanceVariable(dEnemy));
			return chanceB;
			
		}
		protected function chanceVariable(dEnemy:Object):Boolean
		{
			return true;
		}
		protected function tickDownSkills(e:Event):void
		{
			for (var i:int=0; i < thisSkillsArray.length; i++)
			{
				tsaIndex = i;
				var dEnemy:Object = thisSkillsArray[i][0];
				thisSkillsArray[i][1]--;
				if (thisSkillsArray[i][1] <= 0 || (bypassDeath == false && common.Commons.enemyList.indexOf(dEnemy) == -1 && common.Commons.towerList.indexOf(dEnemy) == -1))
				{
					if (bypassDeath == true || (common.Commons.enemyList.indexOf(dEnemy) != -1 || common.Commons.towerList.indexOf(dEnemy) != -1))
					{
						removeEffect(thisSkillsArray[i]);
					}
					var postRemovalCheck:Array = thisSkillsArray[i];
					thisSkillsArray.splice(i,1);
					i--;
					tsaIndex = i;
					afterRemoval(postRemovalCheck);
					if (thisSkillsArray.length == 0 && sourceObject == null && bulletList.length == 0)
					{
						removeEventListener(Event.ENTER_FRAME,tickDownSkills);
					}
				}
				else
				{
					checkOverride(thisSkillsArray[i]);
				}
			}
		}
		//New class start
		protected function newHitTarget(dEnemy:Object):Array
		{
			var a:Array;
			return a;
		}
		protected function initialEffect(tsa:Array):void
		{

		}
		protected function checkOverride(tsa:Array):void
		{

		}
		protected function removeEffect(tsa:Array):void
		{

		}
		protected function afterRemoval(prc:Array):void
		{
			
		}
		//Stop
		protected function doTowerSkill():void
		{

		}
		protected function deactivateSkill():void
		{

		}
		public function endClass():void
		{
			deactivateSkill();
			if (sA[0] == "timer")
			{
				if (sourceObject != null)
				{
					sourceObject.timeSkills.splice(sourceObject.timeSkills.indexOf(this),1);
				}
				removeEventListener(Event.ENTER_FRAME, skillTick);
			}
			else if (sA[0] == "hit")
			{
				if (sourceObject != null)
				{
					sourceObject.hitSkills.splice(sourceObject.hitSkills.indexOf(this),1);
				}
			}
			sourceObject.allSkills.splice(sourceObject.allSkills.indexOf(this),1);
			if (thisSkillsArray.length == 0 && bulletList.length == 0)
			{
				removeEventListener(Event.ENTER_FRAME,tickDownSkills);
			}
			common.Commons.removeSkillsList(this);
			sourceObject = null;
		}
		protected function checkGridFor(origin:Object,cRange:int,checkFor:String,corners:Boolean=false):Array
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
								var eList:Array = common.Commons.enemyList;

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
	}

}