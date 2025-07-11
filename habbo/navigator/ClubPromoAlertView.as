package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class ClubPromoAlertView extends AlertView
   {
       
      
      private var _text:String;
      
      private var var_4749:String;
      
      public function ClubPromoAlertView(param1:IHabboTransitionalNavigator, param2:String, param3:String, param4:String)
      {
         super(param1,"nav_promo_alert",param2);
         _text = param3;
         var_4749 = param4;
      }
      
      override internal function setupAlertWindow(param1:class_3514) : void
      {
         var _loc4_:IWindowContainer;
         (_loc4_ = param1.content).findChildByName("body_text").caption = _text;
         _loc4_.findChildByName("promo_text").caption = var_4749;
         var _loc3_:IWindow = _loc4_.findChildByName("ok");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onOk);
         }
         var _loc2_:IWindow = _loc4_.findChildByName("promo_container");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onPromo);
         }
      }
      
      private function onOk(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function onPromo(param1:WindowMouseEvent) : void
      {
         navigator.openCatalogClubPage("ClubPromoAlertView");
         dispose();
      }
   }
}
