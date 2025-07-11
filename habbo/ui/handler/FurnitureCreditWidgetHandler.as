package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetCreditFurniUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetCreditFurniRedeemMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureCreditWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var var_318:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function FurnitureCreditWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_CREDIT_WIDGET";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function dispose() : void
      {
         var_318 = true;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWFWM_MESSAGE_REQUEST_CREDITFURNI","RWFCRM_REDEEM"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc3_:RoomWidgetFurniToWidgetMessage = null;
         var _loc2_:IRoomObject = null;
         var _loc7_:IRoomObjectModel = null;
         var _loc6_:Number = NaN;
         var _loc4_:RoomWidgetCreditFurniUpdateEvent = null;
         var _loc5_:RoomWidgetCreditFurniRedeemMessage = null;
         switch(param1.type)
         {
            case "RWFWM_MESSAGE_REQUEST_CREDITFURNI":
               _loc3_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc2_ = _container.roomEngine.getRoomObject(_loc3_.roomId,_loc3_.id,_loc3_.category);
               if(_loc2_ != null && _container.isOwnerOfFurniture(_loc2_))
               {
                  if((_loc7_ = _loc2_.getModel()) != null)
                  {
                     _loc6_ = Number(_loc7_.getNumber("furniture_credit_value"));
                     _loc4_ = new RoomWidgetCreditFurniUpdateEvent("RWCFUE_CREDIT_FURNI_UPDATE",_loc3_.id,_loc6_);
                     _container.events.dispatchEvent(_loc4_);
                  }
               }
               break;
            case "RWFCRM_REDEEM":
               _loc5_ = param1 as RoomWidgetCreditFurniRedeemMessage;
               if(_container != null && _container.roomSession != null)
               {
                  _container.roomSession.sendCreditFurniRedeemMessage(_loc5_.objectId);
               }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:Event = null;
         if(_container != null && _container.events != null && _loc2_ != null)
         {
            _container.events.dispatchEvent(_loc2_);
         }
      }
      
      public function update() : void
      {
      }
   }
}
