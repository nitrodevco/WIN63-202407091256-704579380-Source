package com.sulake.habbo.roomevents.wired_menu.tabs.tab_settings
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_1257;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_326;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_412;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetPreferencesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_736;
   
   public class WiredMenuSettingsTab extends WiredMenuDefaultTab
   {
       
      
      private var MODIFY_PERMISSION_OPTIONS:Array;
      
      private var READ_PERMISSION_OPTIONS:Array;
      
      private var var_649:int = -1;
      
      private var var_492:int = -1;
      
      private var _ignoringCheckboxEvents:Boolean = false;
      
      public function WiredMenuSettingsTab(param1:WiredMenuController, param2:IWindowContainer)
      {
         var _loc4_:int = 0;
         var _loc3_:class_3398 = null;
         MODIFY_PERMISSION_OPTIONS = [1,2,3];
         READ_PERMISSION_OPTIONS = [0,1,2,3];
         super(param1,param2);
         addMessageEvent(new class_326(onWiredSettings));
         updateLoadingState();
         requestData();
         for each(_loc4_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc3_ = getModifyCheckbox(_loc4_);
            _loc3_.addEventListener("WE_SELECTED",onPermissionsChanged);
            _loc3_.addEventListener("WE_UNSELECTED",onPermissionsChanged);
         }
         for each(_loc4_ in READ_PERMISSION_OPTIONS)
         {
            _loc3_ = getReadCheckbox(_loc4_);
            _loc3_.addEventListener("WE_SELECTED",onPermissionsChanged);
            _loc3_.addEventListener("WE_UNSELECTED",onPermissionsChanged);
         }
         toolbarCheckbox.addEventListener("WE_SELECTED",onPreferencesChanged);
         toolbarCheckbox.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         wiredInspectButton.addEventListener("WE_SELECTED",onPreferencesChanged);
         wiredInspectButton.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         playtestCheckbox.addEventListener("WE_SELECTED",onPreferencesChanged);
         playtestCheckbox.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         syntaxCheckbox.addEventListener("WE_SELECTED",onPreferencesChanged);
         syntaxCheckbox.addEventListener("WE_UNSELECTED",onPreferencesChanged);
      }
      
      private function onWiredSettings(param1:class_326) : void
      {
         var _loc2_:class_1257 = param1.getParser();
         var_649 = _loc2_.modifyPermissionMask;
         var_492 = _loc2_.readPermissionMask;
         updateLoadingState();
      }
      
      override protected function isDataReady() : Boolean
      {
         return var_649 != -1 && var_492 != -1;
      }
      
      private function requestData() : void
      {
         controller.send(new class_412());
      }
      
      override protected function initializeInterface() : void
      {
         updatePermissionsUI();
         updatePreferencesUI();
      }
      
      private function onPermissionsChanged(param1:WindowEvent) : void
      {
         if(_ignoringCheckboxEvents)
         {
            return;
         }
         var _loc3_:class_3398 = param1.target as class_3398;
         var _loc2_:int = int(_loc3_.id);
         var _loc5_:* = _loc3_.name.indexOf("modify_") == 0;
         var _loc4_:* = param1.type == "WE_SELECTED";
         if(_loc5_)
         {
            if(_loc4_)
            {
               var_649 |= 1 << _loc2_;
            }
            else
            {
               var_649 &= ~(1 << _loc2_);
            }
         }
         else if(_loc4_)
         {
            var_492 |= 1 << _loc2_;
         }
         else
         {
            var_492 &= ~(1 << _loc2_);
         }
         updatePermissionsUI();
         controller.send(new class_736(var_649,var_492));
      }
      
      private function updatePermissionsUI() : void
      {
         var _loc4_:int = 0;
         var _loc3_:class_3398 = null;
         var _loc1_:class_3398 = null;
         _ignoringCheckboxEvents = true;
         selectedModifyMask = var_649;
         selectedReadMask = var_492;
         var _loc2_:Boolean = controller.isRoomOwnerOrStaff();
         Util.disableSection(modifySettingsContainer,!_loc2_);
         Util.disableSection(readSettingsContainer,!_loc2_);
         if(getModifyCheckbox(2).isSelected)
         {
            getModifyCheckbox(3).select();
            Util.disableSection(getModifyCheckbox(3));
         }
         if(getReadCheckbox(2).isSelected)
         {
            getReadCheckbox(3).select();
            Util.disableSection(getReadCheckbox(3));
         }
         if(getReadCheckbox(0).isSelected)
         {
            for each(_loc4_ in READ_PERMISSION_OPTIONS)
            {
               if(_loc4_ != 0)
               {
                  _loc3_ = getReadCheckbox(_loc4_);
                  _loc3_.select();
                  Util.disableSection(_loc3_);
               }
            }
         }
         for each(_loc4_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc3_ = getModifyCheckbox(_loc4_);
            if(_loc3_.isSelected)
            {
               _loc1_ = getReadCheckbox(_loc4_);
               _loc1_.select();
               Util.disableSection(_loc1_);
            }
         }
         _ignoringCheckboxEvents = false;
      }
      
      private function updatePreferencesUI() : void
      {
         _ignoringCheckboxEvents = true;
         Util.select(toolbarCheckbox,controller.wiredMenuButton);
         Util.select(wiredInspectButton,controller.wiredInspectButton);
         Util.select(playtestCheckbox,controller.playTestMode);
         Util.select(syntaxCheckbox,controller.variableSyntaxMode == 0);
         _ignoringCheckboxEvents = false;
      }
      
      private function onPreferencesChanged(param1:WindowEvent) : void
      {
         if(_ignoringCheckboxEvents)
         {
            return;
         }
         controller.wiredMenuButton = toolbarCheckbox.isSelected;
         controller.wiredInspectButton = wiredInspectButton.isSelected;
         controller.playTestMode = playtestCheckbox.isSelected;
         controller.variableSyntaxMode = !!syntaxCheckbox.isSelected ? 0 : 1;
         controller.send(new WiredSetPreferencesMessageComposer(controller.wiredMenuButton,controller.wiredInspectButton,controller.playTestMode,controller.variableSyntaxMode));
      }
      
      private function get modifySettingsContainer() : IWindowContainer
      {
         return container.findChildByName("modify_settings_container") as IWindowContainer;
      }
      
      private function get readSettingsContainer() : IWindowContainer
      {
         return container.findChildByName("read_settings_container") as IWindowContainer;
      }
      
      private function get toolbarCheckbox() : class_3398
      {
         return container.findChildByName("preference_toolbar_checkbox") as class_3398;
      }
      
      private function get wiredInspectButton() : class_3398
      {
         return container.findChildByName("preference_inspect_button_checkbox") as class_3398;
      }
      
      private function get playtestCheckbox() : class_3398
      {
         return container.findChildByName("preference_playtest_checkbox") as class_3398;
      }
      
      private function get syntaxCheckbox() : class_3398
      {
         return container.findChildByName("preference_syntax_checkbox") as class_3398;
      }
      
      private function getModifyCheckbox(param1:int) : class_3398
      {
         return container.findChildByName("modify_" + param1 + "_checkbox") as class_3398;
      }
      
      private function getReadCheckbox(param1:int) : class_3398
      {
         return container.findChildByName("read_" + param1 + "_checkbox") as class_3398;
      }
      
      private function get selectedModifyMask() : int
      {
         var _loc1_:class_3398 = null;
         var _loc3_:* = 0;
         for each(var _loc2_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc1_ = getModifyCheckbox(_loc2_);
            if(_loc1_.isSelected)
            {
               _loc3_ |= 1 << _loc2_;
            }
         }
         return _loc3_;
      }
      
      private function get selectedReadMask() : int
      {
         var _loc1_:class_3398 = null;
         var _loc3_:* = 0;
         for each(var _loc2_ in READ_PERMISSION_OPTIONS)
         {
            _loc1_ = getReadCheckbox(_loc2_);
            if(_loc1_.isSelected)
            {
               _loc3_ |= 1 << _loc2_;
            }
         }
         return _loc3_;
      }
      
      private function set selectedModifyMask(param1:int) : void
      {
         var _loc2_:class_3398 = null;
         for each(var _loc3_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc2_ = getModifyCheckbox(_loc3_);
            Util.select(_loc2_,(param1 & 1 << _loc3_) != 0);
         }
      }
      
      private function set selectedReadMask(param1:int) : void
      {
         var _loc2_:class_3398 = null;
         for each(var _loc3_ in READ_PERMISSION_OPTIONS)
         {
            _loc2_ = getReadCheckbox(_loc3_);
            Util.select(_loc2_,(param1 & 1 << _loc3_) != 0);
         }
      }
   }
}
