package com.sulake.habbo.avatar.view
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.AvatarEditorView;
   import com.sulake.habbo.avatar.HabboAvatarEditorManager;
   import com.sulake.habbo.communication.messages.incoming.avatar.class_341;
   
   public class AvatarEditorNameChangeView
   {
      
      private static var NAME_SUGGESTION_BG_COLOR:uint = 13232628;
      
      private static var NAME_SUGGESTION_BG_COLOR_OVER:uint = 11129827;
       
      
      private var _window:class_3514;
      
      private var var_1747:AvatarEditorView;
      
      private var var_480:HabboAvatarEditorManager;
      
      private var var_3131:AvatarEditorNameSuggestionListRenderer;
      
      private var _checkedName:String;
      
      private var _pendingName:String;
      
      private var var_3283:Boolean = false;
      
      public function AvatarEditorNameChangeView(param1:AvatarEditorView, param2:int, param3:int)
      {
         super();
         var_1747 = param1;
         var_480 = var_1747.editor.manager;
         _window = class_3514(var_480.windowManager.buildFromXML(XML(new HabboAvatarEditorCom.avatar_editor_name_change())));
         _window.x = param2;
         var _loc4_:int = int(var_480.windowManager.getDesktop(1).width);
         if(_window.x + _window.width > _loc4_)
         {
            _window.x = _loc4_ - _window.width;
         }
         _window.y = param3;
         initControls();
      }
      
      private function initControls() : void
      {
         _window.procedure = windowEventHandler;
         var _loc1_:class_3357 = _window.findChildByName("select_name_button") as class_3357;
         if(_loc1_)
         {
            _loc1_.disable();
         }
      }
      
      public function focus() : void
      {
         _window.activate();
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
               _loc1_.caption = var_480.localization.getLocalization("help.tutorial.name.wait_while_checking");
            }
         }
         var_3283 = true;
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:IWindow = null;
         var _loc4_:ITextFieldWindow = null;
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
         var _loc5_:* = param2.name;
         if("check_name_button" === _loc5_)
         {
            var_480.handler.checkName(getName());
            nameCheckWaitBegin();
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
      
      public function set checkedName(param1:String) : void
      {
         _checkedName = param1;
         if(_pendingName == _checkedName)
         {
            return;
         }
         setNameAvailableView();
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
         var_480.localization.registerParameter("help.tutorial.name.available","name",_checkedName);
         _loc2_.text = var_480.localization.getLocalization("help.tutorial.name.available");
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
            case class_341.var_1590:
               var_480.localization.registerParameter("help.tutorial.name.taken","name",param2);
               _loc5_.text = var_480.localization.getLocalization("help.tutorial.name.taken");
               break;
            case class_341.var_1604:
               var_480.localization.registerParameter("help.tutorial.name.invalid","name",param2);
               _loc5_.text = var_480.localization.getLocalization("help.tutorial.name.invalid");
               break;
            case class_341.var_1595:
               break;
            case class_341.var_1596:
               _loc5_.text = var_480.localization.getLocalization("help.tutorial.name.long");
               break;
            case class_341.var_1592:
               _loc5_.text = var_480.localization.getLocalization("help.tutorial.name.short");
               break;
            case class_341.var_1617:
               _loc5_.text = var_480.localization.getLocalization("help.tutorial.name.change_not_allowed");
               break;
            case class_341.var_1620:
               _loc5_.text = var_480.localization.getLocalization("help.tutorial.name.merge_hotel_down");
         }
         var _loc4_:IWindowContainer;
         if((_loc4_ = _window.findChildByName("suggestions") as IWindowContainer) == null)
         {
            return;
         }
         if(param1 == class_341.var_1620 || param1 == class_341.var_1617)
         {
            _loc4_.visible = false;
            return;
         }
         _loc4_.visible = true;
         var_3131 = new AvatarEditorNameSuggestionListRenderer(var_480);
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
         _loc2_.text = var_480.localization.getLocalization("help.tutorial.name.info");
         var _loc1_:IWindowContainer = _window.findChildByName("suggestions") as IWindowContainer;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
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
   }
}
