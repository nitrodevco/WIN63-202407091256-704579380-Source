package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import flash.geom.Rectangle;
   
   public class TagListRenderer
   {
       
      
      private const MARGIN_X:int = 5;
      
      private const MARGIN_Y:int = 5;
      
      private var var_1629:InfoStandWidget;
      
      private var var_85:Function;
      
      private var _offsetX:int;
      
      private var _offsetY:int;
      
      private var var_3496:Rectangle = null;
      
      private var var_4900:int = 0;
      
      private var var_3673:Array;
      
      public function TagListRenderer(param1:InfoStandWidget, param2:Function)
      {
         super();
         var_1629 = param1;
         var_85 = param2;
      }
      
      public function dispose() : void
      {
         var_1629 = null;
         var_85 = null;
      }
      
      public function renderTags(param1:Array, param2:IWindowContainer, param3:Array) : int
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc9_:ITextWindow = null;
         var _loc7_:int = 0;
         var_3673 = param3;
         if(var_3673 != null)
         {
            _loc4_ = [];
            while((_loc5_ = param1.pop()) != null)
            {
               param3.indexOf(_loc5_) != -1 ? _loc4_.unshift(_loc5_) : _loc4_.push(_loc5_);
            }
            param1 = _loc4_;
         }
         while(param2.removeChildAt(0) != null)
         {
         }
         var_4900 = 0;
         _offsetX = 0;
         _offsetY = 0;
         var_3496 = param2.rectangle;
         var_3496.height = 150;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            _loc9_ = createTag(param1[_loc7_] as String);
            if(fit(_loc9_))
            {
               param2.addChild(_loc9_);
            }
            else
            {
               _loc9_.dispose();
            }
            _loc7_++;
         }
         var _loc8_:int;
         if((_loc8_ = param2.numChildren) == 0)
         {
            return 0;
         }
         var _loc6_:IWindow;
         return (_loc6_ = param2.getChildAt(param2.numChildren - 1)).bottom;
      }
      
      private function fit(param1:IWindow) : Boolean
      {
         if(param1.width > var_3496.width)
         {
            return false;
         }
         if(_offsetY + param1.height > var_3496.height)
         {
            return false;
         }
         if(_offsetX + param1.width > var_3496.width)
         {
            _offsetX = 0;
            _offsetY += param1.height + 5;
            return fit(param1);
         }
         param1.offset(_offsetX,_offsetY);
         _offsetX += param1.width + 5;
         return true;
      }
      
      private function createTag(param1:String) : ITextWindow
      {
         var _loc2_:XmlAsset = null;
         if(var_3673 != null && var_3673.indexOf(param1) != -1)
         {
            _loc2_ = var_1629.assets.getAssetByName("user_tag_highlighted") as XmlAsset;
         }
         else
         {
            _loc2_ = var_1629.assets.getAssetByName("user_tag") as XmlAsset;
         }
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:ITextWindow = var_1629.windowManager.buildFromXML(_loc2_.content as XML) as ITextWindow;
         if(_loc3_ == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _loc3_.addEventListener("WME_CLICK",var_85);
         _loc3_.caption = param1;
         return _loc3_;
      }
   }
}
