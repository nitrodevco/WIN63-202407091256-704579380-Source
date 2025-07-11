package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.utils.QuickRandom;
   
   public class class_3565 extends DefaultGameStage
   {
       
      
      protected var var_757:Map;
      
      private var var_2684:Array;
      
      private var var_2692:Array;
      
      public function class_3565()
      {
         var_757 = new Map();
         var_2684 = [];
         var_2692 = [];
         super();
      }
      
      private static function zeroPad2digit(param1:int) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return param1.toString();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(var_757 != null)
         {
            for each(var _loc1_ in var_757)
            {
               _loc1_.dispose();
            }
            var_757.dispose();
            var_757 = null;
         }
         var_2684 = [];
         var_2692 = [];
      }
      
      public function addGameObject(param1:int, param2:ISynchronizedGameObject) : void
      {
         var_757.add(param1,param2);
         param2.isActive = true;
      }
      
      public function addInactiveGameObject(param1:int, param2:ISynchronizedGameObject) : void
      {
         var_757.add(param1,param2);
         param2.isActive = false;
      }
      
      public function addGameObjectById(param1:int, param2:ISynchronizedGameObject) : void
      {
         var_757.add(param1,param2);
         param2.isActive = true;
         if(param2.gameObjectId != param1)
         {
            throw new Exception("Could not add gameobject with id:" + param1);
         }
      }
      
      public function removeGameObject(param1:int) : void
      {
         var _loc2_:ISynchronizedGameObject = var_757.remove(param1);
         if(_loc2_)
         {
            _loc2_.onRemove();
            var_2692.push(_loc2_);
         }
      }
      
      public function removeAllGameObjects() : void
      {
         for each(var _loc1_ in var_757.getValues())
         {
            _loc1_.onRemove();
            var_2692.push(_loc1_);
         }
         var_757 = new Map();
      }
      
      public function putGameObjectOnDeleteList(param1:ISynchronizedGameObject) : void
      {
         if(param1 == null)
         {
            HabboGamesCom.log("Trying to put null in delete list.");
            return;
         }
         var_2684.push(param1);
         param1.isActive = false;
      }
      
      public function getGameObject(param1:int) : ISynchronizedGameObject
      {
         return var_757.getValue(param1) as ISynchronizedGameObject;
      }
      
      public function getGameObjects() : Array
      {
         return var_757.getValues();
      }
      
      public function subturn() : void
      {
         for each(var _loc2_ in var_757.getValues())
         {
            _loc2_.subturn(this);
         }
         if(var_2684.length > 0)
         {
            for each(var _loc1_ in var_2684)
            {
               this.removeGameObject(_loc1_.gameObjectId);
            }
            var_2684 = [];
         }
      }
      
      public function calculateChecksum(param1:int) : int
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = QuickRandom.iterateSeed(param1);
         var _loc8_:int = 1;
         var _loc9_:int = 0;
         var _loc4_:String = "";
         var _loc3_:String = "";
         if(HabboGamesCom.logEnabled && param1 % _loc8_ == 0)
         {
            _loc4_ = (_loc4_ = (_loc4_ = "") + ("\nturn ### " + param1 + " ###\n")) + ("seed " + _loc6_ + "\n");
            _loc3_ = "";
         }
         for each(var _loc10_ in var_757)
         {
            if(_loc10_.isGhost && _loc10_ is HumanGameObject)
            {
               HumanGameObject(_loc10_).addGhostLocation(param1);
            }
            else if(!(!_loc10_.isActive || Boolean(_loc10_.isGhost)))
            {
               _loc7_ = 1;
               _loc5_ = _loc10_.numberOfVariables;
               _loc2_ = 0;
               while(_loc2_ < _loc5_)
               {
                  _loc6_ += _loc10_.getVariable(_loc2_) * _loc7_;
                  _loc7_++;
                  if(HabboGamesCom.logEnabled && param1 % _loc8_ == 0)
                  {
                     _loc3_ += _loc10_.getVariable(_loc2_);
                     if(_loc2_ < _loc5_ - 1)
                     {
                        _loc3_ += ",";
                     }
                  }
                  _loc2_++;
               }
               if(HabboGamesCom.logEnabled && param1 % _loc8_ == 0)
               {
                  _loc4_ += "++ \"O" + zeroPad2digit(_loc9_ + 1) + "-CS:" + _loc6_ + " Parms:" + _loc3_ + "\"\n";
                  _loc3_ = "";
                  _loc9_++;
               }
            }
         }
         if(param1 % _loc8_ == 0)
         {
            HabboGamesCom.log(_loc4_.toString());
         }
         return _loc6_;
      }
      
      public function appendGameObjects(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         for each(_loc3_ in var_757.getValues())
         {
            if(_loc3_.isActive)
            {
               _loc2_++;
            }
         }
         param1.writeInt(_loc2_);
         for each(_loc3_ in var_757.getValues())
         {
            if(_loc3_.isActive)
            {
            }
         }
      }
      
      public function resetRemovedGameObjects() : Array
      {
         var _loc1_:Array = var_2692;
         var_2692 = [];
         return _loc1_;
      }
   }
}
