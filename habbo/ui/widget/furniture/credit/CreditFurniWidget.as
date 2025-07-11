package com.sulake.habbo.ui.widget.furniture.credit
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetCreditFurniUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetCreditFurniRedeemMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public class CreditFurniWidget extends RoomWidgetBase
   {
      
      private static const const_685:Number = 100;
      
      private static const const_561:Number = 100;
       
      
      private var _window:IWindowContainer;
      
      private var var_3197:int = -1;
      
      private var var_3854:Number;
      
      public function CreditFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         hideInterface();
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWCFUE_CREDIT_FURNI_UPDATE",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCFUE_CREDIT_FURNI_UPDATE",onObjectUpdate);
      }
      
      private function onObjectUpdate(param1:RoomWidgetCreditFurniUpdateEvent) : void
      {
         hideInterface();
         var_3197 = param1.objectId;
         var_3854 = param1.creditValue;
         showInterface();
      }
      
      private function showInterface() : void
      {
         var _loc2_:IWindow = null;
         if(var_3197 == -1)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         windowManager.registerLocalizationParameter("widgets.furniture.credit.redeem.value","value",String(var_3854));
         var _loc3_:IAsset = assets.getAssetByName("credit_redeem");
         var _loc1_:XmlAsset = XmlAsset(_loc3_);
         if(_loc1_ == null)
         {
            return;
         }
         _window = windowManager.createWindow("creditfurniui_container","",4,0,131072 | 1,new Rectangle(100,100,2,2),null,0) as IWindowContainer;
         _window.buildFromXML(XML(_loc1_.content));
         _window.background = true;
         _window.color = 33554431;
         _loc2_ = _window.findChildByName("cancel");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc2_ = _window.findChildByName("exchange");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc2_ = _window.findChildByName("link");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc2_ = _window.findChildByTag("close");
         if(_loc2_ != null)
         {
            _loc2_.procedure = onWindowClose;
         }
         _window.addEventListener("WME_CLICK",onMouseEvent);
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         var_3197 = -1;
         var_3854 = 0;
      }
      
      private function sendRedeemMessage() : void
      {
         var _loc1_:RoomWidgetCreditFurniRedeemMessage = null;
         if(var_3197 == -1)
         {
            return;
         }
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetCreditFurniRedeemMessage("RWFCRM_REDEEM",var_3197);
            messageListener.processWidgetMessage(_loc1_);
            hideInterface();
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "link":
               if((_loc4_ = String(localizations.getLocalization("widget.furni.info.url"))).indexOf("http") == 0)
               {
                  HabboWebTools.navigateToURL(_loc4_,"habboMain");
               }
               break;
            case "exchange":
               sendRedeemMessage();
               break;
            case "cancel":
            case "close":
               hideInterface();
         }
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideInterface();
      }
   }
}
