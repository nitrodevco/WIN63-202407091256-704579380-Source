package com.sulake.habbo.game.snowwar.utils
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class SnowWarAnimatedWindowElement implements IDisposable
   {
       
      
      private var var_2225:int;
      
      private var var_2953:String;
      
      private var var_1862:Array;
      
      private var _currentFrame:int;
      
      private var var_1817:IBitmapWrapperWindow;
      
      private var var_1883:Timer;
      
      private var _disposed:Boolean = false;
      
      public function SnowWarAnimatedWindowElement(param1:IAssetLibrary, param2:IBitmapWrapperWindow, param3:String, param4:int, param5:int = 100, param6:Boolean = false)
      {
         var _loc7_:int = 0;
         var_1862 = [];
         super();
         var_1817 = param2;
         var_2953 = param3;
         var_2225 = param4;
         _loc7_ = 1;
         while(_loc7_ <= var_2225)
         {
            if(param1.hasAsset(var_2953 + _loc7_))
            {
               var_1862.push(param1.getAssetByName(var_2953 + _loc7_).content as BitmapData);
            }
            else
            {
               var_1862.push(new BitmapData(1,1));
               class_14.log("Missing asset for Snow War: " + var_2953 + _loc7_);
            }
            _loc7_++;
         }
         if(param6)
         {
            var_2225 += param4 - 2;
            _loc7_ = param4 - 1;
            while(_loc7_ > 1)
            {
               if(param1.hasAsset(var_2953 + _loc7_))
               {
                  var_1862.push(param1.getAssetByName(var_2953 + _loc7_).content as BitmapData);
               }
               else
               {
                  var_1862.push(new BitmapData(1,1));
                  class_14.log("Missing loop asset for Snow War: " + var_2953 + _loc7_);
               }
               _loc7_--;
            }
         }
         update();
         var_1883 = new Timer(param5);
         var_1883.addEventListener("timer",onTimer);
         var_1883.start();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_1883.removeEventListener("timer",onTimer);
            var_1883.stop();
            var_1883 = null;
            if(var_1817 && var_1817.bitmap)
            {
               var_1817.bitmap.fillRect(var_1817.bitmap.rect,0);
               var_1817.invalidate();
            }
            var_1817 = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         _currentFrame = ++_currentFrame % var_2225;
         if(!var_1817.bitmap)
         {
            var_1817.bitmap = new BitmapData(var_1817.width,var_1817.height);
         }
         var_1817.bitmap.fillRect(var_1817.bitmap.rect,0);
         var _loc2_:BitmapData = var_1862[_currentFrame];
         var _loc1_:Point = new Point((var_1817.width - _loc2_.width) / 2,(var_1817.height - _loc2_.height) / 2);
         var_1817.bitmap.copyPixels(_loc2_,_loc2_.rect,_loc1_);
         var_1817.invalidate();
      }
   }
}
