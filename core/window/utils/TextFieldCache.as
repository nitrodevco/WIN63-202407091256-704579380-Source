package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.class_285;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TextFieldCache implements IDisposable
   {
      
      private static var _textFieldCache:Map = new Map();
      
      private static var var_42:TextFieldCache = new TextFieldCache();
       
      
      private var _disposed:Boolean = false;
      
      public function TextFieldCache()
      {
         super();
         if(var_42 == null)
         {
            class_3639.events.addEventListener("change",onTextStyleChanged);
         }
      }
      
      public static function getTextFieldByStyle(param1:class_3613) : TextField
      {
         var _loc2_:TextField = _textFieldCache[param1.name];
         if(_loc2_)
         {
            return _loc2_;
         }
         _loc2_ = new TextField();
         var _loc3_:TextFormat = _loc2_.defaultTextFormat;
         if(!param1)
         {
            param1 = class_3639.getStyle("regular");
         }
         _loc3_.font = param1.fontFamily;
         _loc3_.size = param1.fontSize;
         _loc3_.color = param1.color;
         _loc3_.bold = param1.fontWeight == "bold" ? true : null;
         _loc3_.italic = param1.fontStyle == "italic" ? true : null;
         _loc3_.underline = param1.textDecoration == "underline" ? true : null;
         _loc3_.indent = param1.textIndent;
         _loc3_.leading = param1.leading;
         _loc3_.kerning = param1.kerning;
         _loc3_.letterSpacing = param1.letterSpacing;
         _loc2_.antiAliasType = param1.antiAliasType == "normal" ? "normal" : "advanced";
         _loc2_.gridFitType = "pixel";
         _loc2_.sharpness = !!param1.sharpness ? param1.sharpness as int : 0;
         _loc2_.thickness = !!param1.thickness ? param1.thickness as int : 0;
         if(!param1.fontWeight)
         {
            _loc3_.bold = false;
         }
         if(!param1.fontStyle)
         {
            _loc3_.italic = false;
         }
         if(!param1.textDecoration)
         {
            _loc3_.underline = false;
         }
         if(!param1.textIndent)
         {
            _loc3_.indent = 0;
         }
         if(!param1.leading)
         {
            _loc3_.leading = 0;
         }
         if(!param1.kerning)
         {
            _loc3_.kerning = false;
         }
         if(!param1.letterSpacing)
         {
            _loc3_.letterSpacing = 0;
         }
         if(!param1.antiAliasType)
         {
            _loc2_.antiAliasType = "advanced";
         }
         _loc2_.autoSize = "left";
         _loc2_.setTextFormat(_loc3_);
         _loc2_.embedFonts = class_285.isEmbeddedFont(_loc3_.font);
         _loc2_.defaultTextFormat = _loc3_;
         _textFieldCache[param1.name] = _loc2_;
         return _loc2_;
      }
      
      public static function getTextFieldByStyleName(param1:String) : TextField
      {
         var _loc2_:class_3613 = class_3639.getStyle(param1);
         if(!_loc2_)
         {
            return null;
         }
         return getTextFieldByStyle(_loc2_);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         class_3639.events.removeEventListener("change",onTextStyleChanged);
         _textFieldCache.reset();
         var_42 = null;
         _disposed = true;
      }
      
      private function onTextStyleChanged(param1:Event) : void
      {
         _textFieldCache.reset();
      }
   }
}
