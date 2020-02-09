package  assets.maptiles {
	
	import flash.display.MovieClip
	import flash.events.*;
	import enemies.Enemy;
	import assets.maptiles.*;
	import towers.skills.Skill;
	
	public class Tile extends MovieClip{
		
		public var occupied:Boolean;
		private var _root:MovieClip;
		
		public var isIced:Boolean;
		public var isOnFire:Boolean;
		
		public var burnAmount:Number = 0;
		public var icedSlow:Number = 0;
		
		private var iceLayer:Ice;
		private var fireLayer:FireRoad;
		
		private var skillsList:Array = new Array;

		public function Tile() {
			occupied = false;
			addEventListener(Event.ADDED_TO_STAGE, beginClass)
			addEventListener(Event.REMOVED, endClass)
			// constructor code
		}
		
		private function beginClass(e:Event):void
		{
			fireLayer = new FireRoad();
			addChild(fireLayer)
			fireLayer.visible = false;
			
			iceLayer = new Ice();
			addChild(iceLayer)
			iceLayer.visible = false;
			_root = MovieClip(root);
			removeEventListener(Event.ADDED_TO_STAGE, beginClass);
		}
		public function addFireLayer(sourceSkill:Object,BurnAmount:Number):void
		{
			if (skillsList.indexOf(sourceSkill) == -1)
			{
			skillsList.push(sourceSkill)
			burnAmount += BurnAmount;
			}
			if (burnAmount > 0)
			{
				isOnFire = true;
				fireLayer.visible = true;
			}
		}
		public function removeFireLayer(sourceSkill:Object,BurnAmount:int):void
		{
			skillsList.splice(skillsList.indexOf(sourceSkill),1)
			burnAmount -= BurnAmount;
			if (burnAmount == 0)
			{
			fireLayer.visible = false;
			isOnFire = false;
			}
		}
		public function addIceLayer(sourceSkill:Skill,slow:Number):void
		{
			if (skillsList.indexOf(sourceSkill) == -1)
			{
				skillsList.push(sourceSkill)
				//trace("thisXY: ", this.x/32,this.y/32,"SL.length: ",skillsList.length,"My ID: ",skillsList.indexOf(sourceSkill))
			}
			if (icedSlow == 0)
			{
				iceLayer.visible = true
				isIced = true;
			}
			if (icedSlow < slow)
			{
				icedSlow = slow
			}
		}
		public function removeIceLayer(sourceSkill:Object):void
		{
			//trace("index of: ",skillsList.indexOf(sourceSkill))
			skillsList.splice(skillsList.indexOf(sourceSkill),1)
			var icedCheck:Boolean;
			icedSlow = 0;
			for (var i:int=0; i <skillsList.length;i++)
			{
				if (skillsList[i].sName == sourceSkill.sName)
				{
					//trace("Found iceman at: ",i)
					if (icedSlow < skillsList[i].sA[2])
					{
						//trace("He had higher ice: ", skillsList[i].sA[2])
						icedSlow = skillsList[i].sA[2]
					}
					icedCheck = true
				}
			}
			if (icedCheck == false)
			{
				//trace("No other ice")
				iceLayer.visible = false;
				isIced = false;
			}
			//trace("SkillsList length: ",skillsList.length)
			
		}
		private function endClass(e:Event):void
		{
			while(skillsList.length > 0)
			{
				skillsList[0].deactivateSkill(skillsList[0]);
			}
			iceLayer = null;
			fireLayer = null;
			_root = null;
			removeEventListener(Event.ADDED_TO_STAGE, beginClass);
			removeEventListener(Event.REMOVED, endClass)
		}
	}
	
}
