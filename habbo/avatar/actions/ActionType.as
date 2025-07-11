package com.sulake.habbo.avatar.actions
{
   public class ActionType
   {
       
      
      private var var_280:int;
      
      private var _value:int;
      
      private var var_3714:Array;
      
      private var var_4062:Boolean = true;
      
      private var var_3839:Boolean = true;
      
      public function ActionType(param1:XML)
      {
         var_3714 = [];
         super();
         var_280 = parseInt(param1.@value);
         _value = parseInt(param1.@value);
         var _loc3_:String = String(param1.@prevents);
         if(_loc3_ != "")
         {
            var_3714 = _loc3_.split(",");
         }
         var_4062 = String(param1.@preventheadturn) == "true";
         var _loc2_:String = String(param1.@animated);
         if(_loc2_ == "")
         {
            var_3839 = true;
         }
         else
         {
            var_3839 = _loc2_ == "true";
         }
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get prevents() : Array
      {
         return var_3714;
      }
      
      public function get preventHeadTurn() : Boolean
      {
         return var_4062;
      }
      
      public function get isAnimated() : Boolean
      {
         return var_3839;
      }
   }
}
