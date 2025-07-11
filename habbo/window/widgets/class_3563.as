package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_3420;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   
   public interface class_3563 extends class_3420
   {
       
      
      function get bitmapWrapper() : IStaticBitmapWrapperWindow;
      
      function get normalAsset() : String;
      
      function set normalAsset(param1:String) : void;
      
      function get hoverAsset() : String;
      
      function set hoverAsset(param1:String) : void;
   }
}
