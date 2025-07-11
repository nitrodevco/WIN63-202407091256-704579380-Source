package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.utils.ITextFieldContainer;
   import com.sulake.core.window.utils.class_3639;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class TextSkinRenderer extends SkinRenderer
   {
      
      private static const const_418:ColorTransform = new ColorTransform(0,0,0,1,255,255,255,0);
       
      
      protected var var_1680:Matrix;
      
      public function TextSkinRenderer(param1:String)
      {
         super(param1);
         var_1680 = new Matrix();
      }
      
      override public function parse(param1:IAsset, param2:XMLList, param3:IAssetLibrary) : void
      {
         var _loc4_:String = String(param1.content.toString());
         class_3639.setStyles(class_3639.parseCSS(_loc4_));
      }
      
      override public function draw(param1:IWindow, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc7_:ITextFieldContainer = null;
         var _loc9_:Object = null;
         var _loc11_:ColorTransform = null;
         if(param2 != null)
         {
            _loc7_ = ITextFieldContainer(param1);
            var _loc10_:ITextWindow;
            var _loc6_:String = (_loc10_ = ITextWindow(param1)).autoSize;
            var _loc8_:TextField = _loc7_.textField;
            var_1680.tx = _loc7_.margins.left;
            var_1680.ty = _loc7_.margins.top;
            if(_loc6_ == "right")
            {
               var_1680.tx = Math.floor(param1.width - _loc8_.width - _loc7_.margins.right);
            }
            else if(_loc6_ == "center")
            {
               var_1680.tx = Math.floor(param1.width / 2 - _loc8_.width / 2);
            }
            if((_loc10_.etchingColor & 4278190080) != 0)
            {
               const_418.redOffset = _loc10_.etchingColor >> 16 & 255;
               const_418.greenOffset = _loc10_.etchingColor >> 8 & 255;
               const_418.blueOffset = _loc10_.etchingColor & 255;
               const_418.alphaMultiplier = (_loc10_.etchingColor >> 24 & 255) / 255;
               if((_loc9_ = ETCHING_POSITION[_loc10_.etchingPosition]) != null)
               {
                  var_1680.tx += _loc9_.x;
                  var_1680.ty += _loc9_.y;
                  param2.draw(_loc8_,var_1680,const_418,null,null,false);
                  var_1680.tx -= _loc9_.x;
                  var_1680.ty -= _loc9_.y;
               }
            }
            if(param1.dynamicStyleColor)
            {
               _loc11_ = param1.dynamicStyleColor;
            }
            param2.draw(_loc8_,var_1680,_loc11_,null,null,false);
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return param1 == 0;
      }
   }
}
