package com.sulake.habbo.avatar
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import flash.display.BitmapData;
   
   public class PlaceholderAvatarImage extends AvatarImage
   {
      
      internal static var _fullImageCache:Map = new Map();
       
      
      public function PlaceholderAvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:AvatarFigureContainer, param4:String, param5:EffectAssetDownloadManager)
      {
         super(param1,param2,param3,param4,param5,null);
      }
      
      override public function dispose() : void
      {
         if(!var_318)
         {
            if(_cache)
            {
               _cache.dispose();
               _cache = null;
            }
            var_1671 = null;
            _assets = null;
            var_1753 = null;
            var_426 = null;
            var_2244 = null;
            var_531 = null;
            if(!var_3191 && var_859)
            {
               var_859.dispose();
            }
            var_859 = null;
            var_2288 = null;
            var_318 = true;
         }
      }
      
      override protected function getFullImage(param1:String) : BitmapData
      {
         return _fullImageCache[param1];
      }
      
      override protected function cacheFullImage(param1:String, param2:BitmapData) : void
      {
         if(_fullImageCache.getValue(param1))
         {
            (_fullImageCache.getValue(param1) as BitmapData).dispose();
            _fullImageCache.remove(param1);
         }
         _fullImageCache[param1] = param2;
      }
      
      override public function appendAction(param1:String, ... rest) : Boolean
      {
         var _loc3_:String = null;
         if(rest != null && rest.length > 0)
         {
            _loc3_ = String(rest[0]);
         }
         switch(param1)
         {
            case "posture":
               switch(_loc3_)
               {
                  case "lay":
                  case "mv":
                  case "std":
                  case "swim":
                  case "float":
                  case "sit":
                     super.appendAction.apply(null,[param1].concat(rest));
               }
               break;
            case "fx":
            case "dance":
            case "wave":
            case "sign":
            case "cri":
            case "usei":
            case "blow":
               super.addActionData.apply(null,[param1].concat(rest));
         }
         return true;
      }
      
      override public function isPlaceholder() : Boolean
      {
         return true;
      }
   }
}
