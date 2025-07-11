package com.sulake.habbo.window.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   
   public interface ILimitedItemOverlay extends IDisposable
   {
       
      
      function get window() : IWindowContainer;
      
      function set serialNumber(param1:int) : void;
      
      function set seriesSize(param1:int) : void;
   }
}
