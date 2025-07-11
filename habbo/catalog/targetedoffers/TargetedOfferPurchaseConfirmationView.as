package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   
   public class TargetedOfferPurchaseConfirmationView extends OfferView
   {
       
      
      private var var_2460:int;
      
      public function TargetedOfferPurchaseConfirmationView(param1:OfferController, param2:TargetedOffer, param3:int)
      {
         super(param1,param2);
         var_2460 = param3;
         _window = IWindowContainer(var_319.catalog.windowManager.buildFromXML(XML(var_319.catalog.assets.getAssetByName("targeted_offer_purchase_confirmation_xml").content)));
         var _loc4_:HabboCatalog;
         if((_loc4_ = var_319.catalog as HabboCatalog).getBoolean("disclaimer.credit_spending.enabled"))
         {
            setDisclaimerAccepted(false);
         }
         else
         {
            _window.findChildByName("disclaimer").dispose();
            setDisclaimerAccepted(true);
         }
         ITextWindow(_window.findChildByName("product_name")).text = getLocalization(param2.title);
         var _loc5_:IWindowContainer = _window.findChildByName("purchase_cost_box") as IWindowContainer;
         _loc4_.utils.showPriceInContainer(_loc5_,param2,param3);
         var _loc6_:ITextWindow;
         if((_loc6_ = _window.findChildByName("quantity") as ITextWindow) != null)
         {
            if(param1.catalog.multiplePurchaseEnabled && var_2460 > 1)
            {
               _loc6_.text = "X " + var_2460;
            }
         }
         _window.procedure = onInput;
         _window.center();
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IWindow = _window.findChildByName("select_button");
         if(_loc2_ == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_.enable();
         }
         else
         {
            _loc2_.disable();
         }
      }
      
      private function onInput(param1:WindowEvent, param2:IWindow) : void
      {
         if(!var_319)
         {
            return;
         }
         if(param1.type == "WME_DOWN")
         {
            switch(param2.name)
            {
               case "spending_disclaimer":
                  setDisclaimerAccepted(class_3398(param2).isSelected);
                  break;
               case "header_button_close":
               case "cancel_button":
                  var_319.maximizeOffer(_offer);
                  break;
               case "buy_button":
                  var_319.purchaseTargetedOffer(_offer,var_2460);
            }
         }
      }
   }
}
