package com.sulake.habbo.moderation
{
    import assets.class_14

    import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_1024
   import com.sulake.habbo.communication.messages.incoming.moderation.class_1068
   import com.sulake.habbo.communication.messages.incoming.moderation.class_1084
   import com.sulake.habbo.communication.messages.incoming.moderation.class_237
   import com.sulake.habbo.communication.messages.incoming.moderation.class_398
   import com.sulake.habbo.communication.messages.incoming.moderation.class_415
   import com.sulake.habbo.communication.messages.incoming.moderation.class_476
   import com.sulake.habbo.communication.messages.incoming.moderation.class_504
   import com.sulake.habbo.communication.messages.incoming.moderation.class_514
   import com.sulake.habbo.communication.messages.incoming.moderation.class_574
   import com.sulake.habbo.communication.messages.incoming.moderation.class_688
   import com.sulake.habbo.communication.messages.incoming.moderation.class_851
   import com.sulake.habbo.communication.messages.parser.moderation.class_1138
   import com.sulake.habbo.communication.messages.parser.moderation.class_1229
   import com.sulake.habbo.communication.messages.parser.moderation.class_1254
   import com.sulake.habbo.communication.messages.parser.moderation.class_1285
   import com.sulake.habbo.communication.messages.parser.moderation.class_1287
   import com.sulake.habbo.communication.messages.parser.moderation.class_1330
   import com.sulake.habbo.communication.messages.parser.moderation.class_1343
   import com.sulake.habbo.communication.messages.parser.moderation.class_1533
   import com.sulake.habbo.communication.messages.parser.moderation.class_1553
   import com.sulake.habbo.communication.messages.parser.moderation.class_1599
   import com.sulake.habbo.communication.messages.parser.moderation.class_1606
   import com.sulake.habbo.communication.messages.parser.moderation.class_1618
   import com.sulake.habbo.communication.messages.parser.moderation.class_1722
   import com.sulake.habbo.communication.messages.parser.moderation.class_1762
   import com.sulake.habbo.userclassification.UserClassificationData;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.room.session.class_640;
   import package_141.*;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1339;
   import com.sulake.habbo.communication.messages.parser.userclassification.class_1201;
   import com.sulake.habbo.communication.messages.parser.callforhelp.class_1223;
   import com.sulake.habbo.communication.messages.parser.callforhelp.class_1245;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_510;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1746;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_177;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_696;
   import package_53.*;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_360;
   import com.sulake.habbo.communication.messages.incoming.userclassification.class_356;
   
   public class ModerationMessageHandler
   {
       
      
      private var _moderationManager:ModerationManager;
      
      private var _userInfoListeners:Array;
      
      private var _roomVisitsListeners:Array;
      
      private var var_3811:Array;
      
      private var _chatlogListeners:Array;
      
      private var _roomInfoListeners:Array;
      
      private var _roomEnterListeners:Array;
      
      public function ModerationMessageHandler(param1:ModerationManager)
      {
         _userInfoListeners = [];
         _roomVisitsListeners = [];
         var_3811 = [];
         _chatlogListeners = [];
         _roomInfoListeners = [];
         _roomEnterListeners = [];
         super();
         _moderationManager = param1;
         var _loc2_:IConnection = param1.connection;
         _loc2_.addMessageEvent(new class_237(onCfhChatlog));
         _loc2_.addMessageEvent(new class_851(onRoomChatlog));
         _loc2_.addMessageEvent(new class_504(onIssueDeleted));
         _loc2_.addMessageEvent(new class_510(onRoomEnter));
         _loc2_.addMessageEvent(new class_476(onIssuePickFailed));
         _loc2_.addMessageEvent(new class_640(onRoomExit));
         _loc2_.addMessageEvent(new class_696(onSanctions));
         _loc2_.addMessageEvent(new class_1068(onModeratorInit));
         _loc2_.addMessageEvent(new class_1084(onIssueInfo));
         _loc2_.addMessageEvent(new class_415(onModeratorActionResult));
         _loc2_.addMessageEvent(new class_514(onRoomInfo));
         _loc2_.addMessageEvent(new class_574(onUserChatlog));
         _loc2_.addMessageEvent(new class_1024(onRoomVisits));
         _loc2_.addMessageEvent(new class_356(onRoomUserClassification));
         _loc2_.addMessageEvent(new class_177(onCfhTopics));
         _loc2_.addMessageEvent(new class_688(onModeratorToolPreferences));
         _loc2_.addMessageEvent(new class_398(onUserInfo));
      }
      
      private function onIssueInfo(param1:class_1084) : void
      {
         if(param1 == null || _moderationManager == null)
         {
            return;
         }
         var _loc2_:class_1618 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:class_1722 = _loc2_.issueData;
         _moderationManager.issueManager.playSound(_loc3_);
         _moderationManager.issueManager.updateIssue(_loc3_);
      }
      
      private function onModeratorInit(param1:class_1068) : void
      {
         var _loc4_:* = null;
         if(param1 == null || _moderationManager == null)
         {
            return;
         }
         var _loc3_:class_1553 = param1.getParser();
         if(_loc3_ == null || _loc3_.data == null)
         {
            return;
         }
         var _loc2_:class_1762 = _loc3_.data;
         var _loc6_:Array = _loc2_.issues;
         var _loc5_:Array = _loc2_.messageTemplates;
         for each(_loc4_ in _loc6_)
         {
            _moderationManager.issueManager.updateIssue(_loc4_);
         }
         _moderationManager.issueManager.updateIssueBrowser();
         _moderationManager.initMsg = _loc2_;
         _moderationManager.startPanel.show();
      }
      
      private function onModeratorToolPreferences(param1:class_688) : void
      {
         var _loc2_:class_1229 = null;
         if(_moderationManager && _moderationManager.issueManager)
         {
            _loc2_ = param1.getParser();
            _moderationManager.issueManager.setToolPreferences(_loc2_.windowX,_loc2_.windowY,_loc2_.windowHeight,_loc2_.windowWidth);
         }
      }
      
      private function onIssuePickFailed(param1:class_476) : void
      {
         var alert:Boolean;
         var issues:Array;
         var retryEnabled:Boolean;
         var retryCount:int;
         var pickedAlready:Boolean;
         var event:class_476 = param1;
         var parser:class_1533 = event.getParser();
         if(parser == null)
         {
            return;
         }
         alert = true;
         issues = parser.issues;
         retryEnabled = parser.retryEnabled;
         retryCount = parser.retryCount;
         pickedAlready = _moderationManager.issueManager.issuePickFailed(issues);
         if(pickedAlready)
         {
            if(retryEnabled)
            {
               if(retryCount < 10)
               {
                  alert = false;
                  _moderationManager.issueManager.autoPick("pick failed retry",retryEnabled,retryCount);
               }
            }
         }
         if(alert)
         {
            _moderationManager.windowManager.alert("Error","Issue picking failed",0,function(param1:class_3348, param2:WindowEvent):void
            {
               param1.dispose();
            });
         }
      }
      
      private function onIssueDeleted(param1:class_504) : void
      {
         if(param1 == null || _moderationManager == null)
         {
            return;
         }
         var _loc2_:class_1285 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         _moderationManager.issueManager.removeIssue(_loc2_.issueId);
      }
      
      private function onUserInfo(param1:class_398) : void
      {
         var _loc3_:class_1138 = param1.getParser();
         class_14.log("GOT USER INFO: " + _loc3_.data.userId + ", " + _loc3_.data.cautionCount);
         for each(var _loc2_ in _userInfoListeners)
         {
            _loc2_.onUserInfo(_loc3_.data);
         }
      }
      
      private function onRoomInfo(param1:class_514) : void
      {
         var _loc2_:* = null;
         var _loc3_:class_1599 = param1.getParser();
         for each(_loc2_ in _roomInfoListeners)
         {
            _loc2_.onRoomInfo(_loc3_.data);
         }
      }
      
      private function onCfhChatlog(param1:class_237) : void
      {
         var _loc3_:class_1254 = param1.getParser();
         var _loc2_:Array = [];
         _loc2_.push(_loc3_.data.chatRecord);
         var _loc4_:Dictionary;
         (_loc4_ = new Dictionary())[_loc3_.data.callerUserId] = 0;
         _loc4_[_loc3_.data.reportedUserId] = 1;
         onChatlog("Call For Help Evidence #" + _loc3_.data.chatRecordId,3,_loc3_.data.callId,_loc2_,_loc4_);
      }
      
      private function onRoomChatlog(param1:class_851) : void
      {
         var _loc3_:class_1606 = param1.getParser();
         var _loc2_:Array = [];
         _loc2_.push(_loc3_.data);
         var _loc4_:Dictionary = new Dictionary();
         onChatlog("Room Chatlog: " + _loc3_.data.roomName,4,_loc3_.data.roomId,_loc2_,_loc4_);
      }
      
      private function onUserChatlog(param1:class_574) : void
      {
         var _loc2_:class_1343 = param1.getParser();
         var _loc3_:Dictionary = new Dictionary();
         _loc3_[_loc2_.data.userId] = 0;
         onChatlog("User Chatlog: " + _loc2_.data.userName,5,_loc2_.data.userId,_loc2_.data.rooms,_loc3_);
      }
      
      private function onChatlog(param1:String, param2:int, param3:int, param4:Array, param5:Dictionary) : void
      {
         var _loc6_:Array = _chatlogListeners.concat();
         for each(var _loc7_ in _loc6_)
         {
            _loc7_.onChatlog(param1,param2,param3,param4,param5);
         }
      }
      
      private function onRoomVisits(param1:class_1024) : void
      {
         var _loc2_:* = null;
         var _loc4_:class_1287 = param1.getParser();
         var _loc3_:Array = _roomVisitsListeners.concat();
         for each(_loc2_ in _loc3_)
         {
            _loc2_.onRoomVisits(_loc4_.data);
         }
      }
      
      private function onRoomUserClassification(param1:class_356) : void
      {
         var _loc9_:* = null;
         var _loc5_:class_1201;
         var _loc10_:Map = (_loc5_ = (param1 as class_356).getParser()).classifiedUsernameMap;
         var _loc3_:Map = _loc5_.classifiedUserTypeMap;
         var _loc6_:int = 1;
         var _loc7_:Array = [];
         for each(var _loc8_ in _loc10_.getKeys())
         {
            _loc7_.push(new UserClassificationData(_loc8_,_loc10_[_loc8_],_loc3_[_loc8_]));
         }
         var _loc2_:UserClassificationCtrl = new UserClassificationCtrl(_moderationManager,_loc6_);
         _loc2_.show();
         var _loc4_:Array = var_3811.concat();
         for each(_loc9_ in _loc4_)
         {
            _loc9_.onUserClassification(_loc6_,_loc7_);
         }
      }
      
      private function onSanctions(param1:class_696) : void
      {
         var _loc2_:class_1223 = param1.getParser();
         class_14.log("Got sanction data..." + [_loc2_.issueId,_loc2_.accountId,_loc2_.sanctionType]);
         _moderationManager.issueManager.updateSanctionData(_loc2_.issueId,_loc2_.accountId,_loc2_.sanctionType);
      }
      
      private function onCfhTopics(param1:class_177) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:class_1245 = param1.getParser();
         _loc2_ = _loc3_.callForHelpCategories;
         _moderationManager.cfhTopics = _loc2_;
      }
      
      private function onRoomEnter(param1:class_510) : void
      {
         var _loc2_:* = null;
         var _loc3_:class_1339 = param1.getParser();
         this._moderationManager.currentFlatId = _loc3_.guestRoomId;
         this._moderationManager.startPanel.guestRoomEntered(_loc3_);
         for each(_loc2_ in _roomEnterListeners)
         {
            _loc2_.onRoomChange();
         }
      }
      
      private function onRoomExit(param1:class_640) : void
      {
         var _loc2_:* = null;
         this._moderationManager.currentFlatId = 0;
         this._moderationManager.startPanel.roomExited();
         for each(_loc2_ in _roomEnterListeners)
         {
            _loc2_.onRoomChange();
         }
      }
      
      private function onModeratorActionResult(param1:class_415) : void
      {
         var _loc2_:class_1330 = param1.getParser();
         class_14.log("GOT MOD ACTION RESULT: " + _loc2_.userId + ", " + _loc2_.success);
         if(_loc2_.success)
         {
            _moderationManager.connection.send(new class_360(_loc2_.userId));
         }
         else
         {
            _moderationManager.windowManager.alert("Alert","Moderation action failed. If you tried to ban a user, please check if the user is already banned.",0,onAlertClose);
         }
      }
      
      public function addUserInfoListener(param1:class_3619) : void
      {
         _userInfoListeners.push(param1);
      }
      
      public function removeUserInfoListener(param1:class_3619) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in _userInfoListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _userInfoListeners = _loc3_;
      }
      
      public function addRoomInfoListener(param1:RoomToolCtrl) : void
      {
         _roomInfoListeners.push(param1);
      }
      
      public function removeRoomInfoListener(param1:RoomToolCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in _roomInfoListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomInfoListeners = _loc3_;
      }
      
      public function addRoomEnterListener(param1:RoomToolCtrl) : void
      {
         _roomEnterListeners.push(param1);
      }
      
      public function removeRoomEnterListener(param1:RoomToolCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in _roomEnterListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomEnterListeners = _loc3_;
      }
      
      public function addRoomVisitsListener(param1:RoomVisitsCtrl) : void
      {
         _roomVisitsListeners.push(param1);
      }
      
      public function removeRoomVisitsListener(param1:RoomVisitsCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in _roomVisitsListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomVisitsListeners = _loc3_;
      }
      
      public function addChatlogListener(param1:class_3593) : void
      {
         _chatlogListeners.push(param1);
      }
      
      public function removeChatlogListener(param1:class_3593) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in _chatlogListeners)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _chatlogListeners = _loc3_;
      }
      
      public function addUserClassificationListener(param1:UserClassificationCtrl) : void
      {
         var_3811.push(param1);
      }
      
      public function removeUserClassificationListener(param1:UserClassificationCtrl) : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in var_3811)
         {
            if(_loc2_ != param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _roomVisitsListeners = _loc3_;
      }
      
      private function onAlertClose(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
      }
   }
}
