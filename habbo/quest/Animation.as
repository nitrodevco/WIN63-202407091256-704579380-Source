package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import flash.display.BitmapData;
   
   public class Animation implements IDisposable
   {
       
      
      private var var_1696:IBitmapWrapperWindow;
      
      private var var_2875:int;
      
      private var var_2876:Boolean;
      
      private var var_1761:Array;
      
      public function Animation(param1:IBitmapWrapperWindow)
      {
         var_1761 = [];
         super();
         var_1696 = param1;
         var_1696.visible = false;
         if(param1.bitmap == null)
         {
            param1.bitmap = new BitmapData(param1.width,param1.height,true,0);
         }
      }
      
      public function dispose() : void
      {
         var_1696 = null;
         if(var_1761)
         {
            for each(var _loc1_ in var_1761)
            {
               _loc1_.dispose();
            }
            var_1761 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1696 == null;
      }
      
      public function addObject(param1:AnimationObject) : void
      {
         var_1761.push(param1);
      }
      
      public function stop() : void
      {
         var_2876 = false;
         var_1696.visible = false;
      }
      
      public function restart() : void
      {
         var_2875 = 0;
         var_2876 = true;
         for each(var _loc1_ in var_1761)
         {
            _loc1_.onAnimationStart();
         }
         draw();
         var_1696.visible = true;
      }
      
      public function update(param1:uint) : void
      {
         if(var_2876)
         {
            var_2875 += param1;
            draw();
         }
      }
      
      private function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc3_:BitmapData = null;
         var_1696.bitmap.fillRect(var_1696.bitmap.rect,0);
         if(var_2876)
         {
            _loc1_ = false;
            for each(var _loc2_ in var_1761)
            {
               if(!_loc2_.isFinished(var_2875))
               {
                  _loc1_ = true;
                  _loc3_ = _loc2_.getBitmap(var_2875);
                  if(_loc3_ != null)
                  {
                     var_1696.bitmap.copyPixels(_loc3_,_loc3_.rect,_loc2_.getPosition(var_2875));
                  }
               }
            }
         }
         var_1696.invalidate();
         var_2876 = _loc1_;
      }
   }
}
