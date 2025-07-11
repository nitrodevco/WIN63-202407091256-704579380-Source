package com.sulake.habbo.notifications
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.utils.IModalDialog;
   
   public class NotificationPopup implements IDisposable
   {
       
      
      private var _notifications:HabboNotifications;
      
      private var var_1907:IModalDialog;
      
      private var var_329:String;
      
      private var _parameters:Map;
      
      public function NotificationPopup(param1:HabboNotifications, param2:String, param3:Map)
      {
         var _loc7_:IWindow = null;
         var _loc8_:IWindow = null;
         super();
         _notifications = param1;
         var_329 = param2;
         _parameters = param3;
         var _loc10_:String = getNotificationPart("title",true);
         var _loc11_:String = getNotificationPart("message",true).replace(/\\r/g,"\r");
         var _loc6_:String = getNotificationPart("linkUrl",false);
         var _loc4_:* = null;
         var _loc5_:Boolean = _loc6_ != null && _loc6_.substr(0,6) == "event:";
         if(_loc6_ != null)
         {
            if((_loc4_ = getNotificationPart("linkTitle",false)) == null)
            {
               _loc4_ = _loc6_;
            }
         }
         var _loc12_:IAsset = _notifications.assets.getAssetByName("layout_notification_popup_xml");
         var_1907 = _notifications.windowManager.buildModalDialogFromXML(_loc12_.content as XML);
         var _loc9_:IWindowContainer;
         (_loc9_ = var_1907.rootWindow as IWindowContainer).procedure = windowProcedure;
         _loc9_.caption = _loc10_;
         if(_loc6_ != null)
         {
            if(_loc5_)
            {
               (_loc7_ = _loc9_.findChildByName("action")).visible = true;
               _loc7_.caption = _loc4_;
            }
            else
            {
               (_loc8_ = _loc9_.findChildByName("link")).visible = true;
               _loc8_.caption = _loc4_;
            }
         }
         _loc9_.findChildByName("message").caption = _loc11_;
         IStaticBitmapWrapperWindow(_loc9_.findChildByName("illustration")).assetUri = _notifications.getNotificationImageUrl(param3,param2);
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_1907.dispose();
         var_1907 = null;
         _notifications = null;
         var_329 = null;
         _parameters = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1907 == null;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(disposed)
         {
            return;
         }
         switch(param1.type)
         {
            case "WME_CLICK":
               switch(param2.name)
               {
                  case "header_button_close":
                     dispose();
                     break;
                  case "action":
                     _notifications.createLinkEvent(getNotificationPart("linkUrl",false).substr(6));
                     dispose();
                     break;
                  case "link":
                     HabboWebTools.openWebPage(getNotificationPart("linkUrl",false),"habboMain");
               }
               break;
            case "WE_RESIZED":
               if(param2.name == "illustration")
               {
                  param2.parent.limits.minHeight = param2.height;
               }
         }
      }
      
      private function getNotificationPart(param1:String, param2:Boolean) : String
      {
         return _notifications.getNotificationPart(_parameters,var_329,param1,param2);
      }
   }
}
