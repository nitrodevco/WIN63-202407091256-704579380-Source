package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.session.product.class_3423;
   import flash.display.BitmapData;
   
   public interface class_3388 extends IGetImageListener, IDisposable
   {
       
      
      function get productType() : String;
      
      function get productClassId() : int;
      
      function set extraParam(param1:String) : void;
      
      function get extraParam() : String;
      
      function get productCount() : int;
      
      function get productData() : class_3423;
      
      function get furnitureData() : class_3365;
      
      function get isUniqueLimitedItem() : Boolean;
      
      function get isColorable() : Boolean;
      
      function get uniqueLimitedItemSeriesSize() : int;
      
      function get uniqueLimitedItemsLeft() : int;
      
      function set uniqueLimitedItemsLeft(param1:int) : void;
      
      function initIcon(param1:class_3553, param2:IGetImageListener = null, param3:IAvatarImageListener = null, param4:class_3377 = null, param5:IBitmapWrapperWindow = null, param6:IStuffData = null, param7:Function = null) : BitmapData;
      
      function set view(param1:IWindowContainer) : void;
      
      function set grid(param1:IItemGrid) : void;
   }
}
