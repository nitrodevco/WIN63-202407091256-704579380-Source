package com.sulake.habbo.moderation
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1722;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_1670;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorUserInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetUserChatlogMessageComposer;
   
   public class UserInfoCtrl implements IDisposable, class_3619
   {
      
      private static const secsInMinute:int = 60;
      
      private static const secsInHour:int = 3600;
      
      private static const secsInDay:int = 86400;
      
      private static const secsInYear:int = 31536000;
       
      
      private var _callerFrame:class_3514;
      
      private var _main:ModerationManager;
      
      private var var_418:int;
      
      private var var_3769:class_1722;
      
      private var var_47:class_1670;
      
      private var var_3203:IWindowContainer;
      
      private var _openToolsBelow:Boolean;
      
      private var _disposed:Boolean;
      
      private var var_2679:IssueHandler;
      
      public function UserInfoCtrl(param1:class_3514, param2:ModerationManager, param3:class_1722, param4:IssueHandler = null, param5:Boolean = false)
      {
         super();
         _callerFrame = param1;
         _main = param2;
         var_3769 = param3;
         _openToolsBelow = param5;
         var_2679 = param4;
      }
      
      public static function formatTime(param1:int) : String
      {
         if(param1 < 2 * 60)
         {
            return param1 + " secs ago";
         }
         if(param1 < 2 * 3600)
         {
            return Math.round(param1 / 60) + " mins ago";
         }
         if(param1 < 2 * 86400)
         {
            return Math.round(param1 / 3600) + " hours ago";
         }
         if(param1 < 2 * 31536000)
         {
            return Math.round(param1 / 86400) + " days ago";
         }
         return Math.round(param1 / 31536000) + " years ago";
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function load(param1:IWindowContainer, param2:int) : void
      {
         var_3203 = param1;
         var_418 = param2;
         var_47 = null;
         refresh();
         _main.messageHandler.addUserInfoListener(this);
         _main.connection.send(new GetModeratorUserInfoMessageComposer(param2));
      }
      
      public function onUserInfo(param1:class_1670) : void
      {
         if(param1.userId != var_418)
         {
            return;
         }
         var_47 = param1;
         refresh();
      }
      
      public function refresh() : void
      {
         if(var_3203.disposed)
         {
            return;
         }
         var _loc1_:IWindowContainer = prepare();
         if(var_47 == null)
         {
            _loc1_.findChildByName("fields").visible = false;
            _loc1_.findChildByName("loading_txt").visible = true;
            return;
         }
         _loc1_.findChildByName("fields").visible = true;
         _loc1_.findChildByName("loading_txt").visible = false;
         setTxt(_loc1_,"name_txt",var_47.userName);
         setTxt(_loc1_,"registered_txt",formatTime(var_47.registrationAgeInMinutes * 60));
         setTxt(_loc1_,"cfh_count_txt","" + var_47.cfhCount);
         setAlertTxt(_loc1_,"abusive_cfh_count_txt",var_47.abusiveCfhCount);
         setAlertTxt(_loc1_,"caution_count_txt",var_47.cautionCount);
         setAlertTxt(_loc1_,"ban_count_txt",var_47.banCount);
         setAlertTxt(_loc1_,"trading_lock_count_txt",var_47.tradingLockCount);
         setTxt(_loc1_,"trading_lock_expiry_txt",var_47.tradingExpiryDate,"No active lock");
         setTxt(_loc1_,"last_login_txt",formatTime(var_47.minutesSinceLastLogin * 60));
         setTxt(_loc1_,"online_txt",var_47.online ? "Yes" : "No");
         setTxt(_loc1_,"last_purchase_txt",var_47.lastPurchaseDate,"No purchases");
         setTxt(_loc1_,"email_address_txt",var_47.primaryEmailAddress,"No email found");
         setTxt(_loc1_,"id_bans_txt","" + var_47.identityRelatedBanCount);
         setTxt(_loc1_,"user_class_txt",var_47.userClassification,"-");
         setTxt(_loc1_,"last_sanction_time_txt",var_47.lastSanctionTime);
         if(var_47.sanctionAgeHours <= 48)
         {
            (_loc1_.findChildByName("last_sanction_time_txt") as ITextWindow).textColor = 255 * (48 - var_47.sanctionAgeHours) / 48 << 16;
         }
         if(var_47.primaryEmailAddress == "No identity")
         {
            _loc1_.findChildByName("modaction_but").disable();
         }
         class_14.log("USER: " + var_47.userName + ", " + var_47.banCount + ", " + var_47.cautionCount);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _main.messageHandler.removeUserInfoListener(this);
         _callerFrame = null;
         _main = null;
         var_47 = null;
         var_3203 = null;
      }
      
      private function prepare() : IWindowContainer
      {
         var _loc1_:IWindowContainer = IWindowContainer(var_3203.findChildByName("user_info"));
         if(_loc1_ == null)
         {
            _loc1_ = IWindowContainer(_main.getXmlWindow("user_info"));
            var_3203.addChild(_loc1_);
            _main.initMsg.chatlogsPermission ? null : _loc1_.findChildByName("chatlog_but").disable();
            _main.initMsg.alertPermission ? null : _loc1_.findChildByName("message_but").disable();
            _main.initMsg.alertPermission || _main.initMsg.kickPermission || _main.initMsg.banPermission ? null : _loc1_.findChildByName("modaction_but").disable();
         }
         _loc1_.findChildByName("chatlog_but").procedure = onChatlogButton;
         _loc1_.findChildByName("roomvisits_but").procedure = onRoomVisitsButton;
         _loc1_.findChildByName("habboinfotool_but").procedure = onHabboInfoToolButton;
         _loc1_.findChildByName("message_but").procedure = onMessageButton;
         _loc1_.findChildByName("modaction_but").procedure = onModActionButton;
         _loc1_.findChildByName("view_caution_count_txt").procedure = onViewCautions;
         _loc1_.findChildByName("view_ban_count_txt").procedure = onViewBans;
         _loc1_.findChildByName("view_trading_lock_count_txt").procedure = onViewTradingLocks;
         _loc1_.findChildByName("view_id_bans_txt").procedure = onViewIDBans;
         return _loc1_;
      }
      
      private function setAlertTxt(param1:IWindowContainer, param2:String, param3:int) : void
      {
         var _loc5_:IWindow = param1.findChildByName(param2);
         var _loc4_:IWindow;
         if((_loc4_ = param1.findChildByName("view_" + param2)) != null)
         {
            _loc4_.visible = param3 > 0;
         }
         _loc5_.caption = "" + param3;
      }
      
      private function setTxt(param1:IWindowContainer, param2:String, param3:String, param4:String = "") : void
      {
         var _loc5_:IWindow = ITextWindow(param1.findChildByName(param2));
         if(!param3 || param3.length == 0)
         {
            _loc5_.caption = param4;
         }
         else
         {
            _loc5_.caption = param3;
         }
      }
      
      private function onChatlogButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("chatLog");
         _main.windowTracker.show(new ChatlogCtrl(new GetUserChatlogMessageComposer(var_47.userId),_main,5,var_47.userId),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onRoomVisitsButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new RoomVisitsCtrl(_main,var_47.userId),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onHabboInfoToolButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("openInfoTool");
         _main.openHkPage("habboinfotool.url",var_47.userName);
      }
      
      private function onMessageButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("openSendMessage");
         _main.windowTracker.show(new SendMsgsCtrl(_main,var_47.userId,var_47.userName,var_3769),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onModActionButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("openModAction");
         _main.windowTracker.show(new ModActionCtrl(_main,var_47.userId,var_47.userName,var_3769,this),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onViewCautions(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewCautions");
         showModeratorLog();
      }
      
      private function onViewBans(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewBans");
         showModeratorLog();
      }
      
      private function onViewTradingLocks(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewTradingLocks");
         showModeratorLog();
      }
      
      private function onViewIDBans(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewIdentityInfo");
         showIdentityInformation();
      }
      
      private function showModeratorLog() : void
      {
         _main.openHkPage("moderatoractionlog.url",var_47.userName);
      }
      
      private function showIdentityInformation() : void
      {
         _main.openHkPage("identityinformationtool.url","" + var_47.identityId);
      }
      
      internal function logEvent(param1:String, param2:String) : void
      {
         if(_main != null)
         {
            _main.logEvent(param1,param2);
         }
      }
      
      internal function trackAction(param1:String) : void
      {
         if(var_2679 == null || var_2679.disposed)
         {
            _main.trackGoogle("userInfo_" + param1);
         }
         else if(this == var_2679.callerUserInfo)
         {
            var_2679.trackAction("callerUserInfo_" + param1);
         }
         else if(this == var_2679.reportedUserInfo)
         {
            var_2679.trackAction("reportedUserInfo_" + param1);
         }
         else
         {
            var_2679.trackAction("userInfo_" + param1);
         }
      }
   }
}
