package com.sulake.habbo.roomevents.wired_setup.common
{
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.class_3556;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.class_1791;
   
   public class VariablePicker
   {
      
      public static var UNSPECIFIED_TYPE:int = 2147483647;
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2585:class_1791;
      
      private var _dropdown:class_3520;
      
      private var var_1303:int;
      
      private var var_4114:Function;
      
      private var var_2675:Vector.<WiredVariable>;
      
      private var var_3553:Function;
      
      private var var_3146:Boolean = false;
      
      private var var_2590:Boolean = false;
      
      private var var_3058:Boolean = false;
      
      private var var_2604:Number = 0;
      
      private var var_3527:Dictionary;
      
      public function VariablePicker(param1:HabboUserDefinedRoomEvents, param2:class_3520, param3:Function = null, param4:Function = null)
      {
         var_2675 = new Vector.<WiredVariable>();
         super();
         _roomEvents = param1;
         _dropdown = param2;
         var_4114 = param3;
         var_3553 = param4;
         _dropdown.addEventListener("WE_SELECTED",onSelectAction);
         _dropdown.addEventListener("WE_COLLAPSE",onDropdownCollapse);
      }
      
      public function init(param1:class_1791, param2:Number, param3:int) : void
      {
         var_2585 = param1;
         var_1303 = param3;
         var_3058 = false;
         var_3146 = false;
         var_2590 = false;
         var_2604 = 0;
         var_3527 = new Dictionary();
         var_3527[param3] = param2;
         populate(param2);
      }
      
      public function reload(param1:int) : void
      {
         init(var_2585,param1,var_1303);
      }
      
      private function populate(param1:Number, param2:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc4_:WiredVariable = null;
         var _loc6_:String = null;
         var _loc3_:int = -1;
         var_2675.splice(0,var_2675.length);
         var _loc7_:Vector.<String> = new Vector.<String>();
         var_3146 = false;
         _loc5_ = 0;
         while(_loc5_ < var_2585.variables.length)
         {
            _loc4_ = var_2585.variables[_loc5_];
            if((var_4114 == null || var_4114(_loc4_)) && _loc4_.variableName != "" && (_loc4_.variableType == var_1303 || var_1303 == UNSPECIFIED_TYPE))
            {
               if(!(_loc4_.isInvisible && param1 != _loc4_.variableId))
               {
                  if(param1 == _loc4_.variableId)
                  {
                     _loc3_ = int(var_2675.length);
                     if(_loc4_.availabilityType == class_3556.var_2975 && !param2)
                     {
                        var_2590 = true;
                        populate(param1,true);
                        return;
                     }
                  }
                  if(_loc4_.availabilityType == class_3556.var_2975)
                  {
                     var_3146 = true;
                  }
                  if(_loc4_.availabilityType != class_3556.var_2975 || param2)
                  {
                     var_2675.push(_loc4_);
                     _loc7_.push(Util.variableDisplayName(_loc4_,_roomEvents.wiredMenu.variableSyntaxMode));
                  }
               }
            }
            _loc5_++;
         }
         if(var_3146 && !param2)
         {
            _loc6_ = "wiredfurni.params.variables.show_internal";
            _loc7_.push(_roomEvents.localization.getLocalization(_loc6_,_loc6_));
         }
         var_3058 = true;
         _dropdown.populateWithVector(_loc7_);
         if(_loc3_ != -1)
         {
            _dropdown.selection = _loc3_;
            var_2604 = param1;
         }
         else
         {
            var_2604 = 0;
         }
      }
      
      private function onSelectAction(param1:WindowEvent) : void
      {
         if(_dropdown.selection >= var_2675.length)
         {
            var_2590 = true;
            populate(var_2604,true);
            _dropdown.openMenu();
            return;
         }
         var_2604 = selectedVariableId;
         if(var_3553 != null)
         {
            var_3553(selectedVariable);
         }
      }
      
      private function onDropdownCollapse(param1:WindowEvent) : void
      {
         if(var_3058)
         {
            var_3058 = false;
            return;
         }
         if(var_2590 && (selectedVariable == null || selectedVariable.availabilityType != class_3556.var_2975))
         {
            var_2590 = false;
            populate(selectedVariableId,false);
         }
      }
      
      public function set variableType(param1:int) : *
      {
         var _loc2_:Number = NaN;
         if(param1 != var_1303)
         {
            var_3527[var_1303] = selectedVariableId;
            var_1303 = param1;
            _loc2_ = 0;
            if(var_1303 in var_3527)
            {
               _loc2_ = Number(var_3527[var_1303]);
            }
            populate(_loc2_);
            if(var_3553 != null)
            {
               var_3553(selectedVariable);
            }
         }
      }
      
      public function get selectedVariable() : WiredVariable
      {
         var _loc1_:Number = _dropdown.selection;
         if(_loc1_ < 0 || _loc1_ >= var_2675.length)
         {
            return null;
         }
         return var_2675[_loc1_];
      }
      
      public function get selectedVariableId() : Number
      {
         return selectedVariable == null ? 0 : selectedVariable.variableId;
      }
   }
}
