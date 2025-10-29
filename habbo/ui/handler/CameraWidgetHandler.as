package com.sulake.habbo.ui.handler
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.communication.messages.outgoing.camera.PurchasePhotoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.camera.PublishPhotoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.camera.RequestCameraConfigurationMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.camera.PhotoCompetitionMessageComposer;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomDesktop;
   import com.sulake.habbo.ui.widget.camera.CameraWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraPurchaseOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraStorageUrlMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraPublishStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CompetitionStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.InitCameraMessageEvent;
   
   public class CameraWidgetHandler implements IRoomWidgetHandler, IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_1629:CameraWidget;
      
      private var var_4025:CameraStorageUrlMessageEvent;
      
      private var var_3991:CameraPurchaseOKMessageEvent;
      
      private var var_4129:CameraPublishStatusMessageEvent;
      
      private var var_4024:CompetitionStatusMessageEvent;
      
      private var var_4254:InitCameraMessageEvent;
      
      private var var_2687:RoomDesktop;
      
      private var var_625:int = 999;
      
      private var var_530:int = 999;
      
      private var var_637:int = 999;
      
      public function CameraWidgetHandler(param1:RoomDesktop)
      {
         super();
         var_2687 = param1;
      }
      
      public function get creditPrice() : int
      {
         return var_625;
      }
      
      public function get ducketPrice() : int
      {
         return var_530;
      }
      
      public function get publishDucketPrice() : int
      {
         return var_637;
      }
      
      public function get type() : String
      {
         return "RWE_CAMERA";
      }
      
      public function get roomDesktop() : RoomDesktop
      {
         return var_2687;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container && _container.toolbar)
         {
            _container.toolbar.events.removeEventListener("HTE_ICON_CAMERA",onCameraRequested);
         }
         _container = param1;
         if(_container && _container.toolbar)
         {
            _container.toolbar.events.addEventListener("HTE_ICON_CAMERA",onCameraRequested);
         }
         var_4025 = new CameraStorageUrlMessageEvent(onCameraStorageUrlEvent);
         var_3991 = new CameraPurchaseOKMessageEvent(onPurchaseOK);
         var_4129 = new CameraPublishStatusMessageEvent(onPublishStatus);
         var_4024 = new CompetitionStatusMessageEvent(onCompetitionStatus);
         var_4254 = new InitCameraMessageEvent(onInitCameraEvent);
         _container.connection.addMessageEvent(var_4025);
         _container.connection.addMessageEvent(var_3991);
         _container.connection.addMessageEvent(var_4129);
         _container.connection.addMessageEvent(var_4024);
         _container.connection.addMessageEvent(var_4254);
      }
      
      public function sendInitCameraMessage() : void
      {
         if(_container.sessionDataManager.isPerkAllowed("CAMERA"))
         {
            _container.connection.send(new RequestCameraConfigurationMessageComposer());
         }
      }
      
      private function onInitCameraEvent(param1:InitCameraMessageEvent) : void
      {
         var_625 = param1.getParser().getCreditPrice();
         var_530 = param1.getParser().getDucketPrice();
         var_637 = param1.getParser().getPublishDucketPrice();
      }
      
      private function onPurchaseOK(param1:CameraPurchaseOKMessageEvent) : void
      {
         if(var_1629)
         {
            var_1629.purchaseSuccessful();
         }
      }
      
      private function onPublishStatus(param1:CameraPublishStatusMessageEvent) : void
      {
         if(var_1629)
         {
            var_1629.publishingStatus(param1);
         }
      }
      
      private function onCompetitionStatus(param1:CompetitionStatusMessageEvent) : void
      {
         if(var_1629)
         {
            var_1629.competitionStatus(param1);
         }
      }
      
      private function onCameraStorageUrlEvent(param1:CameraStorageUrlMessageEvent) : void
      {
         if(!var_1629)
         {
            return;
         }
         var _loc2_:String = param1.getParser().url;
         var_1629.setRenderedPhotoUrl(_loc2_);
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(_container && container.connection)
         {
            _container.connection.removeMessageEvent(var_4025);
            _container.connection.removeMessageEvent(var_3991);
            _container.connection.removeMessageEvent(var_4129);
            _container.connection.removeMessageEvent(var_4024);
            _container.connection.removeMessageEvent(var_4254);
         }
         _disposed = true;
         _container = null;
         var_2687 = null;
         var_1629 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set widget(param1:CameraWidget) : void
      {
         var_1629 = param1;
      }
      
      private function onCameraRequested(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_ICON_CAMERA")
         {
            if(var_1629)
            {
               var_1629.startTakingPhoto(param1.iconName);
            }
         }
      }
      
      public function addListenerToStage(param1:String, param2:Function) : void
      {
         var_2687.addListenerToStage(param1,param2);
      }
      
      public function removeListenerFromStage(param1:String, param2:Function) : void
      {
         var_2687.removeListenerFromStage(param1,param2);
      }
      
      public function confirmPhotoPurchase() : void
      {
         _container.connection.send(new PurchasePhotoMessageComposer());
      }
      
      public function confirmPhotoPublish() : void
      {
         _container.connection.send(new PublishPhotoMessageComposer());
      }
      
      public function confirmPhotoCompetitionSubmit() : void
      {
         _container.connection.send(new PhotoCompetitionMessageComposer());
      }
      
      public function collectPhotoData() : RenderRoomMessageComposer
      {
         return var_2687.roomEngine.getRenderRoomMessage(var_1629.getViewPort(),var_2687.roomBackgroundColor) as RenderRoomMessageComposer;
      }
      
      public function sendPhotoData(param1:RenderRoomMessageComposer) : void
      {
         _container.connection.send(param1);
      }
   }
}
