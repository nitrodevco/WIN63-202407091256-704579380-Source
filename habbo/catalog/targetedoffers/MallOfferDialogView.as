package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
   
   public class MallOfferDialogView
   {
       
      
      private var var_319:OfferController;
      
      private var _window:IWindowContainer;
      
      private var _offer:HabboMallOffer;
      
      public function MallOfferDialogView(param1:OfferController, param2:HabboMallOffer)
      {
         var _loc3_:String = null;
         super();
         var_319 = param1;
         _offer = param2;
         _window = IWindowContainer(var_319.catalog.windowManager.buildFromXML(XML(var_319.catalog.assets.getAssetByName("targeted_offer_habbomall_xml").content)));
         class_3514(_window).title.text = getLocalization(_offer.title);
         ITextWindow(_window.findChildByName("txt_title")).text = getLocalization(_offer.title);
         if(param2.imageUrl && param2.imageUrl.length > 0)
         {
            _loc3_ = String((var_319.catalog as ICoreConfiguration).getProperty("image.library.url"));
            IStaticBitmapWrapperWindow(_window.findChildByName("bmp_illustration")).assetUri = _loc3_ + param2.imageUrl;
         }
         _window.procedure = onInput;
         _window.center();
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onInput(param1:WindowEvent, param2:IWindow) : void
      {
         if(!var_319 || !_offer)
         {
            return;
         }
         if(param1.type == "WME_DOWN")
         {
            switch(param2.name)
            {
               case "header_button_close":
                  var_319.onHabboMallOfferClosed(_offer);
                  break;
               case "btn_buy":
                  var_319.onHabboMallOfferOpened(_offer);
            }
         }
      }
      
      private function getLocalization(param1:String, param2:String = null) : String
      {
         return var_319.catalog.localization.getLocalization(param1,param2 || param1);
      }
   }
}
