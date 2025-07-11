package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.class_3836;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.LandingViewWidgetType;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainer;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.outgoing.competition.class_1011;
   import com.sulake.habbo.communication.messages.incoming.competition.class_581;
   
   public class WidgetContainerWidget implements ILandingViewWidget, ISlotAwareWidget
   {
       
      
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowContainer;
      
      private var var_1643:Dictionary;
      
      private var var_2696:CommonWidgetSettings;
      
      private var var_3406:int;
      
      private var var_1372:String;
      
      private var var_2569:WidgetContainer;
      
      public function WidgetContainerWidget(param1:HabboLandingView)
      {
         var_1643 = new Dictionary();
         super();
         _landingView = param1;
      }
      
      public static function hideChildren(param1:IWindowContainer) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = false;
            _loc2_++;
         }
      }
      
      public function set slot(param1:int) : void
      {
         var_3406 = param1;
      }
      
      public function get container() : IWindow
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
      }
      
      public function initialize() : void
      {
         _container = IWindowContainer(_landingView.getXmlWindow("widget_container_widget"));
         var_2696 = new CommonWidgetSettings(_landingView);
         _landingView.communicationManager.addHabboConnectionMessageEvent(new class_581(onTimingCode));
         var_1372 = _landingView.getProperty("landing.view.dynamic.slot." + var_3406 + ".conf");
      }
      
      public function refresh() : void
      {
         _landingView.send(new class_1011(var_1372));
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function refreshContent() : void
      {
         hideChildren(_container);
         if(var_2569 != null)
         {
            var_2569.refresh(_container);
            var_2569.container.visible = true;
            _container.height = var_2569.container.height;
            _container.width = var_2569.container.width;
         }
      }
      
      private function createWidgetContainer(param1:String) : WidgetContainer
      {
         var _loc3_:String = _landingView.getProperty("landing.view." + param1 + ".widget");
         var _loc2_:ILandingViewWidget = LandingViewWidgetType.getWidgetForType(_loc3_,_landingView);
         if(_loc2_ == null)
         {
            return null;
         }
         if(_loc2_ is ISlotAwareWidget)
         {
            ISlotAwareWidget(_loc2_).slot = var_3406;
         }
         if(_loc2_ is class_3836)
         {
            class_3836(_loc2_).configurationCode = param1;
         }
         var _loc4_:WidgetContainer = new WidgetContainer(_loc2_,null,var_2696,_container);
         var_1643[param1] = _loc4_;
         return _loc4_;
      }
      
      private function onTimingCode(param1:class_581) : void
      {
         if(param1.getParser().schedulingStr == var_1372 && !disposed)
         {
            switchCurrentWidget(param1.getParser().code);
            refreshContent();
         }
      }
      
      private function switchCurrentWidget(param1:String) : void
      {
         if(param1 == "")
         {
            var_2569 = null;
            return;
         }
         var _loc2_:WidgetContainer = var_1643[param1];
         if(_loc2_ == null)
         {
            _loc2_ = createWidgetContainer(param1);
         }
         var_2569 = _loc2_;
      }
   }
}
