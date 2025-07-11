package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import com.sulake.habbo.roomevents.wired_setup.triggerconfs.class_3612;
   import flash.events.Event;
   
   public class class_3801 extends DefaultAddonType
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _cont:IWindowContainer;
      
      private var var_3381:SliderWindowController;
      
      private var var_3336:SliderWindowController;
      
      public function class_3801()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3833.var_4955;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         _roomEvents = param3;
         var_3381 = new SliderWindowController(param3,getExecutionsSlider(),param3.assets,1,100,1);
         var_3381.setValue(100);
         var_3381.addEventListener("change",onExecutionsChange);
         var_3336 = new SliderWindowController(param3,getTimeWindowSlider(),param3.assets,1,20,1);
         var_3336.setValue(1);
         var_3336.addEventListener("change",onTimeWindowChange);
      }
      
      private function getExecutionsSlider() : IWindowContainer
      {
         return _cont.findChildByName("execution_slider_cont") as IWindowContainer;
      }
      
      private function getTimeWindowSlider() : IWindowContainer
      {
         return _cont.findChildByName("timewindow_slider_cont") as IWindowContainer;
      }
      
      private function onExecutionsChange(param1:Event) : void
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
               _roomEvents.localization.registerParameter("wiredfurni.params.setexecutions","amount","" + _loc3_);
            }
         }
      }
      
      private function onTimeWindowChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc5_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc5_ = _loc2_.getValue();
               _loc4_ = class_3612.getSecsFromPulses(_loc3_);
               _roomEvents.localization.registerParameter("wiredfurni.params.settimewindow","timewindow","" + _loc4_);
            }
         }
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc3_:int = int(param1.intParams[0]);
         var _loc2_:int = int(param1.intParams[1]);
         var_3381.setValue(_loc3_);
         var_3336.setValue(_loc2_);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_3381.getValue());
         _loc1_.push(var_3336.getValue());
         return _loc1_;
      }
   }
}
