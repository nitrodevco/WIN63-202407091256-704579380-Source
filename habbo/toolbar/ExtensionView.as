package com.sulake.habbo.toolbar
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.class_79;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.toolbar.events.ExtensionViewEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class ExtensionView implements IExtensionView
   {
      
      private static const MARGIN:int = 3;
      
      private static const PURSE_EXTENSION_OFFSET:int = -8;
       
      
      private var _toolbar:HabboToolbar;
      
      private var var_1694:IItemListWindow;
      
      private var _items:Map;
      
      private var _disposed:Boolean = false;
      
      private var _landingView:Boolean = false;
      
      private var var_2218:Array;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _extraMargin:int = 0;
      
      public function ExtensionView(param1:IHabboWindowManager, param2:IAssetLibrary, param3:HabboToolbar)
      {
         var_2218 = [];
         super();
         _toolbar = param3;
         _windowManager = param1;
         var _loc5_:XmlAsset;
         if(_loc5_ = param2.getAssetByName("extension_grid_xml") as XmlAsset)
         {
            var_1694 = param1.buildFromXML(_loc5_.content as XML,1) as IItemListWindow;
         }
         var _loc4_:IWindowContainer = var_1694.desktop;
         if(var_1694)
         {
            var_1694.x = _loc4_.width - var_1694.width - 3 - extraMargin;
            var_1694.y = 3;
            var_1694.visible = true;
         }
         else
         {
            class_79.error("Unable to initialize Toolbar Extension view window from xml asset",false);
         }
         _items = new Map();
      }
      
      public function dispose() : void
      {
         var _loc1_:Array = null;
         var _loc2_:* = null;
         if(!_disposed)
         {
            _loc1_ = _items.getKeys();
            for each(_loc2_ in _loc1_)
            {
               detachExtension(_loc2_);
            }
            if(var_1694)
            {
               var_1694.dispose();
               var_1694 = null;
            }
            var_2218 = null;
            _toolbar = null;
            _items = null;
            _disposed = true;
         }
      }
      
      public function get visible() : Boolean
      {
         return var_1694 && var_1694.visible;
      }
      
      public function get screenHeight() : uint
      {
         if(!var_1694)
         {
            return 0;
         }
         return var_1694.height + var_1694.y;
      }
      
      public function attachExtension(param1:String, param2:IWindow, param3:int = -1, param4:Array = null) : void
      {
         if(!_disposed)
         {
            if(_items.getValue(param1))
            {
               return;
            }
            _items.add(param1,param2);
            param3 = param4 != null ? resolveIndex(param4) : param3;
            if(param3 == -1)
            {
               var_2218.push(param2);
            }
            else
            {
               var_2218.splice(param3,0,param2);
            }
            if(var_1694)
            {
               _toolbar.createAndAttachDimmerWindow(param2 as IWindowContainer);
               refreshItemWindow();
            }
            queueResizeEvent();
         }
      }
      
      public function hasExtension(param1:String) : Boolean
      {
         return _items.getValue(param1) != null;
      }
      
      private function getKeyForWindow(param1:IWindow) : String
      {
         var _loc2_:int = _items.getValues().indexOf(param1);
         if(_loc2_ != -1)
         {
            return _items.getKeys()[_loc2_];
         }
         return "";
      }
      
      public function refreshItemWindow() : void
      {
         var _loc2_:String = null;
         var_1694.removeListItems();
         for each(var _loc1_ in var_2218)
         {
            _loc2_ = getKeyForWindow(_loc1_);
            switch(_loc2_)
            {
               case "logout_tools":
               case "purse_credits":
               case "purse_engagement_currency":
               case "purse_habbo_club":
               case "purse_seasonal_currency":
               case "talent_promo":
               case "club_promo":
               case "vip_quests":
               case "video_offers":
               case "settings":
               case "phone_number":
               case "verification_code":
               case "return_gift":
               case "targeted_offer":
                  var_1694.addListItem(_loc1_);
                  break;
               case "purse":
                  var_1694.addListItem(_loc1_);
                  var_1694.y = 3 + -8;
                  break;
               default:
                  if(!_landingView)
                  {
                     var_1694.addListItem(_loc1_);
                  }
                  break;
            }
         }
         var_1694.arrangeListItems();
         var_1694.invalidate();
      }
      
      private function resolveIndex(param1:Array) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < var_2218.length)
         {
            if(param1.indexOf(var_2218[_loc2_].name) > -1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function detachExtension(param1:String) : void
      {
         var _loc2_:IWindowContainer = null;
         if(!_disposed)
         {
            _loc2_ = _items[param1];
            if(_loc2_ != null)
            {
               var_2218.splice(var_2218.indexOf(_loc2_),1);
               if(var_1694)
               {
                  _toolbar.removeDimmer(_loc2_);
                  refreshItemWindow();
               }
            }
            _items.remove(param1);
            queueResizeEvent();
         }
      }
      
      private function queueResizeEvent() : void
      {
         var _loc1_:Timer = new Timer(25,1);
         _loc1_.addEventListener("timerComplete",onResizeTimer);
         _loc1_.start();
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         if(_toolbar)
         {
            _toolbar.events.dispatchEvent(new ExtensionViewEvent("EVE_EXTENSION_VIEW_RESIZED"));
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(var_1694)
         {
            var_1694.visible = param1;
         }
      }
      
      public function removeDimmers() : void
      {
         for each(var _loc1_ in var_2218)
         {
            _toolbar.removeDimmer(_loc1_);
         }
      }
      
      public function getIconLocation(param1:String) : Rectangle
      {
         var _loc3_:IWindow = null;
         var _loc2_:Rectangle = null;
         var _loc4_:* = param1;
         if("HTIE_EXT_GROUP" === _loc4_)
         {
            _loc3_ = _items["room_group_info"] as IWindow;
         }
         if(_loc3_ != null && _loc3_.visible)
         {
            _loc2_ = new Rectangle();
            _loc3_.getGlobalRectangle(_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      public function getIcon(param1:String) : IWindow
      {
         var _loc2_:IWindow = null;
         if(param1 == "HTIE_EXT_GROUP")
         {
            _loc2_ = _items["room_group_info"] as IWindow;
         }
         return _loc2_;
      }
      
      public function get landingView() : Boolean
      {
         return _landingView;
      }
      
      public function set landingView(param1:Boolean) : void
      {
         _landingView = param1;
         refreshItemWindow();
      }
      
      public function set extraMargin(param1:int) : void
      {
         _extraMargin = param1;
         if(var_1694)
         {
            var_1694.x = var_1694.desktop.width - var_1694.width - 3 - extraMargin;
         }
      }
      
      public function get extraMargin() : int
      {
         return _extraMargin;
      }
   }
}
