package com.sulake.habbo.quest
{
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_1724;
   
   public class AchievementCategory
   {
       
      
      private var var_1078:String;
      
      private var var_275:Vector.<class_1724>;
      
      public function AchievementCategory(param1:String)
      {
         var_275 = new Vector.<class_1724>(0);
         super();
         var_1078 = param1;
      }
      
      public function add(param1:class_1724) : void
      {
         var_275.push(param1);
      }
      
      public function update(param1:class_1724) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_1724 = null;
         _loc3_ = 0;
         while(_loc3_ < var_275.length)
         {
            _loc2_ = var_275[_loc3_];
            if(_loc2_.achievementId == param1.achievementId)
            {
               var_275[_loc3_] = param1;
            }
            _loc3_++;
         }
      }
      
      public function getProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_275)
         {
            _loc1_ += _loc2_.finalLevel ? _loc2_.level : _loc2_.level - 1;
         }
         return _loc1_;
      }
      
      public function getMaxProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_275)
         {
            _loc1_ += _loc2_.levelCount;
         }
         return _loc1_;
      }
      
      public function get code() : String
      {
         return var_1078;
      }
      
      public function get achievements() : Vector.<class_1724>
      {
         return var_275;
      }
   }
}
