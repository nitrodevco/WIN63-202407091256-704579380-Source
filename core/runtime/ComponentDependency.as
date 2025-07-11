package com.sulake.core.runtime
{
   public class ComponentDependency
   {
       
      
      private var var_443:IID;
      
      private var var_818:Function;
      
      private var var_798:Boolean;
      
      private var _eventListeners:Array;
      
      public function ComponentDependency(param1:IID, param2:Function, param3:Boolean = true, param4:Array = null)
      {
         super();
         var_443 = param1;
         var_818 = param2;
         var_798 = param3;
         _eventListeners = param4;
      }
      
      internal function get identifier() : IID
      {
         return var_443;
      }
      
      internal function get dependencySetter() : Function
      {
         return var_818;
      }
      
      internal function get isRequired() : Boolean
      {
         return var_798;
      }
      
      internal function get eventListeners() : Array
      {
         return _eventListeners;
      }
   }
}
