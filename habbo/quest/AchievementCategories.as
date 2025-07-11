package com.sulake.habbo.quest
{
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_1724;
   
   public class AchievementCategories
   {
      
      private static const ACHIEVEMENT_DISABLED:int = 0;
      
      private static const ACHIEVEMENT_ENABLED:int = 1;
      
      private static const ACHIEVEMENT_ARCHIVED:int = 2;
      
      private static const ACHIEVEMENT_OFF_SEASON:int = 3;
      
      private static const ACHIEVEMENT_CATEGORY_ARCHIVED:String = "archive";
       
      
      private var var_3068:Dictionary;
      
      private var var_2706:Vector.<AchievementCategory>;
      
      public function AchievementCategories(param1:Array)
      {
         var _loc4_:* = null;
         var _loc5_:AchievementCategory = null;
         var_3068 = new Dictionary();
         var_2706 = new Vector.<AchievementCategory>(0);
         super();
         var _loc2_:AchievementCategory = new AchievementCategory("archive");
         var_3068["archive"] = _loc2_;
         for each(var _loc3_ in param1)
         {
            if(_loc3_.category != "")
            {
               if(_loc3_.state == 2)
               {
                  _loc5_ = var_3068["archive"];
               }
               else
               {
                  _loc5_ = var_3068[_loc3_.category];
               }
               if(_loc5_ == null)
               {
                  _loc5_ = new AchievementCategory(_loc3_.category);
                  var_3068[_loc3_.category] = _loc5_;
                  if(_loc3_.category != "misc")
                  {
                     var_2706.push(_loc5_);
                  }
                  else
                  {
                     _loc4_ = _loc5_;
                  }
               }
               _loc5_.add(_loc3_);
            }
         }
         if(_loc4_ != null)
         {
            var_2706.push(_loc4_);
         }
         var_2706.push(_loc2_);
      }
      
      public function update(param1:class_1724) : void
      {
         if(param1 == null || param1.category == "")
         {
            return;
         }
         var _loc2_:AchievementCategory = var_3068[param1.category];
         if(_loc2_ != null)
         {
            _loc2_.update(param1);
         }
      }
      
      public function get categoryList() : Vector.<AchievementCategory>
      {
         return var_2706;
      }
      
      public function getMaxProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_2706)
         {
            _loc1_ += _loc2_.getMaxProgress();
         }
         return _loc1_;
      }
      
      public function getProgress() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_2706)
         {
            _loc1_ += _loc2_.getProgress();
         }
         return _loc1_;
      }
      
      public function getCategoryByCode(param1:String) : AchievementCategory
      {
         for each(var _loc2_ in var_2706)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
