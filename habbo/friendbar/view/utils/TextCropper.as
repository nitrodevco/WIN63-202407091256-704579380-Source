package com.sulake.habbo.friendbar.view.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.ITextWindow;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TextCropper implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_1670:TextField;
      
      private var var_3038:TextFormat;
      
      private var var_4948:String = "...";
      
      private var var_4944:int = 20;
      
      public function TextCropper()
      {
         super();
         var_1670 = new TextField();
         var_1670.autoSize = "left";
         var_1670.antiAliasType = "advanced";
         var_1670.gridFitType = "pixel";
         var_3038 = var_1670.defaultTextFormat;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_1670 = null;
            _disposed = true;
         }
      }
      
      public function crop(param1:ITextWindow) : void
      {
         var _loc2_:int = 0;
         var_3038.font = param1.fontFace;
         var_3038.size = param1.fontSize;
         var_3038.bold = param1.bold;
         var_3038.italic = param1.italic;
         var_1670.setTextFormat(var_3038);
         var_1670.text = param1.getLineText(0);
         var _loc3_:int = var_1670.textWidth;
         if(_loc3_ > param1.width)
         {
            _loc2_ = var_1670.getCharIndexAtPoint(param1.width - var_4944,var_1670.textHeight / 2);
            param1.text = param1.text.slice(0,_loc2_) + var_4948;
         }
      }
   }
}
