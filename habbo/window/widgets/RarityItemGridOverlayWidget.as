package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.class_3723;
   
   public class RarityItemGridOverlayWidget implements IRarityItemGridOverlayWidget
   {
      
      public static const TYPE:String = "rarity_item_overlay_grid";
       
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var _disposed:Boolean;
      
      private var var_509:IWindowContainer;
      
      private var var_806:int;
      
      private var var_4995:IStaticBitmapWrapperWindow;
      
      public function RarityItemGridOverlayWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = IWindowContainer(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("rarity_item_overlay_griditem_xml").content)));
         var_1759.rootWindow = var_509;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         var_806 = param1;
         var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(var_509.findChildByName("rarity_item_overlay_plaque_number_bitmap"));
         _loc2_.bitmap = class_3723.createBitmap(_windowManager.assets,rarityLevel,_loc2_.width,_loc2_.height);
      }
      
      public function get rarityLevel() : int
      {
         return var_806;
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
            if(var_1759 != null)
            {
               var_1759.rootWindow = null;
               var_1759 = null;
            }
            if(var_509 != null)
            {
               var_509.dispose();
               var_509 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
   }
}
