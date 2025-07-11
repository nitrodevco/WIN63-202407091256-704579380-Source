package com.sulake.habbo.catalog.club
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.purse.class_3378;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class ClubBuyConfirmationDialog
   {
       
      
      private var _offer:ClubBuyOfferData;
      
      private var var_319:ClubBuyController;
      
      private var var_1631:class_3514;
      
      private var var_562:int;
      
      public function ClubBuyConfirmationDialog(param1:ClubBuyController, param2:ClubBuyOfferData, param3:int)
      {
         super();
         _offer = param2;
         var_319 = param1;
         var_562 = param3;
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
         var_1631 = var_319.catalog.utils.createWindow("club_buy_confirmation") as class_3514;
         if(!var_1631)
         {
            return;
         }
         var_1631.procedure = windowEventHandler;
         var_1631.center();
         if(var_319.catalog.getBoolean("disclaimer.credit_spending.enabled"))
         {
            setDisclaimerAccepted(false);
         }
         else
         {
            var_1631.findChildByName("disclaimer").dispose();
            setDisclaimerAccepted(true);
         }
         var _loc1_:IHabboLocalizationManager = var_319.localization;
         var _loc4_:class_3378;
         var _loc5_:String = (_loc4_ = var_319.getPurse()).hasClubLeft && _loc4_.isVIP ? "extension." : "subscription.";
         var _loc3_:String = _offer.months == 0 ? "days" : "months";
         var _loc2_:String = "catalog.vip.buy.confirm." + _loc5_ + _loc3_;
         _loc1_.registerParameter(_loc2_,"num_" + _loc3_,String(_offer.months == 0 ? _offer.extraDays : _offer.months));
         var_1631.findChildByName("subscription_name").caption = _loc1_.getLocalization(_loc2_);
         _loc1_.registerParameter("catalog.vip.buy.confirm.end_date","day",String(_offer.day));
         _loc1_.registerParameter("catalog.vip.buy.confirm.end_date","month",String(_offer.month));
         _loc1_.registerParameter("catalog.vip.buy.confirm.end_date","year",String(_offer.year));
         var_319.catalog.utils.showPriceInContainer(var_1631.findChildByName("purchase_cost_box") as IWindowContainer,_offer);
      }
      
      private function setDisclaimerAccepted(param1:Boolean) : void
      {
         if(var_1631 == null)
         {
            return;
         }
         var _loc2_:IWindow = var_1631.findChildByName("select_button");
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
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(!param1 || !param2 || !var_319 || !_offer)
         {
            return;
         }
         if(param1.type != "WME_CLICK" && param1.type != "WME_DOUBLE_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "spending_disclaimer":
               setDisclaimerAccepted(class_3398(param2).isSelected);
               break;
            case "select_button":
               var_319.catalog.doNotCloseAfterVipPurchase();
               var_319.confirmSelection(_offer,var_562);
               break;
            case "header_button_close":
            case "cancel_button":
               var_319.catalog.forgetPageDuringVipPurchase();
               var_319.closeConfirmation();
         }
      }
   }
}
