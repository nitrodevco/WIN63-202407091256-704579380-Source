package com.sulake.habbo.ui.widget.furniture.clothingchange
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetClothingChangeUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetClothingChangeMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public class ClothingChangeFurnitureWidget extends RoomWidgetBase
   {
      
      private static const const_549:String = "Boy";
      
      private static const const_1109:String = "Girl";
       
      
      private var var_2230:IWindowContainer;
      
      private var var_455:int = 0;
      
      private var var_1114:int = 0;
      
      private var var_369:int = 0;
      
      public function ClothingChangeFurnitureWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         hideGenderSelectionInterface();
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWCCUE_SHOW_GENDER_SELECTION",onUpdate);
         param1.addEventListener("RWCCUE_SHOW_CLOTHING_EDITOR",onUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCCUE_SHOW_GENDER_SELECTION",onUpdate);
         param1.removeEventListener("RWCCUE_SHOW_CLOTHING_EDITOR",onUpdate);
      }
      
      private function onUpdate(param1:RoomWidgetClothingChangeUpdateEvent) : void
      {
         var _loc2_:* = param1.type;
         if("RWCCUE_SHOW_GENDER_SELECTION" === _loc2_)
         {
            showGenderSelectionInterface(param1);
         }
      }
      
      private function showGenderSelectionInterface(param1:RoomWidgetClothingChangeUpdateEvent) : void
      {
         hideGenderSelectionInterface();
         var_455 = param1.objectId;
         var_1114 = param1.objectCategory;
         var_369 = param1.roomId;
         var _loc4_:IAsset = assets.getAssetByName("boygirl");
         var _loc2_:XmlAsset = XmlAsset(_loc4_);
         if(_loc2_ == null)
         {
            return;
         }
         var_2230 = windowManager.createWindow("clothing change gender selection","",4,0,32768 | 1 | 131072 | 1,new Rectangle(100,100,200,200),null,0) as IWindowContainer;
         var_2230.buildFromXML(XML(_loc2_.content));
         var_2230.addEventListener("WME_CLICK",onGenderSelectionMouseEvent);
         var_2230.center();
         var _loc3_:IWindow = var_2230.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.procedure = onGenderSelectionWindowClose;
         }
         _loc3_ = var_2230.findChildByName("Boy");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onGenderSelectionMouseEvent);
         }
         _loc3_ = var_2230.findChildByName("Girl");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onGenderSelectionMouseEvent);
         }
      }
      
      private function hideGenderSelectionInterface() : void
      {
         if(var_2230 != null)
         {
            var_2230.dispose();
            var_2230 = null;
         }
      }
      
      private function onGenderSelectionWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideGenderSelectionInterface();
      }
      
      private function onGenderSelectionMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "Boy":
               requestEditor("M");
               hideGenderSelectionInterface();
               break;
            case "Girl":
               requestEditor("F");
               hideGenderSelectionInterface();
               break;
            case "close":
            case "close_btn":
               hideGenderSelectionInterface();
         }
      }
      
      private function requestEditor(param1:String) : void
      {
         var _loc2_:RoomWidgetClothingChangeMessage = new RoomWidgetClothingChangeMessage("RWCCM_REQUEST_EDITOR",param1,var_455,var_1114,var_369);
         messageListener.processWidgetMessage(_loc2_);
      }
   }
}
