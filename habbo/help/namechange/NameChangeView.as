package com.sulake.habbo.help.namechange
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.help.INameChangeUI;
   import flash.external.ExternalInterface;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   
   public class NameChangeView implements IDisposable
   {
      
      private static const NAME_UPDATE_FUNCTION:String = "FlashExternalInterface.updateName";
      
      private static var NAME_SUGGESTION_BG_COLOR:uint = 13232628;
      
      private static var NAME_SUGGESTION_BG_COLOR_OVER:uint = 11129827;
       
      
      private var var_319:INameChangeUI;
      
      private var _window:class_3514;
      
      private var _checkedName:String;
      
      private var _pendingName:String;
      
      private var var_1747:IWindowContainer;
      
      private var var_2615:IWindowContainer;
      
      private var var_2700:IWindowContainer;
      
      private var var_1674:IWindowContainer;
      
      private var var_3283:Boolean = false;
      
      private var var_3131:NameSuggestionListRenderer;
      
      private var _disposed:Boolean;
      
      public function NameChangeView(param1:INameChangeUI)
      {
         super();
         var_319 = param1;
      }
      
      public function get id() : String
      {
         return "TUI_NAME_VIEW";
      }
      
      public function set checkedName(param1:String) : void
      {
         _checkedName = param1;
         if(_pendingName == _checkedName)
         {
            showConfirmationView();
            return;
         }
         setNameAvailableView();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            disposeWindow();
            if(var_3131 != null)
            {
               var_3131.dispose();
               var_3131 = null;
            }
            _disposed = true;
         }
      }
      
      private function disposeWindow() : void
      {
         var_1747 = null;
         var_2615 = null;
         var_2700 = null;
         var_1674 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function showView(param1:IWindowContainer) : void
      {
         var_3283 = false;
         if(var_1674)
         {
            var_1674.visible = false;
         }
         var_1674 = param1;
         var_1674.visible = true;
         if(_window)
         {
            _window.content.width = var_1674.width;
            _window.content.height = var_1674.height;
         }
      }
      
      public function showMainView() : void
      {
         if(!_window)
         {
            _window = var_319.buildXmlWindow("welcome_name_change") as class_3514;
            _window.center();
            _window.procedure = windowEventHandler;
            var_1747 = _window.content.getChildAt(0) as IWindowContainer;
         }
         var_319.localization.registerParameter("tutorial.name_change.current","name",var_319.myName);
         _window.caption = var_319.localization.getLocalization("tutorial.name_change.title.main");
         showView(var_1747);
      }
      
      private function showSelectionView() : void
      {
         if(!var_2615)
         {
            var_2615 = var_319.buildXmlWindow("welcome_name_selection") as IWindowContainer;
            if(!var_2615)
            {
               return;
            }
            _window.content.addChild(var_2615);
         }
         _window.caption = var_319.localization.getLocalization("tutorial.name_change.title.select");
         var _loc1_:class_3357 = _window.findChildByName("select_name_button") as class_3357;
         if(_loc1_)
         {
            _loc1_.disable();
         }
         setNormalView();
         showView(var_2615);
      }
      
      private function showConfirmationView() : void
      {
         if(!var_2700)
         {
            var_2700 = var_319.buildXmlWindow("welcome_name_confirmation") as IWindowContainer;
            if(!var_2700)
            {
               return;
            }
            _window.content.addChild(var_2700);
         }
         _window.caption = var_319.localization.getLocalization("tutorial.name_change.title.confirm");
         var _loc1_:ITextWindow = var_2700.findChildByName("final_name") as ITextWindow;
         if(_loc1_)
         {
            _loc1_.text = _checkedName;
         }
         showView(var_2700);
         if(ExternalInterface.available)
         {
            ExternalInterface.call("FlashExternalInterface.updateName",_checkedName);
         }
      }
      
      public function get view() : IWindowContainer
      {
         return _window;
      }
      
      public function setNormalView() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = var_319.localization.getLocalization("help.tutorial.name.info");
         var _loc1_:IWindowContainer = _window.findChildByName("suggestions") as IWindowContainer;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
      }
      
      public function setNameAvailableView() : void
      {
         if(_window == null)
         {
            return;
         }
         nameCheckWaitEnd(true);
         var _loc2_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var_319.localization.registerParameter("help.tutorial.name.available","name",_checkedName);
         _loc2_.text = var_319.localization.getLocalization("help.tutorial.name.available");
         var _loc3_:ITextFieldWindow = _window.findChildByName("input") as ITextFieldWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = _checkedName;
         var _loc1_:IWindowContainer = _window.findChildByName("suggestions") as IWindowContainer;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
      }
      
      public function setNameNotAvailableView(param1:int, param2:String, param3:Array) : void
      {
         var _loc8_:int = 0;
         var _loc6_:IWindow = null;
         nameCheckWaitEnd(false);
         if(var_1674 != var_2615)
         {
            showSelectionView();
         }
         _pendingName = null;
         _checkedName = null;
         if(_window == null)
         {
            return;
         }
         var _loc5_:ITextWindow;
         if((_loc5_ = _window.findChildByName("info_text") as ITextWindow) == null)
         {
            return;
         }
         switch(param1)
         {
            case ChangeUserNameResultMessageEvent.var_1590:
               var_319.localization.registerParameter("help.tutorial.name.taken","name",param2);
               _loc5_.text = var_319.localization.getLocalization("help.tutorial.name.taken");
               break;
            case ChangeUserNameResultMessageEvent.var_1604:
               var_319.localization.registerParameter("help.tutorial.name.invalid","name",param2);
               _loc5_.text = var_319.localization.getLocalization("help.tutorial.name.invalid");
               break;
            case ChangeUserNameResultMessageEvent.var_1595:
               break;
            case ChangeUserNameResultMessageEvent.var_1596:
               _loc5_.text = var_319.localization.getLocalization("help.tutorial.name.long");
               break;
            case ChangeUserNameResultMessageEvent.var_1592:
               _loc5_.text = var_319.localization.getLocalization("help.tutorial.name.short");
               break;
            case ChangeUserNameResultMessageEvent.var_1617:
               _loc5_.text = var_319.localization.getLocalization("help.tutorial.name.change_not_allowed");
               break;
            case ChangeUserNameResultMessageEvent.var_1620:
               _loc5_.text = var_319.localization.getLocalization("help.tutorial.name.merge_hotel_down");
         }
         var _loc4_:IWindowContainer;
         if((_loc4_ = _window.findChildByName("suggestions") as IWindowContainer) == null)
         {
            return;
         }
         if(param1 == ChangeUserNameResultMessageEvent.var_1620 || param1 == ChangeUserNameResultMessageEvent.var_1617)
         {
            _loc4_.visible = false;
            return;
         }
         _loc4_.visible = true;
         var_3131 = new NameSuggestionListRenderer(var_319);
         var _loc7_:int = var_3131.render(param3,_loc4_);
         _loc8_ = 0;
         while(_loc8_ < _loc4_.numChildren)
         {
            (_loc6_ = _loc4_.getChildAt(_loc8_)).color = NAME_SUGGESTION_BG_COLOR;
            _loc6_.addEventListener("WME_CLICK",nameSelected);
            _loc6_.addEventListener("WME_OVER",nameOver);
            _loc6_.addEventListener("WME_OUT",nameOut);
            _loc8_++;
         }
      }
      
      private function nameSelected(param1:WindowMouseEvent) : void
      {
         nameCheckWaitEnd(true);
         var _loc4_:ITextWindow;
         if(!(_loc4_ = param1.target as ITextWindow))
         {
            return;
         }
         var _loc3_:String = _loc4_.text;
         setNormalView();
         var _loc2_:ITextFieldWindow = _window.findChildByName("input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = _loc3_;
      }
      
      private function nameOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.color = NAME_SUGGESTION_BG_COLOR_OVER;
         }
      }
      
      private function nameOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.color = NAME_SUGGESTION_BG_COLOR;
         }
      }
      
      public function nameCheckWaitBegin() : void
      {
         var _loc1_:IWindow = null;
         if(_window && !_window.disposed)
         {
            _loc1_ = _window.findChildByName("select_name_button");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = _window.findChildByName("check_name_button");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = _window.findChildByName("input");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = _window.findChildByName("info_text");
            if(_loc1_)
            {
               _loc1_.caption = var_319.localization.getLocalization("help.tutorial.name.wait_while_checking");
            }
         }
         var_3283 = true;
      }
      
      public function nameCheckWaitEnd(param1:Boolean) : void
      {
         var _loc2_:IWindow = null;
         if(_window && !_window.disposed)
         {
            if(param1)
            {
               _loc2_ = _window.findChildByName("select_name_button");
               if(_loc2_)
               {
                  _loc2_.enable();
               }
            }
            _loc2_ = _window.findChildByName("check_name_button");
            if(_loc2_)
            {
               _loc2_.enable();
            }
            _loc2_ = _window.findChildByName("input");
            if(_loc2_)
            {
               _loc2_.enable();
            }
         }
         var_3283 = false;
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:IWindow = null;
         var _loc4_:ITextFieldWindow = null;
         var _loc5_:String = null;
         if(!var_3283)
         {
            if(param1.type == "WE_CHANGE")
            {
               if(param2.name == "input")
               {
                  _loc3_ = _window.findChildByName("select_name_button");
                  _loc4_ = param2 as ITextFieldWindow;
                  if(_loc3_ && _loc4_)
                  {
                     if(_loc4_.text.length > 2)
                     {
                        _loc3_.enable();
                     }
                     else
                     {
                        _loc3_.disable();
                     }
                  }
               }
            }
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "change_name_button":
               showSelectionView();
               break;
            case "keep_name_button":
               _checkedName = var_319.myName;
               showConfirmationView();
               break;
            case "check_name_button":
               var_319.checkName(getName());
               nameCheckWaitBegin();
               break;
            case "select_name_button":
               if((_loc5_ = getName()).length < 1)
               {
                  return;
               }
               if(_checkedName != _loc5_)
               {
                  _pendingName = _loc5_;
                  var_319.checkName(_loc5_);
                  nameCheckWaitBegin();
               }
               else
               {
                  showConfirmationView();
               }
               break;
            case "cancel_selection_button":
               var_319.hideView();
               break;
            case "confirm_name_button":
               var_319.changeName(_checkedName);
               break;
            case "cancel_confirmation_button":
               var_319.hideView();
               break;
            case "header_button_close":
               var_319.hideView();
         }
      }
      
      private function getName() : String
      {
         var _loc1_:ITextFieldWindow = null;
         if(_window)
         {
            _loc1_ = _window.findChildByName("input") as ITextFieldWindow;
            if(_loc1_)
            {
               return _loc1_.text;
            }
         }
         return null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
