package com.sulake.habbo.navigator.context
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.communication.messages.parser.newnavigator.class_1145;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1706;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1764;
   
   public class ContextContainer
   {
       
      
      private var _navigator:HabboNewNavigator;
      
      private var var_3122:Map;
      
      private var var_674:Vector.<class_1706>;
      
      public function ContextContainer(param1:HabboNewNavigator)
      {
         var_674 = new Vector.<class_1706>();
         super();
         _navigator = param1;
      }
      
      public function hasContextFor(param1:String) : Boolean
      {
         if(!var_3122)
         {
            return false;
         }
         return var_3122.hasKey(param1);
      }
      
      public function initialize(param1:class_1145) : void
      {
         var_3122 = new Map();
         for each(var _loc2_ in param1.topLevelContexts)
         {
            var_3122.add(_loc2_.searchCode,_loc2_.quickLinks);
         }
      }
      
      public function getTopLevelSearches() : Array
      {
         return var_3122.getKeys();
      }
      
      public function get savedSearches() : Vector.<class_1706>
      {
         return var_674;
      }
      
      public function set savedSearches(param1:Vector.<class_1706>) : void
      {
         var_674 = param1;
      }
      
      public function isReady() : Boolean
      {
         return var_3122 != null;
      }
   }
}
