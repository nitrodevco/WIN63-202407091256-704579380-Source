package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.graphics.class_3725;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitmapSkinRenderer extends SkinRenderer implements ISkinRenderer
   {
      
      protected static const const_409:Rectangle = new Rectangle();
      
      protected static const const_438:Point = new Point();
       
      
      protected var _bitmapCache:Dictionary;
      
      protected var var_2030:Matrix;
      
      protected var var_2205:ColorTransform;
      
      public function BitmapSkinRenderer(param1:String)
      {
         super(param1);
         _bitmapCache = new Dictionary(false);
         var_2030 = new Matrix();
         var_2205 = new ColorTransform();
      }
      
      override public function parse(param1:IAsset, param2:XMLList, param3:IAssetLibrary) : void
      {
         class_3725.parseSkinDescription(param1.content as XML,param2,this,name,param3);
      }
      
      override public function dispose() : void
      {
         var _loc2_:String = null;
         var _loc1_:BitmapData = null;
         if(!disposed)
         {
            super.dispose();
            var_2030 = null;
            var_2205 = null;
            for(_loc2_ in _bitmapCache)
            {
               _loc1_ = _bitmapCache[_loc2_] as BitmapData;
               _loc1_.dispose();
               delete _bitmapCache[_loc2_];
            }
            _bitmapCache = null;
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return var_2120[param1] != null;
      }
      
      override public function draw(param1:IWindow, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc13_:* = 0;
         var _loc8_:ISkinTemplateEntity = null;
         var _loc15_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc20_:* = 0;
         var _loc22_:SkinLayoutEntity = null;
         var _loc14_:BitmapData = null;
         var _loc24_:int = 0;
         var _loc27_:* = 0;
         var _loc26_:int = 0;
         var _loc17_:BitmapData = null;
         var _loc23_:ISkinLayout = var_2270[param4];
         var _loc6_:ISkinTemplate = var_2120[param4];
         if(_loc23_ == null)
         {
            _loc23_ = var_2270[0];
            _loc6_ = var_2120[0];
         }
         _loc13_ = uint(_loc23_.numChildren);
         if(_loc23_ != null && _loc13_ > 0)
         {
            var _loc10_:int = param3.width - _loc23_.width;
            var _loc28_:int = param3.height - _loc23_.height;
            var _loc12_:Boolean;
            if(_loc12_ = !param1.background && (param1.color & 16777215) < 16777215)
            {
               var_2205.redMultiplier = ((param1.color & 16711680) >> 16) / 255;
               var_2205.greenMultiplier = ((param1.color & 65280) >> 8) / 255;
               var_2205.blueMultiplier = (param1.color & 255) / 255;
               var_2205.alphaMultiplier = 1;
            }
            _loc20_ = 0;
            while(_loc20_ < _loc13_)
            {
               _loc22_ = _loc23_.getChildAt(_loc20_) as SkinLayoutEntity;
               if((_loc8_ = _loc6_.getChildByName(_loc22_.name) as ISkinTemplateEntity) != null)
               {
                  _loc14_ = getBitmapFromCache(_loc6_,_loc22_.name);
                  if(_loc12_ && _loc22_.colorize)
                  {
                     _loc14_ = _loc14_.clone();
                     _loc14_.colorTransform(_loc14_.rect,var_2205);
                  }
                  _loc15_ = false;
                  _loc9_ = false;
                  const_409.x = _loc22_.region.x + param3.x;
                  const_409.y = _loc22_.region.y + param3.y;
                  const_409.width = _loc22_.region.width;
                  const_409.height = _loc22_.region.height;
                  if(_loc22_.scaleH == 1)
                  {
                     const_409.x += _loc10_;
                  }
                  else
                  {
                     if(_loc22_.scaleH == 2)
                     {
                        _loc15_ = true;
                        const_409.right += _loc10_;
                        if(const_409.width >= 1)
                        {
                        }
                        break;
                     }
                     if(_loc22_.scaleH == 4)
                     {
                        _loc15_ = true;
                        const_409.right += _loc10_;
                        if(const_409.width >= 1)
                        {
                        }
                        break;
                     }
                     if(_loc22_.scaleH == 8)
                     {
                        const_409.x = param3.width / 2 - const_409.width / 2;
                     }
                  }
                  if(_loc22_.scaleV == 1)
                  {
                     const_409.y += _loc28_;
                  }
                  else
                  {
                     if(_loc22_.scaleV == 2)
                     {
                        _loc9_ = true;
                        const_409.bottom += _loc28_;
                        if(const_409.height >= 1)
                        {
                        }
                        break;
                     }
                     if(_loc22_.scaleV == 4)
                     {
                        _loc9_ = true;
                        const_409.bottom += _loc28_;
                        if(const_409.height >= 1)
                        {
                        }
                        break;
                     }
                     if(_loc22_.scaleV == 8)
                     {
                        const_409.y = param3.height / 2 - const_409.height / 2;
                     }
                  }
                  if(!_loc15_ && !_loc9_)
                  {
                     param2.copyPixels(_loc14_,_loc14_.rect,const_409.topLeft,null,null,true);
                  }
                  else if(_loc22_.scaleV == 4 || _loc22_.scaleH == 4)
                  {
                     _loc24_ = _loc14_.width;
                     var _loc19_:int = _loc14_.height;
                     var _loc11_:int = const_409.width / _loc24_;
                     var _loc29_:int = const_409.height / _loc19_;
                     var _loc16_:int = const_409.width % _loc24_;
                     var _loc7_:int = const_409.height % _loc19_;
                     var _loc25_:Point = new Point(const_409.x,const_409.y);
                     var _loc18_:Rectangle = new Rectangle(0,0,_loc16_,_loc14_.height);
                     var _loc21_:Rectangle = new Rectangle(0,0,_loc14_.width,_loc7_);
                     _loc27_ = 0;
                     while(_loc27_ < _loc29_)
                     {
                        _loc25_.x = const_409.x;
                        _loc26_ = 0;
                        while(_loc26_ < _loc11_)
                        {
                           param2.copyPixels(_loc14_,_loc14_.rect,_loc25_,null,null,true);
                           _loc25_.x += _loc24_;
                           _loc26_++;
                        }
                        if(_loc16_ > 0)
                        {
                           param2.copyPixels(_loc14_,_loc18_,_loc25_,null,null,true);
                        }
                        _loc25_.y += _loc19_;
                        _loc27_++;
                     }
                     if(_loc7_ > 0)
                     {
                        _loc25_.x = const_409.x;
                        _loc27_ = 0;
                        while(_loc27_ < _loc11_)
                        {
                           param2.copyPixels(_loc14_,_loc21_,_loc25_,null,null,true);
                           _loc25_.x += _loc24_;
                           _loc27_++;
                        }
                     }
                  }
                  else
                  {
                     if(!(_loc14_.width == 1 && _loc14_.height == 1))
                     {
                        if(const_409.width >= 1)
                        {
                           if(const_409.height < 1)
                           {
                              break;
                           }
                           var_2030.a = const_409.width / _loc14_.width;
                           var_2030.d = const_409.height / _loc14_.height;
                           var_2030.tx = 0;
                           var_2030.ty = 0;
                           (_loc17_ = new BitmapData(const_409.width,const_409.height,true,0)).draw(_loc14_,var_2030);
                           param2.copyPixels(_loc17_,_loc17_.rect,const_409.topLeft,null,null,true);
                           _loc17_.dispose();
                        }
                        break;
                     }
                     var_2030.a = const_409.width;
                     var_2030.d = const_409.height;
                     var_2030.tx = const_409.x;
                     var_2030.ty = const_409.y;
                     param2.draw(_loc14_,var_2030);
                  }
                  if(_loc12_ && _loc22_.colorize)
                  {
                     _loc14_.dispose();
                  }
               }
               _loc20_++;
            }
         }
      }
      
      protected function drawStaticLayoutEntity(param1:BitmapData, param2:Rectangle, param3:ISkinLayout, param4:SkinLayoutEntity, param5:ISkinTemplate, param6:ISkinTemplateEntity) : void
      {
         var _loc7_:BitmapData = null;
         var _loc8_:Rectangle = param4.region.clone();
         _loc8_.x = _loc8_.x + param2.x;
         _loc8_.y += param2.y;
         switch(param6.type)
         {
            case "bitmap":
               _loc7_ = getBitmapFromCache(param5,param4.name);
               if(param4.scaleH == 1)
               {
                  _loc8_.x += param2.width - param3.width;
               }
               if(param4.scaleV == 1)
               {
                  _loc8_.y += param2.height - param3.height;
               }
               param1.copyPixels(_loc7_,_loc7_.rect,_loc8_.topLeft,null,null,true);
               break;
            case "fill":
               param1.fillRect(_loc8_,param4.color);
         }
      }
      
      protected function getBitmapFromCache(param1:ISkinTemplate, param2:String) : BitmapData
      {
         var _loc5_:String = null;
         var _loc6_:ISkinTemplateEntity = null;
         var _loc4_:BitmapData = null;
         _loc5_ = param2 + "@" + param1.name;
         var _loc3_:BitmapData = _bitmapCache[_loc5_];
         if(_loc3_ == null)
         {
            if((_loc6_ = param1.getChildByName(param2) as ISkinTemplateEntity) == null)
            {
               throw new Error("Template entity" + param2 + "not found!");
            }
            if((_loc4_ = param1.asset.content as BitmapData) == null)
            {
               throw new Error("Asset " + param1.asset + " not found!");
            }
            _loc3_ = new TrackedBitmapData(this,_loc6_.region.width,_loc6_.region.height,true);
            _loc3_.copyPixels(_loc4_,_loc6_.region,const_438);
            _bitmapCache[_loc5_] = _loc3_;
         }
         return _loc3_;
      }
      
      private function drawBorders(param1:BitmapData, param2:Rectangle, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = param2.bottom - 1;
         _loc4_ = param2.left;
         while(_loc4_ < param2.right - 1)
         {
            param1.setPixel32(_loc4_,0,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc4_++;
         }
         _loc5_ = param2.top;
         while(_loc5_ < param2.bottom - 1)
         {
            param1.setPixel32(0,_loc5_,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc5_++;
         }
      }
   }
}
