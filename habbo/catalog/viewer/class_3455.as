package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.class_3377;
   import flash.events.Event;
   
   public interface class_3455
   {
       
      
      function dispose() : void;
      
      function init() : void;
      
      function closed() : void;
      
      function dispatchWidgetEvent(param1:Event) : Boolean;
      
      function get window() : IWindowContainer;
      
      function get viewer() : class_3477;
      
      function get pageId() : int;
      
      function get offers() : Vector.<class_3377>;
      
      function get localization() : class_3440;
      
      function get layoutCode() : String;
      
      function get hasLinks() : Boolean;
      
      function get links() : Array;
      
      function selectOffer(param1:int) : void;
      
      function replaceOffers(param1:Vector.<class_3377>, param2:Boolean = false) : void;
      
      function updateLimitedItemsLeft(param1:int, param2:int) : void;
      
      function get acceptSeasonCurrencyAsCredits() : Boolean;
      
      function get allowDragging() : Boolean;
      
      function set searchPageId(param1:int) : void;
      
      function get mode() : int;
      
      function get isBuilderPage() : Boolean;
   }
}
