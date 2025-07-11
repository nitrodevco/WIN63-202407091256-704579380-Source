package com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown
{
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   
   public class ExpandableDropdown
   {
       
      
      private var _dropdown:class_3520;
      
      private var _onChangeCallback:Function;
      
      private var _advancedVisible:Boolean = false;
      
      private var var_3058:Boolean = false;
      
      private var var_2604:Number = 0;
      
      private var var_752:Vector.<ExpandableDropdownOption>;
      
      private var var_4535:String;
      
      private var var_2676:Vector.<ExpandableDropdownOption>;
      
      public function ExpandableDropdown(param1:class_3520, param2:String, param3:Function = null)
      {
         var_752 = new Vector.<ExpandableDropdownOption>();
         var_2676 = new Vector.<ExpandableDropdownOption>();
         super();
         _dropdown = param1;
         var_4535 = param2;
         _onChangeCallback = param3;
         _dropdown.addEventListener("WE_SELECTED",onSelectAction);
         _dropdown.addEventListener("WE_COLLAPSE",onDropdownCollapse);
      }
      
      public function init(param1:Vector.<ExpandableDropdownOption>, param2:int) : void
      {
         var_752 = param1;
         var_3058 = false;
         _advancedVisible = false;
         var_2604 = 0;
         populate(param2);
      }
      
      private function populate(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = -1;
         var_2676.splice(0,var_2676.length);
         var _loc4_:Vector.<String> = new Vector.<String>();
         for each(var _loc5_ in var_752)
         {
            if(param1 == _loc5_.id)
            {
               _loc3_ = int(var_2676.length);
               if(_loc5_.isAdvanced && !param2)
               {
                  _advancedVisible = true;
                  populate(param1,true);
                  return;
               }
            }
            if(!_loc5_.isAdvanced || param2)
            {
               var_2676.push(_loc5_);
               _loc4_.push(_loc5_.displayString);
            }
         }
         if(advancedOptionsAvailable && !param2)
         {
            _loc4_.push(var_4535);
         }
         var_3058 = true;
         _dropdown.populateWithVector(_loc4_);
         if(_loc3_ != -1)
         {
            _dropdown.selection = _loc3_;
            var_2604 = param1;
         }
         else
         {
            var_2604 = -1;
         }
      }
      
      private function get advancedOptionsAvailable() : Boolean
      {
         for each(var _loc1_ in var_752)
         {
            if(_loc1_.isAdvanced)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onSelectAction(param1:WindowEvent) : void
      {
         if(_dropdown.selection >= var_2676.length)
         {
            _advancedVisible = true;
            populate(var_2604,true);
            _dropdown.openMenu();
            return;
         }
         var_2604 = selectedOptionId;
         if(_onChangeCallback != null)
         {
            _onChangeCallback(selectedOption);
         }
      }
      
      private function onDropdownCollapse(param1:WindowEvent) : void
      {
         if(var_3058)
         {
            var_3058 = false;
            return;
         }
         if(_advancedVisible && (selectedOption == null || !selectedOption.isAdvanced))
         {
            _advancedVisible = false;
            populate(selectedOptionId,false);
         }
      }
      
      public function get selectedOption() : ExpandableDropdownOption
      {
         var _loc1_:Number = _dropdown.selection;
         if(_loc1_ < 0 || _loc1_ >= var_2676.length)
         {
            return null;
         }
         return var_2676[_loc1_];
      }
      
      public function get selectedOptionId() : Number
      {
         return selectedOption == null ? -1 : selectedOption.id;
      }
   }
}
