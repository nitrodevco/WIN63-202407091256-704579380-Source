package com.sulake.habbo.roomevents.wired_menu
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuTabConfig;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuTabConfigs;
   import com.sulake.habbo.roomevents.wired_menu.tabs.class_3627;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.utils.Dictionary;
   
   public class WiredMenuView implements IDisposable
   {
      
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_319:WiredMenuController;
      
      private var _window:IWindowContainer;
      
      private var var_4342:WiredMenuTabConfigs;
      
      private var var_318:Boolean = false;
      
      private var var_2253:Dictionary;
      
      private var var_2174:String = null;
      
      private var var_2332:Boolean = false;
      
      public function WiredMenuView(param1:WiredMenuController, param2:IHabboWindowManager)
      {
         super();
         var_319 = param1;
         _windowManager = param2;
         var_4342 = new WiredMenuTabConfigs(param1);
         _window = param2.buildFromXML(XML(var_319.assets.getAssetByName("wired_menu_view_xml").content),1) as IWindowContainer;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
      }
      
      public function initialize() : void
      {
         initializeTabs();
      }
      
      public function show() : void
      {
         var _loc1_:class_3460 = null;
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         if(!var_2332)
         {
            activeTab.startViewing();
            var_2332 = true;
         }
      }
      
      public function isShowing() : Boolean
      {
         return _windowManager != null && _window != null && _window.parent != null;
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      public function hide() : void
      {
         var _loc1_:class_3460 = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
            if(var_2332)
            {
               activeTab.stopViewing();
               var_2332 = false;
            }
         }
      }
      
      private function initializeTabs() : void
      {
         var _loc2_:ITabButtonWindow = null;
         var_2253 = new Dictionary();
         var _loc1_:* = null;
         for each(var _loc3_ in tabConfigs)
         {
            if(_loc3_.isCreateImmediately)
            {
               getOrCreateTab(_loc3_.id);
            }
            if(_loc1_ == null && _loc3_.isEnabled)
            {
               _loc1_ = _loc3_;
            }
            _loc2_ = _window.findChildByName(_loc3_.tabButtonName) as ITabButtonWindow;
            _loc2_.addEventListener("WE_SELECTED",onTabSelected);
            _window.findChildByName(_loc3_.containerName).visible = false;
         }
         selectTab(_loc1_.id);
         alignTabs();
      }
      
      public function selectTab(param1:String) : void
      {
         var _loc2_:WiredMenuTabConfig = getTabConfigById(param1);
         if(_loc2_ == null || !_loc2_.isEnabled)
         {
            return;
         }
         tabContext.selector.setSelected(ISelectableWindow(_window.findChildByName(_loc2_.tabButtonName)));
      }
      
      private function alignTabs() : void
      {
         var _loc2_:int = 0;
         var _loc3_:ITabButtonWindow = null;
         var _loc4_:WiredMenuTabConfig = null;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < tabContext.numTabItems)
         {
            _loc3_ = tabContext.getTabItemAt(_loc2_);
            if((_loc4_ = getTabConfigByTabName(_loc3_.name)).isEnabled)
            {
               _loc1_ += 1;
            }
            else
            {
               _loc3_.visible = false;
               _loc3_.width = 0;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < tabContext.numTabItems)
         {
            _loc3_ = tabContext.getTabItemAt(_loc2_);
            if(_loc3_.visible)
            {
               _loc3_.width = _loc3_.parent.width / _loc1_;
            }
            _loc2_++;
         }
      }
      
      private function onTabSelected(param1:WindowEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:IWindow = param1.target;
         for each(var _loc3_ in tabConfigs)
         {
            if(_loc3_.tabButtonName == _loc4_.name)
            {
               _loc2_ = _loc3_.id;
               break;
            }
         }
         setActiveTab(_loc2_);
      }
      
      private function setActiveTab(param1:String) : void
      {
         var _loc2_:class_3627 = null;
         var _loc5_:WiredMenuTabConfig = null;
         var _loc4_:WiredMenuTabConfig;
         if((_loc4_ = getTabConfigById(param1)).id == var_2174)
         {
            return;
         }
         if(var_2174 != null)
         {
            _loc2_ = getTabById(var_2174);
            _loc5_ = getTabConfigById(var_2174);
            if(var_2332)
            {
               _loc2_.stopViewing();
            }
            _loc2_.setTabInactive();
            if(!_loc5_.isReusable)
            {
               _loc2_.dispose();
               delete var_2253[var_2174];
            }
            _window.findChildByName(_loc5_.containerName).visible = false;
         }
         var_2174 = param1;
         var _loc3_:class_3627 = getOrCreateTab(param1);
         _window.findChildByName(_loc4_.containerName).visible = true;
         _loc3_.setTabActive();
         if(var_2332)
         {
            _loc3_.startViewing();
         }
         headerTitle.text = var_319.localizationManager.getLocalization(_loc4_.titleLocalizationKey,_loc4_.id);
      }
      
      internal function permissionsUpdated() : void
      {
         for each(var _loc1_ in var_2253)
         {
            _loc1_.permissionsUpdated();
         }
      }
      
      private function get tabConfigs() : Vector.<WiredMenuTabConfig>
      {
         return var_4342.menuTabs;
      }
      
      private function getTabConfigById(param1:String) : WiredMenuTabConfig
      {
         for each(var _loc2_ in tabConfigs)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getTabConfigByTabName(param1:String) : WiredMenuTabConfig
      {
         for each(var _loc2_ in tabConfigs)
         {
            if(_loc2_.tabButtonName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getTabById(param1:String) : class_3627
      {
         return var_2253[param1];
      }
      
      public function get activeTab() : class_3627
      {
         return getTabById(var_2174);
      }
      
      public function get activeTabId() : String
      {
         return var_2174;
      }
      
      private function getOrCreateTab(param1:String) : class_3627
      {
         var _loc3_:WiredMenuTabConfig = getTabConfigById(param1);
         var _loc2_:class_3627 = var_2253[param1];
         if(_loc2_ == null)
         {
            _loc2_ = _loc3_.createTab(var_319,_window.findChildByName(_loc3_.containerName) as IWindowContainer);
            var_2253[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         var _loc1_:class_3627 = null;
         var _loc2_:ITabButtonWindow = null;
         if(var_318)
         {
            return;
         }
         hide();
         closeButton.removeEventListener("WME_CLICK",onWindowClose);
         for each(var _loc3_ in tabConfigs)
         {
            _loc1_ = getTabById(_loc3_.id);
            if(_loc1_ != null)
            {
               if(_loc3_.id == var_2174)
               {
                  if(var_2332)
                  {
                     _loc1_.stopViewing();
                  }
                  _loc1_.setTabInactive();
               }
               _loc1_.dispose();
            }
            _loc2_ = _window.findChildByName(_loc3_.tabButtonName) as ITabButtonWindow;
            _loc2_.removeEventListener("WE_SELECTED",onTabSelected);
         }
         var_2253 = null;
         var_2174 = null;
         var_2332 = false;
         _window.dispose();
         _window = null;
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      private function get closeButton() : IWindow
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get tabContext() : ITabContextWindow
      {
         return _window.findChildByName("tab_context") as ITabContextWindow;
      }
      
      private function get headerTitle() : ITextWindow
      {
         return _window.findChildByName("header_title") as ITextWindow;
      }
      
      public function get loadingContainer() : IWindowContainer
      {
         return _window.findChildByName("loading_view") as IWindowContainer;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
   }
}
