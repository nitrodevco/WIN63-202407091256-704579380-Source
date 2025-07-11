package com.sulake.habbo.navigator
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   import com.sulake.habbo.communication.messages.outgoing.room.session.class_325;
   
   public class GuestRoomDoorbell
   {
       
      
      private var _navigator:IHabboTransitionalNavigator;
      
      private var _window:class_3514;
      
      private var var_3104:class_1675;
      
      private var var_4030:Boolean;
      
      public function GuestRoomDoorbell(param1:IHabboTransitionalNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function show(param1:class_1675, param2:Point = null, param3:Boolean = false) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_3104 = param1;
         var_4030 = param3;
         createWindow();
         if(_window == null)
         {
            return;
         }
         if(param2 != null)
         {
            param2.offset(-_window.width / 2,-_window.height / 2);
            _window.setGlobalPosition(param2);
         }
         _window.visible = true;
         _window.activate();
         var _loc4_:ITextWindow;
         if((_loc4_ = _window.findChildByName("room_name") as ITextWindow) != null)
         {
            _loc4_.text = param1.roomName;
         }
         if(var_4030)
         {
            setText("info","${navigator.doorbell.waiting}");
            setText("cancel","${navigator.doorbell.button.cancel.entering}");
            showButton("ring",false);
         }
         else
         {
            setText("info","${navigator.doorbell.info}");
            setText("cancel","${generic.cancel}");
            showButton("ring",true);
         }
      }
      
      public function showWaiting() : void
      {
         show(var_3104,null,true);
      }
      
      public function showNoAnswer() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = true;
         _window.activate();
         setText("info","${navigator.doorbell.no.answer}");
         showButton("ring",false);
      }
      
      private function showButton(param1:String, param2:Boolean) : void
      {
         var _loc3_:class_3357 = _window.findChildByName(param1) as class_3357;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.visible = param2;
      }
      
      private function createWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         var _loc2_:XmlAsset = _navigator.assets.getAssetByName("doorbell_xml") as XmlAsset;
         _window = _navigator.windowManager.buildFromXML(_loc2_.content as XML,2) as class_3514;
         if(_window == null)
         {
            return;
         }
         var _loc4_:class_3357;
         if((_loc4_ = _window.findChildByName("ring") as class_3357) != null)
         {
            _loc4_.addEventListener("WME_CLICK",ringDoorbell);
         }
         var _loc3_:IWindow = _window.findChildByName("cancel_region");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",close);
         }
         var _loc1_:IWindow = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",close);
         }
      }
      
      private function setText(param1:String, param2:String) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:IWindow = _window.findChildByName(param1);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.caption = param2;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
         }
         _window = null;
         _navigator = null;
         var_3104 = null;
      }
      
      private function ringDoorbell(param1:WindowMouseEvent) : void
      {
         _navigator.goToRoom(var_3104.flatId,true);
         hide();
      }
      
      private function close(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         if(var_4030 && _navigator != null)
         {
            _navigator.send(new class_325());
         }
         _window.dispose();
         _window = null;
      }
      
      public function hide() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = false;
      }
   }
}
