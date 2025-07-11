package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindowContainer;
   
   public interface ITabPageDecorator
   {
       
      
      function refreshCustomContent(param1:IWindowContainer) : void;
      
      function tabSelected() : void;
      
      function navigatorOpenedWhileInTab() : void;
      
      function refreshFooter(param1:IWindowContainer) : void;
      
      function get filterCategory() : String;
      
      function setSubSelection(param1:int) : void;
      
      function processSearchParam(param1:String) : String;
   }
}
