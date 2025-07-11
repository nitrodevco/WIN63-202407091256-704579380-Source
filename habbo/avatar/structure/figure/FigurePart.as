package com.sulake.habbo.avatar.structure.figure
{
   public class FigurePart implements class_3617
   {
       
      
      private var var_280:int;
      
      private var var_329:String;
      
      private var var_4504:int = -1;
      
      private var var_4311:int;
      
      private var _index:int;
      
      private var var_4569:int = -1;
      
      public function FigurePart(param1:XML)
      {
         super();
         var_280 = parseInt(param1.@id);
         var_329 = String(param1.@type);
         _index = parseInt(param1.@index);
         var_4311 = parseInt(param1.@colorindex);
         var _loc2_:String = param1.@palettemapid;
         if(_loc2_ != "")
         {
            var_4569 = int(_loc2_);
         }
         var _loc3_:String = param1.@breed;
         if(_loc3_ != "")
         {
            var_4504 = int(_loc3_);
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get type() : String
      {
         return var_329;
      }
      
      public function get breed() : int
      {
         return var_4504;
      }
      
      public function get colorLayerIndex() : int
      {
         return var_4311;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get paletteMap() : int
      {
         return var_4569;
      }
   }
}
