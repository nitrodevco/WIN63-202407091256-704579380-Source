package com.sulake.habbo.ui.widget.furniture.petpackage
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetPackageUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenPetPackageMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public class PetPackageFurniWidget extends RoomWidgetBase
   {
      
      private static const GNOME_SPECIES_TYPE_ID:int = 26;
       
      
      private var _window:class_3514;
      
      private var var_1311:int = -1;
      
      private var var_455:int = -1;
      
      private var var_2261:BitmapData;
      
      private var var_2929:Boolean = false;
      
      public function PetPackageFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         hideInterface();
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWOPPUE_OPEN_PET_PACKAGE_REQUESTED",onObjectUpdate);
         param1.addEventListener("RWOPPUE_OPEN_PET_PACKAGE_RESULT",onObjectUpdate);
         param1.addEventListener("RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWOPPUE_OPEN_PET_PACKAGE_REQUESTED",onObjectUpdate);
         param1.removeEventListener("RWOPPUE_OPEN_PET_PACKAGE_RESULT",onObjectUpdate);
         param1.removeEventListener("RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE",onObjectUpdate);
         super.unregisterUpdateEvents(param1);
      }
      
      private function onObjectUpdate(param1:RoomWidgetPetPackageUpdateEvent) : void
      {
         var nameValidationStatus:int;
         var nameValidationInfo:String;
         var error:String;
         var resultMessage:String;
         var event:RoomWidgetPetPackageUpdateEvent = param1;
         switch(event.type)
         {
            case "RWOPPUE_OPEN_PET_PACKAGE_REQUESTED":
               hideInterface();
               var_455 = event.objectId;
               var_2261 = event.image;
               var_1311 = event.typeId;
               showInterface();
               showPetImage();
               break;
            case "RWOPPUE_OPEN_PET_PACKAGE_RESULT":
               if(!var_2929)
               {
                  return;
               }
               var_2929 = false;
               nameValidationStatus = event.nameValidationStatus;
               nameValidationInfo = event.nameValidationInfo;
               switch(nameValidationStatus)
               {
                  case 0:
                     hideInterface();
                     return;
                  case 1:
                     error = "long";
                     break;
                  case 2:
                     error = "short";
                     break;
                  case 3:
                     error = "chars";
                     break;
                  default:
                     error = "bobba";
               }
               resultMessage = constructErrorMessage(error,nameValidationInfo);
               windowManager.alert("${widgets.petpackage.alert.petname.title}",resultMessage,0,function(param1:class_3348, param2:WindowEvent):void
               {
                  param1.dispose();
               });
               break;
            case "RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE":
               if(event.objectId != var_455)
               {
                  return;
               }
               var_2261 = event.image;
               showPetImage();
               break;
         }
      }
      
      private function constructErrorMessage(param1:String, param2:String) : String
      {
         var _loc3_:String = "catalog.alert.petname." + param1;
         var _loc5_:String = _loc3_ + ".additionalInfo";
         localizations.registerParameter(_loc5_,"additional_info",param2);
         var _loc6_:* = String(localizations.getLocalization(_loc3_));
         var _loc4_:String = String(localizations.getLocalization(_loc5_));
         if(param2 != null && param2.length > 0 && _loc4_ != null && _loc4_.length > 0)
         {
            _loc6_ = _loc4_;
         }
         return _loc6_;
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         var_455 = -1;
         var_2929 = false;
         var_2261 = null;
      }
      
      private function showInterface() : void
      {
         var _loc2_:IWindow = null;
         if(var_455 < 0)
         {
            return;
         }
         var _loc3_:IAsset = var_2261 != null ? assets.getAssetByName("petpackage") : assets.getAssetByName("petpackage_new");
         var _loc1_:XmlAsset = XmlAsset(_loc3_);
         if(_loc1_ == null)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _window = windowManager.buildFromXML(XML(_loc1_.content)) as class_3514;
         _window.center();
         var _loc4_:IWindow;
         if(_loc4_ = _window.header.findChildByTag("close"))
         {
            _loc4_.addEventListener("WME_CLICK",onWindowClose);
         }
         _loc2_ = _window.findChildByName("pick_name");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc2_ = _window.findChildByName("cancel");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _window.addEventListener("WME_CLICK",onMouseEvent);
         showPetImage();
      }
      
      private function showPetImage() : void
      {
         var _loc2_:Point = null;
         if(var_2261 == null || _window == null)
         {
            return;
         }
         var _loc1_:IBitmapWrapperWindow = _window.findChildByName("pet_image") as IBitmapWrapperWindow;
         if(_loc1_ != null)
         {
            _loc1_.bitmap = new BitmapData(_loc1_.width,_loc1_.height,true,0);
            _loc2_ = new Point((_loc1_.width - var_2261.width) / 2,(_loc1_.height - var_2261.height) / 2);
            _loc1_.bitmap.copyPixels(var_2261,var_2261.rect,_loc2_);
         }
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideInterface();
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "pick_name":
               sendOpenPetPackage();
               break;
            case "cancel":
               hideInterface();
         }
      }
      
      private function sendOpenPetPackage() : void
      {
         var name:String;
         var message:RoomWidgetOpenPetPackageMessage;
         if(var_2929 || var_455 == -1)
         {
            return;
         }
         name = getName();
         if(name == null || name.length < 1)
         {
            windowManager.alert("${widgets.petpackage.alert.petname.title}","${catalog.alert.petname.short}",0,function(param1:class_3348, param2:WindowEvent):void
            {
               param1.dispose();
            });
            return;
         }
         if(messageListener != null)
         {
            var_2929 = true;
            message = new RoomWidgetOpenPetPackageMessage("RWOPPM_OPEN_PET_PACKAGE",var_455,name);
            messageListener.processWidgetMessage(message);
         }
      }
      
      private function getName() : String
      {
         var _loc1_:ITextFieldWindow = null;
         if(_window)
         {
            _loc1_ = _window.findChildByName("input") as ITextFieldWindow;
            if(_loc1_)
            {
               return _loc1_.text;
            }
         }
         return null;
      }
   }
}
