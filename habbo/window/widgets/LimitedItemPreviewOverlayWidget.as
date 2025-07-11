package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.class_3723;
   
   public class LimitedItemPreviewOverlayWidget implements ILimitedItemPreviewOverlayWidget
   {
      
      public static const TYPE:String = "limited_item_overlay_preview";
       
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var _serialNumber:int;
      
      private var var_4386:int;
      
      public function LimitedItemPreviewOverlayWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = IWindowContainer(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_preview_xml").content)));
         var_1759.rootWindow = var_509;
      }
      
      public function set serialNumber(param1:int) : void
      {
         _serialNumber = param1;
         var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(var_509.findChildByName("unique_item_serial_number_bitmap"));
         _loc2_.bitmap = class_3723.createBitmap(_windowManager.assets,serialNumber,_loc2_.width,_loc2_.height);
      }
      
      public function set seriesSize(param1:int) : void
      {
         var_4386 = param1;
         var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(var_509.findChildByName("unique_item_edition_size_bitmap"));
         _loc2_.bitmap = class_3723.createBitmap(_windowManager.assets,param1,_loc2_.width,_loc2_.height);
      }
      
      public function get serialNumber() : int
      {
         return _serialNumber;
      }
      
      public function get seriesSize() : int
      {
         return var_4386;
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_509 != null)
            {
               var_509.dispose();
               var_509 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_509 == null;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
   }
}
