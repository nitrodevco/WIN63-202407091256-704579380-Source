package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomThumbnailMessageComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.RoomThumbnailCameraWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomThumbnailCameraWidget extends RoomWidgetBase implements IUpdateReceiver, ILinkEventTracker
   {
       
      
      private var var_1660:RoomUI;
      
      private var _window:class_3514 = null;
      
      private var var_1785:IBitmapWrapperWindow;
      
      public function RoomThumbnailCameraWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:ICoreConfiguration, param5:IHabboLocalizationManager, param6:RoomUI)
      {
         super(param1,param2,param3,param5);
         var_1660 = param6;
         this.handler.widget = this;
         if(roomEngine)
         {
            roomEngine.events.addEventListener("REE_DISPOSED",onRoomDisposed);
            roomEngine.events.addEventListener("REE_ROOM_ZOOMED",onRoomZoomed);
         }
         (param2 as Component).context.addLinkEventTracker(this);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         (windowManager as Component).context.removeLinkEventTracker(this);
         super.dispose();
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return !!handler ? handler.container : null;
      }
      
      public function get handler() : RoomThumbnailCameraWidgetHandler
      {
         return var_1653 as RoomThumbnailCameraWidgetHandler;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return !!container ? container.roomEngine : null;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Matrix = null;
         var _loc4_:IRoomSession = null;
         if(_window && var_1785)
         {
            if(var_1785.bitmap == null)
            {
               var_1785.bitmap = new BitmapData(var_1785.width,var_1785.height,false,0);
            }
            var_1785.bitmap.fillRect(var_1785.bitmap.rect,handler.roomDesktop.roomBackgroundColor);
            _loc2_ = new Point(0,0);
            var_1785.getGlobalPosition(_loc2_);
            _loc3_ = new Matrix();
            _loc3_.translate(-_loc2_.x,-_loc2_.y);
            _loc4_ = container.roomSession;
            roomEngine.snapshotRoomCanvasToBitmap(_loc4_.roomId,container.getFirstCanvasId(),var_1785.bitmap,_loc3_,false);
            var_1785.invalidate();
         }
      }
      
      public function startTakingPhoto() : void
      {
         if(roomEngine && roomEngine.getRoomCanvasScale() != 1)
         {
            windowManager.alert("Camera only works on normal zoom!","Return to normal zoom level and try again!",0,null);
            return;
         }
         if(!_window)
         {
            createWindow();
         }
      }
      
      private function createWindow() : void
      {
         if(_window)
         {
            destroy();
         }
         _window = class_3514(windowManager.buildFromXML(XML(var_1660.assets.getAssetByName("iro_room_thumbnail_camera_xml").content)));
         var_1785 = IBitmapWrapperWindow(_window.findChildByName("viewfinder"));
         _window.procedure = windowProcedure;
         _window.center();
         var_1660.registerUpdateReceiver(this,10);
      }
      
      public function destroy() : void
      {
         if(_window)
         {
            _window.destroy();
            _window = null;
            var_1660.removeUpdateReceiver(this);
         }
      }
      
      public function get viewPort() : Rectangle
      {
         var _loc1_:Point = new Point(0,0);
         var_1785.getGlobalPosition(_loc1_);
         return new Rectangle(_loc1_.x,_loc1_.y,var_1785.width,var_1785.height);
      }
      
      private function onRoomDisposed(param1:RoomEngineEvent) : void
      {
         destroy();
      }
      
      private function onRoomZoomed(param1:RoomEngineEvent) : void
      {
         if(roomEngine && roomEngine.getRoomCanvasScale() != 1)
         {
            destroy();
         }
      }
      
      public function triggerCameraShutterSound() : void
      {
         container.soundManager.playSound("CAMERA_shutter");
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:RenderRoomThumbnailMessageComposer = null;
         var _loc4_:WindowMouseEvent;
         if((_loc4_ = param1 as WindowMouseEvent) && _loc4_.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_capture":
                  triggerCameraShutterSound();
                  _loc3_ = RoomThumbnailCameraWidgetHandler(handler).collectPhotoData();
                  if(_loc3_ != null && _loc3_.isSendable())
                  {
                     handler.sendPhotoData(_loc3_);
                     _window.findChildByName("button_capture").disable();
                     _window.findChildByName("button_cancel").disable();
                     var_1660.removeUpdateReceiver(this);
                  }
                  else
                  {
                     windowManager.alert("${generic.alert.title}","${camera.alert.too_much_stuff}",0,null);
                  }
                  return;
               case "header_button_close":
               case "button_cancel":
                  destroy();
            }
         }
      }
      
      public function get linkPattern() : String
      {
         return "roomThumbnailCamera";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         var _loc3_:int = int(_loc2_.length);
         if(_loc3_ < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            startTakingPhoto();
         }
      }
   }
}
