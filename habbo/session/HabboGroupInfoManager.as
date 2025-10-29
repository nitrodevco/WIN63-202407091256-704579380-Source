package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.class_575;
   
   public class HabboGroupInfoManager implements IDisposable
   {
       
      
      private var _sessionDataManager:SessionDataManager;
      
      private var var_121:Map;
      
      private var var_4588:IMessageEvent;
      
      private var var_2920:IMessageEvent;
      
      public function HabboGroupInfoManager(param1:SessionDataManager)
      {
         super();
         _sessionDataManager = param1;
         var_121 = new Map();
         if(_sessionDataManager.communication)
         {
            var_4588 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new RoomReadyMessageEvent(onRoomReady));
            var_2920 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new HabboGroupBadgesMessageEvent(onHabboGroupBadges));
         }
      }
      
      public function get disposed() : Boolean
      {
         return _sessionDataManager == null;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_sessionDataManager.communication)
         {
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(var_4588);
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(var_2920);
         }
         var_121 = null;
         _sessionDataManager = null;
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         _sessionDataManager.send(new class_575());
      }
      
      private function onHabboGroupBadges(param1:HabboGroupBadgesMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Map = param1.badges;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_.getKey(_loc4_);
            var_121.remove(_loc3_);
            var_121.add(_loc3_,_loc2_.getWithIndex(_loc4_));
            _loc4_++;
         }
      }
      
      public function getBadgeId(param1:int) : String
      {
         return var_121.getValue(param1);
      }
   }
}
