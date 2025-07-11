package com.sulake.habbo.avatar.structure
{
   import com.sulake.habbo.avatar.actions.ActionDefinition;
   import com.sulake.habbo.avatar.actions.class_3576;
   import com.sulake.habbo.avatar.structure.parts.*;
   import flash.utils.Dictionary;
   
   public class PartSetsData implements IStructureData
   {
       
      
      private var var_1891:Dictionary;
      
      private var var_3256:Dictionary;
      
      public function PartSetsData()
      {
         super();
         var_1891 = new Dictionary();
         var_3256 = new Dictionary();
      }
      
      public function parse(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc3_ in param1.partSet[0].part)
         {
            var_1891[String(_loc3_["set-type"])] = new PartDefinition(_loc3_);
         }
         for each(var _loc2_ in param1.activePartSet)
         {
            var_3256[String(_loc2_.@id)] = new ActivePartSet(_loc2_);
         }
         return true;
      }
      
      public function appendXML(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc3_ in param1.partSet[0].part)
         {
            var_1891[String(_loc3_["set-type"])] = new PartDefinition(_loc3_);
         }
         for each(var _loc2_ in param1.activePartSet)
         {
            var_3256[String(_loc2_.@id)] = new ActivePartSet(_loc2_);
         }
         return false;
      }
      
      public function getActiveParts(param1:class_3576) : Array
      {
         var _loc2_:ActivePartSet = var_3256[param1.activePartSet];
         if(_loc2_ != null)
         {
            return _loc2_.parts;
         }
         return [];
      }
      
      public function getPartDefinition(param1:String) : PartDefinition
      {
         return var_1891[param1] as PartDefinition;
      }
      
      public function addPartDefinition(param1:XML) : PartDefinition
      {
         var _loc2_:String = String(param1["set-type"]);
         if(var_1891[_loc2_] == null)
         {
            var_1891[_loc2_] = new PartDefinition(param1);
         }
         return var_1891[_loc2_];
      }
      
      public function get parts() : Dictionary
      {
         return var_1891;
      }
      
      public function get activePartSets() : Dictionary
      {
         return var_3256;
      }
      
      public function getActivePartSet(param1:ActionDefinition) : ActivePartSet
      {
         return var_3256[param1.activePartSet] as ActivePartSet;
      }
   }
}
