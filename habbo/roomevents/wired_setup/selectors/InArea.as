package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.room.IRoomAreaSelectionManager;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   
   public class InArea extends DefaultSelectorType
   {
       
      
      private var var_1660:HabboUserDefinedRoomEvents;
      
      private var _cont:IWindowContainer;
      
      private var var_2309:IRoomAreaSelectionManager;
      
      private var var_797:int;
      
      private var var_1094:int;
      
      private var _width:int;
      
      private var var_46:int;
      
      private var var_2219:Boolean = false;
      
      public function InArea()
      {
         super();
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var_1660 = param3;
         _cont = param1;
         var_2309 = var_1660.roomEngine.areaSelectionManager;
         Util.setProcDirectly(getSelectButton(),onSelect);
         Util.setProcDirectly(getClearButton(),onClear);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         if(!var_2219)
         {
            var_2219 = var_2309.activate(onAreaSelected,"highlight_brighten");
         }
         var_797 = param1.intParams[0];
         var_1094 = param1.intParams[1];
         _width = param1.intParams[2];
         var_46 = param1.intParams[3];
         if(var_2219)
         {
            var_2309.setHighlight(var_797,var_1094,_width,var_46);
            getSelectButton().enable();
            getClearButton().enable();
         }
         else
         {
            getSelectButton().disable();
            getClearButton().disable();
         }
      }
      
      override public function onEditEnd() : void
      {
         super.onEditEnd();
         if(var_2219)
         {
            var_2309.deactivate();
            var_2219 = false;
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_797);
         _loc1_.push(var_1094);
         _loc1_.push(_width);
         _loc1_.push(var_46);
         return _loc1_;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getSelectButton() : class_3357
      {
         return _cont.findChildByName("select_button") as class_3357;
      }
      
      private function getClearButton() : class_3357
      {
         return _cont.findChildByName("clear_button") as class_3357;
      }
      
      private function onSelect(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         getSelectButton().disable();
         var_2309.startSelecting();
      }
      
      private function onClear(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_2309.clearHighlight();
      }
      
      private function onAreaSelected(param1:int, param2:int, param3:int, param4:int) : void
      {
         getSelectButton().enable();
         var_797 = param1;
         var_1094 = param2;
         _width = param3;
         var_46 = param4;
      }
   }
}
