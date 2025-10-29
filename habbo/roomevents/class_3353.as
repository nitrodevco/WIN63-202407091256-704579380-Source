package com.sulake.habbo.roomevents
{
    import assets.class_14

    import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniConditionEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredSaveSuccessEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1752;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.OpenEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniTriggerEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredRewardResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniSelectorEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniActionEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniAddonEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredValidationErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredFurniVariableEvent;
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
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.class_1267;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1280;
   import com.sulake.habbo.communication.messages.incoming.room.engine.ObjectRemoveMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   
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
         addMessageEvent(new WiredSaveSuccessEvent(onSaveSuccess));
         addMessageEvent(new WiredFurniVariableEvent(onVariable));
         addMessageEvent(new WiredFurniAddonEvent(onAddon));
         addMessageEvent(new WiredValidationErrorEvent(onValidationError));
         addMessageEvent(new WiredRewardResultMessageEvent(onRewardFailed));
         addMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
         addMessageEvent(new WiredFurniSelectorEvent(onSelector));
         addMessageEvent(new WiredFurniConditionEvent(onCondition));
         addMessageEvent(new ObjectRemoveMessageEvent(onObjectRemove));
         addMessageEvent(new OpenEvent(onOpen));
         addMessageEvent(new UserObjectEvent(onUserObject));
         addMessageEvent(new GuildMembershipsMessageEvent(onGuildMemberships));
         addMessageEvent(new WiredFurniTriggerEvent(onTrigger));
         addMessageEvent(new WiredFurniActionEvent(onAction));
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_roomEvents.communication.addHabboConnectionMessageEvent(param1));
      }
      
      private function onOpen(param1:IMessageEvent) : void
      {
         var _loc2_:class_1150 = (param1 as OpenEvent).getParser();
         _roomEvents.send(new class_833(_loc2_.stuffId));
      }
      
      private function onTrigger(param1:IMessageEvent) : void
      {
         var _loc2_:class_1597 = (param1 as WiredFurniTriggerEvent).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onAction(param1:IMessageEvent) : void
      {
         var _loc2_:class_1148 = (param1 as WiredFurniActionEvent).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onCondition(param1:IMessageEvent) : void
      {
         var _loc2_:class_1311 = (param1 as WiredFurniConditionEvent).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onAddon(param1:IMessageEvent) : void
      {
         var _loc2_:class_1196 = (param1 as WiredFurniAddonEvent).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onVariable(param1:IMessageEvent) : void
      {
         var _loc2_:class_1444 = (param1 as WiredFurniVariableEvent).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onSelector(param1:IMessageEvent) : void
      {
         var _loc2_:class_1209 = (param1 as WiredFurniSelectorEvent).getParser();
         _roomEvents.userDefinedRoomEventsCtrl.prepareForUpdate(_loc2_.def);
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:class_1267 = (param1 as UserObjectEvent).getParser();
         _roomEvents.userName = _loc2_.name;
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         _roomEvents.userDefinedRoomEventsCtrl.close();
      }
      
      private function onObjectRemove(param1:IMessageEvent) : void
      {
         var _loc2_:class_1280 = (param1 as ObjectRemoveMessageEvent).getParser();
         class_14.log("Received object remove event: " + _loc2_.id + ", " + _loc2_.isExpired);
         _roomEvents.userDefinedRoomEventsCtrl.stuffRemoved(_loc2_.id);
      }
      
      private function onRewardFailed(param1:IMessageEvent) : void
      {
         var _loc2_:class_1403 = WiredRewardResultMessageEvent(param1).getParser();
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
         var _loc3_:class_1628 = WiredValidationErrorEvent(param1).getParser();
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
      
      private function onGuildMemberships(param1:GuildMembershipsMessageEvent) : void
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
