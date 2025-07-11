package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class MOTDNotification
   {
       
      
      private var _window:class_3514;
      
      private var var_44:IHabboLocalizationManager;
      
      private var var_693:Array;
      
      private const LIST_ITEM_HEIGHT_MARGIN:int = 20;
      
      public function MOTDNotification(param1:Array, param2:IAssetLibrary, param3:IHabboWindowManager)
      {
         var _loc9_:* = null;
         var _loc8_:IWindowContainer = null;
         var _loc7_:ITextWindow = null;
         super();
         if(!param3 || !param2)
         {
            return;
         }
         var_693 = param1;
         var _loc6_:XmlAsset;
         if((_loc6_ = param2.getAssetByName("motd_notification_xml") as XmlAsset) == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc6_.content as XML) as class_3514;
         if(_window == null)
         {
            return;
         }
         _window.procedure = eventHandler;
         _window.center();
         var _loc5_:XmlAsset;
         if((_loc5_ = param2.getAssetByName("motd_notification_item_xml") as XmlAsset) == null)
         {
            return;
         }
         var _loc4_:IWindowContainer = param3.buildFromXML(_loc5_.content as XML) as IWindowContainer;
         var _loc10_:IItemListWindow = _window.findChildByName("message_list") as IItemListWindow;
         for each(_loc9_ in var_693)
         {
            (_loc7_ = (_loc8_ = _loc4_.clone() as IWindowContainer).findChildByName("message_text") as ITextWindow).text = _loc9_;
            _loc8_.height = _loc7_.textHeight + 20;
            _loc10_.addListItem(_loc8_);
         }
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         var_44 = null;
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "close":
            case "header_button_close":
               break;
            default:
               return;
         }
         dispose();
      }
   }
}
