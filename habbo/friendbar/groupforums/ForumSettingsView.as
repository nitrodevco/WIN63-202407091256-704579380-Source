package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1755;
   
   public class ForumSettingsView
   {
      
      private static const const_926:Number = 0.5;
       
      
      private var var_319:GroupForumController;
      
      private var var_1747:GroupForumView;
      
      private var _window:class_3514;
      
      private var var_3331:ISelectorWindow;
      
      private var var_3147:ISelectorWindow;
      
      private var var_3060:ISelectorWindow;
      
      private var var_3434:ISelectorWindow;
      
      private var var_513:class_1755;
      
      private var var_1559:int;
      
      private var var_1542:int;
      
      private var var_1526:int;
      
      private var var_1554:int;
      
      public function ForumSettingsView(param1:GroupForumView, param2:int, param3:int, param4:class_1755)
      {
         super();
         var_1747 = param1;
         var_319 = var_1747.controller;
         var_513 = param4;
         _window = class_3514(var_319.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_forum_settings_xml())));
         _window.x = param2;
         var _loc5_:int = int(var_319.windowManager.getDesktop(1).width);
         if(_window.x + _window.width > _loc5_)
         {
            _window.x = _loc5_ - _window.width;
         }
         _window.y = param3;
         initControls();
      }
      
      private static function setSelectorState(param1:ISelectorWindow, param2:int, param3:int) : int
      {
         var _loc5_:* = 0;
         var _loc6_:ISelectableWindow = null;
         var _loc4_:IWindow = null;
         if(param3 < param2)
         {
            param3 = param2;
         }
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            if((_loc6_ = param1.getSelectableByName(String(_loc5_))) != null)
            {
               _loc6_.disable();
               _loc6_.blend = 0.5;
               if((_loc4_ = IWindowContainer(param1.parent).findChildByName("label" + _loc5_)) != null)
               {
                  _loc4_.blend = 0.5;
               }
            }
            _loc5_++;
         }
         _loc5_ = param2;
         while(_loc5_ < 4)
         {
            if((_loc6_ = param1.getSelectableByName(String(_loc5_))) != null)
            {
               _loc6_.enable();
               _loc6_.blend = 1;
               if((_loc4_ = IWindowContainer(param1.parent).findChildByName("label" + _loc5_)) != null)
               {
                  _loc4_.blend = 1;
               }
               if(_loc5_ == param3)
               {
                  param1.setSelected(_loc6_);
               }
            }
            _loc5_++;
         }
         return param3;
      }
      
      private static function getSelectorState(param1:ISelectorWindow) : int
      {
         var _loc2_:ISelectableWindow = param1.getSelected();
         if(_loc2_ == null)
         {
            return 0;
         }
         return int(_loc2_.name);
      }
      
      public function focus(param1:class_1755) : void
      {
         if(var_513 != param1)
         {
            var_513 = param1;
            initControls();
         }
         _window.activate();
      }
      
      private function initControls() : void
      {
         var _loc2_:IRegionWindow = GroupForumView.initTopAreaForForum(_window,var_513);
         _loc2_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc2_.addEventListener("WME_CLICK",onTopAreaClick);
         var _loc1_:IWindow = _window.findChildByName("cancel_btn");
         _loc1_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc1_.addEventListener("WME_CLICK",onCancelButtonClick);
         var _loc3_:IWindow = _window.findChildByName("header_button_close");
         _loc3_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc3_.addEventListener("WME_CLICK",onCancelButtonClick);
         var _loc4_:IWindow;
         (_loc4_ = _window.findChildByName("ok_btn")).removeEventListener("WME_CLICK",onPostButtonClick);
         _loc4_.addEventListener("WME_CLICK",onPostButtonClick);
         var_3331 = ISelectorWindow(_window.findChildByName("read_selector"));
         var_3331.addEventListener("WME_OVER",onReadSelectorHover);
         addSelectorListeners(var_3331);
         var_3147 = ISelectorWindow(_window.findChildByName("post_message_selector"));
         var_3147.addEventListener("WME_OVER",onPostMessageSelectorHover);
         addSelectorListeners(var_3147);
         var_3060 = ISelectorWindow(_window.findChildByName("post_thread_selector"));
         var_3060.addEventListener("WME_OVER",onPostThreadSelectorHover);
         addSelectorListeners(var_3060);
         var_3434 = ISelectorWindow(_window.findChildByName("moderate_selector"));
         var_3434.addEventListener("WME_OVER",onModerateSelectorHover);
         addSelectorListeners(var_3434);
         var_1559 = setSelectorState(var_3331,0,var_513.readPermissions);
         var_1542 = setSelectorState(var_3147,var_1559,var_513.postMessagePermissions);
         var_1526 = setSelectorState(var_3060,var_1542,var_513.postThreadPermissions);
         var_1554 = setSelectorState(var_3434,2,var_513.moderatePermissions);
      }
      
      public function dispose() : void
      {
         var_319.forumSettingsView = null;
         _window.dispose();
         _window = null;
      }
      
      private function onTopAreaClick(param1:WindowMouseEvent) : void
      {
         var_319.context.createLinkEvent("group/" + var_513.groupId);
      }
      
      private function onPostButtonClick(param1:WindowMouseEvent) : void
      {
         var_319.updateForumSettings(var_513.groupId,var_1559,var_1542,var_1526,var_1554);
         dispose();
      }
      
      private function onCancelButtonClick(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function addSelectorListeners(param1:ISelectorWindow) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ISelectableWindow = null;
         _loc2_ = 0;
         while(_loc2_ < param1.numSelectables)
         {
            _loc3_ = param1.getSelectableAt(_loc2_);
            _loc3_.removeEventListener("WE_SELECTED",onSelectionChanged);
            _loc3_.addEventListener("WE_SELECTED",onSelectionChanged);
            _loc2_++;
         }
      }
      
      private function onSelectionChanged(param1:WindowEvent) : void
      {
         var_1559 = getSelectorState(var_3331);
         var_1542 = setSelectorState(var_3147,var_1559,getSelectorState(var_3147));
         var_1526 = setSelectorState(var_3060,var_1542,getSelectorState(var_3060));
         var_1554 = getSelectorState(var_3434);
      }
      
      private function onReadSelectorHover(param1:WindowMouseEvent) : void
      {
         var_319.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.read.seen");
      }
      
      private function onPostMessageSelectorHover(param1:WindowMouseEvent) : void
      {
         var_319.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.post.seen");
      }
      
      private function onPostThreadSelectorHover(param1:WindowMouseEvent) : void
      {
         var_319.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.start.thread.seen");
      }
      
      private function onModerateSelectorHover(param1:WindowMouseEvent) : void
      {
         var_319.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.moderate.seen");
      }
   }
}
