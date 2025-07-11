package com.sulake.habbo.avatar.common
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3405;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.class_3418;
   import com.sulake.habbo.avatar.structure.figure.class_3617;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AvatarEditorGridPartItem implements IAvatarImageListener
   {
      
      private static var _downloadIcon:BitmapData;
      
      private static var DRAW_ORDER:Array = [];
      
      {
         DRAW_ORDER.push("li");
         DRAW_ORDER.push("lh");
         DRAW_ORDER.push("ls");
         DRAW_ORDER.push("lc");
         DRAW_ORDER.push("bd");
         DRAW_ORDER.push("sh");
         DRAW_ORDER.push("lg");
         DRAW_ORDER.push("ch");
         DRAW_ORDER.push("ca");
         DRAW_ORDER.push("cc");
         DRAW_ORDER.push("cp");
         DRAW_ORDER.push("wa");
         DRAW_ORDER.push("rh");
         DRAW_ORDER.push("rs");
         DRAW_ORDER.push("rc");
         DRAW_ORDER.push("hd");
         DRAW_ORDER.push("fc");
         DRAW_ORDER.push("ey");
         DRAW_ORDER.push("hr");
         DRAW_ORDER.push("hrb");
         DRAW_ORDER.push("fa");
         DRAW_ORDER.push("ea");
         DRAW_ORDER.push("ha");
         DRAW_ORDER.push("he");
         DRAW_ORDER.push("ri");
      }
      
      private var var_1644:class_3554;
      
      private var _window:IWindowContainer;
      
      private var var_2348:IWindow;
      
      private var var_2520:class_3418;
      
      private var _colors:Array;
      
      private var _useColors:Boolean;
      
      private var var_3588:Boolean = false;
      
      private var var_2298:BitmapData;
      
      private var var_2089:Rectangle;
      
      private var var_4042:int = 0;
      
      private var var_2157:IAvatarRenderManager;
      
      private var var_318:Boolean;
      
      private var _isDisabledForWearing:Boolean;
      
      private const THUMB_DIRECTIONS:Array = [2,6,0,4,3,1];
      
      public function AvatarEditorGridPartItem(param1:IWindowContainer, param2:class_3554, param3:class_3418, param4:Array, param5:Boolean = true, param6:Boolean = false)
      {
         var _loc7_:* = null;
         var _loc8_:Array = null;
         super();
         var_1644 = param2;
         var_2520 = param3;
         _window = param1;
         var_2348 = _window.findChildByTag("BG_COLOR");
         _colors = param4;
         _useColors = param5;
         _isDisabledForWearing = param6;
         if(param3 == null)
         {
            var_2298 = new BitmapData(1,1,true,16777215);
         }
         if(param3 != null)
         {
            _loc8_ = param3.parts;
            for each(_loc7_ in _loc8_)
            {
               var_4042 = Math.max(var_4042,_loc7_.colorLayerIndex);
            }
         }
         var_2157 = var_1644.controller.manager.avatarRenderManager;
         _window.addEventListener("WME_OVER",onMouseOver);
         _window.addEventListener("WME_OUT",onMousetOut);
         updateThumbVisualization();
      }
      
      private function onMousetOut(param1:WindowMouseEvent) : void
      {
         if(!var_3588)
         {
            var_2348.visible = false;
         }
         var_2348.blend = 1;
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         if(!var_3588)
         {
            var_2348.visible = true;
            var_2348.blend = 0.5;
         }
      }
      
      public function dispose() : void
      {
         if(var_318)
         {
            return;
         }
         var_1644 = null;
         var_2520 = null;
         if(_window != null)
         {
            if(!_window.disposed)
            {
               _window.dispose();
            }
         }
         _window = null;
         if(var_2298)
         {
            var_2298.dispose();
         }
         var_2298 = null;
         var_318 = true;
         _downloadIcon = null;
         var_2348 = null;
         var_2089 = null;
         var_2157 = null;
         var_318 = true;
         _colors = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function get view() : IWindowContainer
      {
         return _window;
      }
      
      public function get isSelected() : Boolean
      {
         return var_3588;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         var_3588 = param1;
         updateThumbVisualization();
      }
      
      public function get id() : int
      {
         if(var_2520 == null)
         {
            return -1;
         }
         return var_2520.id;
      }
      
      public function get colorLayerCount() : int
      {
         return var_4042;
      }
      
      public function update() : void
      {
         updateThumbVisualization();
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         var_2298 = param1;
         updateThumbVisualization();
      }
      
      public function get partSet() : class_3418
      {
         return var_2520;
      }
      
      public function set colors(param1:Array) : void
      {
         _colors = param1;
         updateThumbVisualization();
      }
      
      private function updateThumbVisualization() : void
      {
         var _loc1_:BitmapData = null;
         var _loc3_:BitmapData = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc5_:IBitmapWrapperWindow;
         if(_loc5_ = _window.findChildByName("bitmap") as IBitmapWrapperWindow)
         {
            if(var_2298 != null && !_useColors)
            {
               _loc1_ = var_2298;
            }
            else
            {
               _loc1_ = renderThumb();
               if(!_loc1_)
               {
                  return;
               }
            }
            _loc3_ = !!_loc5_.bitmap ? _loc5_.bitmap : new BitmapData(_loc5_.width,_loc5_.height);
            _loc3_.fillRect(_loc3_.rect,16777215);
            _loc4_ = (_loc3_.width - _loc1_.width) / 2;
            _loc6_ = (_loc3_.height - _loc1_.height) / 2;
            _loc3_.copyPixels(_loc1_,_loc1_.rect,new Point(_loc4_,_loc6_),null,null,true);
            _loc5_.bitmap = _loc3_;
         }
         var _loc7_:IWindow = _window.findChildByTag("CLUB_ICON");
         var _loc2_:IStaticBitmapWrapperWindow = _window.findChildByTag("SELLABLE_ICON") as IStaticBitmapWrapperWindow;
         if(var_2520)
         {
            _loc7_.visible = var_2520.clubLevel > 0;
            _loc2_.visible = var_2520.isSellable;
         }
         else
         {
            _loc7_.visible = false;
            _loc2_.visible = false;
         }
         if(_isDisabledForWearing)
         {
            setAlpha(_loc3_,0.2);
         }
         if(var_2348 == null)
         {
            return;
         }
         var_2348.visible = var_3588;
         var_2348.blend = 1;
         _window.invalidate();
      }
      
      private function analyzePartLayers() : Boolean
      {
         var _loc4_:* = null;
         var _loc6_:String = null;
         var _loc7_:BitmapDataAsset = null;
         var _loc3_:BitmapData = null;
         if(var_1644 == null)
         {
            var_2089 = null;
            return false;
         }
         if(!partSet || !partSet.parts || partSet.parts.length == 0)
         {
            var_2089 = null;
            return false;
         }
         if(!var_2157)
         {
            return false;
         }
         var _loc2_:class_3405 = var_2157.createFigureContainer(partSet.type + "-" + partSet.id);
         if(!var_2157.isFigureReady(_loc2_))
         {
            var_2157.downloadFigure(_loc2_,this);
            return false;
         }
         var _loc8_:int = 0;
         var _loc5_:Boolean = false;
         var _loc1_:Rectangle = new Rectangle();
         for each(_loc4_ in partSet.parts)
         {
            if(_loc5_)
            {
               _loc6_ = "h_std_" + _loc4_.type + "_" + _loc4_.id + "_" + THUMB_DIRECTIONS[_loc8_] + "_" + "0";
               _loc7_ = var_2157.getAssetByName(_loc6_) as BitmapDataAsset;
            }
            else
            {
               _loc8_ = 0;
               while(!_loc5_ && _loc8_ < THUMB_DIRECTIONS.length)
               {
                  _loc6_ = "h_std_" + _loc4_.type + "_" + _loc4_.id + "_" + THUMB_DIRECTIONS[_loc8_] + "_" + "0";
                  if((_loc7_ = var_2157.getAssetByName(_loc6_) as BitmapDataAsset) && _loc7_.content)
                  {
                     _loc5_ = true;
                  }
                  else
                  {
                     _loc8_++;
                  }
               }
            }
            if(_loc7_ && _loc7_.content)
            {
               _loc3_ = _loc7_.content as BitmapData;
               _loc1_ = _loc1_.union(new Rectangle(-1 * _loc7_.offset.x,-1 * _loc7_.offset.y,_loc7_.rectangle.width,_loc7_.rectangle.height));
            }
         }
         if(_loc1_ && _loc1_.width > 0)
         {
            var_2089 = _loc1_;
            return true;
         }
         return false;
      }
      
      private function renderThumb() : BitmapData
      {
         var _loc11_:IAsset = null;
         var _loc4_:BitmapData = null;
         var _loc3_:* = null;
         var _loc10_:String = null;
         var _loc12_:BitmapDataAsset = null;
         var _loc1_:BitmapData = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:ColorTransform = null;
         var _loc2_:IPartColor = null;
         var _loc6_:Rectangle = null;
         if(partSet == null)
         {
            return null;
         }
         if(var_1644 == null)
         {
            return null;
         }
         if(var_2089 == null)
         {
            if(!analyzePartLayers())
            {
               if(!_downloadIcon)
               {
                  _downloadIcon = (_loc11_ = var_1644.controller.manager.windowManager.assets.getAssetByName("avatar_editor_avatar_editor_download_icon")).content as BitmapData;
               }
               return _downloadIcon;
            }
         }
         if(!var_2157)
         {
            return null;
         }
         _loc4_ = new BitmapData(var_2089.width,var_2089.height,true,16777215);
         var _loc5_:int = 0;
         var _loc9_:Boolean = false;
         var _loc14_:Array = partSet.parts.concat().sort(sortByDrawOrder);
         for each(_loc3_ in _loc14_)
         {
            _loc12_ = null;
            if(_loc9_)
            {
               _loc10_ = "h_std_" + _loc3_.type + "_" + _loc3_.id + "_" + THUMB_DIRECTIONS[_loc5_] + "_" + "0";
               _loc12_ = var_2157.getAssetByName(_loc10_) as BitmapDataAsset;
            }
            else
            {
               _loc5_ = 0;
               while(!_loc9_ && _loc5_ < THUMB_DIRECTIONS.length)
               {
                  _loc10_ = "h_std_" + _loc3_.type + "_" + _loc3_.id + "_" + THUMB_DIRECTIONS[_loc5_] + "_" + "0";
                  if((_loc12_ = var_2157.getAssetByName(_loc10_) as BitmapDataAsset) && _loc12_.content)
                  {
                     _loc9_ = true;
                  }
                  else
                  {
                     _loc5_++;
                  }
               }
            }
            if(_loc12_)
            {
               _loc1_ = BitmapData(_loc12_.content);
               _loc7_ = -1 * _loc12_.offset.x - var_2089.x;
               _loc8_ = -1 * _loc12_.offset.y - var_2089.y;
               _loc13_ = null;
               if(_useColors && _loc3_.colorLayerIndex > 0)
               {
                  _loc2_ = _colors[_loc3_.colorLayerIndex - 1];
                  if(_loc2_ != null)
                  {
                     _loc13_ = _loc2_.colorTransform;
                  }
               }
               if(_loc13_)
               {
                  _loc6_ = new Rectangle(_loc7_,_loc8_,_loc12_.rectangle.width,_loc12_.rectangle.height);
                  _loc4_.draw(_loc12_.content as BitmapData,new Matrix(1,0,0,1,-_loc12_.rectangle.x + _loc7_,-_loc12_.rectangle.y + _loc8_),_loc13_,null,_loc6_);
               }
               else
               {
                  _loc4_.copyPixels(_loc1_,_loc12_.rectangle,new Point(_loc7_,_loc8_),null,null,true);
               }
            }
         }
         return _loc4_;
      }
      
      private function setAlpha(param1:BitmapData, param2:Number) : BitmapData
      {
         var _loc3_:Rectangle = new Rectangle(0,0,param1.width,param1.height);
         var _loc4_:ColorTransform;
         (_loc4_ = new ColorTransform()).alphaMultiplier = param2;
         param1.colorTransform(_loc3_,_loc4_);
         return param1;
      }
      
      private function sortByDrawOrder(param1:class_3617, param2:class_3617) : Number
      {
         var _loc3_:Number = DRAW_ORDER.indexOf(param1.type);
         var _loc4_:Number = DRAW_ORDER.indexOf(param2.type);
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.index < param2.index)
         {
            return -1;
         }
         if(param1.index > param2.index)
         {
            return 1;
         }
         return 0;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(!analyzePartLayers())
         {
            return;
         }
         updateThumbVisualization();
      }
      
      public function get isDisabledForWearing() : Boolean
      {
         return _isDisabledForWearing;
      }
   }
}
