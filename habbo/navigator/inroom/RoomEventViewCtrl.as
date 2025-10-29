package com.sulake.habbo.navigator.inroom
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.TextFieldManager;
   import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1680;
   import com.sulake.habbo.communication.messages.parser.advertisement.class_1118;
   import com.sulake.habbo.communication.messages.outgoing.navigator.EditEventMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CancelEventMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.advertisement.RoomAdErrorEvent;
   
   public class RoomEventViewCtrl implements IDisposable
   {
       
      
      private var _navigator:IHabboTransitionalNavigator;
      
      private var _window:class_3514;
      
      private var var_2246:TextFieldManager;
      
      private var var_2376:TextFieldManager;
      
      public function RoomEventViewCtrl(param1:IHabboTransitionalNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function dispose() : void
      {
         _navigator = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_2246 = null;
         var_2376 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function show() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            _window.visible = false;
            return;
         }
         prepareWindow();
         clearErrors();
         var _loc1_:class_1680 = _navigator.data.roomEventData;
         if(_loc1_ == null)
         {
            createEvent();
         }
         else
         {
            editEvent(_loc1_);
         }
         _window.visible = true;
         _window.activate();
      }
      
      private function editEvent(param1:class_1680) : void
      {
         _window.caption = _navigator.getText("navigator.eventsettings.editcaption");
         var_2246.setText(param1.eventName);
         var_2376.setText(param1.eventDescription);
      }
      
      private function createEvent() : void
      {
         _window.caption = _navigator.getText("navigator.createevent");
         var_2376.goBackToInitialState();
         var_2246.goBackToInitialState();
      }
      
      private function getInput(param1:String) : ITextFieldWindow
      {
         return ITextFieldWindow(_window.findChildByName(param1));
      }
      
      private function onClose(param1:WindowEvent) : void
      {
         close();
      }
      
      private function save() : void
      {
         var _loc1_:int = _navigator.data.roomEventData.adId;
         var _loc3_:String = var_2246.getText();
         var _loc2_:String = var_2376.getText();
         if(!isMandatoryFieldsFilled())
         {
            return;
         }
         _navigator.send(new EditEventMessageComposer(_loc1_,_loc3_,_loc2_));
      }
      
      private function onEndButtonClick(param1:WindowEvent) : void
      {
         _navigator.send(new CancelEventMessageComposer(_navigator.data.roomEventData.adId));
         close();
      }
      
      private function onCancelButtonClick(param1:WindowEvent) : void
      {
         close();
      }
      
      private function onUnfocus(param1:WindowEvent) : void
      {
         if(_navigator.data.roomEventData != null)
         {
            save();
         }
      }
      
      private function onRoomAdError(param1:RoomAdErrorEvent) : void
      {
         this.clearErrors();
         var _loc2_:class_1118 = param1.getParser();
         var _loc3_:int = _loc2_.errorCode;
         if(_loc3_ == 0)
         {
            var_2246.displayError(_navigator.getText("roomad.error.0.description"));
            var_2246.setText(_loc2_.filteredText);
         }
         else if(_loc3_ == 1)
         {
            var_2376.displayError(_navigator.getText("roomad.error.0.description"));
            var_2376.setText(_loc2_.filteredText);
         }
      }
      
      private function isMandatoryFieldsFilled() : Boolean
      {
         this.clearErrors();
         if(!var_2246.checkMandatory(_navigator.getText("navigator.eventsettings.nameerr")))
         {
            return false;
         }
         return true;
      }
      
      private function clearErrors() : void
      {
         var_2246.clearErrors();
         var_2376.clearErrors();
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_3514(_navigator.getXmlWindow("iro_event_settings"));
         addMouseClickListener(_window.findChildByTag("close"),onClose);
         var_2246 = new TextFieldManager(_navigator,getInput("event_name"),25);
         var_2376 = new TextFieldManager(_navigator,getInput("event_desc"),100);
         var_2246.input.addEventListener("WE_UNFOCUSED",onUnfocus);
         var_2376.input.addEventListener("WE_UNFOCUSED",onUnfocus);
         _navigator.communication.addHabboConnectionMessageEvent(new RoomAdErrorEvent(onRoomAdError));
         _window.center();
      }
      
      private function addMouseClickListener(param1:IWindow, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      private function find(param1:String) : IWindow
      {
         var _loc2_:IWindow = _window.findChildByName(param1);
         if(_loc2_ == null)
         {
            throw new Error("Window element with name: " + param1 + " cannot be found!");
         }
         return _loc2_;
      }
      
      private function prepareEventTypes() : void
      {
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc1_:String = null;
         var _loc3_:Array = [];
         var _loc5_:int = 100;
         _loc2_ = 1;
         while(_loc2_ < _loc5_)
         {
            _loc4_ = "roomevent_type_" + _loc2_;
            _loc1_ = _navigator.getText(_loc4_);
            if(_loc1_ == null || _loc1_ == _loc4_)
            {
               break;
            }
            _loc3_.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
   }
}
