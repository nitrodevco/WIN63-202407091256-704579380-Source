package com.sulake.habbo.help
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.widgets.class_3528;
   
   public class HabboWayController
   {
       
      
      private const START_PAGE:int = 0;
      
      private var var_967:int = 0;
      
      private var var_1824:int = 0;
      
      private var _habboHelp:HabboHelp;
      
      private var var_1907:IModalDialog;
      
      private var _window:IWindowContainer;
      
      private var _disposed:Boolean = false;
      
      public function HabboWayController(param1:HabboHelp)
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
      
      private function get finalPage() : int
      {
         return _habboHelp.getInteger("help.habboway.page.count",6);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showHabboWay() : void
      {
         closeWindow();
         var_1907 = _habboHelp.getModalXmlWindow("habbo_way");
         _window = IWindowContainer(var_1907.rootWindow);
         _window.procedure = onWindowEvent;
         class_3528(IWidgetWindow(_window.findChildByName("page_widget")).widget).size = finalPage;
         setCurrentPage(0);
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
               setCurrentPage(Math.min(finalPage,var_1824 + 1));
               _habboHelp.trackGoogle("habboWay","clickNextPage_" + var_1824);
               break;
            case "back_button":
            case "previous_button":
               setCurrentPage(Math.max(0,var_1824 - 1));
               _habboHelp.trackGoogle("habboWay","clickPrevPage_" + var_1824);
               break;
            case "quiz_button":
               _habboHelp.trackGoogle("habboWay","clickQuiz");
               _habboHelp.showHabboWayQuiz();
         }
      }
      
      private function setCurrentPage(param1:int) : void
      {
         var_1824 = param1;
         if(var_1824 < finalPage)
         {
            if(var_1824 == 0)
            {
               _window.findChildByName("previous_button").visible = false;
            }
            else
            {
               _window.findChildByName("previous_button").visible = true;
            }
            IStaticBitmapWrapperWindow(_window.findChildByName("illustration")).assetUri = "${image.library.url}habboway/page_" + var_1824 + ".png";
            IStaticBitmapWrapperWindow(_window.findChildByName("dove_image")).assetUri = "help_habboway_dove_off";
            class_3528(IWidgetWindow(_window.findChildByName("page_widget")).widget).position = var_1824 + 1;
            _window.findChildByName("correct_title").caption = "${habbo.way.page." + var_1824 + ".correct.title}";
            _window.findChildByName("correct_description").caption = "${habbo.way.page." + var_1824 + ".correct.description}";
            _window.findChildByName("wrong_title").caption = "${habbo.way.page." + var_1824 + ".wrong.title}";
            _window.findChildByName("wrong_description").caption = "${habbo.way.page." + var_1824 + ".wrong.description}";
            _window.findChildByName("page_container").visible = true;
            _window.findChildByName("final_page").visible = false;
            _window.findChildByName("page_container").invalidate();
         }
         else
         {
            IStaticBitmapWrapperWindow(_window.findChildByName("illustration")).assetUri = "${image.library.url}habboway/page_end.png";
            IStaticBitmapWrapperWindow(_window.findChildByName("dove_image")).assetUri = "help_habboway_dove_on";
            class_3528(IWidgetWindow(_window.findChildByName("page_widget")).widget).position = 0;
            _window.findChildByName("page_container").visible = false;
            _window.findChildByName("final_page").visible = true;
            _window.findChildByName("final_page").invalidate();
         }
      }
   }
}
