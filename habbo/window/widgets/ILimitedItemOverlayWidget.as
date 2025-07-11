package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_3420;
   
   public interface ILimitedItemOverlayWidget extends class_3420
   {
       
      
      function set serialNumber(param1:int) : void;
      
      function set seriesSize(param1:int) : void;
      
      function get serialNumber() : int;
      
      function get seriesSize() : int;
   }
}
