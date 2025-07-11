package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.ChooserItem;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class FurniChooserWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_318:Boolean = false;
      
      public function FurniChooserWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_CHOOSER";
      }
      
      public function dispose() : void
      {
         var_318 = true;
         _container = null;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWRWM_FURNI_CHOOSER");
         _loc1_.push("RWROM_SELECT_OBJECT");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetRoomObjectMessage = null;
         if(param1 == null)
         {
            return null;
         }
         switch(param1.type)
         {
            case "RWRWM_FURNI_CHOOSER":
               handleFurniChooserRequest();
               break;
            case "RWROM_SELECT_OBJECT":
               _loc2_ = param1 as RoomWidgetRoomObjectMessage;
               if(_loc2_ == null)
               {
                  return null;
               }
               if(_loc2_.category == 10 || _loc2_.category == 20)
               {
                  _container.roomEngine.selectRoomObject(_container.roomSession.roomId,_loc2_.id,_loc2_.category);
               }
               break;
         }
         return null;
      }
      
      private function handleFurniChooserRequest() : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:class_3365 = null;
         var _loc7_:* = null;
         var _loc1_:IRoomObject = null;
         var _loc2_:String = null;
         var _loc10_:int = 0;
         if(_container == null || _container.roomSession == null || _container.roomEngine == null)
         {
            return;
         }
         if(_container.roomSession.userDataManager == null)
         {
            return;
         }
         var _loc9_:int = _container.roomSession.roomId;
         var _loc8_:Array = [];
         var _loc3_:int = _container.roomEngine.getRoomObjectCount(_loc9_,10);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _container.roomEngine.getRoomObjectWithIndex(_loc9_,_loc4_,10);
            if(_loc1_ != null)
            {
               _loc6_ = int(_loc1_.getModel().getNumber("furniture_type_id"));
               if((_loc5_ = _container.sessionDataManager.getFloorItemData(_loc6_)) != null)
               {
                  _loc7_ = _loc5_.localizedName;
               }
               else
               {
                  _loc7_ = _loc1_.getType();
               }
               _loc8_.push(new ChooserItem(_loc1_.getId(),10,_loc7_));
            }
            _loc4_++;
         }
         _loc3_ = _container.roomEngine.getRoomObjectCount(_loc9_,20);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _container.roomEngine.getRoomObjectWithIndex(_loc9_,_loc4_,20);
            if(_loc1_ != null)
            {
               _loc2_ = _loc1_.getType();
               if(_loc2_.indexOf("poster") == 0)
               {
                  _loc10_ = int(_loc2_.replace("poster",""));
                  _loc7_ = String(_container.localization.getLocalization("poster_" + _loc10_ + "_name","poster_" + _loc10_ + "_name"));
               }
               else
               {
                  _loc6_ = int(_loc1_.getModel().getNumber("furniture_type_id"));
                  if((_loc5_ = _container.sessionDataManager.getWallItemData(_loc6_)) != null && _loc5_.localizedName.length > 0)
                  {
                     _loc7_ = _loc5_.localizedName;
                  }
                  else
                  {
                     _loc7_ = _loc2_;
                  }
               }
               _loc8_.push(new ChooserItem(_loc1_.getId(),20,_loc7_));
            }
            _loc4_++;
         }
         _loc8_.sort(compareItems);
         _container.events.dispatchEvent(new RoomWidgetChooserContentEvent("RWCCE_FURNI_CHOOSER_CONTENT",_loc8_,_container.sessionDataManager.isAnyRoomController));
      }
      
      private function compareItems(param1:ChooserItem, param2:ChooserItem) : int
      {
         if(param1 == null || param2 == null || param1.name == param2.name || param1.name.length == 0 || param2.name.length == 0)
         {
            return 1;
         }
         var _loc3_:Array = new Array(param1.name.toUpperCase(),param2.name.toUpperCase()).sort();
         if(_loc3_.indexOf(param1.name.toUpperCase()) == 0)
         {
            return -1;
         }
         return 1;
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}
