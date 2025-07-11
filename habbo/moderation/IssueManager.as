package com.sulake.habbo.moderation
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.utils.StringUtil;
   import flash.events.Event;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1722;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1744;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1746;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_1063;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_344;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_502;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_781;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_834;
   
   public class IssueManager
   {
      
      public static const const_553:String = "issue_bundle_open";
      
      public static const BUNDLE_MY:String = "issue_bundle_my";
      
      public static const const_918:String = "issue_bundle_picked";
      
      public static const PRIORITY_UPDATE_INTERVAL_MS:int = 15000;
      
      public static const RESOLUTION_USELESS:int = 1;
      
      public static const RESOLUTION_RESOLVED:int = 3;
       
      
      private var _moderationManager:ModerationManager;
      
      private var var_2693:IssueBrowser;
      
      private var var_314:Map;
      
      private var var_1756:Map;
      
      private var var_3209:Map;
      
      private var var_2606:Array;
      
      private var var_3015:Array;
      
      private var _issueHandlers:Map;
      
      private var var_3770:Map;
      
      private var var_4331:int = 1;
      
      private var var_4919:int;
      
      private var var_4089:Timer;
      
      private var var_3886:int;
      
      private var var_466:int;
      
      private var var_379:int;
      
      private var _windowWidth:int;
      
      private var var_442:int;
      
      private var var_4776:Vector.<class_1746>;
      
      public function IssueManager(param1:ModerationManager)
      {
         super();
         _moderationManager = param1;
         var_314 = new Map();
         var_1756 = new Map();
         var_3209 = new Map();
         var_2693 = new IssueBrowser(this,_moderationManager.windowManager,_moderationManager.assets);
         var_2606 = [];
         var_3015 = [];
         _issueHandlers = new Map();
         var_3770 = new Map();
         var_4919 = _moderationManager.getInteger("chf.score.updatefactor",60);
         var_3886 = _moderationManager.getInteger("max.call_for_help.results",200);
         var_4089 = new Timer(15000,0);
         var_4089.addEventListener("timer",updateIssueBrowser);
         var_4089.start();
      }
      
      public function get issueListLimit() : int
      {
         return var_3886;
      }
      
      public function init() : void
      {
         var_2693.show();
      }
      
      public function pickBundle(param1:int, param2:String, param3:Boolean = false, param4:int = 0) : void
      {
         var _loc5_:IssueBundle;
         if((_loc5_ = var_1756.getValue(param1) as IssueBundle) == null)
         {
            return;
         }
         sendPick(_loc5_.getIssueIds(),param3,param4,param2);
         var_2606 = var_2606.concat(_loc5_.getIssueIds());
      }
      
      public function autoPick(param1:String, param2:Boolean = false, param3:int = 0) : void
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:Array = var_1756.getValues();
         for each(_loc6_ in _loc5_)
         {
            if(_loc6_.state == 1 && (_loc4_ == null || isBundleHigherPriorityOrOlder(_loc6_,_loc4_)))
            {
               _loc4_ = _loc6_;
            }
         }
         if(_loc4_ == null)
         {
            return;
         }
         pickBundle(_loc4_.id,param1,param2,param3);
      }
      
      private function isBundleHigherPriorityOrOlder(param1:IssueBundle, param2:IssueBundle) : Boolean
      {
         if(param1.highestPriority < param2.highestPriority)
         {
            return true;
         }
         return param1.highestPriority == param2.highestPriority && param1.issueAgeInMilliseconds < param2.issueAgeInMilliseconds;
      }
      
      public function releaseAll() : void
      {
         var _loc3_:* = null;
         if(var_1756 == null)
         {
            return;
         }
         var _loc1_:int = _moderationManager.sessionDataManager.userId;
         var _loc2_:Array = [];
         for each(_loc3_ in var_1756)
         {
            if(_loc3_.state == 2 && _loc3_.pickerUserId == _loc1_)
            {
               _loc2_ = _loc2_.concat(_loc3_.getIssueIds());
            }
         }
         sendRelease(_loc2_);
      }
      
      public function releaseBundle(param1:int) : void
      {
         if(var_1756 == null)
         {
            return;
         }
         var _loc2_:IssueBundle = var_1756.getValue(param1) as IssueBundle;
         if(_loc2_ == null)
         {
            return;
         }
         sendRelease(_loc2_.getIssueIds());
      }
      
      private function sendRelease(param1:Array) : void
      {
         if(param1 == null || param1.length == 0 || _moderationManager == null || _moderationManager.connection == null)
         {
            return;
         }
         _moderationManager.connection.send(new class_344(param1));
         var_3015 = var_3015.concat(param1);
      }
      
      public function playSound(param1:class_1722) : void
      {
         if(var_314[param1.issueId] != null)
         {
            return;
         }
         if(var_2693 == null || !var_2693.isOpen())
         {
            _moderationManager.soundManager.playSound("HBST_call_for_help");
         }
      }
      
      public function updateIssue(param1:class_1722) : void
      {
         var _loc9_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Boolean = false;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var_314.remove(param1.issueId);
         var_314.add(param1.issueId,param1);
         var _loc6_:int;
         if((_loc6_ = var_3209.getValue(param1.issueId)) != 0)
         {
            if((_loc9_ = var_1756.getValue(_loc6_) as IssueBundle) != null)
            {
               if(_loc9_.matches(param1))
               {
                  _loc9_.updateIssue(param1);
               }
               else
               {
                  _loc9_.removeIssue(param1.issueId);
                  if(_loc9_.getIssueCount() == 0)
                  {
                     var_1756.remove(_loc9_.id);
                     removeHandler(_loc9_.id);
                  }
                  var_3209.remove(param1.issueId);
                  _loc9_ = null;
               }
            }
         }
         if(param1.state == 3)
         {
            var_314.remove(param1.issueId);
            return;
         }
         if(_loc9_ == null)
         {
            for each(_loc3_ in var_1756)
            {
               if(_loc3_.matches(param1))
               {
                  (_loc9_ = _loc3_).updateIssue(param1);
                  var_3209.add(param1.issueId,_loc9_.id);
                  break;
               }
            }
         }
         if(_loc9_ == null)
         {
            _loc6_ = var_4331++;
            _loc9_ = new IssueBundle(_loc6_,param1);
            var_3209.add(param1.issueId,_loc6_);
            var_1756.add(_loc6_,_loc9_);
         }
         if(_loc9_ == null)
         {
            return;
         }
         if(var_2606.indexOf(param1.issueId) != -1)
         {
            handleBundle(_loc9_.id);
            _loc2_ = _moderationManager.sessionDataManager.userId;
            if(_loc2_ != param1.pickerUserId)
            {
               if(param1.state == 2)
               {
                  unhandleBundle(_loc9_.id);
               }
            }
         }
         if(param1.state == 1)
         {
            _loc4_ = getBundles("issue_bundle_my");
            _loc5_ = false;
            for each(_loc7_ in _loc4_)
            {
               if(_loc7_.matches(param1,true))
               {
                  _loc5_ = true;
                  break;
               }
            }
            if((_loc8_ = var_3015.indexOf(param1.issueId)) == -1 && _loc5_)
            {
               sendPick([param1.issueId],false,0,"matches bundle with issue: " + _loc7_.getHighestPriorityIssue().issueId);
            }
            else
            {
               var_3015.splice(_loc8_,1);
            }
         }
         updateHandler(_loc9_.id);
         var_2693.update();
      }
      
      public function updateIssueBrowser(param1:Event = null) : void
      {
         if(_moderationManager == null)
         {
            return;
         }
         if(var_2693 != null)
         {
            var_2693.update();
         }
      }
      
      private function updateHandler(param1:int) : void
      {
         var _loc2_:IIssueHandler = _issueHandlers.getValue(param1);
         if(_loc2_ != null)
         {
            _loc2_.updateIssuesAndMessages();
         }
      }
      
      public function removeHandler(param1:int) : void
      {
         var _loc2_:IIssueHandler = _issueHandlers.remove(param1);
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            _loc2_ = null;
         }
      }
      
      public function addModActionView(param1:int, param2:ModActionCtrl) : void
      {
         var_3770.add(param1,param2);
      }
      
      public function removeModActionView(param1:int) : void
      {
         var_3770.remove(param1);
      }
      
      public function removeIssue(param1:int) : void
      {
         var _loc3_:IssueBundle = null;
         if(var_314 == null)
         {
            return;
         }
         var _loc2_:int = var_3209.getValue(param1);
         if(_loc2_ != 0)
         {
            _loc3_ = var_1756.getValue(_loc2_) as IssueBundle;
            if(_loc3_ != null)
            {
               _loc3_.removeIssue(param1);
               if(_loc3_.getIssueCount() == 0)
               {
                  var_1756.remove(_loc3_.id);
               }
            }
         }
         var_314.remove(param1);
         var_2693.update();
      }
      
      public function getBundles(param1:String) : Array
      {
         var _loc4_:* = null;
         if(var_1756 == null)
         {
            return [];
         }
         var _loc3_:Array = [];
         var _loc2_:int = _moderationManager.sessionDataManager.userId;
         for each(_loc4_ in var_1756)
         {
            switch(param1)
            {
               case "issue_bundle_open":
                  if(_loc4_.state == 1)
                  {
                     _loc3_.push(_loc4_);
                  }
                  break;
               case "issue_bundle_my":
                  if(_loc4_.state == 2 && _loc4_.pickerUserId == _loc2_)
                  {
                     _loc3_.push(_loc4_);
                  }
                  break;
               case "issue_bundle_picked":
                  if(_loc4_.state == 2 && _loc4_.pickerUserId != _loc2_)
                  {
                     _loc3_.push(_loc4_);
                  }
                  break;
            }
         }
         return _loc3_;
      }
      
      public function handleBundle(param1:int) : void
      {
         var _loc5_:IssueBundle;
         if((_loc5_ = var_1756.getValue(param1) as IssueBundle) == null)
         {
            return;
         }
         var _loc4_:IIssueHandler = new IssueHandler(_moderationManager,_loc5_,var_4776,var_466,var_379,_windowWidth,var_442);
         _moderationManager.windowTracker.show(_loc4_ as ITrackedWindow,null,false,false,false,true,var_466,var_379,_windowWidth,var_442);
         removeHandler(param1);
         _issueHandlers.add(param1,_loc4_);
         var _loc2_:Array = [];
         for each(var _loc3_ in var_2606)
         {
            if(!_loc5_.contains(_loc3_))
            {
               _loc2_ = _loc2_.concat(_loc3_);
            }
         }
         var_2606 = _loc2_;
      }
      
      public function unhandleBundle(param1:int) : void
      {
         var _loc3_:IssueBundle = var_1756.getValue(param1) as IssueBundle;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:ITrackedWindow = _issueHandlers.remove(param1);
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
      }
      
      public function closeBundle(param1:int, param2:int) : void
      {
         var _loc3_:IssueBundle = var_1756.getValue(param1) as IssueBundle;
         if(_loc3_ == null)
         {
            return;
         }
         sendClose(_loc3_.getIssueIds(),param2);
      }
      
      public function closeDefaultAction(param1:int, param2:int) : void
      {
         var _loc6_:IssueBundle;
         if((_loc6_ = var_1756.getValue(param1) as IssueBundle) == null)
         {
            return;
         }
         var _loc5_:int = _loc6_.getHighestPriorityIssue().issueId;
         var _loc4_:Array = [];
         for each(var _loc3_ in _loc6_.getIssueIds())
         {
            if(_loc3_ != _loc5_)
            {
               _loc4_.push(_loc3_);
            }
         }
         sendCloseDefaultAction(_loc5_,_loc4_,param2);
      }
      
      public function requestSanctionData(param1:int, param2:int) : void
      {
         var _loc3_:IssueBundle = var_1756.getValue(param1) as IssueBundle;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.getHighestPriorityIssue() != null)
         {
            _moderationManager.connection.send(new class_781(_loc3_.getHighestPriorityIssue().issueId,-1,param2));
         }
      }
      
      public function requestSanctionDataForAccount(param1:int, param2:int) : void
      {
         _moderationManager.connection.send(new class_781(-1,param1,param2));
      }
      
      public function updateSanctionData(param1:int, param2:int, param3:class_1744) : void
      {
         var _loc4_:IIssueHandler = null;
         var _loc5_:ModActionCtrl = null;
         var _loc6_:String = param3.name + (param3.avatarOnly ? " (avatar) " : " ");
         if(param3.sanctionLengthInHours > 24)
         {
            _loc6_ += param3.sanctionLengthInHours / 24 + " days";
         }
         else
         {
            _loc6_ += param3.sanctionLengthInHours + "h";
         }
         if(!StringUtil.isEmpty(param3.tradeLockInfo))
         {
            _loc6_ += " & " + param3.tradeLockInfo;
         }
         if(!StringUtil.isEmpty(param3.machineBanInfo))
         {
            _loc6_ += " & " + param3.machineBanInfo;
         }
         if(param1 > 0)
         {
            for each(var _loc7_ in var_1756)
            {
               if(_loc7_.contains(param1))
               {
                  if((_loc4_ = _issueHandlers.getValue(_loc7_.id)) != null)
                  {
                     _loc4_.showDefaultSanction(param2,_loc6_);
                  }
               }
            }
         }
         else if((_loc5_ = var_3770.getValue(param2)) != null)
         {
            _loc5_.showDefaultSanction(param2,_loc6_);
         }
      }
      
      private function sendClose(param1:Array, param2:int) : void
      {
         if(param1 == null || _moderationManager == null || _moderationManager.connection == null)
         {
            return;
         }
         _moderationManager.connection.send(new class_502(param1,param2));
      }
      
      private function sendPick(param1:Array, param2:Boolean, param3:int, param4:String) : void
      {
         if(param1 == null || _moderationManager == null || _moderationManager.connection == null)
         {
            return;
         }
         _moderationManager.connection.send(new class_1063(param1,param2,param3,param4));
      }
      
      private function sendCloseDefaultAction(param1:int, param2:Array, param3:int) : void
      {
         _moderationManager.connection.send(new class_834(param1,param2,param3));
      }
      
      public function autoHandle(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:Array = var_1756.getValues();
         var _loc2_:int = _moderationManager.sessionDataManager.userId;
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.state == 2 && _loc5_.pickerUserId == _loc2_ && _loc5_.id != param1 && (_loc3_ == null || _loc5_.highestPriority < _loc3_.highestPriority))
            {
               _loc3_ = _loc5_;
            }
         }
         if(_loc3_ == null)
         {
            autoPick("issue manager pick next");
            return;
         }
         handleBundle(_loc3_.id);
      }
      
      public function issuePickFailed(param1:Array) : Boolean
      {
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc10_:String = null;
         var _loc2_:int = 0;
         var _loc13_:* = null;
         var _loc5_:* = null;
         var _loc11_:Array = null;
         var _loc12_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:IIssueHandler = null;
         if(!param1)
         {
            return false;
         }
         var _loc7_:Boolean = false;
         var _loc9_:int = _moderationManager.sessionDataManager.userId;
         for each(_loc6_ in param1)
         {
            _loc4_ = int(_loc6_.issueId);
            _loc10_ = _loc6_.pickerUserName;
            _loc2_ = _loc6_.pickerUserId;
            if(_loc2_ != -1 && _loc2_ != _loc9_)
            {
               _loc7_ = true;
            }
            _loc13_ = null;
            for each(_loc5_ in var_1756)
            {
               if((_loc11_ = _loc5_.getIssueIds()) != null)
               {
                  for each(_loc12_ in _loc11_)
                  {
                     if(_loc4_ == _loc12_)
                     {
                        _loc13_ = _loc5_;
                        break;
                     }
                  }
               }
            }
            if(_loc13_ != null)
            {
               _loc8_ = _loc13_.id;
               _loc3_ = _issueHandlers.getValue(_loc8_);
               if(_loc3_ != null)
               {
                  _loc3_.dispose();
               }
               releaseBundle(_loc8_);
            }
         }
         return _loc7_;
      }
      
      public function setToolPreferences(param1:int, param2:int, param3:int, param4:int) : void
      {
         var_466 = param1;
         var_379 = param2;
         var_442 = param3;
         _windowWidth = param4;
      }
      
      public function setCfhTopics(param1:Vector.<class_1746>) : void
      {
         this.var_4776 = param1;
      }
      
      public function getCfhTopics() : Vector.<class_1746>
      {
         return var_4776;
      }
   }
}
