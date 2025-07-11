package com.sulake.room.renderer.cache
{
    import assets.class_14

    import com.sulake.core.utils.Map;
   import com.sulake.room.renderer.utils.class_3815;
   import flash.display.BitmapData;
   
   [SecureSWF(rename="true")]
   public class class_3807
   {
       
      
      private var var_2139:Map;
      
      private var var_2529:int = 0;
      
      private var var_2699:int = 0;
      
      private var var_4215:int = 0;
      
      private var var_3433:int = 0;
      
      public function class_3807(param1:int, param2:int, param3:int = 1)
      {
         super();
         var_2139 = new Map();
         var_2699 = param1 * 1024 * 1024;
         var_4215 = param2 * 1024 * 1024;
         var_3433 = param3 * 1024 * 1024;
         if(var_3433 < 0)
         {
            var_3433 = 0;
         }
      }
      
      public function get memUsage() : int
      {
         return var_2529;
      }
      
      public function get memLimit() : int
      {
         return var_2699;
      }
      
      public function dispose() : void
      {
         var _loc1_:Array = null;
         if(var_2139 != null)
         {
            _loc1_ = var_2139.getKeys();
            for each(var _loc2_ in _loc1_)
            {
               if(!removeItem(_loc2_))
               {
                  class_14.log("Failed to remove item " + _loc2_ + " from room canvas bitmap cache!");
               }
            }
            var_2139.dispose();
            var_2139 = null;
         }
      }
      
      public function compress() : void
      {
         var _loc1_:Array = null;
         var _loc2_:class_3846 = null;
         var _loc3_:int = 0;
         if(memUsage > memLimit)
         {
            _loc1_ = var_2139.getValues();
            _loc1_.sortOn("useCount",16);
            _loc1_.reverse();
            _loc3_ = _loc1_.length - 1;
            while(_loc3_ >= 0)
            {
               _loc2_ = _loc1_[_loc3_] as class_3846;
               if(_loc2_.useCount > 1)
               {
                  break;
               }
               removeItem(_loc2_.name);
               _loc3_--;
            }
            increaseMemoryLimit();
         }
      }
      
      private function increaseMemoryLimit() : void
      {
         var_2699 += var_3433;
         if(var_2699 > var_4215)
         {
            var_2699 = var_4215;
         }
      }
      
      private function removeItem(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:class_3846 = var_2139.getValue(param1) as class_3846;
         if(_loc2_ != null)
         {
            if(_loc2_.useCount <= 1)
            {
               var_2139.remove(_loc2_.name);
               var_2529 -= _loc2_.memUsage;
               _loc2_.dispose();
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function getBitmapData(param1:String) : class_3815
      {
         var _loc2_:class_3846 = var_2139.getValue(param1) as class_3846;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.bitmapData;
      }
      
      public function addBitmapData(param1:String, param2:class_3815) : void
      {
         var _loc4_:BitmapData = null;
         if(param2 == null || param2.width <= 0 || param2.height <= 0)
         {
            return;
         }
         var _loc3_:class_3846 = var_2139.getValue(param1) as class_3846;
         if(_loc3_ != null)
         {
            if((_loc4_ = _loc3_.bitmapData) != null)
            {
               var_2529 -= _loc4_.width * _loc4_.height * 4;
            }
            _loc3_.bitmapData = param2;
         }
         else
         {
            _loc3_ = new class_3846(param2,param1);
            var_2139.add(param1,_loc3_);
         }
         var_2529 += param2.width * param2.height * 4;
      }
   }
}
