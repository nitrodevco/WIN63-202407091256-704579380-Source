package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class class_3677 extends DefaultActionType
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2973:SliderWindowController;
      
      public function class_3677()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3849.MOVE_FURNI_TO;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getDirectionSelector(cont).getSelected().id);
         _loc1_.push(int(var_2973.getValue()));
         return _loc1_;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_2973 = new SliderWindowController(param3,getInput(param1),param3.assets,1,5,1);
         var_2973.setValue(1);
         var_2973.addEventListener("change",onSliderChange);
         param3.refreshButton(param1,"move_0",true,null,0);
         param3.refreshButton(param1,"move_2",true,null,0);
         param3.refreshButton(param1,"move_4",true,null,0);
         param3.refreshButton(param1,"move_6",true,null,0);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         getDirectionSelector(cont).setSelected(getDirectionRadio(cont,_loc2_));
         var_2973.setValue(param1.intParams[1]);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:IWindowContainer) : IWindowContainer
      {
         return param1.findChildByName("slider_container") as IWindowContainer;
      }
      
      private function onSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc4_:Number = NaN;
         var _loc3_:int = 0;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc4_ = _loc2_.getValue();
               _roomEvents.localization.registerParameter("wiredfurni.params.emptytiles","tiles","" + _loc3_);
            }
         }
      }
      
      private function getDirectionRadio(param1:IWindowContainer, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("direction_" + param2 + "_radio"));
      }
      
      private function getDirectionSelector(param1:IWindowContainer) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("direction_selector"));
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv." + param1;
      }
   }
}
