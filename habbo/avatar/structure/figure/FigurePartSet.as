package com.sulake.habbo.avatar.structure.figure
{
   public class FigurePartSet implements class_3418
   {
       
      
      private var var_329:String;
      
      private var var_280:int;
      
      private var var_129:String;
      
      private var var_842:int;
      
      private var var_3248:Boolean;
      
      private var var_901:Boolean;
      
      private var var_1891:Array;
      
      private var _hiddenLayers:Array;
      
      private var var_4264:Boolean;
      
      private var var_1120:Boolean;
      
      public function FigurePartSet(param1:XML, param2:String)
      {
         var _loc3_:FigurePart = null;
         var _loc5_:int = 0;
         super();
         var_329 = param2;
         var_280 = parseInt(param1.@id);
         var_129 = String(param1.@gender);
         var_842 = parseInt(param1.@club);
         var_3248 = Boolean(parseInt(param1.@colorable));
         var_901 = Boolean(parseInt(param1.@selectable));
         var_4264 = Boolean(parseInt(param1.@preselectable));
         var_1120 = Boolean(parseInt(param1.@sellable));
         var_1891 = [];
         _hiddenLayers = [];
         for each(var _loc4_ in param1.part)
         {
            _loc3_ = new FigurePart(_loc4_);
            if((_loc5_ = indexOfPartType(_loc3_)) != -1)
            {
               var_1891.splice(_loc5_,0,_loc3_);
            }
            else
            {
               var_1891.push(_loc3_);
            }
         }
         for each(var _loc6_ in param1.hiddenlayers.layer)
         {
            _hiddenLayers.push(String(_loc6_.@parttype));
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in var_1891)
         {
            _loc1_.dispose();
         }
         var_1891 = null;
         _hiddenLayers = null;
      }
      
      private function indexOfPartType(param1:FigurePart) : int
      {
         var _loc3_:int = 0;
         var _loc2_:FigurePart = null;
         _loc3_ = 0;
         while(_loc3_ < var_1891.length)
         {
            _loc2_ = var_1891[_loc3_];
            if(_loc2_.type == param1.type && _loc2_.index < param1.index)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function getPart(param1:String, param2:int) : class_3617
      {
         for each(var _loc3_ in var_1891)
         {
            if(_loc3_.type == param1 && _loc3_.id == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function get type() : String
      {
         return var_329;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get gender() : String
      {
         return var_129;
      }
      
      public function get clubLevel() : int
      {
         return var_842;
      }
      
      public function get isColorable() : Boolean
      {
         return var_3248;
      }
      
      public function get isSelectable() : Boolean
      {
         return var_901;
      }
      
      public function get parts() : Array
      {
         return var_1891;
      }
      
      public function get hiddenLayers() : Array
      {
         return _hiddenLayers;
      }
      
      public function get isPreSelectable() : Boolean
      {
         return var_4264;
      }
      
      public function get isSellable() : Boolean
      {
         return var_1120;
      }
   }
}
