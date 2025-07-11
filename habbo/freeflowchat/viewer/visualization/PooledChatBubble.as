package com.sulake.habbo.freeflowchat.viewer.visualization
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.viewer.enum.ChatBubbleWidth;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.class_3595;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class PooledChatBubble extends Sprite
   {
      
      public static const MAX_WIDTH_DEFAULT:uint = 300;
      
      private static const DESKTOP_MARGIN_LEFT:int = 85;
      
      private static const DESKTOP_MARGIN_RIGHT:int = 190;
      
      private static const LINEAR_INTERPOLATION_MS:uint = 150;
      
      private static const MAX_HEIGHT:uint = 108;
      
      private static const const_721:int = 28;
      
      private static const POINTER_DEFAULT_MARGIN_RIGHT:int = 15;
      
      private static const POINTER_REPOSITION_INTERVAL_MS:int = 2000;
      
      private static const ZERO_POINT:Point = new Point(0,0);
       
      
      private var var_1660:HabboFreeFlowChat;
      
      private var var_1901:ChatItem;
      
      private var _background:Sprite;
      
      private var var_2033:Bitmap;
      
      private var var_2659:Bitmap;
      
      private var var_2620:BitmapData;
      
      private var var_1670:TextField;
      
      private var _style:class_3595;
      
      private var var_2501:uint = 0;
      
      private var var_4312:uint;
      
      private var var_2833:int;
      
      private var var_2811:int;
      
      private var var_4335:int;
      
      private var var_4449:int;
      
      private var var_4495:Number;
      
      private var var_4421:Number;
      
      private var var_3779:Boolean = false;
      
      private var var_3903:int = 0;
      
      private var var_3751:int;
      
      private var var_4505:Boolean = false;
      
      private var _hasHitDesktopMargin:Boolean = false;
      
      private var var_2128:Sprite;
      
      private var var_3814:uint = 0;
      
      private var var_1984:int = -1;
      
      public function PooledChatBubble(param1:HabboFreeFlowChat)
      {
         super();
         var_1660 = param1;
         var_2033 = new Bitmap();
         var_2659 = new Bitmap();
         var_1670 = new TextField();
         var_2128 = new Sprite();
         this.addEventListener("addedToStage",onAddedToStage);
         this.addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      public function set chatItem(param1:ChatItem) : void
      {
         var_1901 = param1;
      }
      
      public function set face(param1:BitmapData) : void
      {
         var_2620 = param1;
      }
      
      public function set style(param1:class_3595) : void
      {
         _style = param1;
      }
      
      public function recreate(param1:String, param2:uint, param3:Boolean = false, param4:int = -1) : void
      {
         var _loc10_:int = 0;
         var _loc14_:int = 0;
         var _loc16_:Array = null;
         var _loc15_:String = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc8_:int = 0;
         var _loc12_:BitmapData = null;
         _background = _style.getNewBackgroundSprite(param2);
         var_2033.bitmapData = _style.pointer;
         var_4505 = param3;
         var _loc11_:int;
         var _loc9_:int = (_loc11_ = int(!!var_1660.roomChatSettings ? ChatBubbleWidth.accordingToRoomChatSetting(var_1660.roomChatSettings.bubbleWidth) : 300)) - _style.textFieldMargins.x - _style.textFieldMargins.width;
         var_1670.width = _loc9_;
         var_1670.multiline = true;
         var_1670.wordWrap = true;
         var_1670.selectable = false;
         var_1670.thickness = -15;
         var_1670.sharpness = 80;
         var_1670.antiAliasType = "advanced";
         var_1670.embedFonts = true;
         var_1670.gridFitType = "pixel";
         var_1670.cacheAsBitmap = !_style.allowHTML;
         var_1670.styleSheet = null;
         var_1670.defaultTextFormat = _style.textFormat;
         var_1670.styleSheet = _style.styleSheet;
         var_1670.addEventListener("link",onTextLinkEvent);
         var _loc7_:* = var_1901.chatType == 0;
         var _loc6_:* = var_1901.chatType == 2;
         var _loc13_:Boolean;
         if(_loc13_ = !_loc7_ && !_loc6_ && !_style.isAnonymous)
         {
            var_1670.alpha = 0.6;
         }
         else
         {
            var_1670.alpha = 1;
         }
         var _loc18_:String = (_loc18_ = (_loc18_ = (_loc13_ ? "<i>" : "") + (_style.isAnonymous ? "" : "<b>" + param1 + ": </b>")) + (_loc6_ ? "<b>" : "") + var_1901.text + (_loc6_ ? "</b>" : "")) + (_loc13_ ? "</i>" : "");
         if(var_1901.links == null || var_1901.links[0] == null)
         {
            var_1670.htmlText = _loc18_;
         }
         else
         {
            _loc14_ = -1;
            _loc16_ = [];
            _loc10_ = 0;
            while(_loc10_ < var_1901.links.length)
            {
               _loc15_ = String(var_1901.links[_loc10_][0][1]);
               _loc19_ = "<a href=\"" + _loc15_ + "\">" + _loc15_ + "</a>";
               _loc20_ = "{" + _loc10_ + "}";
               _loc14_ = (_loc8_ = var_1901.text.indexOf(_loc20_)) + _loc19_.length;
               _loc16_.push([_loc8_,_loc14_]);
               _loc18_ = _loc18_.replace(_loc20_,_loc19_);
               _loc10_++;
            }
            var_1670.htmlText = _loc18_;
         }
         var_1984 = param4;
         var _loc17_:int = Math.min(_loc11_,var_1670.textWidth + _style.textFieldMargins.x + _style.textFieldMargins.width);
         var _loc5_:int = var_1670.textHeight + _style.textFieldMargins.y + _style.textFieldMargins.height;
         if(!_style.isSystemStyle)
         {
            _loc5_ = Math.min(108,_loc5_);
         }
         if(param4 != -1)
         {
            _loc5_ = Math.max(param4,_loc5_);
         }
         _loc17_ = Math.max(_loc17_,_background.width);
         _loc5_ = Math.max(_loc5_,_background.height);
         _background.width = _loc17_;
         _background.height = _loc5_;
         _background.x = 0;
         _background.y = 0;
         _background.cacheAsBitmap = true;
         addChild(_background);
         if(!_style.isAnonymous)
         {
            var_2033.x = Math.max(_style.getPointerLeftMargin(28),Math.min(_style.getPointerRightMargin(15),userRelativePosX));
            var_2033.y = _loc5_ - _style.pointerOffsetToBubbleBottom;
            addChild(var_2033);
         }
         if(var_2620 != null && _style.faceOffset != null)
         {
            if(var_2620.height > _loc5_)
            {
               (_loc12_ = new BitmapData(var_2620.width,_loc5_)).copyPixels(var_2620,new Rectangle(0,var_2620.height - _loc5_,var_2620.width,_loc5_),new Point(0,0));
            }
            else
            {
               _loc12_ = var_2620;
            }
            var_2659.bitmapData = _loc12_;
            var_2659.x = _style.faceOffset.x - _loc12_.width / 2;
            var_2659.y = Math.max(1,_style.faceOffset.y - _loc12_.height / 2);
            addChild(var_2659);
         }
         var_1670.width = Math.min(_loc9_,var_1670.textWidth + _style.textFieldMargins.width);
         var_1670.height = var_1670.textHeight + _style.textFieldMargins.height;
         var_1670.x = _style.textFieldMargins.x;
         var_1670.y = _style.textFieldMargins.y;
         addChild(var_1670);
         if(!_style.isSystemStyle && var_1670.textHeight > 108)
         {
            var_2128.graphics.clear();
            var_2128.graphics.beginFill(16777215);
            var_2128.graphics.drawRect(0,0,var_1670.textWidth + 5,108 - _style.textFieldMargins.height);
            var_2128.graphics.endFill();
            var_1670.mask = var_2128;
            addChild(var_2128);
            var_2128.x = var_1670.x;
            var_2128.y = var_1670.y;
         }
         else
         {
            var_2128.graphics.clear();
            var_1670.mask = null;
         }
         this.cacheAsBitmap = !_style.allowHTML;
         var_3779 = false;
         var_2501 = 0;
         var_3814 = 0;
         visible = false;
      }
      
      public function unregister() : void
      {
         this.cacheAsBitmap = false;
         this.removeEventListener("click",onMouseClick);
         if(var_2128.parent == this)
         {
            safelyRemoveChild(var_2128);
         }
         safelyRemoveChild(var_1670);
         if(_style.faceOffset != null && var_2659.parent == this)
         {
            safelyRemoveChild(var_2659);
            var_2659.bitmapData = null;
         }
         if(var_2033 && var_2033.parent)
         {
            safelyRemoveChild(var_2033);
         }
         safelyRemoveChild(_background);
         if(var_1670)
         {
            var_1670.removeEventListener("link",onTextLinkEvent);
         }
      }
      
      private function onTextLinkEvent(param1:TextEvent) : void
      {
         var _loc7_:String = null;
         var _loc4_:String = null;
         var _loc3_:TextField = null;
         var _loc2_:Point = null;
         var _loc5_:Rectangle = null;
         var _loc6_:String = null;
         if(param1.text && param1.text.length > 0)
         {
            _loc7_ = param1.text;
            _loc4_ = "highlight/";
            if(_loc7_.indexOf(_loc4_) > -1)
            {
               _loc3_ = param1.target as TextField;
               _loc2_ = new Point(_loc3_.mouseX,_loc3_.mouseY);
               _loc2_ = _loc3_.localToGlobal(_loc2_);
               _loc5_ = new Rectangle(_loc2_.x,_loc2_.y);
               _loc6_ = _loc7_.substr(_loc7_.indexOf(_loc4_) + _loc4_.length,_loc7_.length);
               var_1660.windowManager.hideHint();
               var_1660.windowManager.showHint(_loc6_.toLocaleUpperCase(),_loc5_);
            }
            else
            {
               var_1660.context.createLinkEvent(param1.text);
            }
         }
      }
      
      private function safelyRemoveChild(param1:DisplayObject) : void
      {
         try
         {
            removeChild(param1);
         }
         catch(error:ArgumentError)
         {
         }
      }
      
      public function get displayedHeight() : Number
      {
         return _style.isSystemStyle ? height : Math.min(108,height);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.addEventListener("click",onMouseClick);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeEventListener("click",onMouseClick);
      }
      
      public function moveTo(param1:int, param2:int) : void
      {
         if(var_2833 != param1 || var_2811 != param2)
         {
            var_4312 = var_2501;
            var_4335 = proxyX;
            var_4449 = y;
            var_2833 = param1;
            var_2811 = param2;
            var_4495 = (param1 - proxyX) / 150;
            var_4421 = (param2 - y) / 150;
         }
      }
      
      public function warpTo(param1:int, param2:int) : void
      {
         var_2833 = param1;
         var_2811 = param2;
         proxyX = param1;
         y = param2;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:* = 0;
         var_2501 += param1;
         if(proxyX != var_2833 || y != var_2811)
         {
            _loc2_ = uint(var_2501 - var_4312);
            if(_loc2_ < 150 && _loc2_ > 0)
            {
               proxyX = var_4335 + _loc2_ * var_4495;
               y = int(var_4449 + _loc2_ * var_4421);
            }
            else
            {
               proxyX = var_2833;
               y = var_2811;
            }
         }
         if(var_2501 > var_3814 + 2000)
         {
            repositionPointer();
            var_3814 = var_2501;
         }
         if(var_2501 > 150 && !visible)
         {
            visible = true;
         }
      }
      
      public function get proxyX() : int
      {
         return var_3751;
      }
      
      public function set proxyX(param1:int) : void
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var_3751 = param1;
         if(var_4505 && stage)
         {
            _loc2_ = var_3751 + var_3903;
            _hasHitDesktopMargin = false;
            _loc3_ = stage.stageWidth - 190 - width;
            if(_loc2_ > _loc3_)
            {
               _loc2_ = _loc3_;
               _hasHitDesktopMargin = true;
            }
            if(_loc2_ < 85)
            {
               _loc2_ = 85;
               _hasHitDesktopMargin = true;
            }
            x = _loc2_;
         }
         else
         {
            x = var_3751 + var_3903;
         }
      }
      
      public function repositionPointer() : void
      {
         if(var_2033 && var_2033.parent)
         {
            var_2033.x = Math.max(_style.getPointerLeftMargin(28),Math.min(_background.width - _style.getPointerRightMargin(15),userRelativePosX));
            var_2033.y = _background.height - _style.pointerOffsetToBubbleBottom;
         }
      }
      
      public function get readyToRecycle() : Boolean
      {
         return var_3779;
      }
      
      public function set readyToRecycle(param1:Boolean) : void
      {
         var_3779 = param1;
         if(param1)
         {
            this.removeEventListener("click",onMouseClick);
         }
      }
      
      public function get timeStamp() : uint
      {
         return var_1901.timeStamp;
      }
      
      public function set component(param1:HabboFreeFlowChat) : void
      {
         var_1660 = param1;
      }
      
      private function get userRelativePosX() : int
      {
         return userScreenPos.x - this.x;
      }
      
      public function get userScreenPos() : Point
      {
         if(var_1901.forcedScreenLocation)
         {
            if(var_1660.displayObject.stage == null)
            {
               return ZERO_POINT;
            }
            return new Point(var_1660.displayObject.stage.stageWidth / 2 + var_1901.forcedScreenLocation,500);
         }
         return var_1660.getScreenPointFromRoomLocation(var_1901.roomId,var_1901.userLocation);
      }
      
      public function get roomId() : int
      {
         return var_1901.roomId;
      }
      
      public function set roomPanOffsetX(param1:int) : void
      {
         if(var_3903 != param1)
         {
            var_3903 = param1;
            warpTo(var_2833,var_2811);
         }
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(_style && _style.isAnonymous)
         {
            return;
         }
         if(!var_1660.clickHasToPropagate(param1))
         {
            var_1660.selectAvatarWithChatItem(var_1901);
            param1.stopImmediatePropagation();
         }
      }
      
      public function get overlap() : Rectangle
      {
         return _style.overlap;
      }
      
      public function get hasHitDesktopMargin() : Boolean
      {
         return _hasHitDesktopMargin;
      }
      
      public function get minHeight() : int
      {
         return var_1984;
      }
   }
}
