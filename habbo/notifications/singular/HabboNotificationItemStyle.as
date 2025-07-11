package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.utils.Map;
   import flash.display.BitmapData;
   
   public class HabboNotificationItemStyle
   {
       
      
      private var _icon:BitmapData;
      
      private var var_3710:Boolean;
      
      private var var_4813:String;
      
      private var var_3767:String;
      
      private var _iconAssetUri:String;
      
      public function HabboNotificationItemStyle(param1:Map, param2:BitmapData, param3:String, param4:Boolean, param5:String)
      {
         super();
         _iconAssetUri = param3;
         if(param1 != null && param3 == null)
         {
            _icon = param1["icon"];
            var_3767 = param1["internallink"];
         }
         if(param2 != null)
         {
            _icon = param2;
            var_3710 = param4;
         }
         else
         {
            var_3710 = false;
         }
         var_4813 = param5;
      }
      
      public function dispose() : void
      {
         if(var_3710 && _icon != null)
         {
            _icon.dispose();
            _icon = null;
         }
      }
      
      public function get icon() : BitmapData
      {
         return _icon;
      }
      
      public function get internalLink() : String
      {
         return var_3767;
      }
      
      public function set internalLink(param1:String) : void
      {
         var_3767 = param1;
      }
      
      public function get iconSrc() : String
      {
         return var_4813;
      }
      
      public function get iconAssetUri() : String
      {
         return _iconAssetUri;
      }
   }
}
