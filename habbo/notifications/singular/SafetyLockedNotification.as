package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class SafetyLockedNotification
   {
      
      private static const TOOLBAR_EXTENSION_ID:String = "safety_locked_notification";
      
      private static const LINK_COLOR_NORMAL:uint = 16777215;
      
      private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
       
      
      private var _window:class_3437;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolbar:IHabboToolbar;
      
      private var var_4097:ITextWindow;
      
      private var var_418:int;
      
      public function SafetyLockedNotification(param1:int, param2:IAssetLibrary, param3:IHabboWindowManager, param4:IHabboCatalog, param5:IHabboToolbar)
      {
         super();
         if(!param2 || !param3 || !param4)
         {
            return;
         }
         _catalog = param4;
         _toolbar = param5;
         var_418 = param1;
         var _loc6_:XmlAsset;
         if((_loc6_ = param2.getAssetByName("safety_locked_notification_xml") as XmlAsset) == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc6_.content as XML) as class_3437;
         if(_window == null)
         {
            return;
         }
         _window.procedure = eventHandler;
         _toolbar.extensionView.attachExtension("safety_locked_notification",_window);
         var_4097 = _window.findChildByName("unlock_link") as ITextWindow;
         var _loc7_:IRegionWindow;
         if(_loc7_ = _window.findChildByName("unlock_link_region") as IRegionWindow)
         {
            _loc7_.addEventListener("WME_OVER",onMouseOver);
            _loc7_.addEventListener("WME_OUT",onMouseOut);
         }
      }
      
      public function get visible() : Boolean
      {
         return _window && _window.visible;
      }
      
      public function dispose() : void
      {
         if(_toolbar)
         {
            _toolbar.extensionView.detachExtension("safety_locked_notification");
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _catalog = null;
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:String = null;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "unlock_link_region":
            case "unlock_link":
               break;
            default:
               return;
         }
         _loc3_ = (_toolbar as Component).getProperty("link.format.safetylock_unlock");
         HabboWebTools.openWebPage(_loc3_,"habboMain");
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         var_4097.textColor = 12247545;
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         var_4097.textColor = 16777215;
      }
   }
}
