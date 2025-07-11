package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class LimitedItemSupplyLeftOverlayWidget implements ILimitedItemSupplyLeftOverlayWidget
   {
      
      public static const TYPE:String = "limited_item_overlay_supply";
       
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_509:IWindowContainer;
      
      private var var_4630:int;
      
      private var var_4386:int;
      
      public function LimitedItemSupplyLeftOverlayWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = IWindowContainer(_windowManager.buildFromXML(XML(_windowManager.assets.getAssetByName("unique_item_overlay_supply_xml").content)));
         var_1759.rootWindow = var_509;
      }
      
      public function set supplyLeft(param1:int) : void
      {
         var_4630 = param1;
         var _loc3_:ITextWindow = var_509.findChildByName("items_left_count") as ITextWindow;
         _loc3_.text = param1.toString();
         var _loc2_:Boolean = false;
         var_509.findChildByName("unique_item_sold_out_bitmap").visible = _loc2_;
      }
      
      public function get supplyLeft() : int
      {
         return var_4630;
      }
      
      public function set serialNumber(param1:int) : void
      {
      }
      
      public function set seriesSize(param1:int) : void
      {
         var_4386 = param1;
         var _loc2_:ITextWindow = var_509.findChildByName("items_total_count") as ITextWindow;
         _loc2_.text = param1.toString();
      }
      
      public function get serialNumber() : int
      {
         return 0;
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
