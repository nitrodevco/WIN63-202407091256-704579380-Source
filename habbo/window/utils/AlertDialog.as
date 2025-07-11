package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.INotify;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.core.window.utils.class_3562;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class AlertDialog implements class_3348, INotify
   {
      
      protected static const LIST_BUTTONS:String = "_alert_button_list";
      
      protected static const const_923:String = "_alert_button_ok";
      
      protected static const const_578:String = "_alert_button_cancel";
      
      protected static const BUTTON_CUSTOM:String = "_alert_button_custom";
      
      protected static const const_545:String = "header_button_close";
      
      protected static const const_602:String = "_alert_text_summary";
      
      private static var var_1461:uint = 0;
       
      
      protected var var_617:String = "";
      
      protected var var_449:String = "";
      
      protected var _disposed:Boolean = false;
      
      protected var _callback:Function = null;
      
      protected var _window:class_3514;
      
      protected var var_1907:IModalDialog;
      
      public function AlertDialog(param1:IHabboWindowManager, param2:XML, param3:String, param4:String, param5:uint, param6:Function, param7:Boolean)
      {
         var _loc8_:IWindow = null;
         super();
         var_1461++;
         if(param7)
         {
            var_1907 = param1.buildModalDialogFromXML(param2);
            _window = var_1907.rootWindow as class_3514;
         }
         else
         {
            _window = param1.buildFromXML(param2,2) as class_3514;
         }
         if(param5 == 0)
         {
            param5 = uint(16 | 1 | 2);
         }
         var _loc9_:IItemListWindow;
         if(_loc9_ = _window.findChildByName("_alert_button_list") as IItemListWindow)
         {
            if(!(param5 & 16))
            {
               (_loc8_ = _loc9_.getListItemByName("_alert_button_ok")).dispose();
            }
            if(!(param5 & 32))
            {
               (_loc8_ = _loc9_.getListItemByName("_alert_button_cancel")).dispose();
            }
            if(!(param5 & 64))
            {
               (_loc8_ = _loc9_.getListItemByName("_alert_button_custom")).dispose();
            }
         }
         _window.procedure = dialogEventProc;
         _window.center();
         this.title = param3;
         this.summary = param4;
         this.callback = param6;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1907 && !var_1907.disposed)
            {
               var_1907.dispose();
               var_1907 = null;
               _window = null;
            }
            if(_window && !_window.disposed)
            {
               _window.dispose();
               _window = null;
            }
            _callback = null;
            _disposed = true;
         }
      }
      
      protected function dialogEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:WindowEvent = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "_alert_button_ok":
                  if(_callback != null)
                  {
                     _loc3_ = WindowEvent.allocate("WE_OK",null,null);
                     _callback(this,_loc3_);
                     _loc3_.recycle();
                  }
                  else
                  {
                     dispose();
                  }
                  break;
               case "header_button_close":
               case "_alert_button_cancel":
                  if(_callback != null)
                  {
                     _loc3_ = WindowEvent.allocate("WE_CANCEL",null,null);
                     _callback(this,_loc3_);
                     _loc3_.recycle();
                  }
                  else
                  {
                     dispose();
                  }
            }
         }
      }
      
      public function getButtonCaption(param1:int) : class_3562
      {
         var _loc2_:IInteractiveWindow = null;
         if(!_disposed)
         {
            switch(param1)
            {
               case 16:
                  _loc2_ = _window.findChildByName("_alert_button_ok") as IInteractiveWindow;
                  break;
               case 32:
                  _loc2_ = _window.findChildByName("_alert_button_cancel") as IInteractiveWindow;
                  break;
               case 64:
                  _loc2_ = _window.findChildByName("_alert_button_custom") as IInteractiveWindow;
            }
         }
         return !!_loc2_ ? new AlertDialogCaption(_loc2_.caption,_loc2_.toolTipCaption,_loc2_.visible) : null;
      }
      
      public function setButtonCaption(param1:int, param2:class_3562) : void
      {
         var _loc3_:IInteractiveWindow = null;
         if(!_disposed)
         {
            switch(param1)
            {
               case 16:
                  _loc3_ = _window.findChildByName("_alert_button_ok") as IInteractiveWindow;
                  break;
               case 32:
                  _loc3_ = _window.findChildByName("_alert_button_cancel") as IInteractiveWindow;
                  break;
               case 64:
                  _loc3_ = _window.findChildByName("_alert_button_custom") as IInteractiveWindow;
            }
         }
         if(_loc3_)
         {
            _loc3_.caption = param2.text;
         }
      }
      
      public function set title(param1:String) : void
      {
         var_617 = param1;
         if(_window)
         {
            _window.caption = var_617;
         }
      }
      
      public function get title() : String
      {
         return var_617;
      }
      
      public function set summary(param1:String) : void
      {
         var_449 = param1;
         if(_window)
         {
            ITextWindow(_window.findChildByTag("DESCRIPTION")).text = var_449;
         }
      }
      
      public function get summary() : String
      {
         return var_449;
      }
      
      public function set titleBarColor(param1:uint) : void
      {
         if(!_window)
         {
            return;
         }
         _window.color = param1;
      }
      
      public function get titleBarColor() : uint
      {
         if(!_window)
         {
            return 0;
         }
         return _window.color;
      }
      
      public function set callback(param1:Function) : void
      {
         _callback = param1;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
