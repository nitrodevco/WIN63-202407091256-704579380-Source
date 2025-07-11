package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
   
   public class MallOfferMinimizedView extends OfferView
   {
      
      private static const IMAGE_DEFAULT_URL:String = "targetedoffers/offer_default_icon.png";
       
      
      private var var_4795:HabboMallOffer;
      
      public function MallOfferMinimizedView(param1:OfferController, param2:HabboMallOffer)
      {
         super(param1,null);
         var_4795 = param2;
         _window = IWindowContainer(var_319.catalog.windowManager.buildFromXML(XML(var_319.catalog.assets.getAssetByName("targeted_offer_minimized_xml").content)));
         var _loc4_:ITextWindow;
         if(_loc4_ = ITextWindow(_window.findChildByName("txt_title")))
         {
            _loc4_.text = getLocalization(param2.title);
         }
         var _loc3_:String = String((var_319.catalog as ICoreConfiguration).getProperty("image.library.url"));
         IStaticBitmapWrapperWindow(_window.findChildByName("bmp_icon")).assetUri = _loc3_ + "targetedoffers/offer_default_icon.png";
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
            var_319.maximizeMallOffer(var_4795);
            param2.name;
         }
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
   }
}
