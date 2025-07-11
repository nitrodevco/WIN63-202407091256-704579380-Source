package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class class_3692 extends DefaultActionType
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2973:SliderWindowController;
      
      public function class_3692()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3849.MUTE_USER;
      }
      
      override public function readStringParamFromForm() : String
      {
         return String(getMessage(cont).text);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_2973.getValue());
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         getMessage(cont).text = param1.stringParam;
         var _loc2_:int = int(param1.intParams[0]);
         var_2973.setValue(_loc2_);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getMessage(param1:IWindowContainer) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("chat_message"));
      }
      
      override public function validate() : String
      {
         var _loc2_:String = null;
         var _loc1_:int = 100;
         if(getMessage(cont).text.length > _loc1_)
         {
            _loc2_ = "wiredfurni.chatmsgtoolong";
            return roomEvents.localization.getLocalization(_loc2_,_loc2_);
         }
         return null;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_2973 = new SliderWindowController(param3,getSlider(param1),param3.assets,0,10,1);
         var_2973.setValue(1);
         var_2973.addEventListener("change",onSliderChange);
      }
      
      private function getSlider(param1:IWindowContainer) : IWindowContainer
      {
         return param1.findChildByName("slider_container") as IWindowContainer;
      }
      
      protected function onSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc4_:Number = NaN;
         var _loc3_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = (int(_loc4_ = _loc2_.getValue())).toString();
               _roomEvents.localization.registerParameter("wiredfurni.params.length.minutes","minutes",_loc3_);
            }
         }
      }
      
      public function get slider() : SliderWindowController
      {
         return var_2973;
      }
   }
}
