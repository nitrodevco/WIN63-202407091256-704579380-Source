package com.sulake.habbo.moderation
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1722;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1746;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1785;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModKickMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModMessageMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModBanMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModMuteMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.DefaultSanctionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModTradingLockMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModAlertMessageComposer;
   
   public class ModActionCtrl implements IDisposable, ITrackedWindow
   {
      
      private static var var_1837:Array;
      
      private static var var_3343:Map;
       
      
      private var _main:ModerationManager;
      
      private var var_2109:int;
      
      private var _targetUserName:String;
      
      private var var_3769:class_1722;
      
      private var _frame:class_3514;
      
      private var _topicDropdown:class_3520;
      
      private var var_3324:Array;
      
      private var _actionTypeDropdown:class_3520;
      
      private var var_2195:ITextFieldWindow;
      
      private var _disposed:Boolean;
      
      private var var_3010:UserInfoCtrl;
      
      public function ModActionCtrl(param1:ModerationManager, param2:int, param3:String, param4:class_1722, param5:UserInfoCtrl)
      {
         super();
         _main = param1;
         var_2109 = param2;
         _targetUserName = param3;
         var_3769 = param4;
         var_3010 = param5;
         if(var_1837 == null)
         {
            var_1837 = [];
            var_1837.push(new ModActionDefinition(1,"Alert",1,1,0));
            var_1837.push(new ModActionDefinition(2,"Mute 1h",2,2,0));
            var_1837.push(new ModActionDefinition(3,"Ban 18h",3,3,0));
            var_1837.push(new ModActionDefinition(4,"Ban 7 days",3,4,0));
            var_1837.push(new ModActionDefinition(5,"Ban 30 days (step 1)",3,5,0));
            var_1837.push(new ModActionDefinition(7,"Ban 30 days (step 2)",3,7,0));
            var_1837.push(new ModActionDefinition(6,"Ban 100 years",3,6,0));
            var_1837.push(new ModActionDefinition(106,"Ban avatar-only 100 years",3,6,0));
            var_1837.push(new ModActionDefinition(101,"Kick",4,0,0));
            var_1837.push(new ModActionDefinition(102,"Lock trade 1 week",5,0,168));
            var_1837.push(new ModActionDefinition(104,"Lock trade permanent",5,0,876000));
            var_1837.push(new ModActionDefinition(105,"Message",6,0,0));
         }
         _main.issueManager.addModActionView(var_2109,this);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = class_3514(_main.getXmlWindow("modact_summary"));
         _frame.caption = "Mod action on: " + _targetUserName;
         _frame.findChildByName("custom_sanction_button").procedure = onCustomSanctionButton;
         var_2195 = ITextFieldWindow(_frame.findChildByName("message_input"));
         _frame.findChildByName("default_sanction_button").procedure = onDefaultSanctionButton;
         _frame.findChildByName("default_sanction_button").disable();
         initializeTopicToSanctionTypeMapping();
         initializeTopicDropdown();
         initializeActionTypeDropdown();
         var _loc1_:IWindow = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         _frame.visible = true;
      }
      
      public function getType() : int
      {
         return 7;
      }
      
      public function getId() : String
      {
         return _targetUserName;
      }
      
      public function getFrame() : class_3514
      {
         return _frame;
      }
      
      private function logEvent(param1:String, param2:String = "") : void
      {
         if(var_3010 != null)
         {
            var_3010.logEvent(param1,param2);
         }
      }
      
      private function trackAction(param1:String) : void
      {
         if(var_3010 != null && !var_3010.disposed)
         {
            var_3010.trackAction("modAction_" + param1);
         }
      }
      
      private function initializeTopicToSanctionTypeMapping() : void
      {
         var _loc2_:String = null;
         var _loc6_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         if(var_3343 == null)
         {
            var_3343 = new Map();
            _loc2_ = _main.getProperty("cfh.topic_id.to.sanction_type_id");
            if(_loc2_ != null)
            {
               _loc6_ = _loc2_.split(",");
               _loc3_ = 0;
               while(_loc3_ < _loc6_.length)
               {
                  if((_loc4_ = _loc6_[_loc3_].split("=")).length == 2)
                  {
                     _loc1_ = parseInt(String(_loc4_[0]));
                     _loc5_ = parseInt(String(_loc4_[1]));
                     var_3343.add(_loc1_,_loc5_);
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      private function initializeTopicDropdown() : void
      {
         _topicDropdown = class_3520(_frame.findChildByName("cfh_topics"));
         _topicDropdown.addEventListener("WE_SELECTED",refreshSanctionDataForSelectedTopic);
         var_3324 = [];
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         for each(var _loc4_ in _main.issueManager.getCfhTopics())
         {
            for each(var _loc3_ in _loc4_.topics)
            {
               _loc1_[_loc2_] = "${help.cfh.topic." + _loc3_.id + "}";
               var_3324[_loc2_] = _loc3_.id;
               _loc2_++;
            }
         }
         _topicDropdown.populate(_loc1_);
      }
      
      private function refreshSanctionDataForSelectedTopic(param1:WindowEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = _topicDropdown.selection;
         var _loc2_:int = int(var_3324[_loc5_]);
         var _loc3_:int = var_3343.getValue(_loc2_);
         if(!_loc3_)
         {
            _loc3_ = var_3343.getValue(0);
         }
         if(_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < var_1837.length)
            {
               if(var_1837[_loc4_].actionId == _loc3_)
               {
                  _actionTypeDropdown.selection = _loc4_;
                  break;
               }
               _loc4_++;
            }
         }
         else
         {
            _actionTypeDropdown.selection = -1;
         }
         _main.issueManager.requestSanctionDataForAccount(var_2109,_loc2_);
      }
      
      public function showDefaultSanction(param1:int, param2:String) : void
      {
         if(_frame == null || param1 != var_2109)
         {
            return;
         }
         var _loc3_:ITextWindow = _frame.findChildByName("default_sanction_label") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.caption = param2;
         }
         _frame.findChildByName("default_sanction_button").enable();
      }
      
      private function initializeActionTypeDropdown() : void
      {
         _actionTypeDropdown = class_3520(_frame.findChildByName("sanction_type"));
         var _loc1_:Array = [];
         for each(var _loc2_ in var_1837)
         {
            _loc1_.push(_loc2_.name);
         }
         _actionTypeDropdown.populate(_loc1_);
      }
      
      private function onDefaultSanctionButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_topicDropdown.selection < 0)
         {
            _main.windowManager.alert("Alert","Please select a topic.",0,onAlertClose);
            return;
         }
         class_14.log("Giving default sanction...");
         trackAction("defaultAction");
         logEvent("action.default");
         var _loc3_:int = int(var_3324[_topicDropdown.selection]);
         _main.connection.send(new DefaultSanctionMessageComposer(var_2109,_loc3_,var_2195.text,getIssueId()));
         dispose();
      }
      
      private function onCustomSanctionButton(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc6_:* = false;
         var _loc3_:int = 0;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_topicDropdown.selection < 0)
         {
            _main.windowManager.alert("Alert","Please select a topic.",0,onAlertClose);
            return;
         }
         if(_actionTypeDropdown.selection < 0)
         {
            _main.windowManager.alert("Alert","Please select a sanction.",0,onAlertClose);
            return;
         }
         var _loc4_:int = int(var_3324[_topicDropdown.selection]);
         var _loc5_:ModActionDefinition;
         switch((_loc5_ = var_1837[_actionTypeDropdown.selection]).actionType - 1)
         {
            case 0:
               if(!_main.initMsg.alertPermission)
               {
                  _main.windowManager.alert("Alert","You have insufficient permissions.",0,onAlertClose);
                  return;
               }
               trackAction("sendCaution");
               _main.connection.send(new ModAlertMessageComposer(var_2109,var_2195.text,_loc4_,getIssueId()));
               break;
            case 1:
               trackAction("mute");
               _main.connection.send(new ModMuteMessageComposer(var_2109,var_2195.text,_loc4_,getIssueId()));
               break;
            case 2:
               if(!_main.initMsg.banPermission)
               {
                  _main.windowManager.alert("Alert","You have insufficient permissions.",0,onAlertClose);
                  return;
               }
               trackAction("ban");
               _loc6_ = _loc5_.actionId == 106;
               _main.connection.send(new ModBanMessageComposer(var_2109,var_2195.text,_loc4_,_loc5_.sanctionTypeId,_loc6_,getIssueId()));
               break;
            case 3:
               if(!_main.initMsg.kickPermission)
               {
                  _main.windowManager.alert("Alert","You have insufficient permissions.",0,onAlertClose);
                  return;
               }
               trackAction("kick");
               _main.connection.send(new ModKickMessageComposer(var_2109,var_2195.text,_loc4_,getIssueId()));
               break;
            case 4:
               trackAction("trading_lock");
               _loc3_ = _loc5_.actionLengthHours * 60;
               _main.connection.send(new ModTradingLockMessageComposer(var_2109,var_2195.text,_loc3_,_loc4_,getIssueId()));
               break;
            case 5:
               if(StringUtil.isEmpty(var_2195.text))
               {
                  _main.windowManager.alert("Alert","Please write a message to user.",0,onAlertClose);
                  return;
               }
               trackAction("sendCaution");
               _main.connection.send(new ModMessageMessageComposer(var_2109,var_2195.text,_loc4_,getIssueId()));
               break;
         }
         logEvent("action.custom","unknown");
         dispose();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("close");
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _topicDropdown = null;
         var_2195 = null;
         _main.issueManager.removeModActionView(var_2109);
         _main = null;
      }
      
      private function onAlertClose(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function getIssueId() : int
      {
         return var_3769 != null ? var_3769.issueId : -1;
      }
   }
}
