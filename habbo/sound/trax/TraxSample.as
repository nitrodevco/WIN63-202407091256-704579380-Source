package com.sulake.habbo.sound.trax
{
   import com.sulake.core.runtime.IDisposable;
   import flash.utils.ByteArray;
   
   public class TraxSample implements IDisposable
   {
      
      public static const SAMPLE_FREQUENCY_44KHZ:String = "sample_44khz";
      
      public static const SAMPLE_FREQUENCY_22KHZ:String = "sample_22khz";
      
      public static const SAMPLE_FREQUENCY_11KHZ:String = "sample_11khz";
      
      public static const SAMPLE_SCALE_16BIT:String = "sample_16bit";
      
      public static const SAMPLE_SCALE_8BIT:String = "sample_8bit";
      
      public static const SAMPLE_VALUE_MULTIPLIER:Number = 0.000030517578125;
      
      private static const FADEOUT_LENGTH:int = 32;
      
      private static const MASK_8BIT:int = 255;
      
      private static const MASK_16BIT:int = 65535;
      
      private static const OFFSET_8BIT:int = 127;
      
      private static const OFFSET_16BIT:int = 32767;
       
      
      private var _disposed:Boolean = false;
      
      private var _sampleData:Vector.<int> = null;
      
      private var var_280:int;
      
      private var var_1838:int = 2;
      
      private var var_1724:int = 1;
      
      private var var_2492:Array;
      
      private var var_4663:uint;
      
      public function TraxSample(param1:ByteArray, param2:int, param3:String = "sample_44khz", param4:String = "sample_16bit")
      {
         var _loc8_:int = 0;
         var _loc16_:Number = NaN;
         var _loc10_:int = 0;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc11_:int = 0;
         var_2492 = [];
         super();
         var_280 = param2;
         var _loc12_:int = 65536;
         switch(param3)
         {
            case "sample_22khz":
               var_1724 = 2;
               break;
            case "sample_11khz":
               var_1724 = 4;
               break;
            default:
               var_1724 = 1;
         }
         var _loc17_:* = param4;
         if("sample_8bit" !== _loc17_)
         {
            var_1838 = 2;
            _loc12_ = 65536;
         }
         else
         {
            var_1838 = 4;
            _loc12_ = 256;
         }
         var _loc15_:int = var_1838 * var_1724;
         var _loc14_:int = int((_loc14_ = param1.length / 8) / _loc15_) * _loc15_;
         _sampleData = new Vector.<int>(_loc14_ / _loc15_,true);
         var _loc13_:Number = 1 / (_loc12_ / 2);
         param1.position = 0;
         var _loc9_:int = 0;
         var _loc7_:int = _loc14_ / var_1724;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc16_ = param1.readFloat();
            param1.readFloat();
            _loc10_ = 2;
            while(_loc10_ <= var_1724)
            {
               _loc6_ = param1.readFloat();
               param1.readFloat();
               _loc5_ = _loc10_;
               _loc16_ = _loc16_ * (_loc5_ - 1) / _loc5_ + _loc6_ / _loc5_;
               _loc10_++;
            }
            if(_loc8_ >= _loc7_ - 1 - 32)
            {
               _loc16_ *= (_loc7_ - _loc8_ - 1) / 32;
            }
            if((_loc11_ = (_loc16_ + 1) / _loc13_) < 0)
            {
               _loc11_ = 0;
            }
            else if(_loc11_ >= _loc12_)
            {
               _loc11_ = _loc12_ - 1;
            }
            _loc9_ = (_loc9_ *= _loc12_) + _loc11_;
            if(_loc8_ % var_1838 == var_1838 - 1)
            {
               _sampleData[int(_loc8_ / var_1838)] = _loc9_;
               _loc9_ = 0;
            }
            _loc8_++;
         }
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get length() : uint
      {
         return _sampleData.length * var_1838 * var_1724;
      }
      
      public function get usageCount() : int
      {
         return var_2492.length;
      }
      
      public function get usageTimeStamp() : int
      {
         return var_4663;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _sampleData = null;
            var_2492 = null;
         }
      }
      
      public function setSample(param1:Vector.<int>, param2:int, param3:int, param4:int) : int
      {
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:* = 0;
         if(param1 == null || _sampleData == null)
         {
            return param4;
         }
         var _loc5_:int = var_1838 * var_1724;
         param4 /= _loc5_;
         if(param2 < 0)
         {
            param3 += param2;
            param2 = 0;
         }
         if(param3 > param1.length - param2)
         {
            param3 = param1.length - param2;
         }
         var _loc8_:int = param3 / _loc5_;
         var _loc7_:int = 0;
         if(_loc8_ > _sampleData.length - param4)
         {
            _loc7_ = (_loc8_ - (_sampleData.length - param4)) * _loc5_;
            _loc8_ = _sampleData.length - param4;
            if(_loc7_ > param1.length - param2)
            {
               _loc7_ = param1.length - param2;
            }
         }
         if(var_1724 == 1)
         {
            if(var_1838 == 2)
            {
               while(_loc8_-- > 0)
               {
                  _loc10_ = _sampleData[param4++];
                  param1[param2++] = (_loc10_ >> 16 & 65535) - 32767;
                  param1[param2++] = (_loc10_ & 65535) - 32767;
               }
            }
            else if(var_1838 == 4)
            {
               while(_loc8_-- > 0)
               {
                  _loc10_ = _sampleData[param4++];
                  param1[param2++] = (_loc10_ >> 24 & 255) - 127 << 8;
                  param1[param2++] = (_loc10_ >> 16 & 255) - 127 << 8;
                  param1[param2++] = (_loc10_ >> 8 & 255) - 127 << 8;
                  param1[param2++] = (_loc10_ & 255) - 127 << 8;
               }
            }
         }
         else if(var_1724 >= 2)
         {
            _loc9_ = 0;
            _loc6_ = 0;
            if(var_1838 == 2)
            {
               while(_loc8_-- > 0)
               {
                  _loc6_ = ((_loc10_ = _sampleData[param4++]) >> 16 & 65535) - 32767;
                  _loc9_ = var_1724;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
                  _loc6_ = (_loc10_ & 65535) - 32767;
                  _loc9_ = var_1724;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
               }
            }
            else if(var_1838 == 4)
            {
               while(_loc8_-- > 0)
               {
                  _loc6_ = ((_loc10_ = _sampleData[param4++]) >> 24 & 255) - 127 << 8;
                  _loc9_ = var_1724;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
                  _loc6_ = (_loc10_ >> 16 & 255) - 127 << 8;
                  _loc9_ = var_1724;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
                  _loc6_ = (_loc10_ >> 8 & 255) - 127 << 8;
                  _loc9_ = var_1724;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
                  _loc6_ = (_loc10_ & 255) - 127 << 8;
                  _loc9_ = var_1724;
                  while(_loc9_ > 0)
                  {
                     param1[param2++] = _loc6_;
                     _loc9_--;
                  }
               }
            }
         }
         while(_loc7_-- > 0)
         {
            param1[param2++] = 0;
         }
         return param4 * _loc5_;
      }
      
      public function addSample(param1:Vector.<int>, param2:int, param3:int, param4:int) : int
      {
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:* = 0;
         if(param1 == null || _sampleData == null)
         {
            return param4;
         }
         var _loc5_:int = var_1838 * var_1724;
         param4 /= _loc5_;
         if(param2 < 0)
         {
            param3 += param2;
            param2 = 0;
         }
         if(param3 > param1.length - param2)
         {
            param3 = param1.length - param2;
         }
         var _loc7_:int;
         if((_loc7_ = param3 / _loc5_) > _sampleData.length - param4)
         {
            _loc7_ = _sampleData.length - param4;
         }
         if(var_1724 == 1)
         {
            if(var_1838 == 2)
            {
               while(_loc7_-- > 0)
               {
                  _loc9_ = _sampleData[param4++];
                  param1[param2++] += (_loc9_ >> 16 & 65535) - 32767;
                  param1[param2++] += (_loc9_ & 65535) - 32767;
               }
            }
            else if(var_1838 == 4)
            {
               while(_loc7_-- > 0)
               {
                  _loc9_ = _sampleData[param4++];
                  param1[param2++] += (_loc9_ >> 24 & 255) - 127 << 8;
                  param1[param2++] += (_loc9_ >> 16 & 255) - 127 << 8;
                  param1[param2++] += (_loc9_ >> 8 & 255) - 127 << 8;
                  param1[param2++] += (_loc9_ & 255) - 127 << 8;
               }
            }
         }
         else if(var_1724 >= 2)
         {
            _loc8_ = 0;
            _loc6_ = 0;
            if(var_1838 == 2)
            {
               while(_loc7_-- > 0)
               {
                  _loc6_ = ((_loc9_ = _sampleData[param4++]) >> 16 & 65535) - 32767;
                  _loc8_ = var_1724;
                  while(_loc8_ > 0)
                  {
                     var _loc10_:* = param2++;
                     var _loc11_:* = param1[_loc10_] + _loc6_;
                     param1[_loc10_] = _loc11_;
                     _loc8_--;
                  }
                  _loc6_ = (_loc9_ & 65535) - 32767;
                  _loc8_ = var_1724;
                  while(_loc8_ > 0)
                  {
                     _loc11_ = param2++;
                     _loc10_ = param1[_loc11_] + _loc6_;
                     param1[_loc11_] = _loc10_;
                     _loc8_--;
                  }
               }
            }
            else if(var_1838 == 4)
            {
               while(_loc7_-- > 0)
               {
                  _loc6_ = ((_loc9_ = _sampleData[param4++]) >> 24 & 255) - 127 << 8;
                  _loc8_ = var_1724;
                  while(_loc8_ > 0)
                  {
                     _loc10_ = param2++;
                     _loc11_ = param1[_loc10_] + _loc6_;
                     param1[_loc10_] = _loc11_;
                     _loc8_--;
                  }
                  _loc6_ = (_loc9_ >> 16 & 255) - 127 << 8;
                  _loc8_ = var_1724;
                  while(_loc8_ > 0)
                  {
                     _loc11_ = param2++;
                     _loc10_ = param1[_loc11_] + _loc6_;
                     param1[_loc11_] = _loc10_;
                     _loc8_--;
                  }
                  _loc6_ = (_loc9_ >> 8 & 255) - 127 << 8;
                  _loc8_ = var_1724;
                  while(_loc8_ > 0)
                  {
                     _loc10_ = param2++;
                     _loc11_ = param1[_loc10_] + _loc6_;
                     param1[_loc10_] = _loc11_;
                     _loc8_--;
                  }
                  _loc6_ = (_loc9_ & 255) - 127 << 8;
                  _loc8_ = var_1724;
                  while(_loc8_ > 0)
                  {
                     _loc11_ = param2++;
                     _loc10_ = param1[_loc11_] + _loc6_;
                     param1[_loc11_] = _loc10_;
                     _loc8_--;
                  }
               }
            }
         }
         return param4 * _loc5_;
      }
      
      public function setUsageFromSong(param1:int, param2:uint) : void
      {
         if(var_2492 == null)
         {
            return;
         }
         if(var_2492.indexOf(param1) == -1)
         {
            var_2492.push(param1);
         }
         var_4663 = param2;
      }
      
      public function isUsedFromSong(param1:int) : Boolean
      {
         if(var_2492 == null)
         {
            return false;
         }
         return var_2492.indexOf(param1) != -1;
      }
   }
}
