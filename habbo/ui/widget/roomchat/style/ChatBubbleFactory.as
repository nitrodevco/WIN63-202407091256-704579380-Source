package com.sulake.habbo.ui.widget.roomchat.style
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ChatBubbleFactory
   {
      
      private static const const_696:int = 0;
       
      
      private var _styles:Map;
      
      public function ChatBubbleFactory(param1:IAssetLibrary, param2:IHabboWindowManager, param3:XML)
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc6_:XML = null;
         var _loc8_:ChatBubbleStyle = null;
         _styles = new Map();
         super();
         for each(var _loc9_ in param3.child("style"))
         {
            _loc4_ = int(_loc9_.@id[0]);
            _loc5_ = _loc9_.@assetId[0];
            _loc7_ = "roomchat_styles_" + _loc5_ + "_style_xml";
            _loc6_ = XML(param1.getAssetByName(_loc7_).content);
            try
            {
               _loc8_ = new ChatBubbleStyle(param1,param2,_loc6_);
               _styles.add(_loc4_,_loc8_);
            }
            catch(e:Error)
            {
               class_14.log("Error initializing chat style: " + _loc4_ + ", error message: " + e.message);
            }
         }
      }
      
      public function getBubbleWindow(param1:int, param2:int) : IRegionWindow
      {
         var _loc3_:ChatBubbleStyle = getSafeChatBubbleStyle(param1);
         switch(param2)
         {
            case 0:
               return IRegionWindow(_loc3_.normalLayout.clone());
            case 1:
               if(_loc3_.whisperLayout != null)
               {
                  return IRegionWindow(_loc3_.whisperLayout.clone());
               }
               return IRegionWindow(_loc3_.normalLayout.clone());
               break;
            case 2:
               if(_loc3_.shoutLayout != null)
               {
                  return IRegionWindow(_loc3_.shoutLayout.clone());
               }
               return IRegionWindow(_loc3_.normalLayout.clone());
               break;
            default:
               if(_loc3_.whisperLayout != null)
               {
                  return IRegionWindow(_loc3_.whisperLayout.clone());
               }
               return IRegionWindow(_loc3_.normalLayout.clone());
         }
      }
      
      public function getPointerBitmapData(param1:int) : BitmapData
      {
         return getSafeChatBubbleStyle(param1).pointerBitmapData;
      }
      
      public function buildBubbleImage(param1:int, param2:int, param3:int, param4:int, param5:uint) : BitmapData
      {
         var _loc14_:ChatBubbleStyle = null;
         var _loc12_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc14_ = getSafeChatBubbleStyle(param1);
         var _loc16_:int = 0;
         var _loc11_:Point = new Point();
         var _loc13_:BitmapData = new BitmapData(_loc14_.leftBitmapData.width + param3 + _loc14_.rightBitmapData.width,param4,true,0);
         _loc16_ += _loc14_.leftBitmapData.width;
         _loc13_.copyPixels(_loc14_.leftBitmapData,_loc14_.leftBitmapData.rect,_loc11_);
         if(_loc14_.leftColorBitmapData != null)
         {
            _loc12_ = 232;
            var _loc8_:uint = 177;
            var _loc6_:uint = 55;
            if(param5 != 0)
            {
               _loc12_ = uint(param5 >> 16 & 255);
               _loc8_ = uint(param5 >> 8 & 255);
               _loc6_ = uint(param5 >> 0 & 255);
            }
            _loc13_.draw(_loc14_.leftColorBitmapData,null,new ColorTransform(_loc12_ / 255,_loc8_ / 255,_loc6_ / 255),"darken");
         }
         var _loc7_:Matrix = new Matrix();
         if(_loc14_.middleBitmapData.width == 1)
         {
            _loc7_.scale(param3 / _loc14_.middleBitmapData.width,1);
            _loc7_.translate(_loc16_,0);
            _loc13_.draw(_loc14_.middleBitmapData,_loc7_);
         }
         else
         {
            _loc7_.translate(_loc16_,0);
            _loc9_ = param3 / _loc14_.middleBitmapData.width + 1;
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc13_.draw(_loc14_.middleBitmapData,_loc7_);
               _loc7_.translate(_loc14_.middleBitmapData.width,0);
               _loc10_++;
            }
         }
         _loc16_ += param3;
         _loc11_.x = _loc16_;
         _loc13_.copyPixels(_loc14_.rightBitmapData,_loc14_.rightBitmapData.rect,_loc11_);
         var _loc15_:Rectangle;
         (_loc15_ = _loc14_.rightBitmapData.rect.clone()).offsetPoint(_loc11_);
         return _loc13_;
      }
      
      public function getStyleIds() : Array
      {
         return _styles.getKeys();
      }
      
      public function getAllowedUserInputStyleIds() : Array
      {
         var _loc3_:ChatBubbleStyle = null;
         var _loc2_:Array = [];
         for each(var _loc1_ in getStyleIds())
         {
            _loc3_ = _styles.getValue(_loc1_);
            if(!_loc3_.isSystemStyle && !_loc3_.isStaffOverrideable)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function getStaffOverrideableStyleIds() : Array
      {
         var _loc3_:ChatBubbleStyle = null;
         var _loc2_:Array = [];
         for each(var _loc1_ in getStyleIds())
         {
            _loc3_ = _styles.getValue(_loc1_);
            if(_loc3_.isStaffOverrideable)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function getStyleSelectorPreviewBitmap(param1:int) : BitmapData
      {
         var _loc2_:ChatBubbleStyle = getSafeChatBubbleStyle(param1);
         return _loc2_.selectorPreviewIconBitmapData;
      }
      
      public function getActualBubbleHeight(param1:int) : int
      {
         var _loc2_:ChatBubbleStyle = getSafeChatBubbleStyle(param1);
         return _loc2_.middleBitmapData.height;
      }
      
      private function getSafeChatBubbleStyle(param1:int) : ChatBubbleStyle
      {
         if(!_styles.hasKey(param1))
         {
            param1 = 0;
         }
         return ChatBubbleStyle(_styles.getValue(param1));
      }
   }
}
