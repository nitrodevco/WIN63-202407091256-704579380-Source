package com.sulake.habbo.ui.widget.roomchat.style
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   
   public class ChatBubbleStyle
   {
       
      
      private var var_950:int;
      
      private var _styleName:String;
      
      private var var_4598:Boolean = false;
      
      private var var_4288:Boolean = false;
      
      private var _normalLayout:IRegionWindow;
      
      private var _whisperLayout:IRegionWindow;
      
      private var _shoutLayout:IRegionWindow;
      
      private var var_4507:BitmapData;
      
      private var var_4609:BitmapData;
      
      private var var_4779:BitmapData;
      
      private var var_4514:BitmapData;
      
      private var var_4443:BitmapData;
      
      private var var_4756:BitmapData;
      
      public function ChatBubbleStyle(param1:IAssetLibrary, param2:IHabboWindowManager, param3:XML)
      {
         super();
         var_950 = param3.@id[0];
         _styleName = param3.@name[0];
         var_4598 = param3.@systemstyle[0];
         var_4288 = param3.@staffoverride[0];
         var _loc11_:XML = param3.child("layouts")[0];
         var _loc4_:XML = param3.child("bitmaps")[0];
         _normalLayout = buildBubbleWindow(param2,param1,getXmlElementAssetId(_loc11_,"speakLayout"));
         _whisperLayout = buildBubbleWindow(param2,param1,getXmlElementAssetId(_loc11_,"whisperLayout"));
         _shoutLayout = buildBubbleWindow(param2,param1,getXmlElementAssetId(_loc11_,"shoutLayout"));
         var _loc9_:String = getXmlElementAssetId(_loc4_,"leftBitmap");
         var _loc6_:String = getXmlElementAssetId(_loc4_,"leftColorBitmap");
         var _loc7_:String = getXmlElementAssetId(_loc4_,"middleBitmap");
         var _loc5_:String = getXmlElementAssetId(_loc4_,"rightBitmap");
         var _loc10_:String = getXmlElementAssetId(_loc4_,"pointerBitmap");
         if(_loc9_)
         {
            var_4507 = getBitmapDataFor(_loc9_,param1);
         }
         if(_loc6_)
         {
            var_4609 = getBitmapDataFor(_loc6_,param1);
         }
         if(_loc7_)
         {
            var_4779 = getBitmapDataFor(_loc7_,param1);
         }
         if(_loc5_)
         {
            var_4514 = getBitmapDataFor(_loc5_,param1);
         }
         if(_loc10_)
         {
            var_4443 = getBitmapDataFor(_loc10_,param1);
         }
         var _loc8_:String;
         if(_loc8_ = getXmlElementAssetId(_loc4_,"previewIconBitmap"))
         {
            var_4756 = getBitmapDataFor(_loc8_,param1);
         }
      }
      
      private static function getXmlElementAssetId(param1:XML, param2:String) : String
      {
         var _loc3_:XMLList = param1.child(param2);
         if(_loc3_.length() < 1)
         {
            return null;
         }
         var _loc4_:XMLList;
         if((_loc4_ = XML(_loc3_[0]).attribute("assetId")).length() < 1)
         {
            return null;
         }
         return _loc4_[0];
      }
      
      public function get normalLayout() : IRegionWindow
      {
         return _normalLayout;
      }
      
      public function get whisperLayout() : IRegionWindow
      {
         return _whisperLayout;
      }
      
      public function get shoutLayout() : IRegionWindow
      {
         return _shoutLayout;
      }
      
      public function get leftBitmapData() : BitmapData
      {
         return var_4507;
      }
      
      public function get leftColorBitmapData() : BitmapData
      {
         return var_4609;
      }
      
      public function get middleBitmapData() : BitmapData
      {
         return var_4779;
      }
      
      public function get rightBitmapData() : BitmapData
      {
         return var_4514;
      }
      
      public function get pointerBitmapData() : BitmapData
      {
         return var_4443;
      }
      
      public function get isSystemStyle() : Boolean
      {
         return var_4598;
      }
      
      public function get isStaffOverrideable() : Boolean
      {
         return var_4288;
      }
      
      public function get selectorPreviewIconBitmapData() : BitmapData
      {
         return var_4756;
      }
      
      private function buildBubbleWindow(param1:IHabboWindowManager, param2:IAssetLibrary, param3:String) : IRegionWindow
      {
         if(param3 == null)
         {
            return null;
         }
         var _loc5_:IAsset = param2.getAssetByName(localAssetName(param3 + "_xml"));
         var _loc4_:IRegionWindow;
         (_loc4_ = param1.buildFromXML(_loc5_.content as XML,1) as IRegionWindow).tags.push("roomchat_bubble");
         _loc4_.x = 0;
         _loc4_.y = 0;
         _loc4_.width = 0;
         _loc4_.background = true;
         _loc4_.mouseThreshold = 0;
         _loc4_.setParamFlag(1073741824,true);
         return _loc4_;
      }
      
      private function localAssetName(param1:String) : String
      {
         return "roomchat_styles_" + _styleName + "_" + param1;
      }
      
      private function getBitmapDataFor(param1:String, param2:IAssetLibrary) : BitmapData
      {
         var _loc3_:IAsset = param2.getAssetByName(localAssetName(param1));
         if(_loc3_)
         {
            return BitmapData(_loc3_.content);
         }
         throw new Error("Configured bitmapdata asset missing for chat bubble style: " + localAssetName(param1));
      }
   }
}
