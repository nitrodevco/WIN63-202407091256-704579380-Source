package com.sulake.habbo.ui.widget.camera
{
   import adobe.serialization.json.JSON

   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer;
   import com.sulake.habbo.tracking.HabboTracking;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;

   public class CameraViewFinder implements IUpdateReceiver
   {
      
      private static const const_894:Number = 350;
      
      private static const NUMBER_OF_SLOTS:int = 5;
      
      private static var var_3646:Boolean = false;
      
      private static var var_1856:Vector.<CameraSlotData> = new Vector.<CameraSlotData>(5);
      
      private static var var_4193:Vector.<RenderRoomMessageComposer> = new Vector.<RenderRoomMessageComposer>(5);
       
      
      private var var_1629:CameraWidget;
      
      private var _window:IWindowContainer;
      
      private var _disposed:Boolean = false;
      
      private var var_1785:IBitmapWrapperWindow;
      
      private var _flash:IBitmapWrapperWindow;
      
      private var _imageWidth:int;
      
      private var var_4315:int;
      
      private var var_4034:Boolean = false;
      
      private var var_1732:int = 0;
      
      private var _isLoadingFromCache:Boolean = false;
      
      private var _imageLoader:Loader;
      
      private var _flashStartTime:uint = 0;
      
      public function CameraViewFinder(param1:CameraWidget)
      {
         var _loc2_:IWindow = null;
         super();
         var_1629 = param1;
         openViewFinder();
         var_1732 = 0;
         while(var_1732 < 5)
         {
            clearCurrentSlot(true);
            var_1732++;
         }
         var_1732 = 0;
         var _loc3_:Boolean = getFromMemoryCache();
         if(_loc3_)
         {
            _loc2_ = _window.findChildByName("slot_container");
            _loc2_.visible = true;
         }
         setMode(false);
         setActiveSlot(0);
         _flash = _window.findChildByName("flash") as IBitmapWrapperWindow;
         _flash.bitmap = new BitmapData(_flash.width,_flash.height,false,16777215);
         _flash.visible = false;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _flash = null;
         var_1785 = null;
         var_1629.component.removeUpdateReceiver(this);
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function openViewFinder() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = var_1629.getXmlWindow("camera_interface") as IWindowContainer;
         _window.center();
         _window.visible = false;
         var_1785 = _window.findChildByName("image") as IBitmapWrapperWindow;
         _imageWidth = var_1785.width;
         var_4315 = var_1785.height;
         var_1785.visible = true;
         _window.procedure = windowProcedure;
      }
      
      public function update(param1:uint) : void
      {
         if(var_4034)
         {
            return;
         }
         if(var_1785.bitmap == null)
         {
            var_1785.bitmap = new BitmapData(_imageWidth,var_4315,false,0);
         }
         var_1785.bitmap.fillRect(var_1785.bitmap.rect,var_1629.handler.roomDesktop.roomBackgroundColor);
         var _loc3_:Matrix = new Matrix();
         var _loc2_:Rectangle = getViewPort();
         _loc3_.translate(-_loc2_.x,-_loc2_.y);
         var_1629.snapShotRoomCanvas(var_1785.bitmap,_loc3_,false);
         var_1785.invalidate();
         if(_flashStartTime > 0)
         {
            updateFlash();
         }
      }
      
      private function updateFlash() : void
      {
         _flash.visible = true;
         var _loc2_:Number = getTimer() - _flashStartTime;
         var _loc1_:Number = (350 - _loc2_) / 350;
         _flash.blend = _loc1_;
         if(_loc2_ > 350)
         {
            _flashStartTime = 0;
            _flash.visible = false;
         }
      }
      
      public function getViewPort() : Rectangle
      {
         var _loc1_:IWindow = _window as IWindow;
         return new Rectangle(_window.x + var_1785.x,_window.y + var_1785.y,var_1785.width,var_1785.height);
      }
      
      public function toggleVisible(param1:String) : void
      {
         if(_window.visible)
         {
            hide();
         }
         else
         {
            HabboTracking.getInstance().trackEventLog("Stories","camera","stories.camera.opened",param1);
            show();
            setMode(false);
         }
      }
      
      public function show() : void
      {
         _window.visible = true;
         _window.center();
         var_1629.component.registerUpdateReceiver(this,100);
      }
      
      public function hide() : void
      {
         _window.visible = false;
         var_1629.component.removeUpdateReceiver(this);
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc5_:IStaticBitmapWrapperWindow = null;
         var _loc4_:RenderRoomMessageComposer = null;
         var _loc3_:IWindow = null;
         var _loc6_:String = null;
         var _loc7_:CameraSlotData = null;
         var _loc8_:int = 0;
         if(param2.name == "button_release")
         {
            _loc5_ = IStaticBitmapWrapperWindow(_window.findChildByName("release_bitmap"));
            switch(param1.type)
            {
               case "WME_DOWN":
                  _loc5_.assetUri = "camera_camera_btn_down";
                  break;
               case "WME_UP":
                  _loc5_.assetUri = "camera_cam_btn_hi";
                  break;
               case "WME_OVER":
                  _loc5_.assetUri = "camera_cam_btn_hi";
                  break;
               case "WME_OUT":
                  _loc5_.assetUri = "camera_camera_btn";
            }
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "header_button_close":
               hide();
               break;
            case "button_editor":
               hide();
               var_1629.editPhoto(var_1785.bitmap.clone());
               break;
            case "delete_photo_button":
               clearCurrentSlot();
               setMode(false);
               break;
            case "header_button_help":
               var_1629.component.context.createLinkEvent("habbopages/camera");
               break;
            case "button_release":
               if(var_4034)
               {
                  setMode(false);
               }
               else
               {
                  var_1629.triggetCameraShutterSound();
                  if((_loc4_ = var_1629.handler.collectPhotoData()) != null && _loc4_.isSendable())
                  {
                     var_4193[var_1732] = _loc4_;
                     addToCurrentSlot(var_1785.bitmap.clone());
                     _flashStartTime = getTimer();
                     HabboTracking.getInstance().trackEventLog("Stories","camera","stories.photo.taken");
                     _loc3_ = _window.findChildByName("slot_container");
                     _loc3_.visible = true;
                  }
                  else
                  {
                     var_1629.windowManager.alert("${generic.alert.title}","${camera.alert.too_much_stuff}",0,null);
                  }
               }
         }
         if(param1.target.name.indexOf("cameraButton_") != -1)
         {
            _loc6_ = param1.target.name.charAt(param1.target.name.length - 1);
            if(var_1856[int(_loc6_)].isEmpty)
            {
               setActiveSlot(int(_loc6_));
               setMode(false);
               return;
            }
            _loc7_ = var_1856[int(_loc6_)];
            var_1785.bitmap = _loc7_.image.clone();
            setMode(true);
            setActiveSlot(int(_loc6_));
         }
         if(param1.target.name.indexOf("chooseSlotButton_") != -1)
         {
            _loc8_ = int(param1.target.name.charAt(param1.target.name.length - 1));
            if(var_1856.length < _loc8_)
            {
               return;
            }
            setActiveSlot(_loc8_);
            setMode(false);
         }
      }
      
      private function setActiveSlot(param1:int) : void
      {
         (_window.findChildByName("slotImage_" + var_1732) as IStaticBitmapWrapperWindow).assetUri = "camera_arrow_gray";
         var_1732 = param1;
         (_window.findChildByName("slotImage_" + var_1732) as IStaticBitmapWrapperWindow).assetUri = "camera_arrow_green";
         var _loc2_:IWindow = _window.findChildByName("photo_border");
         var _loc4_:IWindow = _window.findChildByName("cameraButton_" + var_1732);
         _loc2_.x = _loc4_.x - 1 + _loc4_.parent.x;
         _loc2_.y = _loc4_.y - 3 + _loc4_.parent.y;
         _loc2_.visible = true;
         var _loc3_:IWindow = _window.findChildByName("delete_photo_button");
         _loc3_.y = _loc2_.y;
         _loc3_.x = _loc2_.right - _loc3_.width;
      }
      
      private function setMode(param1:Boolean) : void
      {
         var_4034 = param1;
         var _loc3_:IWindow = _window.findChildByName("button_editor");
         var _loc5_:IWindow = _window.findChildByName("camera_crosshair");
         var _loc2_:IWindow = _window.findChildByName("photo_date");
         var _loc7_:IWindow = _window.findChildByName("photo_roomname");
         var _loc6_:IWindow = _window.findChildByName("buyButtonBg");
         _loc2_.visible = _loc7_.visible = false;
         var _loc4_:IWindow = _window.findChildByName("delete_photo_button");
         _loc5_.visible = !param1;
         _loc4_.visible = _loc3_.visible = _loc6_.visible = param1;
      }
      
      private function onPurchaseError(param1:Event) : void
      {
         var _loc2_:Object = null;
         try
         {
            _loc2_ = adobe.serialization.json.JSON.decode(URLLoader(param1.target).data);
            switch(_loc2_.error.code)
            {
               case "PURCHASING_FAILED":
                  var_1629.windowManager.alert("Something went wrong","sorry, purhcase failed. We will investigate the issue. #code 1",0,null);
                  break;
               case "MODERATED":
                  var_1629.windowManager.alert("Inappropriate text","Your photo caption contained inappropriate words. They were changed to bobba. Please edit the text and try again.",0,null);
                  var_1629.changeCaptionFieldText(_loc2_.error.message,true);
            }
         }
         catch(error:Error)
         {
            var_1629.windowManager.alert("Something went wrong","sorry, purhcase failed. We will investigate the issue. # code 2",0,null);
         }
      }
      
      private function getFromMemoryCache() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < var_1856.length)
         {
            if(var_1856[_loc2_].isEmpty == false)
            {
               drawImageToSlot(_loc2_,var_1856[_loc2_]);
               _loc1_ = true;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function drawImageToSlot(param1:int, param2:CameraSlotData) : void
      {
         var _loc4_:IBitmapWrapperWindow;
         (_loc4_ = _window.findChildByName("cameraSlot_" + param1) as IBitmapWrapperWindow).bitmap = new BitmapData(_loc4_.width,_loc4_.height,false,0);
         var _loc3_:Number = (_loc4_.width - 2) / _imageWidth;
         var _loc5_:Matrix;
         (_loc5_ = new Matrix()).scale(_loc3_,_loc3_);
         _loc5_.tx = _loc5_.ty = 1;
         _loc4_.bitmap.draw(param2.image,_loc5_,null,null,null,true);
      }
      
      private function getFromLocalCache() : Boolean
      {
         var _loc2_:SharedObject = null;
         try
         {
            _loc2_ = SharedObject.getLocal("camera_image_" + var_1732);
         }
         catch(error:Error)
         {
            return false;
         }
         if(_loc2_.size == 0 || !_loc2_.data)
         {
            return false;
         }
         var _loc1_:ByteArray = _loc2_.data.photo as ByteArray;
         if(!_loc1_)
         {
            return false;
         }
         if(!_imageLoader)
         {
            _imageLoader = new Loader();
         }
         _imageLoader.loadBytes(_loc1_);
         _imageLoader.contentLoaderInfo.addEventListener("complete",onImageLoadedFromCache);
         var _loc3_:CameraSlotData = new CameraSlotData();
         _loc3_.setDate(new Date());
         if(int(_loc2_.data.date) > 0)
         {
            _loc3_.setDate(new Date(int(_loc2_.data.date)));
         }
         var_1856[var_1732] = _loc3_;
         return true;
      }
      
      private function onImageLoadedFromCache(param1:Event) : void
      {
         var _loc2_:BitmapData = new BitmapData(_imageLoader.width,_imageLoader.height,false);
         _loc2_.draw(_imageLoader);
         var_1856[var_1732].image = _loc2_.clone();
         addToCurrentSlot(_loc2_,false,true);
         if(var_1732 < 5 && _isLoadingFromCache)
         {
            getFromLocalCache();
            if(var_1732 == 5 - 1)
            {
               _isLoadingFromCache = false;
            }
         }
         else
         {
            var_3646 = true;
         }
      }
      
      private function findNextEmptySlotIndex() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < var_1856.length)
         {
            if(var_1856[_loc1_].isEmpty)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function clearCurrentSlot(param1:Boolean = false) : void
      {
         if(param1 && var_1856[var_1732] && !var_1856[var_1732].isEmpty)
         {
            return;
         }
         var_1856[var_1732] = null;
         addToCurrentSlot(new BitmapData(320,320,false,13816530),true);
         var_1785.bitmap = var_1856[var_1732].image.clone();
         setMode(false);
      }
      
      private function addToCurrentSlot(param1:BitmapData, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc4_:CameraSlotData;
         (_loc4_ = new CameraSlotData()).image = param1;
         if(param2)
         {
            _loc4_.isEmpty = true;
         }
         else
         {
            _loc4_.setDate(new Date());
            _loc4_.isEmpty = false;
         }
         if(!param3 && !param2 || var_1856[var_1732] == null)
         {
            var_1856[var_1732] = _loc4_;
         }
         drawImageToSlot(var_1732,_loc4_);
         if(!param2)
         {
            if((_loc5_ = findNextEmptySlotIndex()) >= 0)
            {
               setActiveSlot(_loc5_);
            }
            else if(!var_3646 && !param3)
            {
               var_1629.windowManager.alert(var_1629.localizations.getLocalization("camera.full.header"),var_1629.localizations.getLocalization("camera.full.body"),0,null);
               var_3646 = true;
            }
         }
      }
      
      public function getRenderRoomMessage() : RenderRoomMessageComposer
      {
         return var_4193[var_1732];
      }
   }
}
