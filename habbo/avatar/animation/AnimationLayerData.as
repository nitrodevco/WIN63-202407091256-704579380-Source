package com.sulake.habbo.avatar.animation
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.actions.ActiveActionData;
   import com.sulake.habbo.avatar.actions.class_3544;
   import com.sulake.habbo.avatar.actions.class_3576;
   
   public class AnimationLayerData implements class_3526
   {
      
      public static const const_868:String = "bodypart";
      
      public static const const_933:String = "fx";
       
      
      private var var_280:String;
      
      private var _action:class_3544;
      
      private var _animationFrame:int;
      
      private var var_3823:int;
      
      private var var_3740:int;
      
      private var var_3945:int;
      
      private var _directionOffset:int;
      
      private var var_329:String;
      
      private var var_710:String;
      
      private var _items:Map;
      
      public function AnimationLayerData(param1:XML, param2:String, param3:class_3576)
      {
         _items = new Map();
         super();
         var_280 = String(param1.@id);
         _animationFrame = parseInt(param1.@frame);
         var_3823 = parseInt(param1.@dx);
         var_3740 = parseInt(param1.@dy);
         var_3945 = parseInt(param1.@dz);
         _directionOffset = parseInt(param1.@dd);
         var_329 = param2;
         var_710 = String(param1.@base);
         for each(var _loc5_ in param1.item)
         {
            _items[String(_loc5_.@id)] = String(_loc5_.@base);
         }
         var _loc4_:String = "";
         if(var_710 != "")
         {
            _loc4_ = String(baseAsInt());
         }
         if(param3 != null)
         {
            _action = new ActiveActionData(param3.state,base);
            _action.definition = param3;
         }
      }
      
      public function get items() : Map
      {
         return _items;
      }
      
      private function baseAsInt() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < var_710.length)
         {
            _loc2_ += var_710.charCodeAt(_loc1_);
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get id() : String
      {
         return var_280;
      }
      
      public function get animationFrame() : int
      {
         return _animationFrame;
      }
      
      public function get dx() : int
      {
         return var_3823;
      }
      
      public function get dy() : int
      {
         return var_3740;
      }
      
      public function get dz() : int
      {
         return var_3945;
      }
      
      public function get directionOffset() : int
      {
         return _directionOffset;
      }
      
      public function get type() : String
      {
         return var_329;
      }
      
      public function get base() : String
      {
         return var_710;
      }
      
      public function get action() : class_3544
      {
         return _action;
      }
   }
}
