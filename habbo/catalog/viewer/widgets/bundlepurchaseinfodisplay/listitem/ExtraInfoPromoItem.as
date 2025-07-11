package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.HabboCatalogUtils;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ExtraInfoPromoItem extends UpdateableExtraInfoListItem
   {
      
      private static const const_1164:String = "catalog.bundlewidget.discount.promo";
       
      
      private var _window:IWindowContainer = null;
      
      private var var_3755:Boolean = true;
      
      private var _catalog:HabboCatalog;
      
      private var var_3127:Map;
      
      private var var_3594:int = 0;
      
      private var var_1629:BundlePurchaseExtraInfoWidget;
      
      private var var_2445:Number = 0;
      
      private var var_2843:Timer;
      
      public function ExtraInfoPromoItem(param1:BundlePurchaseExtraInfoWidget, param2:int, param3:ExtraInfoItemData, param4:HabboCatalog)
      {
         super(null,param2,param3,0);
         var_1629 = param1;
         _catalog = param4;
         createNextDiscountMap();
         resolveNextDiscountLevel();
         var_2843 = new Timer(50);
         var_2843.addEventListener("timer",onEffectTimer);
         var_2843.start();
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            var_2843.stop();
            var_2843.removeEventListener("timer",onEffectTimer);
            var_2843 = null;
            var_3127 = null;
            _catalog = null;
            super.dispose();
         }
      }
      
      override public function update(param1:ExtraInfoItemData) : void
      {
         super.update(param1);
         var _loc2_:int = var_3594;
         resolveNextDiscountLevel();
         if(var_3594 != _loc2_)
         {
            var_2445 = 1;
         }
         var_3755 = true;
         render();
      }
      
      override public function getRenderedWindow() : IWindowContainer
      {
         if(_window == null)
         {
            createWindow();
         }
         if(var_3755)
         {
            render();
         }
         return _window;
      }
      
      private function createWindow() : void
      {
         _window = IWindowContainer(_catalog.utils.createWindow("discountPromoItem"));
         _window.procedure = windowProcedure;
         var _loc1_:IBitmapWrapperWindow = IBitmapWrapperWindow(_window.findChildByName("icon_bitmap"));
         HabboCatalogUtils.replaceCenteredImage(_loc1_,BitmapData(_catalog.assets.getAssetByName("thumb_up").content).clone());
      }
      
      private function render() : void
      {
         _catalog.localization.registerParameter("catalog.bundlewidget.discount.promo","quantity",var_3594.toString());
         _catalog.localization.registerParameter("catalog.bundlewidget.discount.promo","discount",var_3127.getValue(var_3594));
         var _loc1_:String = String(_catalog.localization.getLocalizationRaw("catalog.bundlewidget.discount.promo").value);
         _window.findChildByName("promo_text").caption = _loc1_;
         _window.findChildByName("promo_text_effect").caption = _loc1_;
         var_3755 = false;
      }
      
      private function resolveNextDiscountLevel() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = var_3127.getKeys();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(int(_loc1_[_loc2_]) > data.quantity)
            {
               var_3594 = int(_loc1_[_loc2_]);
               break;
            }
            _loc2_++;
         }
      }
      
      private function createNextDiscountMap() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var_3127 = new Map();
         _loc2_ = 1;
         _loc3_ = 0;
         while(_loc2_ <= 100)
         {
            _loc4_ = _catalog.utils.calculateBundlePrice(true,1,_loc2_);
            _loc1_ = _loc2_ - _loc4_;
            if(_loc1_ > _loc3_ && _catalog.utils.bundleDiscountFlatPriceSteps.indexOf(_loc2_) == -1)
            {
               var_3127.add(_loc2_,_loc1_);
               _loc3_ = _loc1_;
            }
            _loc2_++;
         }
      }
      
      private function onEffectTimer(param1:TimerEvent) : void
      {
         if(var_2445 > 0)
         {
            var_2445 -= 0.1;
            if(var_2445 < 0)
            {
               var_2445 = 0;
            }
            _window.findChildByName("promo_text_effect").blend = var_2445;
         }
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param2.name == "click_region")
         {
            switch(param1.type)
            {
               case "WME_CLICK":
                  var_1629.events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_ITEM_CLICKED",data,id));
                  break;
               case "WME_OVER":
                  ITextWindow(_window.findChildByName("promo_text")).textColor = 12582911;
                  break;
               case "WME_OUT":
                  ITextWindow(_window.findChildByName("promo_text")).textColor = 16777215;
            }
         }
      }
   }
}
