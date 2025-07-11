package com.sulake.habbo.help.guidehelp
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.help.GuideHelpManager;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.class_3614;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.help.data.class_1698;
   import com.sulake.habbo.communication.messages.outgoing.room.session.class_325;
   
   public class HelpController implements IDisposable
   {
       
      
      private var _habboHelp:HabboHelp;
      
      private var _guideHelp:GuideHelpManager;
      
      private var _disposed:Boolean = false;
      
      private var var_2198:IModalDialog;
      
      private var _tourPopup:IWindowContainer;
      
      private var _tourPopupShowTime:int;
      
      private var var_2081:IWindowContainer;
      
      public function HelpController(param1:GuideHelpManager)
      {
         super();
         _habboHelp = param1.habboHelp;
         _guideHelp = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         closeWindow();
         closeTourPopup();
         _habboHelp = null;
         _guideHelp = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function openWindow() : void
      {
         if(var_2198 == null && !disposed)
         {
            var_2198 = _guideHelp.habboHelp.getModalXmlWindow("main_help");
            var_2198.rootWindow.procedure = windowEventProcedure;
         }
      }
      
      public function closeWindow() : void
      {
         if(var_2198 != null)
         {
            var_2198.dispose();
            var_2198 = null;
         }
      }
      
      private function windowEventProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:class_3398 = null;
         if(disposed || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               closeWindow();
               break;
            case "tour_button":
               _guideHelp.createHelpRequest(_habboHelp.newIdentity ? 0 : 2);
               _habboHelp.trackGoogle("helpWindow","click_userTour");
               closeWindow();
               break;
            case "bully_button":
               closeWindow();
               _habboHelp.toggleNewHelpWindow();
               _habboHelp.trackGoogle("helpWindow","click_reportBully");
               break;
            case "instructions_button":
               _guideHelp.createHelpRequest(1);
               _habboHelp.trackGoogle("helpWindow","click_instructions");
               closeWindow();
               break;
            case "self_help_link":
               HabboWebTools.openWebPage(_habboHelp.getProperty("zendesk.url"),"habboMain");
               _habboHelp.trackGoogle("helpWindow","click_selfHelp");
               closeWindow();
               break;
            case "habboway_link":
               if(_habboHelp.getBoolean("habboway.enabled"))
               {
                  _habboHelp.showHabboWay();
               }
               else
               {
                  HabboWebTools.openWebPage(_habboHelp.getProperty("habboway.url"),"habboMain");
               }
               _habboHelp.trackGoogle("helpWindow","click_habboWay");
               closeWindow();
               break;
            case "safetybooklet_link":
               _habboHelp.showSafetyBooklet();
               _habboHelp.trackGoogle("helpWindow","click_showSafetyBooklet");
               closeWindow();
               break;
            case "emergency_button":
               _loc3_ = IWindowContainer(var_2198.rootWindow).findChildByName("leave_room") as class_3398;
               if(_loc3_ != null && Boolean(_loc3_.isSelected))
               {
                  _habboHelp.sendMessage(new class_325());
               }
               closeWindow();
               _habboHelp.startEmergencyRequest();
               _habboHelp.trackGoogle("helpWindow","click_emergency");
         }
      }
      
      public function openTourPopup() : void
      {
         if(_tourPopup == null && !disposed)
         {
            _tourPopupShowTime = getTimer();
            _tourPopup = _guideHelp.habboHelp.getXmlWindow("welcome_tour_popup") as IWindowContainer;
            _tourPopup.center();
            _tourPopup.y *= 0.25;
            _tourPopup.procedure = tourPopupEventProcedure;
         }
      }
      
      private function closeTourPopup() : void
      {
         if(_tourPopup != null)
         {
            _tourPopup.dispose();
            _tourPopup = null;
         }
      }
      
      private function tourPopupEventProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(disposed || param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:int = (_tourPopupShowTime - getTimer()) / 1000;
         switch(param2.name)
         {
            case "refuse_tour":
               _habboHelp.tracking.trackEventLog("Help","","tour.new_user.cancel","",_loc3_);
               _habboHelp.trackGoogle("newbieTourWindow","click_refuseTour");
               closeTourPopup();
               break;
            case "header_button_close":
               _habboHelp.tracking.trackEventLog("Help","","tour.new_user.dismiss","",_loc3_);
               _habboHelp.trackGoogle("newbieTourWindow","click_closeWindow");
               closeTourPopup();
               break;
            case "take_tour":
               _guideHelp.createHelpRequest(0);
               _habboHelp.tracking.trackEventLog("Help","","tour.new_user.accept","",_loc3_);
               _habboHelp.trackGoogle("newbieTourWindow","click_acceptTour");
               closeTourPopup();
         }
      }
      
      public function showPendingTicket(param1:class_1698) : void
      {
         var _loc2_:String = null;
         if(param1.isGuide)
         {
            _loc2_ = "pending_guide_session";
         }
         else
         {
            switch(param1.type)
            {
               case 0:
               case 2:
                  _loc2_ = "pending_tour_request";
                  break;
               case 1:
                  _loc2_ = "pending_instructions_request";
                  break;
               case 3:
                  _loc2_ = "pending_bully_request";
                  break;
               default:
                  return;
            }
         }
         var_2081 = _habboHelp.getXmlWindow(_loc2_) as IWindowContainer;
         var_2081.center();
         var_2081.procedure = onPendingReuqestEvent;
         if(param1.isGuide)
         {
            return;
         }
         switch(param1.type - 1)
         {
            case 0:
               var_2081.findChildByName("description").caption = param1.description;
               class_3614(IWidgetWindow(var_2081.findChildByName("timestamp")).widget).timeStamp = new Date().getTime() - param1.secondsAgo * 1000;
               break;
            case 2:
               var_2081.findChildByName("user_name").caption = param1.otherPartyName;
               IAvatarImageWidget(IWidgetWindow(var_2081.findChildByName("user_avatar")).widget).figure = param1.otherPartyFigure;
               class_3614(IWidgetWindow(var_2081.findChildByName("timestamp")).widget).timeStamp = new Date().getTime() - param1.secondsAgo * 1000;
               _habboHelp.localization.registerParameter("guide.pending.bully.room","room",param1.roomName);
         }
      }
      
      private function onPendingReuqestEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "close_button":
                  if(var_2081 != null && !var_2081.disposed)
                  {
                     var_2081.dispose();
                     var_2081 = null;
                  }
            }
         }
      }
   }
}
