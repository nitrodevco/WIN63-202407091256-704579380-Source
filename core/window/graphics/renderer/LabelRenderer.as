package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.TextLabelController;
   import com.sulake.core.window.utils.TextFieldCache;
   import com.sulake.core.window.utils.class_3613;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class LabelRenderer extends SkinRenderer
   {
      
      private static const const_418:ColorTransform = new ColorTransform(0,0,0,1,255,255,255,0);
       
      
      protected var var_1680:Matrix;
      
      protected var var_4444:class_3613;
      
      protected var var_2465:TextField;
      
      public function LabelRenderer(param1:String)
      {
         super(param1);
         var_1680 = new Matrix();
      }
      
      override public function draw(param1:IWindow, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc9_:TextLabelController = null;
         var _loc6_:* = 0;
         var _loc7_:Object = null;
         var _loc10_:ColorTransform = null;
         if(param2 != null)
         {
            var _loc8_:class_3613;
            if((_loc8_ = (_loc9_ = TextLabelController(param1)).textStyle) != var_4444)
            {
               var_2465 = TextFieldCache.getTextFieldByStyle(_loc8_);
               var_4444 = _loc8_;
            }
            var_1680.tx = _loc9_.drawOffsetX;
            var_1680.ty = _loc9_.drawOffsetY;
            var_2465.text = _loc9_.text;
            _loc6_ = uint(_loc8_.color);
            var_2465.textColor = _loc9_.hasTextColor ? _loc9_.textColor : _loc6_;
            var_2465.antiAliasType = "advanced";
            var_2465.gridFitType = "pixel";
            if(_loc9_.vertical)
            {
               var_1680.a = 0;
               var_1680.b = -1;
               var_1680.c = 1;
               var_1680.d = 0;
               var_1680.ty += _loc9_.height;
            }
            if((uint(_loc8_.etchingColor) & 4278190080) != 0)
            {
               const_418.redOffset = uint(_loc8_.etchingColor) >> 16 & 255;
               const_418.greenOffset = uint(_loc8_.etchingColor) >> 8 & 255;
               const_418.blueOffset = uint(_loc8_.etchingColor) & 255;
               if((_loc7_ = ETCHING_POSITION[_loc8_.etchingPosition]) != null)
               {
                  if(_loc9_.vertical)
                  {
                     var_1680.tx += _loc7_.y;
                     var_1680.ty -= _loc7_.x;
                     param2.draw(var_2465,var_1680,const_418,null,null,false);
                     var_1680.tx -= _loc7_.y;
                     var_1680.ty += _loc7_.x;
                  }
                  else
                  {
                     var_1680.tx += _loc7_.x;
                     var_1680.ty += _loc7_.y;
                     param2.draw(var_2465,var_1680,const_418,null,null,false);
                     var_1680.tx -= _loc7_.x;
                     var_1680.ty -= _loc7_.y;
                  }
               }
            }
            if(param1.dynamicStyleColor)
            {
               _loc10_ = param1.dynamicStyleColor;
            }
            param2.draw(var_2465,var_1680,_loc10_,null,null,false);
            if(_loc9_.vertical)
            {
               var_1680.a = 1;
               var_1680.b = 0;
               var_1680.c = 0;
               var_1680.d = 1;
               var_1680.ty -= _loc9_.height;
            }
            var_2465.textColor = _loc6_;
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return param1 == 0;
      }
   }
}
