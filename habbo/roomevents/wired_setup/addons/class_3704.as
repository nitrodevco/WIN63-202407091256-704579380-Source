package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.VariablePicker;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class class_3704 extends SelectorFilter
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _cont:IWindowContainer;
      
      private var var_2631:VariablePicker;
      
      public function class_3704()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.hasValue || param1.canReadCreationTime || param1.canReadLastUpdateTime;
      }
      
      private static function sortTypeIdFromString(param1:String) : int
      {
         var _loc2_:Array = param1.split(".");
         return parseInt(_loc2_[4]);
      }
      
      protected function get variableType() : int
      {
         return -1;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         _cont = param1;
         var_2631 = new VariablePicker(param3,variableMenu,variableSelectionFilter,initSortingDropdown);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = super.readIntParamsFromForm();
         _loc1_.push(selectedSortTypeId);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_2631.selectedVariableId];
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         var _loc3_:Number = Number(param1.variableIds[0]);
         var_2631.init(param1.wiredContext.roomVariablesList,_loc3_,variableType);
         var _loc2_:int = int(param1.intParams[1]);
         initSortingDropdown(var_2631.selectedVariable,_loc2_);
      }
      
      private function get variableMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_variables"));
      }
      
      private function initSortingDropdown(param1:WiredVariable, param2:int = -1) : void
      {
         if(param2 == -1)
         {
            param2 = selectedSortTypeId;
         }
         var _loc5_:class_3520 = sortTypeMenu;
         var _loc4_:Vector.<String> = new Vector.<String>();
         var _loc3_:String = "${wiredfurni.params.variables.sort_by.";
         if(param1 == null || param1.hasValue)
         {
            _loc4_.push(_loc3_ + "0}");
            _loc4_.push(_loc3_ + "1}");
         }
         if(param1 == null || param1.canReadCreationTime)
         {
            _loc4_.push(_loc3_ + "2}");
            _loc4_.push(_loc3_ + "3}");
         }
         if(param1 == null || param1.canReadLastUpdateTime)
         {
            _loc4_.push(_loc3_ + "4}");
            _loc4_.push(_loc3_ + "5}");
         }
         _loc5_.populateWithVector(_loc4_);
         selectedSortTypeId = param2;
      }
      
      private function get sortTypeMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_sorting"));
      }
      
      private function get selectedSortTypeId() : int
      {
         var _loc2_:Array = sortTypeMenu.enumerateSelection();
         var _loc1_:int = sortTypeMenu.selection;
         if(_loc1_ == -1)
         {
            return 0;
         }
         return sortTypeIdFromString(_loc2_[_loc1_]);
      }
      
      private function set selectedSortTypeId(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_3520;
         var _loc2_:Array = (_loc4_ = sortTypeMenu).enumerateSelection();
         var _loc5_:* = -1;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(sortTypeIdFromString(_loc2_[_loc3_]) == param1)
            {
               _loc5_ = _loc3_;
            }
            _loc3_++;
         }
         _loc4_.selection = _loc5_;
      }
   }
}
