package com.sulake.habbo.ui.widget.furniture.ecotronbox
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetEcotronBoxOpenMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class EcotronBoxFurniWidget extends RoomWidgetBase
   {
      
      private static const const_685:Number = 100;
      
      private static const const_561:Number = 100;
       
      
      private var _window:IWindowContainer;
      
      private var var_455:int = -1;
      
      private var _text:String;
      
      private var var_319:Boolean;
      
      private var var_1940:Boolean = false;
      
      private var _furniTypeName:String = "ecotron_box";
      
      private var _interfaceMapByFurniTypeName:Map;
      
      public function EcotronBoxFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary = null)
      {
         _interfaceMapByFurniTypeName = new Map();
         super(param1,param2,param3);
         _interfaceMapByFurniTypeName.add("","ecotronbox_card");
         _interfaceMapByFurniTypeName.add("ecotron_box","ecotronbox_card");
         _interfaceMapByFurniTypeName.add("matic_box","ecotronbox_card_furnimatic");
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
         param1.addEventListener("RWEBDUE_PACKAGEINFO",onObjectUpdate);
         param1.addEventListener("RWEBDUE_CONTENTS",onObjectUpdate);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWPDUE_PACKAGEINFO",onPresentUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWEBDUE_PACKAGEINFO",onObjectUpdate);
         param1.removeEventListener("RWEBDUE_CONTENTS",onObjectUpdate);
         param1.removeEventListener("RWPDUE_PACKAGEINFO",onPresentUpdate);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
      }
      
      private function onObjectUpdate(param1:RoomWidgetEcotronBoxDataUpdateEvent) : void
      {
         hideInterface();
         switch(param1.type)
         {
            case "RWEBDUE_PACKAGEINFO":
               var_1940 = false;
               var_455 = param1.objectId;
               _text = param1.text;
               var_319 = param1.controller;
               _furniTypeName = param1.furniTypeName;
               showInterface();
               break;
            case "RWEBDUE_CONTENTS":
               if(!var_1940)
               {
                  return;
               }
               var_455 = param1.objectId;
               showInterface();
               showIcon(param1.iconBitmapData);
               showDescription(param1.text);
               setOpenButton(false);
               break;
         }
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         if(param1.id == var_455)
         {
            hideInterface();
         }
      }
      
      private function onPresentUpdate(param1:RoomWidgetPresentDataUpdateEvent) : void
      {
         var _loc2_:* = param1.type;
         if("RWPDUE_PACKAGEINFO" === _loc2_)
         {
            hideInterface();
         }
      }
      
      private function showIcon(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         if(_window == null)
         {
            return;
         }
         var _loc4_:IBitmapWrapperWindow;
         if((_loc4_ = _window.findChildByName("ecotronbox_card_preview") as IBitmapWrapperWindow) == null)
         {
            return;
         }
         var _loc2_:int = (_loc4_.width - param1.width) / 2;
         var _loc3_:int = (_loc4_.height - param1.height) / 2;
         if(_loc4_.bitmap == null)
         {
            _loc4_.bitmap = new BitmapData(_loc4_.width,_loc4_.height,true,16777215);
         }
         _loc4_.bitmap.fillRect(_loc4_.bitmap.rect,16777215);
         _loc4_.bitmap.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_),null,null,false);
      }
      
      private function showDescription(param1:String) : void
      {
         var _loc2_:ITextWindow = null;
         _loc2_ = _window.findChildByName("ecotronbox_card_msg") as ITextWindow;
         if(_loc2_ != null && param1 != null)
         {
            _loc2_.caption = param1;
         }
      }
      
      private function showInterface() : void
      {
         var _loc3_:ITextWindow = null;
         var _loc2_:IWindow = null;
         if(var_455 < 0)
         {
            return;
         }
         var _loc4_:IAsset = assets.getAssetByName(_interfaceMapByFurniTypeName.getValue(_furniTypeName));
         var _loc1_:XmlAsset = XmlAsset(_loc4_);
         if(_loc1_ == null)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _window = windowManager.createWindow("ecotronboxcardui_container","",4,0,131072 | 1,new Rectangle(100,100,2,2),null,0) as IWindowContainer;
         _window.buildFromXML(XML(_loc1_.content));
         _loc3_ = _window.findChildByName("ecotronbox_card_date") as ITextWindow;
         if(_loc3_ != null && _text != null)
         {
            _loc3_.caption = _text;
         }
         _loc2_ = _window.findChildByName("ecotronbox_card_btn_close");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseEvent);
         }
         setOpenButton(true);
      }
      
      private function setOpenButton(param1:Boolean) : void
      {
         var _loc2_:IWindow = null;
         if(_window == null)
         {
            return;
         }
         _loc2_ = _window.findChildByName("ecotronbox_card_btn_open");
         if(_loc2_ != null)
         {
            if(var_319 && param1)
            {
               _loc2_.visible = true;
               _loc2_.addEventListener("WME_CLICK",onMouseEvent);
            }
            else
            {
               _loc2_.visible = false;
            }
         }
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(!var_1940)
         {
            var_455 = -1;
         }
         _text = "";
         var_319 = false;
      }
      
      private function sendOpen() : void
      {
         var _loc1_:RoomWidgetEcotronBoxOpenMessage = null;
         if(var_1940 || var_455 == -1 || !var_319)
         {
            return;
         }
         var_1940 = true;
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetEcotronBoxOpenMessage("RWEBOM_OPEN_ECOTRONBOX",var_455);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "ecotronbox_card_btn_open":
               sendOpen();
               break;
            case "ecotronbox_card_btn_close":
            default:
               var_1940 = false;
               hideInterface();
         }
      }
   }
}
