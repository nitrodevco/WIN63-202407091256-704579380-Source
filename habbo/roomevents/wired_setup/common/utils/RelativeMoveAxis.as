package com.sulake.habbo.roomevents.wired_setup.common.utils
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class RelativeMoveAxis
   {
       
      
      private var _name:String;
      
      private var _cont:IWindowContainer;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2973:SliderWindowController;
      
      public function RelativeMoveAxis(param1:String, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents)
      {
         super();
         _name = param1;
         _cont = param2.getChildByName(param1 + "_selection") as IWindowContainer;
         _roomEvents = param3;
         initializeSlider();
      }
      
      public function getValue() : int
      {
         var _loc1_:int = var_2973.getValue();
         if(getRadioSelector().getSelected() == getNegativeRadio())
         {
            _loc1_ = -_loc1_;
         }
         return _loc1_;
      }
      
      public function setValue(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = -param1;
            getNegativeRadio().select();
         }
         else
         {
            getPositiveRadio().select();
         }
         var_2973.setValue(param1);
      }
      
      private function initializeSlider() : void
      {
         var_2973 = new SliderWindowController(_roomEvents,getSliderContainer(),_roomEvents.assets,0,20,1);
         var_2973.setValue(0);
         var_2973.addEventListener("change",onDistanceChange);
      }
      
      private function getRadioSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("move_selector"));
      }
      
      private function getPositiveRadio() : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("move_0_radio"));
      }
      
      private function getNegativeRadio() : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("move_1_radio"));
      }
      
      private function getSliderContainer() : IWindowContainer
      {
         return _cont.findChildByName("slider_container_length") as IWindowContainer;
      }
      
      private function onDistanceChange(param1:Event) : void
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
               _roomEvents.localization.registerParameter("wiredfurni.params.movement." + _name + ".distance","distance","" + _loc3_);
            }
         }
      }
   }
}
