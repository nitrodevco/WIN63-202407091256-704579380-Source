package com.sulake.habbo.freeflowchat.viewer.visualization
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.data.ChatItem;
   import com.sulake.habbo.freeflowchat.viewer.enum.ChatBubbleWidth;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.class_3595;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class ChatBubble extends Sprite
   {
      
      public static const MAX_WIDTH_DEFAULT:uint = 300;
      
      public static const const_1106:int = 15;
      
      private static const DESKTOP_MARGIN_LEFT:int = 85;
      
      private static const DESKTOP_MARGIN_RIGHT:int = 190;
      
      private static const LINEAR_INTERPOLATION_MS:uint = 150;
      
      private static const MAX_HEIGHT:uint = 108;
      
      private static const const_721:int = 28;
      
      private static const POINTER_DEFAULT_MARGIN_RIGHT:int = 15;
      
      private static const ZERO_POINT:Point = new Point(0,0);
       
      
      private var var_1660:HabboFreeFlowChat;
      
      private var var_1901:ChatItem;
      
      private var _background:Sprite;
      
      private var var_2033:Bitmap;
      
      private var var_2659:Bitmap;
      
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
      
      public function ChatBubble(param1:ChatItem, param2:class_3595, param3:BitmapData, param4:String, param5:uint, param6:HabboFreeFlowChat, param7:int = -1, param8:Boolean = false, param9:int = -1)
      {
         var _loc21_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:Array = null;
         var _loc14_:String = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc20_:int = 0;
         var _loc23_:* = null;
         super();
         var_1660 = param6;
         var_1901 = param1;
         _style = param2;
         _background = param2.getNewBackgroundSprite(param5);
         var_2033 = param2.isAnonymous ? null : new Bitmap(param2.pointer);
         var_4505 = param8;
         var _loc22_:int = 300;
         if(param7 != -1)
         {
            _loc22_ = ChatBubbleWidth.accordingToRoomChatSetting(param7);
         }
         else if(param6.roomChatSettings)
         {
            _loc22_ = ChatBubbleWidth.accordingToRoomChatSetting(param6.roomChatSettings.bubbleWidth);
         }
         _loc22_ -= 15;
         this.cacheAsBitmap = true;
         var _loc12_:int = _loc22_ - param2.textFieldMargins.x - param2.textFieldMargins.width;
         var_1670 = new TextField();
         var_1670.width = _loc12_;
         var_1670.multiline = true;
         var_1670.wordWrap = true;
         var_1670.selectable = false;
         var_1670.thickness = -15;
         var_1670.sharpness = 80;
         var_1670.antiAliasType = "advanced";
         var_1670.embedFonts = true;
         var_1670.gridFitType = "pixel";
         var_1670.cacheAsBitmap = true;
         var_1670.defaultTextFormat = param2.textFormat;
         var_1670.styleSheet = _style.styleSheet;
         var_1670.addEventListener("link",onTextLinkEvent);
         var _loc11_:* = param1.chatType == 0;
         var _loc19_:* = param1.chatType == 2;
         var _loc13_:Boolean;
         if(_loc13_ = !_loc11_ && !_loc19_ && !_style.isAnonymous)
         {
            var_1670.alpha = 0.6;
         }
         var _loc16_:String = (_loc16_ = (_loc16_ = (_loc13_ ? "<i>" : "") + (_style.isAnonymous ? "" : "<b>" + param4 + ": </b>")) + (_loc19_ ? "<b>" : "") + param1.text + (_loc19_ ? "</b>" : "")) + (_loc13_ ? "</i>" : "");
         if(param1.links == null || param1.links[0] == null)
         {
            var_1670.htmlText = _loc16_;
         }
         else
         {
            _loc24_ = -1;
            _loc25_ = [];
            _loc21_ = 0;
            while(_loc21_ < param1.links.length)
            {
               _loc14_ = String(param1.links[_loc21_][0][1]);
               _loc17_ = "<a href=\"" + _loc14_ + "\">" + _loc14_ + "</a>";
               _loc18_ = "{" + _loc21_ + "}";
               _loc24_ = (_loc20_ = param1.text.indexOf(_loc18_)) + _loc17_.length;
               _loc25_.push([_loc20_,_loc24_]);
               _loc16_ = _loc16_.replace(_loc18_,_loc17_);
               _loc21_++;
            }
            var_1670.htmlText = _loc16_;
         }
         var _loc15_:int = Math.min(_loc22_,var_1670.textWidth + param2.textFieldMargins.x + param2.textFieldMargins.width);
         var _loc10_:int = var_1670.textHeight + param2.textFieldMargins.y + param2.textFieldMargins.height;
         if(!_style.isSystemStyle)
         {
            _loc10_ = Math.min(108,_loc10_);
         }
         if(param9 != -1)
         {
            _loc10_ = Math.max(param9,_loc10_);
         }
         _loc15_ = Math.max(_loc15_,_background.width);
         _loc10_ = Math.max(_loc10_,_background.height);
         _background.width = _loc15_;
         _background.height = _loc10_;
         _background.x = 0;
         _background.y = 0;
         _background.cacheAsBitmap = true;
         addChild(_background);
         if(!_style.isAnonymous)
         {
            var_2033.x = Math.max(param2.getPointerLeftMargin(28),Math.min(param2.getPointerRightMargin(15),userRelativePosX));
            var_2033.y = _loc10_ - param2.pointerOffsetToBubbleBottom;
            addChild(var_2033);
         }
         if(param3 != null && param2.faceOffset != null)
         {
            if(param3.height > _loc10_)
            {
               (_loc23_ = new BitmapData(param3.width,_loc10_)).copyPixels(param3,new Rectangle(0,param3.height - _loc10_,param3.width,_loc10_),new Point(0,0));
            }
            else
            {
               _loc23_ = param3;
            }
            var_2659 = new Bitmap(_loc23_);
            var_2659.x = param2.faceOffset.x - _loc23_.width / 2;
            var_2659.y = Math.max(1,param2.faceOffset.y - _loc23_.height / 2);
            addChild(var_2659);
         }
         var_1670.width = Math.min(_loc12_,var_1670.textWidth + _style.textFieldMargins.width);
         var_1670.height = var_1670.textHeight + _style.textFieldMargins.height;
         var_1670.x = param2.textFieldMargins.x;
         var_1670.y = param2.textFieldMargins.y;
         addChild(var_1670);
         if(!_style.isSystemStyle && var_1670.textHeight > 108)
         {
            var_2128 = new Sprite();
            var_2128.graphics.clear();
            var_2128.graphics.beginFill(16777215);
            var_2128.graphics.drawRect(0,0,var_1670.textWidth + 5,108 - param2.textFieldMargins.height);
            var_1670.mask = var_2128;
            addChild(var_2128);
         }
         this.addEventListener("addedToStage",onAddedToStage);
      }
      
      public function dispose() : void
      {
         this.removeEventListener("addedToStage",onAddedToStage);
         this.removeEventListener("click",onMouseClick);
         if(var_2128)
         {
            removeChild(var_2128);
         }
         if(var_1670)
         {
            var_1670.removeEventListener("link",onTextLinkEvent);
         }
         removeChild(var_1670);
         if(var_2659 != null && _style.faceOffset != null)
         {
            removeChild(var_2659);
         }
         if(var_2033 && var_2033.parent)
         {
            removeChild(var_2033);
         }
         removeChild(_background);
         var_2128 = null;
         var_1670 = null;
         var_2659 = null;
         var_2033 = null;
         _background = null;
         _style = null;
      }
      
      private function onTextLinkEvent(param1:TextEvent) : void
      {
         if(param1.text && param1.text.length > 0)
         {
            var_1660.context.createLinkEvent(param1.text);
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
         repositionPointer();
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:* = 0;
         var_2501 += param1;
         if(proxyX != var_2833 || y != var_2811)
         {
            _loc2_ = uint(var_2501 - var_4312);
            if(_loc2_ < 150)
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
         repositionPointer();
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
      
      public function drawToBitmap(param1:BitmapData) : void
      {
         param1.draw(this);
      }
   }
}
