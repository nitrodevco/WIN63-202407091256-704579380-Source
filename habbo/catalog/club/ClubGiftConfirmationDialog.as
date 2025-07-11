package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.session.product.class_3423;
   
   public class ClubGiftConfirmationDialog
   {
       
      
      private var _offer:class_3377;
      
      private var var_319:ClubGiftController;
      
      private var var_1631:class_3514;
      
      public function ClubGiftConfirmationDialog(param1:ClubGiftController, param2:class_3377)
      {
         super();
         _offer = param2;
         var_319 = param1;
         showConfirmation();
      }
      
      public function dispose() : void
      {
         var_319 = null;
         _offer = null;
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
      }
      
      public function showConfirmation() : void
      {
         if(!_offer || !var_319)
         {
            return;
         }
         var_1631 = createWindow("club_gift_confirmation") as class_3514;
         if(!var_1631)
         {
            return;
         }
         var_1631.procedure = windowEventHandler;
         var_1631.center();
         var _loc2_:ITextWindow = var_1631.findChildByName("item_name") as ITextWindow;
         if(_loc2_)
         {
            _loc2_.text = getProductName();
         }
         var _loc1_:IWindowContainer = var_1631.findChildByName("image_border") as IWindowContainer;
         if(!_loc1_)
         {
            return;
         }
         if(!_offer.productContainer)
         {
            return;
         }
         _offer.productContainer.view = _loc1_;
         _offer.productContainer.initProductIcon(var_319.roomEngine);
      }
      
      private function getProductName() : String
      {
         var _loc1_:class_3423 = null;
         if(_offer && _offer.product)
         {
            _loc1_ = _offer.product.productData;
            if(_loc1_)
            {
               return _loc1_.name;
            }
         }
         return "";
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(!param1 || !param2 || !var_319 || !_offer)
         {
            return;
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "select_button":
               var_319.confirmSelection(_offer.localizationId);
               break;
            case "header_button_close":
            case "cancel_button":
               var_319.closeConfirmation();
         }
      }
      
      private function createWindow(param1:String) : IWindow
      {
         if(!var_319 || !var_319.assets || !var_319.windowManager)
         {
            return null;
         }
         var _loc3_:XmlAsset = var_319.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc3_ || !_loc3_.content)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(!_loc2_)
         {
            return null;
         }
         return var_319.windowManager.buildFromXML(_loc2_);
      }
   }
}
