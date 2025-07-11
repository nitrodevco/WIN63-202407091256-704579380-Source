package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   
   public class TargetedOfferMinimizedView extends OfferView
   {
      
      private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default_icon.png";
       
      
      public function TargetedOfferMinimizedView(param1:OfferController, param2:TargetedOffer)
      {
         var _loc6_:IItemListWindow = null;
         super(param1,param2);
         _window = IWindowContainer(var_319.catalog.windowManager.buildFromXML(XML(var_319.catalog.assets.getAssetByName("targeted_offer_minimized_xml").content)));
         var _loc5_:ITextWindow;
         if(_loc5_ = ITextWindow(_window.findChildByName("txt_title")))
         {
            _loc5_.text = getLocalization(param2.title);
         }
         var _loc3_:String = String((var_319.catalog as ICoreConfiguration).getProperty("image.library.url"));
         var _loc4_:String = param2.iconImageUrl && param2.iconImageUrl.length > 0 ? param2.iconImageUrl : "targetedoffers/offer_default_icon.png";
         IStaticBitmapWrapperWindow(_window.findChildByName("bmp_icon")).assetUri = _loc3_ + _loc4_;
         var_2349 = getLocalization("targeted.offer.minimized.timeleft","");
         if(_offer.expirationTime == 0)
         {
            if(_loc6_ = _window.findChildByName("itemlist") as IItemListWindow)
            {
               _loc6_.removeListItem(_window.findChildByName("cnt_time_left"));
            }
         }
         else
         {
            startUpdateTimer();
         }
         _window.procedure = onInput;
         var_319.attachExtension(_window);
      }
      
      private function onInput(param1:WindowEvent, param2:IWindow) : void
      {
         if(!var_319)
         {
            return;
         }
         if(param1.type == "WME_DOWN")
         {
            var_319.maximizeOffer(_offer);
            param2.name;
         }
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
   }
}
