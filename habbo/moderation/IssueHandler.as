package com.sulake.habbo.moderation
{
    import assets.class_14

    import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1722;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1746;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1785;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_1033;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_570;
   
   public class IssueHandler implements ITrackedWindow, IIssueHandler, IUpdateReceiver
   {
      
      private static const USELESS_REPORTS_TOPIC_ID:int = 27;
      
      private static const AUTO_TOPIC_ID:int = 28;
      
      private static const const_1185:int = 1;
      
      private static const AUTO_TRIGGERED_CATEGORY_ID:int = 3;
       
      
      private var _moderationManager:ModerationManager;
      
      private var var_1740:IssueBundle;
      
      private var var_2262:class_1722;
      
      private var _window:class_3514;
      
      private var var_4843:Vector.<class_1746>;
      
      private var var_3324:Array;
      
      private var _topicDropdown:class_3520;
      
      private var _callerUserInfo:UserInfoCtrl;
      
      private var _reportedUserInfo:UserInfoCtrl;
      
      private var _disposed:Boolean;
      
      private var var_4714:int;
      
      private var var_2949:ChatlogCtrl;
      
      private var _chatFrame:IWindowContainer;
      
      private var var_2643:IItemListWindow;
      
      private var var_3314:int = 0;
      
      private var var_2534:int;
      
      private var var_2453:int;
      
      private var _lastWindowWidth:int;
      
      private var var_2707:int;
      
      private var var_3909:uint;
      
      private var var_3246:IWindowContainer;
      
      private var var_3114:ITextFieldWindow;
      
      public function IssueHandler(param1:ModerationManager, param2:IssueBundle, param3:Vector.<class_1746>, param4:int, param5:int, param6:int, param7:int)
      {
         var_3909 = getTimer();
         super();
         _moderationManager = param1;
         var_1740 = param2;
         var_4843 = param3;
         var_2534 = param4;
         var_2453 = param5;
         _lastWindowWidth = param6;
         var_2707 = param7;
      }
      
      public function getType() : int
      {
         return 8;
      }
      
      public function getId() : String
      {
         return "" + var_1740.id;
      }
      
      public function getFrame() : class_3514
      {
         return _window;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(this._callerUserInfo != null)
         {
            this._callerUserInfo.dispose();
            this._callerUserInfo = null;
         }
         if(this._reportedUserInfo != null)
         {
            this._reportedUserInfo.dispose();
            this._reportedUserInfo = null;
         }
         if(this.var_2949 != null)
         {
            this.var_2949.dispose();
            this.var_2949 = null;
         }
         if(var_3246)
         {
            var_3246.dispose();
            var_3246 = null;
         }
         if(var_3114)
         {
            var_3114.dispose();
            var_3114 = null;
         }
         _moderationManager.removeUpdateReceiver(this);
         _moderationManager = null;
         var_1740 = null;
      }
      
      public function show() : void
      {
         var _loc5_:IItemListWindow = null;
         var _loc6_:IWindow = null;
         if(_window != null)
         {
            return;
         }
         if(_moderationManager.windowManager == null || _moderationManager.assets == null)
         {
            return;
         }
         _window = _moderationManager.getXmlWindow("issue_handler") as class_3514;
         if(_window == null)
         {
            return;
         }
         var _loc3_:IItemListWindow = _window.findChildByName("issues_item_list") as IItemListWindow;
         var_3246 = _loc3_.getListItemAt(0) as IWindowContainer;
         _loc3_.removeListItems();
         var _loc2_:IItemListWindow = _window.findChildByName("msg_item_list") as IItemListWindow;
         var_3114 = _loc2_.getListItemAt(0) as ITextFieldWindow;
         _loc2_.removeListItems();
         var _loc7_:IWindow;
         if((_loc7_ = _window.findChildByTag("close")) != null)
         {
            _loc7_.addEventListener("WME_CLICK",onClose);
         }
         if((_loc7_ = _window.findChildByName("issue_cont")) != null)
         {
            _loc7_.addEventListener("WE_RELOCATED",onWindowRelocatedOrResized);
            _loc7_.addEventListener("WE_RESIZED",onWindowRelocatedOrResized);
            _moderationManager.registerUpdateReceiver(this,1000);
         }
         var_3909 = getTimer();
         setProc("close_useless",onCloseUseless);
         setProc("close_sanction",onCloseSanction);
         setProc("close_resolved",onCloseResolved);
         setProc("release",onRelease);
         if((_loc7_ = _window.findChildByName("move_to_player_support")) != null)
         {
            _loc7_.disable();
         }
         _moderationManager.issueManager.requestSanctionData(var_1740.id,-1);
         initializeTopicDropdown();
         var_2262 = var_1740.getHighestPriorityIssue();
         _callerUserInfo = new UserInfoCtrl(_window,_moderationManager,var_2262,this);
         _reportedUserInfo = new UserInfoCtrl(_window,_moderationManager,var_2262,this);
         _callerUserInfo.load(IWindowContainer(_window.findChildByName("caller_user_info")),var_2262.reporterUserId);
         if(var_2262.categoryId == 3 && var_2262.reportedCategoryId == 28)
         {
            _topicDropdown.selection = var_4714;
            _moderationManager.issueManager.requestSanctionData(var_1740.id,1);
         }
         var _loc1_:IWindowContainer = IWindowContainer(_window.findChildByName("reported_user_info"));
         if(var_1740.reportedUserId > 0)
         {
            _reportedUserInfo.load(_loc1_,var_1740.reportedUserId);
         }
         else
         {
            _loc5_ = IItemListWindow(_window.findChildByName("issue_cont"));
            _loc6_ = _window.findChildByName("reported_user_info_caption");
            _loc5_.removeListItem(_loc6_);
            _loc5_.removeListItem(_loc1_);
         }
         var _loc4_:class_3398;
         if((_loc4_ = _window.findChildByName("handle_next_checkbox") as class_3398) != null)
         {
            _loc4_.select();
         }
         _chatFrame = IWindowContainer(_window.findChildByName("chat_cont"));
         var_2643 = IItemListWindow(_chatFrame.findChildByName("evidence_list"));
         var_2949 = new ChatlogCtrl(new class_1033(var_2262.issueId),_moderationManager,3,var_2262.issueId,var_2262,_chatFrame,var_2643,true);
         var_2949.show();
         class_14.log("HARASSER: " + var_1740.reportedUserId);
         updateIssueList();
         updateMessages();
      }
      
      private function sendWindowPreferences() : void
      {
         var_2534 = _window.x;
         var_2453 = _window.y;
         _lastWindowWidth = _window.width;
         var_2707 = _window.height;
         _moderationManager.issueManager.setToolPreferences(var_2534,var_2453,_lastWindowWidth,var_2707);
         _moderationManager.connection.send(new class_570(var_2534,var_2453,_lastWindowWidth,var_2707));
      }
      
      private function windowDimensionsChanged() : Boolean
      {
         if(var_2534 != _window.x)
         {
            return true;
         }
         if(var_2453 != _window.y)
         {
            return true;
         }
         if(_lastWindowWidth != _window.width)
         {
            return true;
         }
         if(var_2707 != _window.height)
         {
            return true;
         }
         return false;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:uint = uint(getTimer());
         if(windowDimensionsChanged() && _loc2_ - var_3909 > 5000)
         {
            sendWindowPreferences();
         }
      }
      
      private function onWindowRelocatedOrResized(param1:WindowEvent) : void
      {
         var _loc4_:IItemListWindow;
         if((_loc4_ = param1.window as IItemListWindow) == null)
         {
            return;
         }
         var _loc5_:IItemListWindow = _loc4_.getListItemByName("issues_item_list") as IItemListWindow;
         var _loc3_:IItemListWindow = _loc4_.getListItemByName("msg_item_list") as IItemListWindow;
         if(_loc5_ == null || _loc3_ == null)
         {
            return;
         }
         var _loc2_:int = (_loc4_.height - _loc4_.scrollableRegion.height + _loc5_.height + _loc3_.height) * 0.5;
         _loc4_.autoArrangeItems = false;
         _loc5_.height = _loc2_;
         _loc3_.height = _loc2_;
         _loc4_.autoArrangeItems = true;
      }
      
      private function updateIssueList() : void
      {
         var _loc1_:IWindowContainer = null;
         var _loc10_:IWindowContainer = null;
         var _loc2_:IWindow = null;
         var _loc4_:* = null;
         var _loc13_:String = null;
         if(_window == null)
         {
            return;
         }
         var _loc6_:IItemListWindow;
         if((_loc6_ = _window.findChildByName("issues_item_list") as IItemListWindow) == null)
         {
            return;
         }
         var _loc8_:Array = var_1740.issues;
         var _loc7_:int = 0;
         var _loc12_:int = _loc6_.numListItems;
         var _loc3_:int = int(_loc8_.length);
         if(_loc12_ < _loc3_)
         {
            _loc1_ = var_3246.clone() as IWindowContainer;
            _loc6_.addListItem(_loc1_);
            _loc7_ = 1;
            while(_loc7_ < _loc3_ - _loc12_)
            {
               if((_loc10_ = _loc1_.clone() as IWindowContainer) == null)
               {
                  return;
               }
               _loc6_.addListItem(_loc10_);
               _loc7_++;
            }
         }
         else if(_loc12_ > _loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc12_ - _loc3_)
            {
               _loc2_ = _loc6_.removeListItemAt(0);
               _loc2_.dispose();
               _loc7_++;
            }
         }
         var _loc9_:class_1722;
         var _loc11_:int = int((_loc9_ = var_1740.getHighestPriorityIssue()) == null ? 0 : _loc9_.issueId);
         var _loc5_:int = getTimer();
         _loc7_ = 0;
         for each(_loc4_ in _loc8_)
         {
            _loc1_ = _loc6_.getListItemAt(_loc7_) as IWindowContainer;
            if(_loc1_ == null)
            {
               return;
            }
            _loc1_.background = _loc7_++ % 2 == 0;
            _loc1_.id = _loc4_.issueId;
            _loc1_.removeEventListener("WME_CLICK",onIssueClicked);
            _loc1_.addEventListener("WME_CLICK",onIssueClicked);
            setCaption(_loc1_.findChildByName("reporter"),_loc4_.reporterUserName);
            setCaption(_loc1_.findChildByName("type"),class_3472.getSourceName(_loc4_.categoryId));
            setCaption(_loc1_.findChildByName("category"),class_3472.getCategoryName(_loc4_.reportedCategoryId));
            setCaption(_loc1_.findChildByName("time_open"),_loc4_.getOpenTime(_loc5_));
            _loc13_ = _loc4_.issueId == _loc11_ && _loc3_ > 1 ? "Volter Bold" : "Volter";
            (_loc1_.findChildByName("category") as ITextWindow).fontFace = _loc13_;
         }
      }
      
      private function updateMessages() : void
      {
         var _loc1_:ITextFieldWindow = null;
         var _loc6_:ITextWindow = null;
         var _loc2_:IWindow = null;
         var _loc5_:* = null;
         if(_window == null)
         {
            return;
         }
         var _loc4_:IItemListWindow;
         if((_loc4_ = _window.findChildByName("msg_item_list") as IItemListWindow) == null)
         {
            return;
         }
         var _loc8_:Array = var_1740.issues;
         var _loc7_:int = 0;
         var _loc9_:int = _loc4_.numListItems;
         var _loc3_:int = int(_loc8_.length);
         if(_loc9_ < _loc3_)
         {
            _loc1_ = var_3114.clone() as ITextFieldWindow;
            _loc1_.selectable = true;
            _loc1_.editable = false;
            _loc4_.addListItem(_loc1_);
            _loc7_ = 1;
            while(_loc7_ < _loc3_ - _loc9_)
            {
               if((_loc6_ = _loc1_.clone() as ITextWindow) == null)
               {
                  return;
               }
               _loc4_.addListItem(_loc6_);
               _loc7_++;
            }
         }
         else if(_loc9_ > _loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc9_ - _loc3_)
            {
               _loc2_ = _loc4_.removeListItemAt(0);
               _loc2_.dispose();
               _loc7_++;
            }
         }
         _loc7_ = 0;
         for each(_loc5_ in _loc8_)
         {
            _loc1_ = _loc4_.getListItemAt(_loc7_) as ITextFieldWindow;
            if(_loc1_ == null)
            {
               return;
            }
            _loc1_.width = _loc4_.width;
            _loc1_.background = _loc7_++ % 2 == 0;
            _loc1_.caption = _loc5_.reporterUserName + ": " + _loc5_.message;
            _loc1_.height = _loc1_.textHeight + 10;
         }
      }
      
      private function setCaption(param1:IWindow, param2:String) : void
      {
         if(param1 != null)
         {
            param1.caption = param2;
         }
      }
      
      private function initializeTopicDropdown() : void
      {
         _topicDropdown = _window.findChildByName("cfh_topics") as class_3520;
         var _loc1_:* = -1;
         var _loc6_:int;
         if((_loc6_ = var_1740.getHighestPriorityIssue().reportedCategoryId) == 27)
         {
            _topicDropdown.disable();
            return;
         }
         var_3324 = [];
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         for each(var _loc5_ in var_4843)
         {
            for each(var _loc4_ in _loc5_.topics)
            {
               _loc2_[_loc3_] = "${help.cfh.topic." + _loc4_.id + "}";
               var_3324[_loc3_] = _loc4_.id;
               if(_loc4_.id == 1)
               {
                  var_4714 = _loc3_;
               }
               if(_loc4_.id == _loc6_)
               {
                  _loc1_ = _loc3_;
               }
               _loc3_++;
            }
         }
         _topicDropdown.populate(_loc2_);
         if(_loc1_ >= 0)
         {
            _topicDropdown.selection = _loc1_;
         }
         _topicDropdown.addEventListener("WE_SELECTED",refreshSanctionDataForSelectedTopic);
      }
      
      private function refreshSanctionDataForSelectedTopic(param1:WindowEvent) : void
      {
         var _loc3_:int = _topicDropdown.selection;
         var _loc2_:int = int(var_3324[_loc3_]);
         _moderationManager.issueManager.requestSanctionData(var_1740.id,_loc2_);
      }
      
      private function setProc(param1:String, param2:Function) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",param2);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         if(_moderationManager != null && _moderationManager.issueManager != null && var_1740 != null)
         {
            _moderationManager.issueManager.removeHandler(var_1740.id);
            trackAction("closeWindow");
         }
         this.dispose();
      }
      
      private function onCloseUseless(param1:WindowMouseEvent) : void
      {
         class_14.log("Close useless clicked");
         trackAction("closeUseless");
         _moderationManager.trackGoogle("actionCountUseless",var_3314);
         _moderationManager.issueManager.closeBundle(var_1740.id,1);
         checkAutoHandling();
         dispose();
      }
      
      private function onCloseResolved(param1:WindowMouseEvent) : void
      {
         class_14.log("Close resolved clicked");
         trackAction("closeResolved");
         _moderationManager.trackGoogle("actionCountResolved",var_3314);
         _moderationManager.issueManager.closeBundle(var_1740.id,3);
         checkAutoHandling();
         dispose();
      }
      
      private function onCloseSanction(param1:WindowMouseEvent) : void
      {
         class_14.log("Close with default sanction clicked");
         trackAction("closeSanction");
         _moderationManager.trackGoogle("actionCountSanction",var_3314);
         var _loc2_:int = -1;
         var _loc3_:int = _topicDropdown.selection;
         if(_loc3_ >= 0)
         {
            _loc2_ = int(var_3324[_loc3_]);
         }
         if(_loc2_ <= 0 && var_1740.getHighestPriorityIssue().reportedCategoryId == 28)
         {
            _moderationManager.windowManager.alert("Topic missing","You need to select the topic first.",0,null);
         }
         else
         {
            _moderationManager.issueManager.closeDefaultAction(var_1740.id,_loc2_);
            checkAutoHandling();
            dispose();
         }
      }
      
      private function onRelease(param1:WindowMouseEvent) : void
      {
         class_14.log("Release clicked");
         trackAction("release");
         _moderationManager.issueManager.releaseBundle(var_1740.id);
         checkAutoHandling();
         dispose();
      }
      
      private function onIssueClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:int = 0;
         for each(var _loc2_ in var_1740.issues)
         {
            if(_loc2_.issueId == param1.window.id)
            {
               var_2262 = _loc2_;
               _loc3_ = _loc2_.reporterUserId;
               if(_loc3_ != 0)
               {
                  if(_callerUserInfo != null)
                  {
                     _callerUserInfo.dispose();
                  }
                  _callerUserInfo = new UserInfoCtrl(_window,_moderationManager,_loc2_,this);
                  _callerUserInfo.load(IWindowContainer(_window.findChildByName("caller_user_info")),_loc3_);
                  _moderationManager.connection.send(new class_1033(_loc2_.issueId));
                  var_2949.setId(_loc2_.issueId);
                  _moderationManager.messageHandler.addChatlogListener(var_2949);
               }
               break;
            }
         }
      }
      
      public function updateIssuesAndMessages() : void
      {
         updateIssueList();
         updateMessages();
      }
      
      public function showDefaultSanction(param1:int, param2:String) : void
      {
         if(_window == null || _moderationManager == null || _moderationManager.issueManager == null || var_1740 == null)
         {
            return;
         }
         if(param1 != var_1740.reportedUserId)
         {
            return;
         }
         var _loc3_:ITextWindow = _window.findChildByName("sanction_label") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.caption = param2;
         }
      }
      
      private function checkAutoHandling() : void
      {
         if(_window == null || _moderationManager == null || _moderationManager.issueManager == null)
         {
            return;
         }
         var _loc1_:class_3398 = _window.findChildByName("handle_next_checkbox") as class_3398;
         if(_loc1_ != null && Boolean(_loc1_.isSelected))
         {
            _moderationManager.issueManager.autoPick("issue handler pick next");
         }
      }
      
      internal function get callerUserInfo() : UserInfoCtrl
      {
         return _callerUserInfo;
      }
      
      internal function get reportedUserInfo() : UserInfoCtrl
      {
         return _reportedUserInfo;
      }
      
      internal function trackAction(param1:String) : void
      {
         if(_moderationManager == null || _moderationManager.disposed)
         {
            return;
         }
         var_3314++;
         _moderationManager.trackGoogle("issueHandler_" + param1);
      }
   }
}
