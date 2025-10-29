package com.sulake.habbo.friendbar.landingview.layout
{
    import assets.class_14

    import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.outgoing.competition.class_1011;
   import com.sulake.habbo.communication.messages.incoming.competition.CurrentTimingCodeMessageEvent;
   
   public class WidgetContainerLayout implements IUpdateReceiver
   {
      
      private static const WIDGET_COLORABLE_TEXTELEMENT_TAG:String = "COLORABLE";
      
      private static const const_844:int = 0;
      
      private static const DEFAULT_LAYOUT:String = "landing_view_default_dynamic_layout";
      
      private static const GENERIC_RECEPTION_LAYOUT:String = "landing_view_generic_reception";
      
      private static const WIDGET_PLACEHOLDER_PREFIX:String = "widget_placeholder_";
      
      private static const const_447:Array = ["background_back","background_front","background_gradient_top","background_hotel_top","background_gradient","background_right","background_horizon","background_left","background_left_bottom"];
       
      
      protected var _landingView:HabboLandingView;
      
      protected var _window:IWindowContainer;
      
      protected var _dynamicWidgetLayout:DynamicLayoutManager;
      
      protected var var_2682:MovingBackgroundObjects;
      
      protected var _orgWindowWidth:int;
      
      protected var var_4807:int;
      
      private var var_1643:Array;
      
      private var var_2696:CommonWidgetSettings;
      
      private var var_1372:String;
      
      public function WidgetContainerLayout(param1:HabboLandingView)
      {
         var_1643 = [];
         super();
         _landingView = param1;
         registerFixedWidgets();
         var_2682 = new MovingBackgroundObjects(_landingView);
         var_2696 = new CommonWidgetSettings(_landingView);
         param1.registerUpdateReceiver(this,1000);
      }
      
      private static function getColorizableElements(param1:IWindowContainer) : Array
      {
         var _loc2_:Array = new Array(0);
         param1.groupChildrenWithTag("COLORABLE",_loc2_,-1);
         return _loc2_;
      }
      
      public static function applyColorizableWidgetTextColor(param1:IWindowContainer, param2:uint) : void
      {
         if(param1 == null)
         {
            return;
         }
         for each(var _loc3_ in getColorizableElements(param1))
         {
            _loc3_.textColor = param2;
         }
      }
      
      public static function applyColorizableWidgetEtchingColor(param1:IWindowContainer, param2:uint) : void
      {
         if(param1 == null)
         {
            return;
         }
         for each(var _loc3_ in getColorizableElements(param1))
         {
            _loc3_.etchingColor = param2;
         }
      }
      
      public static function applyColorizableWidgetEtchingPosition(param1:IWindowContainer, param2:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         for each(var _loc3_ in getColorizableElements(param1))
         {
            _loc3_.etchingPosition = param2;
         }
      }
      
      public static function applyCommonWidgetSettings(param1:IWindowContainer, param2:CommonWidgetSettings) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2.isTextColorSet || param2.isEtchingColorSet || param2.isEtchingPositionSet)
         {
            for each(var _loc3_ in getColorizableElements(param1))
            {
               _loc3_.textColor = param2.isTextColorSet ? param2.textColor : _loc3_.textColor;
               _loc3_.etchingColor = param2.isEtchingColorSet ? param2.etchingColor : _loc3_.etchingColor;
               _loc3_.etchingPosition = param2.isEtchingPositionSet ? param2.etchingPosition : _loc3_.etchingPosition;
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            var_2682.update(param1);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function dispose() : void
      {
         if(_landingView)
         {
            _landingView.removeUpdateReceiver(this);
         }
         _landingView = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1643)
         {
            for each(var _loc1_ in var_1643)
            {
               _loc1_.dispose();
            }
            var_1643 = null;
         }
         if(var_2682)
         {
            var_2682.dispose();
            var_2682 = null;
         }
         if(_dynamicWidgetLayout)
         {
            _dynamicWidgetLayout.dispose();
            _dynamicWidgetLayout = null;
         }
         if(var_2696)
         {
            var_2696 = null;
         }
      }
      
      public function activate() : void
      {
         if(_window == null)
         {
            createWindow();
            registerDynamicWidgets();
            _landingView.communicationManager.addHabboConnectionMessageEvent(new CurrentTimingCodeMessageEvent(onTimingCode));
            var_1372 = _landingView.getProperty("landing.view.bgtiming");
         }
         for each(var _loc1_ in var_1643)
         {
            _loc1_.refresh(_window);
         }
         resizeWindow();
         _landingView.windowManager.getWindowContext(0).getDesktopWindow().addEventListener("WE_RESIZED",onDesktopResized);
         _window.invalidate();
         if(navigatorPosition != null)
         {
            _landingView.navigator.openNavigator(navigatorPosition);
         }
         _landingView.send(new class_1011(var_1372));
         _window.visible = true;
      }
      
      private function get navigatorPosition() : Point
      {
         var _loc2_:Point = null;
         var _loc1_:IWindow = _window.findChildByName("navigator_placer");
         if(_loc1_ == null)
         {
            return null;
         }
         _loc2_ = new Point();
         _loc1_.getGlobalPosition(_loc2_);
         return _loc2_;
      }
      
      public function disable() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
         for each(var _loc1_ in var_1643)
         {
            _loc1_.disable();
         }
      }
      
      protected function createWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         var _loc1_:String = getLayout();
         _window = IWindowContainer(_landingView.getXmlWindow(_loc1_,0));
         hideWarningIfPresent();
         if(_landingView.getBoolean("landing.view.right_pane_dimmer.hidden"))
         {
            if(_window.findChildByName("right_pane_dimmer") != null)
            {
               _window.findChildByName("right_pane_dimmer").visible = false;
            }
         }
         setOrgWindowSize();
         setupBottomSlotWidgetName();
      }
      
      private function hideWarningIfPresent() : void
      {
         var _loc1_:IWindow = _window.findChildByName("warning");
         if(_loc1_ != null)
         {
            _loc1_.visible = false;
         }
      }
      
      protected function setOrgWindowSize() : void
      {
         _orgWindowWidth = _window.width;
         var_4807 = _window.height;
      }
      
      protected function setupBottomSlotWidgetName() : void
      {
         var _loc1_:String = null;
         var _loc2_:IWindow = _window.findChildByName("widget_placeholder_bottom_slot");
         if(_loc2_ != null)
         {
            _loc1_ = _landingView.getProperty("landing.view.dynamic.slot.6.widget");
            if(_loc1_ == "")
            {
               _loc2_.visible = false;
            }
            else
            {
               _loc2_.name = "widget_placeholder_" + _loc1_;
            }
         }
      }
      
      private function getLayout() : String
      {
         return _landingView.propertyExists("landing.view.layoutxml") ? _landingView.getProperty("landing.view.layoutxml") : "landing_view_default_dynamic_layout";
      }
      
      private function isGenericReceptionLayout() : Boolean
      {
         return getLayout() == "landing_view_generic_reception";
      }
      
      protected function resizeWindow() : void
      {
         if(_window != null)
         {
            if(_dynamicWidgetLayout != null)
            {
               resizeDynamicLayout();
            }
            else
            {
               resizeCustomLayout();
            }
            _window.invalidate();
         }
         for each(var _loc1_ in var_1643)
         {
            _loc1_.windowResized();
         }
      }
      
      private function resizeDynamicLayout() : void
      {
         var _loc1_:Rectangle = _window.desktop.rectangle;
         _window.width = _loc1_.width;
         _window.height = _loc1_.height;
         var _loc2_:int = var_4807 - _loc1_.height;
         var _loc3_:int = _orgWindowWidth - _loc1_.width;
         _dynamicWidgetLayout.resizeTo(_dynamicWidgetLayout.topItemListInitialWidth - _loc3_,_dynamicWidgetLayout.topItemListInitialHeight - _loc2_);
         _dynamicWidgetLayout.scrollbarRightEdgeRelativeToScreen = Math.min(_window.width,_loc1_.width + window.x);
      }
      
      private function resizeCustomLayout() : void
      {
         _window.x = 0;
         _window.y = 0;
         var _loc1_:Rectangle = _window.desktop.rectangle;
         _window.x = Math.max(0,(_loc1_.width - _window.width) / 2);
         if(_loc1_.height > _window.height || isGenericReceptionLayout())
         {
            _window.y = Math.max(0,(_loc1_.height - _window.height) / 2);
         }
         else
         {
            _window.y = _loc1_.height - _window.height;
         }
      }
      
      protected function onDesktopResized(param1:WindowEvent) : void
      {
         resizeWindow();
      }
      
      private function setBackgroundGraphics(param1:String) : void
      {
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc2_:String = null;
         param1 = param1 == null || param1 == "" ? "" : param1 + ".";
         for each(var _loc3_ in const_447)
         {
            if(_loc4_ = IStaticBitmapWrapperWindow(_window.findChildByName(_loc3_)))
            {
               if(_landingView.getProperty("landing.view." + param1 + _loc3_ + ".visible") == "false")
               {
                  _loc4_.visible = false;
               }
               else
               {
                  _loc4_.visible = true;
                  _loc2_ = _landingView.getProperty("landing.view." + param1 + _loc3_ + ".uri",null);
                  if(_loc4_.assetUri != _loc2_ && _loc2_ != null && _loc2_ != "")
                  {
                     _loc4_.assetUri = _loc2_;
                  }
               }
            }
         }
      }
      
      private function registerFixedWidgets() : void
      {
         registerPlaceholderAnchoredWidget("avatarimage");
         registerPlaceholderAnchoredWidget("expiringcatalogpage");
         registerPlaceholderAnchoredWidget("expiringcatalogpagesmall");
         registerPlaceholderAnchoredWidget("communitygoal");
         registerPlaceholderAnchoredWidget("catalogpromo");
         registerPlaceholderAnchoredWidget("achievementcompetition_hall_of_fame");
         registerPlaceholderAnchoredWidget("achievementcompetition_prizes");
         registerPlaceholderAnchoredWidget("dailyquest");
         registerPlaceholderAnchoredWidget("nextlimitedrarecountdown");
         registerPlaceholderAnchoredWidget("habbomoderationpromo");
         registerPlaceholderAnchoredWidget("habbotalentspromo");
         registerPlaceholderAnchoredWidget("habbowaypromo");
         registerPlaceholderAnchoredWidget("safetyquizpromo");
         registerPlaceholderAnchoredWidget("generic");
         registerPlaceholderAnchoredWidget("widgetcontainer");
      }
      
      private function registerPlaceholderAnchoredWidget(param1:String) : void
      {
         var _loc2_:ILandingViewWidget = LandingViewWidgetType.getWidgetForType(param1,_landingView);
         var_1643.push(new WidgetContainer(_loc2_,"widget_placeholder_" + param1,var_2696));
      }
      
      private function registerDynamicWidgets() : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc1_:ILandingViewWidget = null;
         if(_window.findChildByName("placeholder_dynamic_widget_slots") == null)
         {
            class_14.log("ERROR! Tried to initialize dynamic widget list for landing view without the dynamic element present");
            return;
         }
         _dynamicWidgetLayout = new DynamicLayoutManager(this,var_2696);
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc2_ = _landingView.getProperty("landing.view.dynamic.slot." + (_loc3_ + 1) + ".widget",null);
            _loc1_ = LandingViewWidgetType.getWidgetForType(_loc2_,_landingView);
            if(_loc1_ != null)
            {
               if(_loc1_ is ISlotAwareWidget)
               {
                  ISlotAwareWidget(_loc1_).slot = _loc3_ + 1;
               }
               var_1643.push(new WidgetContainer(_loc1_,null,var_2696,_dynamicWidgetLayout.getDynamicSlotContainer(_loc3_)));
            }
            _loc3_++;
         }
         if(_landingView.getBoolean("landing.view.dynamic.slot.5.ignore"))
         {
            _dynamicWidgetLayout.ignoreBottomRightSlot = true;
         }
         if(_landingView.getBoolean("landing.view.dynamic.slot.4.separator"))
         {
            _dynamicWidgetLayout.enableSeparator(4,_landingView.getProperty("landing.view.dynamic.slot.4.title"));
         }
         if(_landingView.getBoolean("landing.view.dynamic.slot.5.separator"))
         {
            _dynamicWidgetLayout.enableSeparator(5,_landingView.getProperty("landing.view.dynamic.slot.5.title"));
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function get landingView() : HabboLandingView
      {
         return _landingView;
      }
      
      private function onTimingCode(param1:CurrentTimingCodeMessageEvent) : void
      {
         if(param1.getParser().schedulingStr == var_1372 && _landingView)
         {
            setBackgroundGraphics(param1.getParser().code);
            var_2682.timingCode = param1.getParser().code;
            var_2682.initialize(_window);
         }
      }
   }
}
