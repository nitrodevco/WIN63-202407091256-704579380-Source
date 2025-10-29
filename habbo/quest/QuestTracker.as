package com.sulake.habbo.quest
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.quest.OpenQuestTrackerMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.StartCampaignMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1715;
   
   public class QuestTracker implements IDisposable
   {
      
      private static const TRACKER_ANIMATION_STATUS_NONE:int = 0;
      
      private static const TRACKER_ANIMATION_STATUS_SLIDE_IN:int = 1;
      
      private static const TRACKER_ANIMATION_STATUS_SLIDE_OUT:int = 2;
      
      private static const TRACKER_ANIMATION_STATUS_COMPLETED_ANIMATION:int = 3;
      
      private static const TRACKER_ANIMATION_STATUS_PROGRESS_NUDGE:int = 4;
      
      private static const TRACKER_ANIMATION_STATUS_CLOSE_WAIT:int = 5;
      
      private static const TRACKER_ANIMATION_STATUS_PROMPT_ANIMATION:int = 6;
      
      private static const NUDGE_OFFSETS:Array = [-2,-3,-2,0,2,3,2,0,2,1,0,1];
      
      private static const const_431:Array = [1,1,2,2,3,3,4,4,5,5,6,6,4];
      
      private static const MAX_SUCCESS_FRAME:int = 6;
      
      private static const PROMPT_SEQUENCE_REPEATS:int = 4;
      
      private static const PROMPT_SEQUENCE_REPEATS_QUEST_OPEN:int = 2;
      
      private static const PROMPT_FRAME_LENGTH_IN_MSECS:int = 200;
      
      private static const PROMPT_FRAMES:Array = ["a","b","c","d"];
      
      private static const PROMPT_DELAY_IN_MSECS:int = 10000;
      
      private static const PROMPT_DELAY_ON_QUEST_OPEN_IN_MSECS:int = 0;
      
      private static const NO_PROMPT_DELAY:int = -1;
      
      private static const PROGRESS_BAR_LOC:Point = new Point(10,87);
      
      private static const PROGRESS_BAR_WIDTH:int = 162;
      
      private static const TRACKER_SLIDE_IN_SPEED:Number = 0.01;
      
      private static const TRACKER_SLIDE_OUT_SPEED:Number = 100;
      
      private static const COMPLETION_CLOSE_DELAY_IN_MSECS:int = 1000;
      
      private static const TOOLBAR_EXTENSION_ID_PREFIX:String = "quest_tracker_";
      
      private static const const_627:int = 10;
      
      private static var var_4028:int = 0;
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_1780:class_1715;
      
      private var _window:IWindowContainer;
      
      private var var_2099:Timer;
      
      private var var_2607:ProgressBar;
      
      private var _trackerAnimationStatus:int = 0;
      
      private var var_2573:int = 0;
      
      private var var_3545:int = 0;
      
      private var _successFrame:int = -1;
      
      private var _msecsUntilPrompt:int = -1;
      
      private var _promptFrame:int = -1;
      
      private var _msecsUntilNextPromptFrame:int;
      
      private var var_3592:int;
      
      private var var_4851:Boolean;
      
      private var var_4728:Boolean;
      
      private var var_3217:Boolean = false;
      
      private var var_3879:int;
      
      public function QuestTracker(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         var_3879 = var_4028;
         var_4028 += 1;
      }
      
      public function dispose() : void
      {
         if(_questEngine)
         {
            _questEngine.toolbar.extensionView.detachExtension("quest_tracker_" + var_3879);
         }
         _questEngine = null;
         var_1780 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_2099)
         {
            var_2099.stop();
            var_2099 = null;
         }
         if(var_2607)
         {
            var_2607.dispose();
            var_2607 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function onQuestCompleted(param1:class_1715, param2:Boolean) : void
      {
         if(_window)
         {
            clearPrompt();
            var_1780 = param1;
            var_2573 = 0;
            refreshTrackerDetails();
            _successFrame = 0;
            _trackerAnimationStatus = 3;
            var_4728 = !param2;
         }
      }
      
      public function onQuestCancelled() : void
      {
         var_1780 = null;
         if(_window)
         {
            clearPrompt();
            var_2607.refresh(0,100,-1,0);
            _trackerAnimationStatus = 2;
         }
      }
      
      public function startDefaultCampaign(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = _questEngine.getInteger("new.identity",0) > 0;
         if(!_loc3_)
         {
            return;
         }
         if(var_2099 == null && _loc3_ && param1 != "")
         {
            _loc2_ = _questEngine.getInteger("questing.startQuestDelayInSeconds",30);
            var_2099 = new Timer(_loc2_ * 1000,1);
            var_2099.addEventListener("timer",onStartQuestTimer);
            var_2099.start();
            class_14.log("Initialized start quest timer with period: " + _loc2_);
         }
      }
      
      public function onRoomExit() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            _window.findChildByName("more_info_txt").visible = false;
            _window.findChildByName("more_info_region").visible = false;
         }
      }
      
      public function onQuest(param1:class_1715) : void
      {
         if(var_2099 != null)
         {
            var_2099.stop();
         }
         var _loc2_:Boolean = _window && _window.visible;
         if(param1.waitPeriodSeconds > 0)
         {
            if(_loc2_)
            {
               setWindowVisible(false);
            }
            return;
         }
         var_1780 = param1;
         prepareTrackerWindow();
         refreshTrackerDetails();
         refreshPromptFrames();
         setWindowVisible(true);
         hideSuccessFrames();
         if(_loc2_)
         {
            if(this._trackerAnimationStatus == 2)
            {
               this._trackerAnimationStatus = 1;
            }
            setupPrompt(_msecsUntilPrompt,4,false);
         }
         else
         {
            this._window.x = getOutScreenLocationX();
            this._trackerAnimationStatus = 1;
            setupPrompt(0,2,false);
         }
      }
      
      private function refreshPromptFrames() : void
      {
         var _loc1_:int = 0;
         if(!_questEngine.isQuestWithPrompts(var_1780))
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < PROMPT_FRAMES.length)
         {
            _questEngine.setupPromptFrameImage(_window,var_1780,PROMPT_FRAMES[_loc1_]);
            _loc1_++;
         }
      }
      
      private function prepareTrackerWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IWindowContainer(_questEngine.getXmlWindow("QuestTracker"));
         _window.findChildByName("more_info_region").procedure = onMoreInfo;
         hideSuccessFrames();
         var_2607 = new ProgressBar(_questEngine,IWindowContainer(_window.findChildByName("content_cont")),162,"quests.tracker.progress",false,PROGRESS_BAR_LOC);
      }
      
      private function hideSuccessFrames() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ <= 6)
         {
            getSuccessFrame(_loc1_).visible = false;
            _loc1_++;
         }
      }
      
      private function hidePromptFrames() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < PROMPT_FRAMES.length)
         {
            getPromptFrame(PROMPT_FRAMES[_loc1_]).visible = false;
            _loc1_++;
         }
      }
      
      private function getSuccessFrame(param1:int) : IWindow
      {
         return _window.findChildByName("success_pic_" + param1);
      }
      
      private function getPromptFrame(param1:String) : IWindow
      {
         return _window.findChildByName("prompt_pic_" + param1);
      }
      
      private function refreshTrackerDetails() : void
      {
         _window.findChildByName("quest_header_txt").caption = _questEngine.localization.getLocalizationWithParams("quests.tracker.caption","","quest_name",_questEngine.getQuestName(var_1780));
         _window.findChildByName("desc_txt").caption = _questEngine.getQuestDesc(var_1780);
         _window.findChildByName("more_info_txt").visible = _questEngine.currentlyInRoom;
         _window.findChildByName("more_info_region").visible = _questEngine.currentlyInRoom;
         var _loc1_:int = Math.ceil(100 * var_1780.completedSteps / var_1780.totalSteps);
         var_2607.refresh(_loc1_,100,var_1780.id,0);
         _questEngine.setupQuestImage(_window,var_1780);
      }
      
      private function onMoreInfo(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.questController.questDetails.showDetails(var_1780);
         }
      }
      
      public function forceWindowCloseAfterAnimationsFinished() : void
      {
         if(_trackerAnimationStatus == 0)
         {
            setWindowVisible(false);
            var_3217 = false;
         }
         else
         {
            var_3217 = true;
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_window == null)
         {
            return;
         }
         var_2607.updateView(param1);
         switch(_trackerAnimationStatus)
         {
            case 0:
               if(_msecsUntilPrompt != -1)
               {
                  _msecsUntilPrompt -= param1;
                  if(_msecsUntilPrompt < 0)
                  {
                     _msecsUntilPrompt = -1;
                     if(var_1780 != null && _questEngine.isQuestWithPrompts(var_1780))
                     {
                        if(var_4851)
                        {
                           startNudge();
                           break;
                        }
                        _trackerAnimationStatus = 6;
                        _promptFrame = 0;
                        _msecsUntilNextPromptFrame = 200;
                     }
                  }
               }
               break;
            case 1:
               _loc4_ = getDefaultLocationX();
               _loc2_ = _window.x - _loc4_;
               if(_loc2_ > 0)
               {
                  _loc3_ = Math.max(1,Math.round(_loc2_ * param1 * 0.01));
                  _window.x -= _loc3_;
               }
               else
               {
                  _trackerAnimationStatus = 0;
                  _window.x = _loc4_;
               }
               break;
            case 2:
               _loc4_ = getOutScreenLocationX();
               _loc2_ = _window.width - _window.x;
               if(_loc2_ > 0)
               {
                  _loc3_ = Math.max(1,Math.round(param1 * 100 / _loc2_));
                  _window.x += _loc3_;
               }
               else
               {
                  _trackerAnimationStatus = 0;
                  _window.x = _loc4_;
                  setWindowVisible(false);
               }
               break;
            case 3:
               hideSuccessFrames();
               getSuccessFrame(const_431[_successFrame]).visible = true;
               _successFrame++;
               if(_successFrame >= const_431.length)
               {
                  _trackerAnimationStatus = 5;
                  var_3545 = 1000;
               }
               break;
            case 4:
               if(var_2573 >= NUDGE_OFFSETS.length - 1)
               {
                  _window.x = getDefaultLocationX();
                  _trackerAnimationStatus = 0;
                  setupPrompt(10000,2,false);
               }
               else
               {
                  _window.x = getDefaultLocationX() + NUDGE_OFFSETS[var_2573];
                  var_2573++;
               }
               break;
            case 5:
               var_3545 -= param1;
               if(var_3545 < 0)
               {
                  _trackerAnimationStatus = 0;
                  if(var_4728 && !var_3217)
                  {
                     _questEngine.send(new OpenQuestTrackerMessageComposer());
                  }
                  else
                  {
                     setWindowVisible(false);
                     var_3217 = false;
                  }
               }
               break;
            case 6:
               setQuestImageVisible(false);
               hidePromptFrames();
               _msecsUntilNextPromptFrame -= param1;
               getPromptFrame(PROMPT_FRAMES[_promptFrame]).visible = true;
               if(_msecsUntilNextPromptFrame < 0)
               {
                  _msecsUntilNextPromptFrame = 200;
                  _promptFrame++;
                  if(_promptFrame >= PROMPT_FRAMES.length)
                  {
                     _promptFrame = 0;
                     var_3592--;
                     if(var_3592 < 1)
                     {
                        setupPrompt(10000,2,true);
                        _trackerAnimationStatus = 0;
                     }
                  }
               }
         }
      }
      
      private function getDefaultLocationX() : int
      {
         return 0;
      }
      
      private function getOutScreenLocationX() : int
      {
         return _window.width + 10;
      }
      
      private function onStartQuestTimer(param1:TimerEvent) : void
      {
         if(this.hasBlockingWindow())
         {
            class_14.log("Quest start blocked. Waiting some more");
            var_2099.reset();
            var_2099.start();
         }
         else
         {
            _questEngine.questController.questDetails.openForNextQuest = _questEngine.getBoolean("questing.showDetailsForNextQuest");
            _questEngine.send(new StartCampaignMessageComposer(_questEngine.questController.getDefaultCampaign()));
         }
      }
      
      private function hasBlockingWindow() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:class_3460 = null;
         _loc2_ = 0;
         while(_loc2_ <= 2)
         {
            _loc1_ = _questEngine.windowManager.getDesktop(_loc2_);
            if(_loc1_ != null && hasBlockingWindowInLayer(_loc1_))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function hasBlockingWindowInLayer(param1:IWindowContainer) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:IWindow = null;
         while(_loc3_ < param1.numChildren)
         {
            _loc2_ = param1.getChildAt(_loc3_);
            if(_loc2_ != null && _loc2_.visible)
            {
               if(_loc2_ as class_3514 != null)
               {
                  if(_loc2_.name != "mod_start_panel" && _loc2_.name != "_frame")
                  {
                     return true;
                  }
               }
               else if(_loc2_.name == "welcome_screen")
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      private function setQuestImageVisible(param1:Boolean) : void
      {
         _window.findChildByName("quest_pic_bitmap").visible = param1;
      }
      
      private function clearPrompt() : void
      {
         setupPrompt(-1,0,false);
      }
      
      private function setupPrompt(param1:int, param2:int, param3:Boolean) : void
      {
         setQuestImageVisible(true);
         hidePromptFrames();
         _msecsUntilPrompt = param1;
         var_3592 = param2;
         var_4851 = param3;
      }
      
      private function startNudge() : void
      {
         var_2573 = 0;
         _trackerAnimationStatus = 4;
      }
      
      private function setWindowVisible(param1:Boolean) : void
      {
         _window.visible = param1;
         if(!param1)
         {
            _questEngine.toolbar.extensionView.detachExtension("quest_tracker_" + var_3879);
         }
         else
         {
            _questEngine.toolbar.extensionView.attachExtension("quest_tracker_" + var_3879,_window);
         }
      }
      
      public function get campaignChainCode() : String
      {
         if(var_1780 == null)
         {
            return null;
         }
         return var_1780.campaignChainCode;
      }
      
      public function get canBeDisposed() : Boolean
      {
         if(var_1780 == null)
         {
            return true;
         }
         if(_window && !_window.visible && _trackerAnimationStatus == 0)
         {
            return true;
         }
         return false;
      }
   }
}
