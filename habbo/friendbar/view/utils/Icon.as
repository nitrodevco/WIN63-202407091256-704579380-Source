package com.sulake.habbo.friendbar.view.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class Icon implements IDisposable
   {
      
      protected static const ALIGN_LEFT:int = 0;
      
      protected static const ALIGN_CENTER:int = 1;
      
      protected static const ALIGN_RIGHT:int = 2;
      
      protected static const MASK_HORIZONTAL:int = 3;
      
      protected static const ALIGN_TOP:int = 4;
      
      protected static const ALIGN_MIDDLE:int = 8;
      
      protected static const ALIGN_BOTTOM:int = 18;
      
      protected static const MASK_VERTICAL:int = 18;
       
      
      private var _disposed:Boolean = false;
      
      private var var_3617:Boolean = false;
      
      protected var var_859:BitmapDataAsset;
      
      protected var var_1696:IBitmapWrapperWindow;
      
      private var var_3819:uint = 9;
      
      protected var var_1883:Timer;
      
      protected var _frame:int = 0;
      
      private var _point:Point;
      
      protected var var_2856:Boolean = false;
      
      protected var _hover:Boolean = false;
      
      public function Icon()
      {
         _point = new Point();
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get disabled() : Boolean
      {
         return var_3617;
      }
      
      protected function set image(param1:BitmapDataAsset) : void
      {
         var_859 = param1;
         redraw();
      }
      
      protected function get image() : BitmapDataAsset
      {
         return var_859;
      }
      
      protected function set canvas(param1:IBitmapWrapperWindow) : void
      {
         var_1696 = param1;
         redraw();
      }
      
      protected function get canvas() : IBitmapWrapperWindow
      {
         return var_1696;
      }
      
      protected function set alignment(param1:uint) : void
      {
         var_3819 = param1;
         redraw();
      }
      
      protected function get alignment() : uint
      {
         return var_3819;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            toggleTimer(false,0);
            image = null;
            canvas = null;
            _disposed = true;
         }
      }
      
      public function notify(param1:Boolean) : void
      {
         var_2856 = param1;
         if(var_2856 && var_3617)
         {
            enable(true);
         }
      }
      
      public function hover(param1:Boolean) : void
      {
         _hover = param1;
      }
      
      public function enable(param1:Boolean) : void
      {
         var_3617 = !param1;
      }
      
      protected function redraw() : void
      {
         var _loc1_:BitmapData = null;
         if(var_1696 && !var_1696.disposed)
         {
            if(!var_1696.bitmap)
            {
               var_1696.bitmap = new BitmapData(var_1696.width,var_1696.height,true,0);
            }
            else
            {
               var_1696.bitmap.fillRect(var_1696.bitmap.rect,0);
            }
            if(var_859 && !var_859.disposed)
            {
               _point.x = _point.y = 0;
               _loc1_ = var_859.content as BitmapData;
               switch((var_3819 & 3) - 1)
               {
                  case 0:
                     _point.x = var_1696.bitmap.width / 2 - _loc1_.width / 2;
                     break;
                  case 1:
                     _point.x = var_1696.bitmap.width - _loc1_.width;
               }
               switch((var_3819 & 18) - 8)
               {
                  case 0:
                     _point.y = var_1696.bitmap.height / 2 - _loc1_.height / 2;
                     break;
                  case 10:
                     _point.y = var_1696.bitmap.height - _loc1_.height;
               }
               var_1696.bitmap.copyPixels(_loc1_,_loc1_.rect,_point);
               var_1696.invalidate();
            }
         }
      }
      
      protected function toggleTimer(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            if(!var_1883)
            {
               var_1883 = new Timer(param2,0);
               var_1883.addEventListener("timer",onTimerEvent);
               var_1883.start();
               onTimerEvent(null);
            }
            var_1883.delay = param2;
         }
         else
         {
            _frame = 0;
            if(var_1883)
            {
               var_1883.reset();
               var_1883.removeEventListener("timer",onTimerEvent);
               var_1883 = null;
            }
         }
      }
      
      protected function onTimerEvent(param1:TimerEvent) : void
      {
      }
   }
}
