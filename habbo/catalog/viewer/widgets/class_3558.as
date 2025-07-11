package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.viewer.class_3455;
   import flash.events.IEventDispatcher;
   
   public interface class_3558
   {
       
      
      function set page(param1:class_3455) : void;
      
      function set events(param1:IEventDispatcher) : void;
      
      function get window() : IWindowContainer;
      
      function get events() : IEventDispatcher;
      
      function get page() : class_3455;
      
      function dispose() : void;
      
      function init() : Boolean;
      
      function closed() : void;
   }
}
