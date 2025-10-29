package com.sulake.habbo.roomevents.wired_setup
{
    import assets.class_14

    import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.*;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.InputSourcesConf;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.SelectorDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1660;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1701;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1702;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1737;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1747;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3620;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateSelectorMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateConditionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateTriggerMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateAddonMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateActionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.ApplySnapshotMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.UpdateVariableMessageComposer;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.WiredVariablesSynchronizer;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.ActionType;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.ActionTypes;
   import com.sulake.habbo.roomevents.wired_setup.addons.AddonTypes;
   import com.sulake.habbo.roomevents.wired_setup.addons.DefaultAddonType;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import com.sulake.habbo.roomevents.wired_setup.conditions.ConditionTypes;
   import com.sulake.habbo.roomevents.wired_setup.help.UserDefinedRoomEventsHelp;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.selectors.SelectorTypes;
   import com.sulake.habbo.roomevents.wired_setup.triggerconfs.TriggerConfs;
   import com.sulake.habbo.roomevents.wired_setup.triggerconfs.class_3612;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.VolterWiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.habbo.roomevents.wired_setup.variables.VariableTypes;
   import com.sulake.habbo.roomevents.wired_setup.variables.class_3532;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.AllVariablesInRoom;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   
   public class UserDefinedRoomEventsCtrl
   {
      
      private static var var_2036:int = 5;
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _window:class_3514;
      
      private var _configureContainer:IWindowContainer;
      
      private var var_4176:TriggerConfs;
      
      private var var_3971:ActionTypes;
      
      private var var_4161:ConditionTypes;
      
      private var var_3985:AddonTypes;
      
      private var var_4075:SelectorTypes;
      
      private var var_4136:VariableTypes;
      
      private var var_1921:Dictionary;
      
      private var var_1645:class_1659;
      
      private var var_2360:RoomObjectHighLighter;
      
      private var _help:UserDefinedRoomEventsHelp;
      
      private var var_3535:SliderWindowController;
      
      private var _furniSourcePickers:Vector.<WiredInputSourcePicker>;
      
      private var _userSourcePickers:Vector.<WiredInputSourcePicker>;
      
      private var _mergedSourcePickers:Vector.<WiredInputSourcePicker>;
      
      private var var_4613:Boolean = false;
      
      private var _advancedModeExpanded:Boolean = false;
      
      private var var_3551:Array;
      
      private var _variablesCallback:Function = null;
      
      private var var_3450:WiredStyle;
      
      private var var_4162:PresetManager;
      
      public function UserDefinedRoomEventsCtrl(param1:HabboUserDefinedRoomEvents)
      {
         var_4176 = new TriggerConfs();
         var_3971 = new ActionTypes();
         var_4161 = new ConditionTypes();
         var_3985 = new AddonTypes();
         var_4075 = new SelectorTypes();
         var_4136 = new VariableTypes();
         var_1921 = new Dictionary();
         _furniSourcePickers = new Vector.<WiredInputSourcePicker>();
         _userSourcePickers = new Vector.<WiredInputSourcePicker>();
         _mergedSourcePickers = new Vector.<WiredInputSourcePicker>();
         var_3551 = [];
         super();
         _roomEvents = param1;
         var_2360 = new RoomObjectHighLighter(param1);
         _help = new UserDefinedRoomEventsHelp(param1);
         var_4162 = new PresetManager(param1);
         var_3450 = new VolterWiredStyle(param1);
      }
      
      private static function select(param1:class_3398, param2:Boolean) : void
      {
         if(param2)
         {
            param1.select();
         }
         else
         {
            param1.unselect();
         }
      }
      
      public function stuffAdded(param1:int) : void
      {
         if(var_1921[param1])
         {
            var_2360.show(param1);
         }
      }
      
      public function stuffSelected(param1:int) : void
      {
         if(_window == null || !_window.visible)
         {
            return;
         }
         if(!isStuffSelectionMode() || !var_1645.allowWallFurni && param1 < 0)
         {
            return;
         }
         if(var_1921[param1])
         {
            delete var_1921[param1];
            var_2360.hide(param1);
         }
         else if(this.getStuffIds().length < var_1645.furniLimit)
         {
            var_1921[param1] = "yes";
            var_2360.show(param1);
         }
         refreshSelectFurni();
         refreshInputSources();
      }
      
      private function isStuffSelectionMode() : Boolean
      {
         return var_1645.inputSourcesConf.allowFurniSelection() || resolveType().forceFurniSelection;
      }
      
      public function get hidePickFurniInstructions() : Boolean
      {
         if(resolveType().forceHidePickFurniInstructions)
         {
            return true;
         }
         return !var_1645.inputSourcesConf.isFurniSelectionDefault() && !resolveType().forceFurniSelection;
      }
      
      private function resolveType() : class_3531
      {
         if(var_1645 != null)
         {
            return resolveHolder().getElementByCode(var_1645.code);
         }
         return null;
      }
      
      private function resolveHolder() : class_3547
      {
         if(var_1645 as class_1701 != null)
         {
            return var_4176;
         }
         if(var_1645 as class_1702 != null)
         {
            return var_3971;
         }
         if(var_1645 as class_1660 != null)
         {
            return var_4161;
         }
         if(var_1645 as class_1747 != null)
         {
            return var_3985;
         }
         if(var_1645 as SelectorDefinition != null)
         {
            return var_4075;
         }
         if(var_1645 as class_1737 != null)
         {
            return var_4136;
         }
         return null;
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = class_3514(_roomEvents.getXmlWindow("ude_main"));
         _configureContainer = IWindowContainer(find(_window,"configure_container"));
         Util.setProcDirectly(find(_configureContainer,"save_button"),onSave);
         Util.setProcDirectly(find(_configureContainer,"cancel_save_button"),onWindowClose);
         Util.setProcDirectly(find(_configureContainer,"helplink"),onHelp);
         Util.setProcDirectly(find(_configureContainer,"advanced_collapser"),onAdvancedModeToggle);
         Util.setProcDirectly(find(_configureContainer,"apply_snapshot_txt"),onApplySnapshot);
         Util.setProcDirectly(find(_configureContainer,"view_in_menu_txt"),onViewInMenu);
         find(_configureContainer,"helplink").mouseThreshold = 0;
         find(_configureContainer,"apply_snapshot_txt").mouseThreshold = 0;
         find(_configureContainer,"view_in_menu_txt").mouseThreshold = 0;
         var_3535 = new SliderWindowController(_roomEvents,IWindowContainer(find(_configureContainer,"delay_slider_container")),_roomEvents.assets,0,20,1);
         var_3535.addEventListener("change",onDelaySliderChange);
         var_3535.setValue(0);
         var_3551 = [];
         setIcon("configure_container","icon_trigger","trigger_icon_bitmap");
         setIcon("configure_container","icon_action","action_icon_bitmap");
         setIcon("configure_container","icon_condition","condition_icon_bitmap");
         setIcon("configure_container","icon_addon","addon_icon_bitmap");
         setIcon("configure_container","icon_selector","selector_icon_bitmap");
         setIcon("configure_container","icon_variable","variable_icon_bitmap");
         var _loc1_:IWindow = _window.findChildByTag("close");
         _loc1_.procedure = onWindowClose;
         _window.center();
      }
      
      private function onDelaySliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc4_ = _loc5_ = _loc2_.getValue();
               _loc3_ = class_3612.getSecsFromPulses(_loc4_);
               _roomEvents.localization.registerParameter("wiredfurni.params.delay","seconds",_loc3_);
            }
         }
      }
      
      private function setIcon(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:IWindowContainer = IWindowContainer(find(_window,param1));
         _roomEvents.refreshButton(_loc4_,param3,true,null,0,param2);
         var_3551.push(param3);
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      public function close() : void
      {
         if(_window)
         {
            resolveType().onEditEnd();
            _window.visible = false;
            var_2360.hideAll(var_1921);
            var_1921 = new Dictionary();
            var_2360.unhighlightActiveWired(var_1645.id);
         }
         if(_variablesCallback != null)
         {
            _roomEvents.variablesSynchronizer.removeListener(_variablesCallback);
            _variablesCallback = null;
         }
      }
      
      private function find(param1:IWindowContainer, param2:String) : IWindow
      {
         var _loc3_:IWindow = param1.findChildByName(param2);
         if(_loc3_ == null)
         {
            throw new Error("Window element with name: " + param2 + " cannot be found!");
         }
         return _loc3_;
      }
      
      private function synchronizeTriggerable(param1:class_1659) : Boolean
      {
         var synchronizer:WiredVariablesSynchronizer;
         var updated:class_1659 = param1;
         var variablesList:AllVariablesInRoom = updated.wiredContext.roomVariablesList;
         if(variablesList != null && variablesList.needsSynchronize)
         {
            synchronizer = _roomEvents.variablesSynchronizer;
            if(_variablesCallback != null)
            {
               synchronizer.removeListener(_variablesCallback);
            }
            _variablesCallback = function(param1:Vector.<WiredVariable>):void
            {
               _variablesCallback = null;
               updated.wiredContext.roomVariablesList.synchronize(param1);
               prepareForUpdate(updated);
            };
            synchronizer.getAllVariables(_variablesCallback,true,variablesList.hash);
            return true;
         }
         return false;
      }
      
      public function prepareForUpdate(param1:class_1659) : void
      {
         var _loc3_:class_1702 = null;
         var _loc4_:int = 0;
         if(synchronizeTriggerable(param1))
         {
            return;
         }
         prepareWindow();
         if(_window.visible && var_1645 != null)
         {
            resolveType().onEditEnd();
         }
         if(var_1645 != null)
         {
            var_2360.unhighlightActiveWired(var_1645.id);
         }
         var_1645 = param1;
         class_14.log("Received: " + var_1645 + ", " + param1.code);
         var _loc5_:class_3531 = resolveType();
         var_2360.highlightActiveWired(var_1645.id);
         var_2360.hideAll(var_1921);
         var_1921 = new Dictionary();
         for each(var _loc2_ in var_1645.stuffIds)
         {
            var_1921[_loc2_] = "yes";
         }
         var _loc6_:IWindow = find(_configureContainer,"save_button");
         if(_roomEvents.wiredMenu.hasWritePermission)
         {
            _loc6_.enable();
         }
         else
         {
            _loc6_.disable();
         }
         this.prepareCustomInput();
         _loc5_.onEditStart(var_1645);
         var_2360.showAll(var_1921);
         _advancedModeExpanded = param1.advancedMode && (isUsingAdvancedSettings || _loc5_.advancedAlwaysVisible());
         if(var_1645 as class_1702 != null)
         {
            _loc3_ = class_1702(var_1645);
            _loc4_ = _loc3_.delayInPulses;
            var_3535.setValue(_loc4_);
         }
         refresh();
         _loc5_.onEditInitialized();
      }
      
      public function get isUsingAdvancedSettings() : Boolean
      {
         return var_1645.usingCustomInputSources || resolveType().usingCustomAdvancedSettings;
      }
      
      public function stuffRemoved(param1:int) : void
      {
         if(_window == null)
         {
            return;
         }
         if(!_window.visible)
         {
            return;
         }
         if(var_1645.id == param1)
         {
            close();
            return;
         }
         if(var_1921[param1])
         {
            delete var_1921[param1];
            refreshSelectFurni();
            refreshInputSources();
         }
      }
      
      private function onSave(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Object = null;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(var_1645 as SelectorDefinition != null && Boolean(getInverseInput().isSelected) && !getFilterInput().isSelected)
         {
            _roomEvents.windowManager.confirm("${wiredfurni.danger.1.change.confirm.title}","${wiredfurni.danger.1.change.confirm.body}",0,confirmCallback);
         }
         else if(!isOwner(var_1645.id) && !var_4613)
         {
            _roomEvents.windowManager.confirm("${wiredfurni.nonowner.change.confirm.title}","${wiredfurni.nonowner.change.confirm.body}",0,confirmCallback);
         }
         else
         {
            _loc3_ = resolveType().requireConfirmation;
            if(_loc3_ != null)
            {
               _roomEvents.windowManager.confirm(_loc3_.title,_loc3_.body,0,confirmCallback);
            }
            else
            {
               update();
            }
         }
      }
      
      private function confirmCallback(param1:class_3441, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            var_4613 = true;
            update();
         }
      }
      
      private function update() : void
      {
         var _loc2_:class_3531 = resolveType();
         var _loc1_:String = _loc2_.validate();
         if(_loc1_ != null)
         {
            _roomEvents.windowManager.alert("Update failed",_loc1_,0,null);
            return;
         }
         if(var_1645 as class_1701 != null)
         {
            _roomEvents.send(new UpdateTriggerMessageComposer(var_1645.id,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),resolveFurniSources(),resolveUserSources()));
         }
         else if(var_1645 as class_1702 != null)
         {
            _roomEvents.send(new UpdateActionMessageComposer(var_1645.id,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),getActionDelay(),resolveFurniSources(),resolveUserSources()));
         }
         else if(var_1645 as class_1660 != null)
         {
            _roomEvents.send(new UpdateConditionMessageComposer(var_1645.id,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),resolveQuantifier(),resolveFurniSources(),resolveUserSources()));
         }
         else if(var_1645 as class_1747 != null)
         {
            _roomEvents.send(new UpdateAddonMessageComposer(var_1645.id,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),resolveFurniSources(),resolveUserSources()));
         }
         else if(var_1645 as SelectorDefinition != null)
         {
            _roomEvents.send(new UpdateSelectorMessageComposer(var_1645.id,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),resolveFilterField(),resolveInverseField(),resolveFurniSources(),resolveUserSources()));
         }
         else if(var_1645 as class_1737 != null)
         {
            _roomEvents.send(new UpdateVariableMessageComposer(var_1645.id,resolveIntParams(),resolveVariableIds(),resolveStringParam(),getStuffIds(),resolveFurniSources(),resolveUserSources()));
         }
      }
      
      public function getActionDelay() : int
      {
         var _loc1_:ActionType = ActionType(this.resolveType());
         return _loc1_.allowDelaying ? var_3535.getValue() : 0;
      }
      
      private function onHelp(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _help.open(_window.x + _window.width + var_2036,_window.y);
      }
      
      private function onApplySnapshot(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _roomEvents.send(new ApplySnapshotMessageComposer(var_1645.id));
      }
      
      private function onViewInMenu(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:class_3532 = resolveType() as class_3532;
         if(_loc3_ == null || _loc3_.initialVariableName.length == 0)
         {
            return;
         }
         _roomEvents.context.createLinkEvent("wiredmenu/open/variable_overview/" + _loc3_.initialVariableName);
      }
      
      private function resolveIntParams() : Array
      {
         var _loc1_:class_3531 = resolveType();
         return _loc1_.readIntParamsFromForm();
      }
      
      private function resolveVariableIds() : Array
      {
         var _loc1_:class_3531 = resolveType();
         return _loc1_.readVariableIdsFromForm();
      }
      
      private function resolveStringParam() : String
      {
         var _loc1_:class_3531 = resolveType();
         return _loc1_.readStringParamFromForm();
      }
      
      private function resolveFurniSources() : Array
      {
         return var_1645.furniSourceTypes;
      }
      
      private function resolveUserSources() : Array
      {
         return var_1645.userSourceTypes;
      }
      
      public function getStuffIds() : Array
      {
         var _loc2_:Array = [];
         for(var _loc1_ in var_1921)
         {
            _loc2_.push(int(_loc1_));
         }
         return _loc2_;
      }
      
      public function resolveQuantifier() : int
      {
         var _loc2_:class_1660 = var_1645 as class_1660;
         var _loc1_:Boolean = _loc2_ != null && _loc2_.quantifierType != 0;
         if(!_loc1_)
         {
            return 0;
         }
         return getQuantifierSelector().getSelected().id;
      }
      
      public function resolveFilterField() : Boolean
      {
         return getFilterInput().isSelected;
      }
      
      public function resolveInverseField() : Boolean
      {
         return getInverseInput().isSelected;
      }
      
      public function refresh() : void
      {
         _configureContainer.visible = false;
         refreshConfigureElement(var_4176);
         refreshConfigureElement(var_3971);
         refreshConfigureElement(var_4161);
         refreshConfigureElement(var_3985);
         refreshConfigureElement(var_4075);
         refreshConfigureElement(var_4136);
         _window.visible = true;
         _window.activate();
      }
      
      private function refreshConfigureElement(param1:class_3547) : void
      {
         if(!param1.acceptTriggerable(var_1645))
         {
            return;
         }
         _configureContainer.visible = true;
         var _loc2_:class_3531 = resolveType();
         refreshHeader(_loc2_,param1.getKey());
         refreshCustomInputs();
         refreshSelectFurni();
         find(_configureContainer,"warning_container").visible = false;
         refreshActionInputs();
         refreshSelectorOptions();
         refreshQuantifier();
         refreshInputSources();
         refreshAdvancedSettings();
         refreshWindowHeight();
      }
      
      public function refreshWindowHeight() : void
      {
         Util.moveAllChildrenToColumn(_configureContainer,3,var_2036);
         if(getFurniSourcesCont().height > 0 || getUserSourcesCont().height > 0 || getMergedSourcesCont().height > 0)
         {
            getFooter().y = getFooter().y - var_2036;
         }
         _configureContainer.height = Util.getLowestPoint(_configureContainer) + 1;
         _window.content.height = Util.getLowestPoint(_window.content);
      }
      
      private function getElementName(param1:int) : String
      {
         var _loc2_:class_3365 = _roomEvents.sessionDataManager.getFloorItemData(param1);
         if(_loc2_ == null)
         {
            class_14.log("COULD NOT FIND FURNIDATA FOR " + param1);
            return "NAME: " + param1;
         }
         return _loc2_.localizedName;
      }
      
      private function getElementDesc(param1:int) : String
      {
         var _loc2_:class_3365 = _roomEvents.sessionDataManager.getFloorItemData(param1);
         if(_loc2_ == null)
         {
            class_14.log("COULD NOT FIND FURNIDATA FOR " + param1);
            return "NAME: " + param1;
         }
         return _loc2_.description;
      }
      
      private function setText(param1:IWindowContainer, param2:String, param3:String) : void
      {
         var _loc4_:ITextWindow;
         (_loc4_ = ITextWindow(find(param1,param2))).caption = param3;
         _loc4_.height = _loc4_.textHeight + 6;
      }
      
      private function displayIcon(param1:class_3531, param2:String) : void
      {
         var _loc4_:DefaultAddonType;
         if((_loc4_ = param1 as DefaultAddonType) != null && _loc4_.isFilter)
         {
            param2 = "selector";
         }
         var _loc3_:String = param2 + "_icon_bitmap";
         for each(var _loc5_ in var_3551)
         {
            find(_configureContainer,_loc5_).visible = _loc3_ == _loc5_;
         }
      }
      
      private function refreshHeader(param1:class_3531, param2:String) : void
      {
         var _loc9_:IWindowContainer = IWindowContainer(find(_configureContainer,"header_container"));
         displayIcon(param1,param2);
         setText(_loc9_,"conf_name_txt",getElementName(var_1645.stuffTypeId));
         setText(_loc9_,"conf_desc_txt",getElementDesc(var_1645.stuffTypeId));
         var _loc5_:IWindow = find(_loc9_,"conf_name_txt");
         var _loc3_:IWindow = find(_loc9_,"conf_desc_txt");
         _loc3_.y = _loc5_.y + _loc5_.height;
         var _loc10_:class_3531 = this.resolveType();
         var _loc6_:IWindow;
         (_loc6_ = find(_loc9_,"apply_snapshot_txt")).visible = _loc10_.hasStateSnapshot;
         var _loc4_:IWindow = find(_loc9_,"view_in_menu_txt");
         var _loc7_:class_3532 = param1 as class_3532;
         _loc4_.visible = _roomEvents.wiredMenu.isEnabled && _loc7_ != null && _loc7_.initialVariableName.length > 0;
         var _loc8_:IWindow;
         (_loc8_ = find(_loc9_,"link_container")).visible = _loc6_.visible || _loc4_.visible;
         _loc8_.y = _loc3_.y + _loc3_.height;
         _loc9_.height = Util.getLowestPoint(_loc9_) + 4;
      }
      
      private function refreshActionInputs() : void
      {
         var _loc1_:IWindowContainer = IWindowContainer(find(_configureContainer,"action_inputs_container"));
         if(var_1645 as class_1702 == null)
         {
            _loc1_.visible = false;
            return;
         }
         var _loc2_:ActionType = ActionType(this.resolveType());
         if(!_loc2_.allowDelaying)
         {
            _loc1_.visible = false;
            return;
         }
         _loc1_.visible = true;
      }
      
      private function refreshWarning(param1:String, param2:String) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(find(_configureContainer,"warning_container"));
         setText(_loc3_,"caption_txt",param1);
         setText(_loc3_,"desc_txt",param2);
         var _loc4_:IWindow = find(_loc3_,"caption_txt");
         find(_loc3_,"desc_txt").y = _loc4_.y + _loc4_.height;
         _loc3_.height = Util.getLowestPoint(_loc3_) + 4;
         find(_configureContainer,"warning_container").visible = true;
      }
      
      private function refreshCustomInputs() : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(_configureContainer.findChildByName("custom_inputs_container"));
         var _loc1_:IWindowContainer = getAdvancedCustomInputs();
         Util.hideChildren(_loc2_);
         Util.hideChildren(_loc1_);
         var _loc3_:Object = prepareCustomInput();
         if(_loc3_.special != null)
         {
            _loc3_.special.visible = true;
         }
         if(_loc3_.advanced != null)
         {
            _loc3_.advanced.visible = true;
         }
         updateInputsHeights();
      }
      
      public function updateInputsHeights() : void
      {
         var _loc2_:IWindowContainer = IWindowContainer(_configureContainer.findChildByName("custom_inputs_container"));
         var _loc1_:IWindowContainer = getAdvancedCustomInputs();
         _loc2_.height = Util.getLowestPoint(_loc2_);
         _loc1_.height = Util.getLowestPoint(_loc1_);
      }
      
      private function prepareCustomInput() : Object
      {
         var _loc4_:class_3547 = resolveHolder();
         var _loc6_:class_3531 = resolveType();
         var _loc3_:IWindowContainer = IWindowContainer(_configureContainer.findChildByName("custom_inputs_container"));
         var _loc1_:IWindowContainer = getAdvancedCustomInputs();
         var _loc7_:String = _loc4_.getKey() + _loc6_.code;
         var _loc2_:IWindowContainer = IWindowContainer(_loc3_.getChildByName(_loc7_));
         if(_loc2_ == null)
         {
            _loc2_ = createCustomInputs(_loc4_,_loc6_,_loc7_,false,_loc3_);
         }
         var _loc5_:IWindowContainer;
         if((_loc5_ = IWindowContainer(_loc1_.getChildByName(_loc7_))) == null)
         {
            _loc5_ = createCustomInputs(_loc4_,_loc6_,_loc7_,true,_loc1_);
         }
         if(!_loc6_.isInitialized())
         {
            _loc6_.onInit(_loc2_,_loc5_,_roomEvents);
         }
         return {
            "special":_loc2_,
            "advanced":_loc5_
         };
      }
      
      private function createCustomInputs(param1:class_3547, param2:class_3531, param3:String, param4:Boolean, param5:IWindowContainer) : IWindowContainer
      {
         var _loc7_:IWindowContainer = null;
         var _loc9_:String = null;
         var _loc8_:WiredUIBuilder = null;
         var _loc6_:int;
         if((_loc6_ = param4 ? param2.advancedInputMode : param2.inputMode) == DefaultElement.INPUTS_TYPE_NONE)
         {
            return null;
         }
         if(_loc6_ == DefaultElement.INPUTS_TYPE_LEGACY_UI)
         {
            _loc9_ = "ude_" + param1.getKey() + "_inputs_" + param2.code;
            if(param4)
            {
               _loc9_ += "_advanced";
            }
            _loc7_ = IWindowContainer(_roomEvents.getXmlWindow(_loc9_));
            param5.addChild(_loc7_);
         }
         else if(_loc6_ == DefaultElement.INPUTS_TYPE_UI_BUILDER)
         {
            param2.setRoomEvents(_roomEvents);
            _loc8_ = new WiredUIBuilder(_roomEvents);
            if(param4)
            {
               param2.buildAdvancedInputs(presetManager,wiredStyle,_loc8_);
            }
            else
            {
               param2.buildInputs(presetManager,wiredStyle,_loc8_);
            }
            _loc7_ = _loc8_.container;
            param5.addChild(_loc7_);
            _loc8_.initializeWidth();
         }
         _loc7_.name = param3;
         return _loc7_;
      }
      
      private function refreshSelectFurni() : void
      {
         var _loc1_:IWindowContainer = IWindowContainer(_configureContainer.findChildByName("select_furni_container"));
         if(!isStuffSelectionMode() || hidePickFurniInstructions)
         {
            _loc1_.visible = false;
            return;
         }
         _loc1_.visible = true;
         var _loc2_:IWindow = _loc1_.findChildByName("furni_name_txt");
         var _loc4_:int = int(this.getStuffIds().length);
         var _loc3_:int = var_1645.furniLimit;
         _roomEvents.localization.registerParameter("wiredfurni.pickfurnis.caption","count","" + _loc4_);
         _roomEvents.localization.registerParameter("wiredfurni.pickfurnis.caption","limit","" + _loc3_);
         _loc1_.height = Util.getLowestPoint(_loc1_) + var_2036;
      }
      
      private function isOwner(param1:int) : Boolean
      {
         var _loc4_:IRoomObject;
         if((_loc4_ = _roomEvents.roomEngine.getRoomObject(_roomEvents.roomId,param1,10)) == null)
         {
            return false;
         }
         var _loc3_:IRoomObjectModel = _loc4_.getModel();
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:Number = Number(_loc4_.getModel().getNumber("furniture_owner_id"));
         return _loc2_ == _roomEvents.sessionDataManager.userId;
      }
      
      public function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
      {
         var _loc2_:class_3531 = resolveType();
         if(_loc2_ != null)
         {
            _loc2_.onGuildMemberships(param1);
         }
      }
      
      private function refreshSelectorOptions() : void
      {
         var _loc2_:SelectorDefinition = var_1645 as SelectorDefinition;
         var _loc1_:* = _loc2_ != null;
         getSelectorOptionsContainer().visible = _loc1_;
         if(_loc1_)
         {
            select(getFilterInput(),_loc2_.isFilter);
            select(getInverseInput(),_loc2_.isInvert);
         }
      }
      
      private function refreshAdvancedSettings() : void
      {
         var _loc15_:IWindowContainer = getFurniSourcesCont();
         var _loc3_:IWindowContainer = getUserSourcesCont();
         var _loc10_:IWindowContainer = getMergedSourcesCont();
         var _loc5_:IWindowContainer = getAdvancedCont();
         var _loc13_:IWindowContainer = getQuantifierContainer();
         var _loc14_:IWindowContainer = getAdvancedCustomInputs();
         var _loc11_:IWindow = getAdvancedCollapser();
         var _loc4_:InputSourcesConf;
         var _loc1_:* = (_loc4_ = var_1645.inputSourcesConf).amountFurniSelections > 0;
         var _loc12_:* = _loc4_.amountUserSelections > 0;
         var _loc16_:* = resolveType().mergedSelections().length > 0;
         var _loc7_:class_1660;
         var _loc6_:Boolean = (_loc7_ = var_1645 as class_1660) != null && _loc7_.quantifierType != 0;
         var _loc2_:* = resolveType().advancedInputMode != DefaultElement.INPUTS_TYPE_NONE;
         var _loc9_:Boolean = var_1645.advancedMode && (_loc1_ || _loc12_ || _loc6_ || _loc2_);
         _loc5_.visible = _loc9_;
         var _loc8_:Boolean = _loc9_ && _advancedModeExpanded;
         getSourcesSpacing().visible = _loc8_;
         _loc15_.visible = _loc1_ && _loc8_;
         _loc3_.visible = _loc12_ && _loc8_;
         _loc10_.visible = _loc16_ && _loc8_;
         _loc13_.visible = _loc6_ && _loc8_;
         _loc14_.visible = _loc2_ && _loc8_;
         var _loc18_:String = _advancedModeExpanded ? "wiredfurni.params.sources.collapse" : "wiredfurni.params.sources.expand";
         var _loc17_:String = String(_roomEvents.localization.getLocalization(_loc18_,_loc18_));
         getAdvancedCollapser().caption = _loc17_;
         _loc11_.visible = !resolveType().advancedAlwaysVisible();
         Util.moveAllChildrenToColumn(_loc15_,0,0);
         Util.moveAllChildrenToColumn(_loc3_,0,0);
         Util.moveAllChildrenToColumn(_loc10_,0,0);
         _loc15_.height = Util.getLowestPoint(_loc15_);
         _loc3_.height = Util.getLowestPoint(_loc3_);
         _loc10_.height = Util.getLowestPoint(_loc10_);
         Util.moveAllChildrenToColumn(_loc5_,_loc11_.visible ? var_2036 : 0,0);
         _loc11_.y = 0;
         _loc5_.height = Math.max(getAdvancedCollapser().height + var_2036,Util.getLowestPoint(_loc5_));
      }
      
      private function refreshQuantifier() : void
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc8_:String = null;
         var _loc2_:int = 0;
         var _loc6_:String = null;
         var _loc1_:String = null;
         var _loc7_:class_1660;
         var _loc3_:Boolean = (_loc7_ = var_1645 as class_1660) != null && _loc7_.quantifierType != class_3620.var_4958;
         if(_loc3_)
         {
            _loc4_ = _loc7_.quantifierType;
            getQuantifierSelector().setSelected(getQuantifierRadio(_loc7_.quantifierCode));
            _loc5_ = "wiredfurni.params.quantifier.";
            _loc8_ = (_loc8_ = _loc4_ == class_3620.var_4931 ? "furni" : (_loc4_ == class_3620.var_4939 ? "users" : (_loc4_ == class_3620.var_4968 ? "variables" : ""))) + (_loc7_.isInvert ? ".neg." : ".");
            _loc2_ = 0;
            while(_loc2_ < 2)
            {
               _loc6_ = _loc5_ + _loc8_ + _loc2_;
               _loc1_ = String(_roomEvents.localization.getLocalization(_loc6_,_loc6_));
               getQuantifierText(_loc2_).caption = _loc1_;
               _loc2_++;
            }
         }
      }
      
      private function refreshInputSources() : void
      {
         var _loc9_:int = 0;
         var _loc10_:WiredInputSourcePicker = null;
         var _loc4_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:IWindowContainer = getFurniSourcesCont();
         var _loc2_:IWindowContainer = getUserSourcesCont();
         var _loc1_:IWindowContainer = getMergedSourcesCont();
         Util.hideChildren(_loc5_,true);
         Util.hideChildren(_loc2_,true);
         Util.hideChildren(_loc1_,true);
         var _loc3_:InputSourcesConf = var_1645.inputSourcesConf;
         var _loc11_:class_3531 = resolveType();
         _loc9_ = 0;
         while(_loc9_ < _loc3_.amountFurniSelections)
         {
            if(_loc9_ >= _furniSourcePickers.length)
            {
               _loc10_ = new WiredInputSourcePicker(_roomEvents,WiredInputSourcePicker.var_1736,_loc9_);
               _furniSourcePickers.push(_loc10_);
               _loc5_.addChild(_loc10_.container);
            }
            else
            {
               _loc10_ = _furniSourcePickers[_loc9_];
            }
            _loc10_.visible = true;
            _loc10_.refreshContainer(var_1645,_loc11_);
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc3_.amountUserSelections)
         {
            if(_loc9_ >= _userSourcePickers.length)
            {
               _loc10_ = new WiredInputSourcePicker(_roomEvents,WiredInputSourcePicker.USER_SOURCE,_loc9_);
               _userSourcePickers.push(_loc10_);
               _loc2_.addChild(_loc10_.container);
            }
            else
            {
               _loc10_ = _userSourcePickers[_loc9_];
            }
            _loc10_.visible = true;
            _loc10_.refreshContainer(var_1645,_loc11_);
            _loc9_++;
         }
         var _loc8_:Array = resolveType().mergedSelections();
         _loc9_ = 0;
         while(_loc9_ < _loc8_.length)
         {
            if(_loc9_ >= _mergedSourcePickers.length)
            {
               _loc10_ = new WiredInputSourcePicker(_roomEvents,WiredInputSourcePicker.MERGED_SOURCE,_loc9_);
               _mergedSourcePickers.push(_loc10_);
               _loc1_.addChild(_loc10_.container);
            }
            else
            {
               _loc10_ = _mergedSourcePickers[_loc9_];
            }
            _loc10_.visible = true;
            _loc6_ = int((_loc4_ = _loc8_[_loc9_])[0]);
            _loc7_ = int(_loc4_[1]);
            _furniSourcePickers[_loc6_].visible = false;
            _userSourcePickers[_loc7_].visible = false;
            _loc10_.refreshContainer(var_1645,_loc11_);
            _loc9_++;
         }
      }
      
      public function updateSourceContainer(param1:int, param2:int) : void
      {
         var _loc3_:* = undefined;
         if(param1 == WiredInputSourcePicker.var_1736)
         {
            _loc3_ = _furniSourcePickers;
         }
         else if(param1 == WiredInputSourcePicker.USER_SOURCE)
         {
            _loc3_ = _userSourcePickers;
         }
         else
         {
            _loc3_ = _mergedSourcePickers;
         }
         if(param2 >= _loc3_.length)
         {
            return;
         }
         _loc3_[param2].refreshContainer(var_1645,resolveType());
      }
      
      private function onAdvancedModeToggle(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _advancedModeExpanded = !_advancedModeExpanded;
         refreshAdvancedSettings();
         refreshWindowHeight();
      }
      
      private function getAdvancedCollapser() : IWindow
      {
         return _configureContainer.findChildByName("advanced_collapser");
      }
      
      private function getFurniSourcesCont() : IWindowContainer
      {
         return _configureContainer.findChildByName("furni_sources_container") as IWindowContainer;
      }
      
      private function getUserSourcesCont() : IWindowContainer
      {
         return _configureContainer.findChildByName("user_sources_container") as IWindowContainer;
      }
      
      private function getMergedSourcesCont() : IWindowContainer
      {
         return _configureContainer.findChildByName("merged_sources_container") as IWindowContainer;
      }
      
      private function getAdvancedCont() : IWindowContainer
      {
         return _configureContainer.findChildByName("advanced_container") as IWindowContainer;
      }
      
      private function getSourcesSpacing() : IWindowContainer
      {
         return _configureContainer.findChildByName("sources_spacing") as IWindowContainer;
      }
      
      private function getFooter() : IWindowContainer
      {
         return _configureContainer.findChildByName("configure_footer") as IWindowContainer;
      }
      
      private function getQuantifierRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_configureContainer.findChildByName("quantifier_" + param1 + "_radio"));
      }
      
      private function getQuantifierText(param1:int) : IWindow
      {
         return _configureContainer.findChildByName("quantifier_" + param1 + "_text");
      }
      
      private function getQuantifierSelector() : ISelectorWindow
      {
         return ISelectorWindow(_configureContainer.findChildByName("quantifier_selector"));
      }
      
      private function getQuantifierContainer() : IWindowContainer
      {
         return _configureContainer.findChildByName("condition_options_container") as IWindowContainer;
      }
      
      private function getAdvancedCustomInputs() : IWindowContainer
      {
         return _configureContainer.findChildByName("advanced_custom_inputs_container") as IWindowContainer;
      }
      
      private function getSelectorOptionsContainer() : IWindowContainer
      {
         return _configureContainer.findChildByName("selector_options_container") as IWindowContainer;
      }
      
      private function getFilterInput() : class_3398
      {
         return class_3398(_configureContainer.findChildByName("filter_checkbox"));
      }
      
      private function getInverseInput() : class_3398
      {
         return class_3398(_configureContainer.findChildByName("inverse_checkbox"));
      }
      
      public function get mergedSourcePickers() : Vector.<WiredInputSourcePicker>
      {
         return _mergedSourcePickers;
      }
      
      public function get wiredStyle() : WiredStyle
      {
         return var_3450;
      }
      
      public function get presetManager() : PresetManager
      {
         return var_4162;
      }
   }
}
