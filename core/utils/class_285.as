package com.sulake.core.utils
{
   import flash.text.Font;
   import flash.utils.getQualifiedClassName;
   
   public class class_285
   {
      
      private static const const_6:Map = new Map();
      
      private static const const_4:Map = new Map();
      
      private static var var_1128:Boolean = false;
      
      {
         init();
      }
      
      public function class_285()
      {
         super();
      }
      
      public static function isSystemFont(param1:String) : Boolean
      {
         return const_6.getValue(param1) != null;
      }
      
      public static function isEmbeddedFont(param1:String) : Boolean
      {
         return const_4.getValue(param1) != null;
      }
      
      public static function get systemFonts() : Map
      {
         return const_6;
      }
      
      public static function get embeddedFonts() : Map
      {
         return const_4;
      }
      
      public static function registerFont(param1:Class) : Font
      {
         var _loc2_:Font = null;
         var _loc5_:* = 0;
         Font.registerFont(param1 as Class);
         var _loc3_:String = getQualifiedClassName(param1);
         var _loc4_:int;
         var _loc6_:Array;
         _loc5_ = _loc4_ = int((_loc6_ = Font.enumerateFonts(false)).length);
         while(_loc5_ > 0)
         {
            _loc2_ = _loc6_[_loc5_ - 1];
            if(getQualifiedClassName(_loc2_) == _loc3_)
            {
               break;
            }
            _loc5_--;
         }
         const_4.add(_loc2_.fontName,_loc2_);
         return _loc2_;
      }
      
      private static function init() : void
      {
         var _loc2_:Array = null;
         var _loc1_:Array = null;
         if(!var_1128)
         {
            _loc2_ = Font.enumerateFonts(true);
            _loc1_ = Font.enumerateFonts(false);
            for each(var _loc3_ in _loc2_)
            {
               if(_loc1_.indexOf(_loc3_) == -1)
               {
                  const_6.add(_loc3_.fontName,_loc3_);
               }
            }
            var_1128 = true;
         }
      }
      
      public static function refresh() : void
      {
         var _loc1_:Font = null;
         var _loc5_:Font = null;
         var _loc3_:int = 0;
         var _loc4_:Array;
         var _loc2_:int = int((_loc4_ = Font.enumerateFonts(false)).length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc4_[_loc3_];
            if(!(_loc5_ = const_4.getValue(_loc1_.fontName)) || _loc5_.fontType != _loc1_.fontType || _loc5_.fontStyle != _loc1_.fontStyle)
            {
               const_4.add(_loc1_.fontName,_loc1_);
            }
            _loc3_++;
         }
      }
   }
}
