package com.sulake.habbo.roomevents
{
    import assets.class_14

    import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1034;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1042;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1752;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_329;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_362;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_481;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_498;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_586;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_743;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_783;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_857;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.class_833;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1148;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1150;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1196;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1209;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1311;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1403;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1444;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1597;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1628;
   import com.sulake.habbo.communication.messages.incoming.room.session.class_640;
   import com.sulake.habbo.communication.messages.parser.handshake.class_1267;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1280;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_198;
   import com.sulake.habbo.communication.messages.incoming.users.class_596;
   import com.sulake.habbo.communication.messages.incoming.handshake.class_556;
   
   [SecureSWF(rename="true")]
   public class class_3353 implements IDisposable
   {
       
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      public function class_3353(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         _messageEvents = new Vector.<IMessageEvent>(0);
         var _loc2_:IHabboCommunicationManager = _roomEvents.communication;
         addMessageEvent(new class_1042(onSaveSuccess));
         addMessageEvent(new class_857(onVariable));
         addMessageEvent(new class_743(onAddon));
         addMessageEvent(new class_783(onValidationError));
         addMessageEvent(new class_481(onRewardFailed));
         addMessageEvent(new class_640(onRoomExit));
         addMessageEvent(new class_498(onSelector));
         addMessageEvent(new class_1034(onCondition));
         addMessageEvent(new class_198(onObjectRemove));
         addMessageEvent(new class_329(onOpen));
         addMessageEvent(new class_556(onUserObject));
         addMessageEvent(new class_596(onGuildMemberships));
         addMessageEvent(new class_362(onTrigger));
         addMessageEvent(new class_586(onAction));
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_roomEvents.communication.addHabboConnectionMessageEvent(param1));
      }
      
      private function onOpen(param1:IMessageEvent) : void
      {
         var _loc2_:class_1150 = (param1 as class_329).getParser();
         _roomEvents.send(new class_833(_loc2_.stuffId));
      }
      
      private function onTrigger(param1:IMessageEvent) : void
      {
         var _loc2_:class_1597 = (param1 as class_362).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onAction(param1:IMessageEvent) : void
      {
         var _loc2_:class_1148 = (param1 as class_586).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onCondition(param1:IMessageEvent) : void
      {
         var _loc2_:class_1311 = (param1 as class_1034).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onAddon(param1:IMessageEvent) : void
      {
         var _loc2_:class_1196 = (param1 as class_743).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onVariable(param1:IMessageEvent) : void
      {
         var _loc2_:class_1444 = (param1 as class_857).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onSelector(param1:IMessageEvent) : void
      {
         var _loc2_:class_1209 = (param1 as class_498).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:class_1267 = (param1 as class_556).getParser();
         _roomEvents.userName = _loc2_.name;
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         _roomEvents.userDefinedRoomEventsCtrl.close();
      }
      
      private function onObjectRemove(param1:IMessageEvent) : void
      {
         var _loc2_:class_1280 = (param1 as class_198).getParser();
         class_14.log("Received object remove event: " + _loc2_.id + ", " + _loc2_.isExpired);
         _roomEvents.userDefinedRoomEventsCtrl.stuffRemoved(_loc2_.id);
      }
      
      private function onRewardFailed(param1:IMessageEvent) : void
      {
         var _loc2_:class_1403 = class_481(param1).getParser();
         if(_loc2_.reason == 6)
         {
            _roomEvents.windowManager.alert(_roomEvents.localization.getLocalization("wiredfurni.rewardsuccess.title"),_roomEvents.localization.getLocalization("wiredfurni.rewardsuccess.body"),0,null);
         }
         else if(_loc2_.reason == 7)
         {
            _roomEvents.windowManager.alert(_roomEvents.localization.getLocalization("wiredfurni.badgereceived.title"),_roomEvents.localization.getLocalization("wiredfurni.badgereceived.body"),0,null);
         }
         else
         {
            _roomEvents.windowManager.alert(_roomEvents.localization.getLocalization("wiredfurni.rewardfailed.title"),_roomEvents.localization.getLocalization("wiredfurni.rewardfailed.reason." + _loc2_.reason),0,null);
         }
      }
      
      private function onValidationError(param1:IMessageEvent) : void
      {
         var _loc3_:class_1628 = class_783(param1).getParser();
         var _loc6_:Map = new Map();
         for each(var _loc5_ in _loc3_.parameters)
         {
            _loc6_.add(_loc5_.key,_loc5_.value);
         }
         var _loc2_:String = String(_roomEvents.localization.getLocalizationWithParamMap(_loc3_.localizationKey,_loc3_.localizationKey,_loc6_));
         var _loc4_:String = String(_roomEvents.localization.getLocalization("wiredfurni.error.title","Update failed"));
         _roomEvents.windowManager.alert(_loc4_,_loc2_,0,null);
      }
      
      private function onSaveSuccess(param1:IMessageEvent) : void
      {
         _roomEvents.userDefinedRoomEventsCtrl.close();
      }
      
      private function onGuildMemberships(param1:class_596) : void
      {
         _roomEvents.userDefinedRoomEventsCtrl.onGuildMemberships(param1);
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var _loc2_:IHabboCommunicationManager = _roomEvents.communication;
         if(_messageEvents != null && _loc2_ != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _loc2_.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         _roomEvents = null;
      }
      
      public function get disposed() : Boolean
      {
         return _roomEvents == null;
      }
   }
}
