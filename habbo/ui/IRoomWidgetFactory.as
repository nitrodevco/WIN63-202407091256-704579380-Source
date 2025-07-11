package com.sulake.habbo.ui
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.ui.widget.IRoomWidget;
   
   public interface IRoomWidgetFactory extends IDisposable
   {
       
      
      function createWidget(param1:String, param2:IRoomWidgetHandler) : IRoomWidget;
   }
}
