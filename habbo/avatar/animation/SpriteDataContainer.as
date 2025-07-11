package com.sulake.habbo.avatar.animation
{
   public class SpriteDataContainer implements ISpriteDataContainer
   {
       
      
      private var var_3223:class_3557;
      
      private var var_280:String;
      
      private var var_4150:int;
      
      private var var_4856:String;
      
      private var var_4674:Boolean;
      
      private var var_4510:Boolean;
      
      private var var_3823:Array;
      
      private var var_3740:Array;
      
      private var var_3945:Array;
      
      public function SpriteDataContainer(param1:class_3557, param2:XML)
      {
         var _loc4_:int = 0;
         super();
         var_3223 = param1;
         var_280 = String(param2.@id);
         var_4150 = parseInt(param2.@ink);
         var_4856 = String(param2.@member);
         var_4510 = Boolean(parseInt(param2.@staticY));
         var_4674 = Boolean(parseInt(param2.@directions));
         var_3823 = [];
         var_3740 = [];
         var_3945 = [];
         for each(var _loc3_ in param2.direction)
         {
            _loc4_ = parseInt(_loc3_.@id);
            var_3823[_loc4_] = parseInt(_loc3_.@dx);
            var_3740[_loc4_] = parseInt(_loc3_.@dy);
            var_3945[_loc4_] = parseInt(_loc3_.@dz);
         }
      }
      
      public function getDirectionOffsetX(param1:int) : int
      {
         if(param1 < var_3823.length)
         {
            return var_3823[param1];
         }
         return 0;
      }
      
      public function getDirectionOffsetY(param1:int) : int
      {
         if(param1 < var_3740.length)
         {
            return var_3740[param1];
         }
         return 0;
      }
      
      public function getDirectionOffsetZ(param1:int) : int
      {
         if(param1 < var_3945.length)
         {
            return var_3945[param1];
         }
         return 0;
      }
      
      public function get animation() : class_3557
      {
         return var_3223;
      }
      
      public function get id() : String
      {
         return var_280;
      }
      
      public function get ink() : int
      {
         return var_4150;
      }
      
      public function get member() : String
      {
         return var_4856;
      }
      
      public function get hasDirections() : Boolean
      {
         return var_4674;
      }
      
      public function get hasStaticY() : Boolean
      {
         return var_4510;
      }
   }
}
