package com.sulake.habbo.help
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.widgets.class_3528;
   
   public class SafetyBookletController implements IDisposable
   {
       
      
      private const START_PAGE:int = 0;
      
      private const FINAL_PAGE:int = 7;
      
      private var _habboHelp:HabboHelp;
      
      private var var_1907:IModalDialog;
      
      private var _window:IWindowContainer;
      
      private var _disposed:Boolean = false;
      
      private var var_1824:int = 0;
      
      public function SafetyBookletController(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            closeWindow();
            if(_habboHelp)
            {
               _habboHelp = null;
            }
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function openSafetyBooklet() : void
      {
         closeWindow();
         var_1907 = _habboHelp.getModalXmlWindow("safety_booklet");
         _window = IWindowContainer(var_1907.rootWindow);
         _window.procedure = onWindowEvent;
         setCurrentPage(0);
         _habboHelp.tracking.trackEventLog("Quiz","","talent.quiz.open");
      }
      
      public function closeWindow() : void
      {
         _window = null;
         if(var_1907)
         {
            var_1907.dispose();
            var_1907 = null;
         }
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(_disposed || !_window || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               closeWindow();
               break;
            case "next_button":
               setCurrentPage(Math.min(7,var_1824 + 1));
               _habboHelp.tracking.trackEventLog("Quiz","" + var_1824,"talent.quiz.change_page");
               _habboHelp.trackGoogle("safetyBooklet","clickNextPage_" + var_1824);
               break;
            case "back_button":
            case "previous_button":
               setCurrentPage(Math.max(0,var_1824 - 1));
               _habboHelp.tracking.trackEventLog("Quiz","" + var_1824,"talent.quiz.change_page");
               _habboHelp.trackGoogle("safetyBooklet","clickPrevPage_" + var_1824);
               break;
            case "quiz_button":
               _habboHelp.trackGoogle("safetyBooklet","clickQuiz");
               _habboHelp.showSafetyQuiz();
               break;
            case "ok_button":
               _habboHelp.trackGoogle("safetyBooklet","clickOk");
               _habboHelp.showSafetyQuiz();
               _habboHelp.closeSafetyBooklet();
         }
      }
      
      private function setCurrentPage(param1:int) : void
      {
         var_1824 = param1;
         _window.findChildByName("safety.quiz.explanation").visible = !_habboHelp.safetyQuizDisabled;
         if(var_1824 < 7)
         {
            if(var_1824 == 0)
            {
               _window.findChildByName("previous_button").visible = false;
            }
            else
            {
               _window.findChildByName("previous_button").visible = true;
            }
            IStaticBitmapWrapperWindow(_window.findChildByName("illustration")).assetUri = "${image.library.url}safetyquiz/page_" + var_1824 + ".png";
            IStaticBitmapWrapperWindow(_window.findChildByName("safety_image")).assetUri = "${image.library.url}safetyquiz/safety_off.png";
            class_3528(IWidgetWindow(_window.findChildByName("page_widget")).widget).position = var_1824 + 1;
            _window.findChildByName("title").caption = "${safety.booklet.page." + var_1824 + ".title}";
            _window.findChildByName("description").caption = "${safety.booklet.page." + var_1824 + ".description}";
            _window.findChildByName("page_container").visible = true;
            _window.findChildByName("final_page").visible = false;
            _window.findChildByName("final_page_no_questions").visible = false;
            _window.findChildByName("page_container").invalidate();
         }
         else
         {
            IStaticBitmapWrapperWindow(_window.findChildByName("illustration")).assetUri = "${image.library.url}safetyquiz/page_end.png";
            IStaticBitmapWrapperWindow(_window.findChildByName("safety_image")).assetUri = "${image.library.url}safetyquiz/safety_on.png";
            class_3528(IWidgetWindow(_window.findChildByName("page_widget")).widget).position = 0;
            _window.findChildByName("page_container").visible = false;
            if(_habboHelp.safetyQuizDisabled)
            {
               _window.findChildByName("final_page_no_questions").visible = true;
               _window.findChildByName("final_page_no_questions").invalidate();
            }
            else
            {
               _window.findChildByName("final_page").visible = true;
               _window.findChildByName("final_page").invalidate();
            }
         }
      }
   }
}
