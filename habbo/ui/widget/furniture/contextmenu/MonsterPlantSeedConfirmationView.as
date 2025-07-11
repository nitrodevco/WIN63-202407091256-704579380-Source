package com.sulake.habbo.ui.widget.furniture.contextmenu
{
    import assets.class_14

    import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUseProductMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class MonsterPlantSeedConfirmationView implements IDisposable, IGetImageListener
   {
      
      private static const PRODUCT_PAGE_UKNOWN:int = -1;
      
      private static const PRODUCT_PAGE_SEED:int = 0;
      
      private static const const_533:String = "header_button_close";
      
      private static const const_560:String = "save_button";
      
      private static const const_613:String = "cancel_text";
      
      private static const const_510:String = "ok_button";
       
      
      private var _window:IWindowContainer;
      
      private var var_318:Boolean = false;
      
      private var var_1629:FurnitureContextMenuWidget;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assets:IAssetLibrary;
      
      private var var_3490:int = -1;
      
      private var var_3665:int;
      
      private var var_2047:class_3365;
      
      public function MonsterPlantSeedConfirmationView(param1:FurnitureContextMenuWidget)
      {
         super();
         var_1629 = param1;
         _windowManager = param1.windowManager;
         _assets = var_1629.assets;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_318 = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         var_2047 = null;
      }
      
      public function open(param1:int) : void
      {
         var _loc3_:int = var_1629.handler.roomSession.roomId;
         var _loc4_:IRoomObject;
         if((_loc4_ = var_1629.handler.roomEngine.getRoomObject(_loc3_,param1,10)) != null)
         {
            var_2047 = var_1629.handler.getFurniData(_loc4_);
            var_3490 = _loc4_.getId();
         }
         var _loc2_:int = -1;
         switch(var_2047.category - 19)
         {
            case 0:
               _loc2_ = 0;
               break;
            default:
               class_14.log("[PlantSeedConfirmationView.open()] Unsupported furniture category: " + var_2047.category);
         }
         setWindowContent(_loc2_);
         _window.visible = true;
      }
      
      private function setWindowContent(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc3_:BitmapData = new BitmapData(10,10);
         var_1629.localizations.registerParameter("useproduct.widget.title.plant_seed","name",var_2047.localizedName);
         if(!_window)
         {
            _loc4_ = "use_product_widget_frame_plant_seed_xml";
            _window = _windowManager.buildFromXML(_assets.getAssetByName(_loc4_).content as XML) as IWindowContainer;
            addClickListener("header_button_close");
            _window.center();
         }
         var_1629.localizations.registerParameter("useproduct.widget.text.plant_seed","productName",var_2047.localizedName);
         var _loc2_:class_3514 = _window as class_3514;
         _loc2_.content.removeChildAt(0);
         var _loc5_:IWindowContainer = createWindow(param1);
         _loc2_.content.addChild(_loc5_);
         switch(param1)
         {
            case 0:
               addClickListener("save_button");
               addClickListener("cancel_text");
               _loc3_ = resolvePreviewImage(var_2047);
               updatePreviewImage(_loc3_);
               _window.invalidate();
               return;
            default:
               throw new Error("Invalid type for use product confirmation content apply: " + param1);
         }
      }
      
      private function createWindow(param1:int) : IWindowContainer
      {
         var _loc2_:IAsset = null;
         var _loc3_:* = null;
         switch(param1)
         {
            case 0:
               _loc2_ = _assets.getAssetByName("use_product_controller_plant_seed_xml");
               return _windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
            default:
               throw new Error("Invalid type for view content creation: " + param1);
         }
      }
      
      private function resolvePreviewImage(param1:class_3365) : BitmapData
      {
         var _loc3_:class_3499 = null;
         var _loc4_:BitmapData = null;
         if(!param1)
         {
            return null;
         }
         var _loc2_:Array = param1.customParams.split(" ");
         switch(param1.category - 19)
         {
            case 0:
               _loc3_ = var_1629.handler.roomEngine.getFurnitureImage(var_2047.id,new Vector3d(90,0,0),64,this,0,"",-1,-1,null);
               break;
            default:
               class_14.log("[PlantSeedConfirmationView] Unsupported furniture category: " + param1.category);
         }
         if(_loc3_ != null)
         {
            var_3665 = _loc3_.id;
            _loc4_ = _loc3_.data;
         }
         return _loc4_;
      }
      
      private function updatePreviewImage(param1:BitmapData) : void
      {
         if(!_window || !param1)
         {
            return;
         }
         setPreviewImage("preview_image_bg");
         setPreviewImage("preview_image");
      }
      
      private function setPreviewImage(param1:String) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName(param1) as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:BitmapDataAsset = _assets.getAssetByName(_loc2_.bitmapAssetName) as BitmapDataAsset;
         if(_loc3_ == null)
         {
            return;
         }
         _loc2_.disposesBitmap = false;
         _loc2_.bitmap = _loc3_.content as BitmapData;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",onMouseClick);
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:RoomWidgetMessage = null;
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_text":
            case "ok_button":
               close();
               break;
            case "save_button":
               _loc2_ = new RoomWidgetUseProductMessage("RWUPM_MONSTERPLANT_SEED",var_3490);
               close();
         }
         if(_loc2_)
         {
            var_1629.messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed)
         {
            return;
         }
         if(var_3665 == param1)
         {
            updatePreviewImage(param2);
            var_3665 = 0;
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}
