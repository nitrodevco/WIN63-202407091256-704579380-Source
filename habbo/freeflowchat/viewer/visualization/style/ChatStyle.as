package com.sulake.habbo.freeflowchat.viewer.visualization.style
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.style.class_3632;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   
   public class ChatStyle implements class_3632, class_3595
   {
       
      
      private var _background:BitmapData;
      
      private var _scale9Grid:Rectangle;
      
      private var var_2033:BitmapData;
      
      private var _pointerY:int;
      
      private var _pointerXMargins:Array;
      
      private var var_4669:Rectangle;
      
      private var var_3038:TextFormat;
      
      private var var_2298:BitmapData;
      
      private var _iconOffset:Point;
      
      private var var_4426:BitmapData;
      
      private var _color:BitmapData;
      
      private var _colorOffset:Point;
      
      private var _overlap:Rectangle;
      
      private var var_4598:Boolean;
      
      private var var_4755:Boolean;
      
      private var var_4310:Boolean;
      
      private var var_4288:Boolean;
      
      private var _isAnonymous:Boolean;
      
      private var _allowHTML:Boolean;
      
      private var var_4773:StyleSheet;
      
      public function ChatStyle(param1:BitmapData, param2:Rectangle, param3:BitmapData, param4:int, param5:Array, param6:Rectangle, param7:TextFormat, param8:Boolean, param9:Point, param10:BitmapData, param11:BitmapData, param12:Boolean, param13:Boolean, param14:Boolean, param15:Boolean, param16:BitmapData = null, param17:Point = null, param18:Rectangle = null, param19:Boolean = false, param20:StyleSheet = null)
      {
         super();
         _background = param1;
         _scale9Grid = param2;
         var_2033 = param3;
         _pointerY = param4;
         _pointerXMargins = param5;
         var_4669 = param6;
         var_3038 = param7;
         _isAnonymous = param8;
         _iconOffset = param9;
         var_2298 = param10;
         var_4426 = param11;
         var_4598 = param12;
         var_4755 = param13;
         var_4310 = param15;
         var_4288 = param14;
         _color = param16;
         _colorOffset = param17;
         _overlap = param18;
         _allowHTML = param19;
         var_4773 = param20;
      }
      
      public function getNewBackgroundSprite(param1:uint = 16777215) : Sprite
      {
         var _loc4_:BitmapData = null;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         if(_color != null)
         {
            (_loc4_ = new BitmapData(_background.width,_background.height,_background.transparent,0)).copyPixels(_background,_background.rect,new Point(0,0));
            _loc2_ = uint(param1 >> 16 & 255);
            _loc5_ = uint(param1 >> 8 & 255);
            _loc3_ = uint(param1 >> 0 & 255);
            _loc4_.draw(_color,null,new ColorTransform(_loc2_ / 255,_loc5_ / 255,_loc3_ / 255),"darken");
         }
         else
         {
            _loc4_ = _background;
         }
         return HabboFreeFlowChat.create9SliceSprite(_scale9Grid,_loc4_);
      }
      
      public function get textFormat() : TextFormat
      {
         return var_3038;
      }
      
      public function get styleSheet() : StyleSheet
      {
         return var_4773;
      }
      
      public function get pointer() : BitmapData
      {
         return var_2033;
      }
      
      public function get pointerOffsetToBubbleBottom() : int
      {
         return _background.height - _pointerY;
      }
      
      public function getPointerLeftMargin(param1:int) : int
      {
         if(_pointerXMargins == null || _pointerXMargins.length < 1)
         {
            return param1;
         }
         return _pointerXMargins[0];
      }
      
      public function getPointerRightMargin(param1:int) : int
      {
         if(_pointerXMargins == null || _pointerXMargins.length < 2)
         {
            return param1;
         }
         return _pointerXMargins[1];
      }
      
      public function get isAnonymous() : Boolean
      {
         return _isAnonymous;
      }
      
      public function get faceOffset() : Point
      {
         return _iconOffset;
      }
      
      public function get iconImage() : BitmapData
      {
         return var_2298;
      }
      
      public function get textFieldMargins() : Rectangle
      {
         return var_4669;
      }
      
      public function get overlap() : Rectangle
      {
         return _overlap;
      }
      
      public function get selectorPreview() : BitmapData
      {
         return var_4426;
      }
      
      public function get isSystemStyle() : Boolean
      {
         return var_4598;
      }
      
      public function get isHcOnly() : Boolean
      {
         return var_4755;
      }
      
      public function get isAmbassadorOnly() : Boolean
      {
         return var_4310;
      }
      
      public function get isStaffOverrideable() : Boolean
      {
         return var_4288;
      }
      
      public function get allowHTML() : Boolean
      {
         return _allowHTML;
      }
   }
}
