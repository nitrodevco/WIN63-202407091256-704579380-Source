package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.common.VariablePicker;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.SharedVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.SharedVariableList;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.class_1791;
   
   public class ReferenceVariable extends DefaultVariableType
   {
       
      
      private var _cont:IWindowContainer;
      
      private var var_2631:VariablePicker;
      
      private var var_2915:WiredVariable;
      
      private var var_3812:int;
      
      private var _rooms:Vector.<Object>;
      
      private var var_4014:Dictionary;
      
      private var var_3784:Boolean = false;
      
      public function ReferenceVariable()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3838.REFERENCE_VARIABLE;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         var_2631 = new VariablePicker(param3,variableMenu,variableVisibilityFilter,onVariableSelected);
         var_2915 = null;
         roomMenu.addEventListener("WE_SELECTED",onRoomSelect);
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_2631.selectedVariableId];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(!!readOnlyCheckbox.isSelected ? 1 : 0);
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         var_3784 = false;
         var _loc4_:Number = Number(param1.variableIds[0]);
         var _loc3_:* = param1.intParams[0] != 0;
         Util.select(readOnlyCheckbox,_loc3_);
         initRooms(_loc4_,param1);
         var _loc2_:SharedVariableList = param1.wiredContext.referenceVariablesList;
         var_2631.init(_loc2_ == null ? class_1791.EMPTY : _loc2_,_loc4_,VariablePicker.UNSPECIFIED_TYPE);
         var_2915 = var_2631.selectedVariable;
         initialVariableName = param1.stringParam;
         var_3784 = true;
         editable = _loc2_ != null;
      }
      
      private function set editable(param1:Boolean) : void
      {
         if(param1)
         {
            variableMenu.enable();
            roomMenu.enable();
            readOnlyCheckbox.enable();
            variableNameTxt.enable();
         }
         else
         {
            variableMenu.disable();
            roomMenu.disable();
            readOnlyCheckbox.disable();
            variableNameTxt.disable();
         }
         var _loc2_:Number = param1 ? 1 : 0.5;
         variableMenu.blend = _loc2_;
         roomMenu.blend = _loc2_;
         readOnlyCheckbox.blend = _loc2_;
      }
      
      private function initRooms(param1:int, param2:class_1659) : void
      {
         var room:Object;
         var sharedVariable:SharedVariable;
         var roomNames:Vector.<String>;
         var i:int;
         var variableId:int = param1;
         var updated:class_1659 = param2;
         var_4014 = new Dictionary();
         _rooms = new Vector.<Object>();
         var selectedRoom:Object = null;
         var roomMap:Dictionary = new Dictionary();
         var selectRoomIndex:int = -1;
         var context:SharedVariableList = updated.wiredContext.referenceVariablesList;
         if(context != null)
         {
            for each(sharedVariable in context.sharedVariables)
            {
               if(!(sharedVariable.roomId in roomMap))
               {
                  room = {
                     "id":sharedVariable.roomId,
                     "name":sharedVariable.roomName
                  };
                  roomMap[sharedVariable.roomId] = room;
                  _rooms.push(room);
               }
               else
               {
                  room = roomMap[sharedVariable.roomId];
               }
               var_4014[sharedVariable.wiredVariable] = room;
               if(sharedVariable.wiredVariable.variableId == variableId)
               {
                  selectedRoom = room;
               }
            }
            _rooms.sort(function(param1:Object, param2:Object):int
            {
               return param1.name.localeCompare(param2.name);
            });
            roomNames = new Vector.<String>();
            i = 0;
            while(i < _rooms.length)
            {
               room = _rooms[i];
               roomNames.push(room.name);
               if(room == selectedRoom)
               {
                  selectRoomIndex = i;
               }
               i += 1;
            }
            roomMenu.populateWithVector(roomNames);
            roomMenu.selection = selectRoomIndex;
         }
         var_3812 = selectRoomIndex;
      }
      
      override public function readStringParamFromForm() : String
      {
         return String(variableNameTxt.text);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function get variableMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_variables"));
      }
      
      private function get roomMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_room"));
      }
      
      private function get readOnlyCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("read_only_checkbox"));
      }
      
      private function onRoomSelect(param1:WindowEvent) : void
      {
         if(var_3812 != roomMenu.selection && var_3784)
         {
            var_2631.reload(0);
            onVariableSelected(null);
         }
         var_3812 = roomMenu.selection;
      }
      
      private function variableVisibilityFilter(param1:WiredVariable) : Boolean
      {
         var _loc2_:int = roomMenu.selection;
         if(_loc2_ < 0 || _loc2_ >= _rooms.length)
         {
            return false;
         }
         var _loc3_:Object = _rooms[_loc2_];
         return var_4014[param1] == _loc3_;
      }
      
      private function onVariableSelected(param1:WiredVariable) : void
      {
         if(variableNameTxt.text.length == 0 || var_2915 != null && var_2915.variableName == variableNameTxt.text)
         {
            variableNameTxt.text = param1 == null ? "" : param1.variableName;
         }
         var_2915 = param1;
      }
   }
}
