package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   
   public interface class_3553 extends IDisposable
   {
       
      
      function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void;
      
      function activate() : void;
      
      function get products() : Vector.<class_3388>;
      
      function get firstProduct() : class_3388;
      
      function set view(param1:IWindowContainer) : void;
      
      function get view() : IWindowContainer;
      
      function set grid(param1:IItemGrid) : void;
      
      function setClubIconLevel(param1:int) : void;
      
      function get offer() : class_3377;
   }
}
