package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.common.VariablePicker;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class VariableUpdate extends DefaultTriggerConf
   {
       
      
      private var _cont:IWindowContainer;
      
      private var var_2631:VariablePicker;
      
      public function VariableUpdate()
      {
         super();
      }
      
      private static function enableCheckbox(param1:class_3398, param2:Boolean) : void
      {
         var _loc3_:ITextWindow = ITextWindow(IWindowContainer(param1.parent).getChildByName("checkbox_txt"));
         if(param2)
         {
            param1.enable();
            _loc3_.enable();
            param1.color = 16777215;
            _loc3_.textColor = 16777215;
         }
         else
         {
            param1.disable();
            _loc3_.disable();
            param1.color = 10066329;
            _loc3_.textColor = 10066329;
            param1.unselect();
         }
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.canInterceptChanges;
      }
      
      override public function get code() : int
      {
         return class_3782.VARIABLE_UPDATE;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         var_2631 = new VariablePicker(param3,variableMenu,variableSelectionFilter,onChangeVariable);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:Number = Number(param1.variableIds[0]);
         var_2631.init(param1.wiredContext.roomVariablesList,_loc2_,VariablePicker.UNSPECIFIED_TYPE);
         onChangeVariable(var_2631.selectedVariable);
         Util.select(createdCheckbox,param1.getBoolean(0));
         Util.select(changedCheckbox,param1.getBoolean(1));
         Util.select(deletedCheckbox,param1.getBoolean(2));
      }
      
      private function onChangeVariable(param1:WiredVariable) : void
      {
         var _loc2_:Boolean = param1 == null || param1.canCreateAndDelete;
         var _loc3_:Boolean = param1 == null || param1.hasValue;
         enableCheckbox(createdCheckbox,_loc2_);
         enableCheckbox(changedCheckbox,_loc3_);
         enableCheckbox(deletedCheckbox,_loc2_);
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_2631.selectedVariableId];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(!!createdCheckbox.isSelected ? 1 : 0);
         _loc1_.push(!!changedCheckbox.isSelected ? 1 : 0);
         _loc1_.push(!!deletedCheckbox.isSelected ? 1 : 0);
         return _loc1_;
      }
      
      private function get variableMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_variables"));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function get createdCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("created_checkbox"));
      }
      
      private function get changedCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("changed_checkbox"));
      }
      
      private function get deletedCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("deleted_checkbox"));
      }
   }
}
