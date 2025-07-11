package com.sulake.habbo.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.help.guidehelp.GuideSessionController;
   import com.sulake.habbo.help.guidehelp.HelpController;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_510;
   import com.sulake.habbo.communication.messages.parser.help.data.class_1698;
   
   public class GuideHelpManager implements IDisposable
   {
       
      
      private var _habboHelp:HabboHelp;
      
      private var var_2898:HelpController;
      
      private var var_2698:GuideSessionController;
      
      private var var_3123:ChatReviewReporterFeedbackCtrl;
      
      private var _disposed:Boolean = false;
      
      private var var_4845:Boolean;
      
      private var var_4992:int;
      
      private var _panicRoomName:String;
      
      private var var_2912:Timer;
      
      public function GuideHelpManager(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         var_2898 = new HelpController(this);
         var_2698 = new GuideSessionController(this);
         var_3123 = new ChatReviewReporterFeedbackCtrl(_habboHelp);
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new class_510(onRoomEnter));
      }
      
      public function get habboHelp() : HabboHelp
      {
         return _habboHelp;
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         if(_habboHelp.newUserTourEnabled && _habboHelp.newIdentity && !var_4845 && !_habboHelp.sessionDataManager.isRealNoob)
         {
            var_2912 = new Timer(getTourPopupDelay(),1);
            var_2912.addEventListener("timer",onTourPopup);
            var_2912.start();
            _habboHelp.tracking.trackEventLog("Help","","tour.new_user.create","",getTourPopupDelay());
            _habboHelp.trackGoogle("newbieTourWindow","timer_popupCreated");
         }
      }
      
      private function onTourPopup(param1:TimerEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         _habboHelp.tracking.trackEventLog("Help","","tour.new_user.show","",getTourPopupDelay());
         _habboHelp.trackGoogle("newbieTourWindow","timer_popupShown");
         openTourPopup();
      }
      
      public function openTourPopup() : void
      {
         var_2898.openTourPopup();
         var_4845 = true;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_2898)
         {
            var_2898.dispose();
            var_2898 = null;
         }
         if(var_2698)
         {
            var_2698.dispose();
            var_2698 = null;
         }
         if(var_3123)
         {
            var_3123.dispose();
            var_3123 = null;
         }
         if(var_2912)
         {
            var_2912.reset();
            var_2912 = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showGuideTool() : void
      {
         var_2698.showGuideTool();
      }
      
      public function showPendingTicket(param1:class_1698) : void
      {
         var_2898.showPendingTicket(param1);
      }
      
      public function createHelpRequest(param1:uint) : void
      {
         var_2698.createHelpRequest(param1);
      }
      
      public function openReportWindow() : void
      {
         var_2698.openReportWindow();
      }
      
      public function showFeedback(param1:String) : void
      {
         var_3123.show(param1);
      }
      
      private function getTourPopupDelay() : int
      {
         return _habboHelp.getInteger("guide.help.new.user.tour.popup.delay",30) * 1000;
      }
      
      public function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_TOOLBAR_CLICK")
         {
            switch(param1.iconId)
            {
               case "HTIE_ICON_HELP":
                  _habboHelp.toggleNewHelpWindow();
                  break;
               case "HTIE_ICON_GUIDE":
                  showGuideTool();
            }
         }
      }
   }
}
