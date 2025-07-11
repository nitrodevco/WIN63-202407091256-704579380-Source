package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.ILayoutNameProvider;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_3863;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.window.widgets.class_3570;
   
   public class class_3886 implements IElementHandler, IDisposable, class_3863, ILayoutNameProvider
   {
       
      
      private var _landingView:HabboLandingView;
      
      private var _window:IWindowContainer;
      
      private var var_4033:Boolean;
      
      private var _timeRemainingKey:String;
      
      private var _expiredKey:String;
      
      public function class_3886()
      {
         super();
      }
      
      public function get layoutName() : String
      {
         return "element_timer";
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return var_4033;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function refresh() : void
      {
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         _landingView = param1;
         _window = IWindowContainer(param2);
         var_4033 = param3[1] == "true";
         _timeRemainingKey = param3[4];
         _expiredKey = param3[5];
         setCaption(null);
         if(var_4033)
         {
            _window.x = int(param3[2]);
            _window.y = int(param3[3]);
         }
      }
      
      protected function setTimer(param1:int) : void
      {
         var _loc2_:IWidgetWindow = IWidgetWindow(_window.findChildByName("countdown_widget"));
         _loc2_.visible = param1 > 0;
         var _loc3_:class_3570 = class_3570(_loc2_.widget);
         _loc3_.seconds = param1;
         setCaption(param1 > 0 ? _timeRemainingKey : _expiredKey);
      }
      
      private function setCaption(param1:String) : void
      {
         var _loc3_:IWindow = _window.findChildByName("timer_caption_txt");
         var _loc2_:Boolean = param1 != null && param1 != "";
         _loc3_.visible = _loc2_;
         if(_loc2_)
         {
            _loc3_.caption = "${" + param1 + "}";
         }
      }
      
      public function get landingView() : HabboLandingView
      {
         return _landingView;
      }
   }
}
