package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.utils.IMargins;
   
   public interface class_3514 extends IWindowContainer
   {
       
      
      function get title() : ILabelWindow;
      
      function get header() : class_3502;
      
      function get content() : IWindowContainer;
      
      function get margins() : IMargins;
      
      function get scaler() : IScalerWindow;
      
      function resizeToFitContent() : void;
      
      function set helpButtonAction(param1:Function) : void;
      
      function get helpPage() : String;
      
      function set helpPage(param1:String) : void;
   }
}
