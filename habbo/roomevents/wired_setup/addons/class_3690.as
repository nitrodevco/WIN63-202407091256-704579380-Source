package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3404;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3690 extends DefaultAddonType implements IUpdateReceiver
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _cont:IWindowContainer;
      
      public function class_3690()
      {
         super();
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         _roomEvents = param3;
         placeholderPreview.selectable = true;
         placeholderNameWindow.addEventListener("WKE_KEY_DOWN",onPlaceholderChange);
         placeholderNameWindow.addEventListener("WKE_KEY_UP",onPlaceholderChange);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         roomEvents.context.registerUpdateReceiver(this,0);
      }
      
      override public function onEditEnd() : void
      {
         super.onEditEnd();
         roomEvents.context.removeUpdateReceiver(this);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      public function onPlaceholderChange(param1:WindowEvent) : void
      {
         updatePlaceholderText();
      }
      
      public function updatePlaceholderText() : void
      {
         var _loc1_:String = String(_roomEvents.localization.getLocalizationWithParams("wiredfurni.params.texts.placeholder_preview","","placeholder",syntaxPrefix + "(" + placeholderNameWindow.text.toLowerCase() + ")"));
         placeholderPreview.text = _loc1_;
      }
      
      protected function get placeholderName() : String
      {
         return placeholderNameWindow.text;
      }
      
      protected function set placeholderName(param1:String) : void
      {
         placeholderNameWindow.text = param1;
         updatePlaceholderText();
      }
      
      protected function get syntaxPrefix() : String
      {
         return "$";
      }
      
      private function get placeholderPreview() : class_3404
      {
         return _cont.findChildByName("placeholder_preview") as class_3404;
      }
      
      protected function get placeholderNameWindow() : ITextFieldWindow
      {
         return _cont.findChildByName("placeholder_name") as ITextFieldWindow;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:String = String(placeholderNameWindow.text);
         var _loc3_:String = String(placeholderNameWindow.text.split(" ").join("_").toLowerCase());
         if(_loc2_ != _loc3_)
         {
            placeholderNameWindow.text = _loc3_;
            updatePlaceholderText();
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}
