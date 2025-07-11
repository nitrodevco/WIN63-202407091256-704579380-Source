package com.sulake.room.object
{
   import com.sulake.core.utils.Map;
   import flash.utils.Dictionary;
   
   public class RoomObjectModel implements IRoomObjectModelController
   {
      
      private static const MAP_KEYS_PREFIX:String = "ROMC_MAP_KEYS_";
      
      private static const MAP_VALUES_PREFIX:String = "ROMC_MAP_VALUES_";
       
      
      private var var_2282:Dictionary;
      
      private var var_2363:Dictionary;
      
      private var var_2346:Dictionary;
      
      private var var_2292:Dictionary;
      
      private var var_3425:Array;
      
      private var var_3349:Array;
      
      private var var_3329:Array;
      
      private var var_3431:Array;
      
      private var var_1656:int;
      
      public function RoomObjectModel()
      {
         super();
         var_2282 = new Dictionary();
         var_2363 = new Dictionary();
         var_2346 = new Dictionary();
         var_2292 = new Dictionary();
         var_3425 = [];
         var_3349 = [];
         var_3329 = [];
         var_3431 = [];
         var_1656 = 0;
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         if(var_2282 != null)
         {
            for(_loc1_ in var_2282)
            {
               delete var_2282[_loc1_];
            }
            var_2282 = null;
         }
         if(var_2363 != null)
         {
            for(_loc1_ in var_2363)
            {
               delete var_2363[_loc1_];
            }
            var_2363 = null;
         }
         if(var_2346 != null)
         {
            for(_loc1_ in var_2346)
            {
               delete var_2346[_loc1_];
            }
            var_2346 = null;
         }
         if(var_2292 != null)
         {
            for(_loc1_ in var_2292)
            {
               delete var_2292[_loc1_];
            }
            var_2292 = null;
         }
         var_3349 = [];
         var_3425 = [];
         var_3431 = [];
         var_3329 = [];
      }
      
      public function hasNumber(param1:String) : Boolean
      {
         return var_2282[param1] != null;
      }
      
      public function hasNumberArray(param1:String) : Boolean
      {
         return var_2346[param1] != null;
      }
      
      public function hasString(param1:String) : Boolean
      {
         return var_2363[param1] != null;
      }
      
      public function hasStringArray(param1:String) : Boolean
      {
         return var_2292[param1] != null;
      }
      
      public function getNumber(param1:String) : Number
      {
         return var_2282[param1];
      }
      
      public function getString(param1:String) : String
      {
         return var_2363[param1];
      }
      
      public function getNumberArray(param1:String) : Array
      {
         var _loc2_:Array = var_2346[param1];
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.slice();
         }
         return _loc2_;
      }
      
      public function getStringArray(param1:String) : Array
      {
         var _loc2_:Array = var_2292[param1];
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.slice();
         }
         return _loc2_;
      }
      
      public function getStringToStringMap(param1:String) : Map
      {
         var _loc4_:int = 0;
         var _loc5_:Map = new Map();
         var _loc2_:Array = getStringArray("ROMC_MAP_KEYS_" + param1);
         var _loc3_:Array = getStringArray("ROMC_MAP_VALUES_" + param1);
         if(_loc2_ != null && _loc3_ != null && _loc2_.length == _loc3_.length)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc5_.add(_loc2_[_loc4_],_loc3_[_loc4_]);
               _loc4_++;
            }
         }
         return _loc5_;
      }
      
      public function setNumber(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(var_3425.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_3425.push(param1);
         }
         if(var_2282[param1] != param2)
         {
            var_2282[param1] = param2;
            var_1656++;
         }
      }
      
      public function setString(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(var_3349.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_3349.push(param1);
         }
         if(var_2363[param1] != param2)
         {
            var_2363[param1] = param2;
            var_1656++;
         }
      }
      
      public function setNumberArray(param1:String, param2:Array, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(var_3329.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_3329.push(param1);
         }
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            if(param2[_loc7_] is Number)
            {
               _loc6_.push(param2[_loc7_]);
            }
            _loc7_++;
         }
         var _loc5_:Array = var_2346[param1];
         var _loc4_:Boolean = true;
         if(_loc5_ != null && _loc5_.length == _loc6_.length)
         {
            _loc7_ = _loc6_.length - 1;
            while(_loc7_ >= 0)
            {
               if(_loc6_[_loc7_] as Number != _loc5_[_loc7_] as Number)
               {
                  _loc4_ = false;
                  break;
               }
               _loc7_--;
            }
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            return;
         }
         var_2346[param1] = _loc6_;
         var_1656++;
      }
      
      public function setStringArray(param1:String, param2:Array, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(var_3431.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_3431.push(param1);
         }
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            if(param2[_loc7_] is String)
            {
               _loc6_.push(param2[_loc7_]);
            }
            _loc7_++;
         }
         var _loc5_:Array = var_2292[param1];
         var _loc4_:Boolean = true;
         if(_loc5_ != null && _loc5_.length == _loc6_.length)
         {
            _loc7_ = _loc6_.length - 1;
            while(_loc7_ >= 0)
            {
               if(_loc6_[_loc7_] as String != _loc5_[_loc7_] as String)
               {
                  _loc4_ = false;
                  break;
               }
               _loc7_--;
            }
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            return;
         }
         var_2292[param1] = _loc6_;
         var_1656++;
      }
      
      public function setStringToStringMap(param1:String, param2:Map, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         setStringArray("ROMC_MAP_KEYS_" + param1,param2.getKeys(),param3);
         setStringArray("ROMC_MAP_VALUES_" + param1,param2.getValues(),param3);
      }
      
      public function getUpdateID() : int
      {
         return var_1656;
      }
   }
}
