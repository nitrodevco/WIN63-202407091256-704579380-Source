package com.sulake.habbo.inventory.badges
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class Badge
   {
      
      public static var var_3512:IWindowContainer;
      
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
       
      
      private var var_1618:Boolean = false;
      
      private var var_372:String;
      
      private var var_3703:Boolean;
      
      private var var_3588:Boolean;
      
      private var _window:IWindowContainer;
      
      private var var_2348:IWindow;
      
      private var _isUnseen:Boolean;
      
      private var _name:String;
      
      private var _desc:String;
      
      private var var_1644:BadgesModel;
      
      public function Badge(param1:BadgesModel, param2:String, param3:String, param4:String, param5:Boolean)
      {
         super();
         var_1644 = param1;
         var_372 = param2;
         _name = param3;
         _desc = param4;
         _isUnseen = param5;
         this.isSelected = false;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get badgeId() : String
      {
         return var_372;
      }
      
      public function get badgeName() : String
      {
         return _name;
      }
      
      public function get badgeDescription() : String
      {
         return _desc;
      }
      
      public function get isInUse() : Boolean
      {
         return var_3703;
      }
      
      public function get isSelected() : Boolean
      {
         return var_3588;
      }
      
      public function get window() : IWindowContainer
      {
         if(!var_1618)
         {
            initWindow();
         }
         return _window;
      }
      
      private function initWindow() : void
      {
         _window = var_3512.clone() as IWindowContainer;
         IBadgeImageWidget(IWidgetWindow(_window.findChildByName("badge")).widget).badgeId = badgeId;
         _window.findChildByName("badge").visible = true;
         var_2348 = _window.findChildByTag("BG_COLOR");
         var_1618 = true;
         _window.procedure = itemEventProc;
      }
      
      private function itemEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:* = param1.type;
         if("WME_CLICK" === _loc3_)
         {
            var_1644.setBadgeSelected(this.badgeId);
         }
      }
      
      public function set isInUse(param1:Boolean) : void
      {
         var_3703 = param1;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         var_3588 = param1;
         if(var_2348 == null || _window == null)
         {
            return;
         }
         var_2348.color = _isUnseen ? 10275685 : 13421772;
         _window.findChildByName("outline").visible = param1;
      }
      
      public function set isUnseen(param1:Boolean) : void
      {
         if(_isUnseen != param1)
         {
            _isUnseen = param1;
            this.isSelected = var_3588;
         }
      }
   }
}
