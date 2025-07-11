package com.sulake.habbo.avatar.structure.figure
{
   import com.sulake.core.utils.Map;
   import flash.utils.Dictionary;
   
   public class SetType implements ISetType
   {
       
      
      private var var_2113:Map;
      
      private var var_329:String;
      
      private var var_4744:int;
      
      private var var_2468:Dictionary;
      
      public function SetType(param1:XML)
      {
         super();
         var_329 = String(param1.@type);
         var_4744 = parseInt(param1.@paletteid);
         var_2468 = new Dictionary();
         var_2468["F"] = [];
         var_2468["M"] = [];
         var_2468["F"][0] = Boolean(parseInt(param1.@mand_f_0));
         var_2468["F"][1] = Boolean(parseInt(param1.@mand_f_1));
         var_2468["M"][0] = Boolean(parseInt(param1.@mand_m_0));
         var_2468["M"][1] = Boolean(parseInt(param1.@mand_m_1));
         var_2113 = new Map();
         append(param1);
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in var_2113.getValues())
         {
            _loc1_.dispose();
         }
         var_2113.dispose();
         var_2113 = null;
      }
      
      public function cleanUp(param1:XML) : void
      {
         var _loc3_:String = null;
         var _loc2_:FigurePartSet = null;
         for each(var _loc4_ in param1["set"])
         {
            _loc3_ = String(_loc4_.@id);
            _loc2_ = var_2113.getValue(_loc3_);
            if(_loc2_ != null)
            {
               _loc2_.dispose();
               var_2113.remove(_loc3_);
            }
         }
      }
      
      public function append(param1:XML) : void
      {
         for each(var _loc2_ in param1["set"])
         {
            var_2113.add(String(_loc2_.@id),new FigurePartSet(_loc2_,var_329));
         }
      }
      
      public function getDefaultPartSet(param1:String) : class_3418
      {
         var _loc4_:int = 0;
         var _loc2_:class_3418 = null;
         var _loc3_:Array = var_2113.getKeys();
         _loc4_ = _loc3_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc2_ = var_2113.getValue(_loc3_[_loc4_]);
            if(_loc2_ && _loc2_.clubLevel == 0 && (_loc2_.gender == param1 || _loc2_.gender == "U"))
            {
               return _loc2_;
            }
            _loc4_--;
         }
         return null;
      }
      
      public function getPartSet(param1:int) : class_3418
      {
         return var_2113.getValue(String(param1));
      }
      
      public function get type() : String
      {
         return var_329;
      }
      
      public function get paletteID() : int
      {
         return var_4744;
      }
      
      public function isMandatory(param1:String, param2:int) : Boolean
      {
         return var_2468[param1.toUpperCase()][Math.min(param2,1)];
      }
      
      public function optionalFromClubLevel(param1:String) : int
      {
         var _loc2_:Array = var_2468[param1.toUpperCase()];
         return _loc2_.indexOf(false);
      }
      
      public function get partSets() : Map
      {
         return var_2113;
      }
   }
}
