package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class RarityItemPreviewOverlayWidget implements IRarityItemPreviewOverlayWidget
   {
      
      public static const TYPE:String = "rarity_item_overlay_preview";
      
      private static const const_1018:String = "rarity_item_overlay_preview:level";
      
      private static const RARITY_LEVEL_DEFAULT:PropertyStruct = new PropertyStruct("rarity_item_overlay_preview:level",0,"int");
       
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var var_806:int;
      
      private var _disposed:Boolean;
      
      private var var_4377:ITextWindow;
      
      public function RarityItemPreviewOverlayWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = IWindowContainer(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("rarity_item_overlay_preview_xml").content)));
         var_4377 = var_509.findChildByName("level") as ITextWindow;
         var_1759.rootWindow = var_509;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         var_806 = param1;
         var_4377.caption = param1.toString();
      }
      
      public function get rarityLevel() : int
      {
         return var_806;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(RARITY_LEVEL_DEFAULT.withValue(rarityLevel));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("rarity_item_overlay_preview:level" === _loc3_)
            {
               rarityLevel = int(_loc2_.value);
            }
         }
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
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
   }
}
