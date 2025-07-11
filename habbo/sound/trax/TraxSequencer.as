package com.sulake.habbo.sound.trax
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.sound.class_3371;
   import com.sulake.habbo.sound.events.SoundCompleteEvent;
   import flash.events.IEventDispatcher;
   import flash.events.SampleDataEvent;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class TraxSequencer implements class_3371, IDisposable
   {
      
      private static const SAMPLES_PER_SECOND:Number = 44100;
      
      private static const BUFFER_LENGTH:uint = 8192;
      
      private static const SAMPLES_BAR_LENGTH:uint = 88000;
      
      private static const BAR_LENGTH:uint = 88000;
      
      private static const MIXING_BUFFER:Vector.<int> = new Vector.<int>(8192,true);
      
      private static const INTERPOLATION_BUFFER:Vector.<int> = new Vector.<int>(8192,true);
       
      
      private var _disposed:Boolean = false;
      
      private var name_1:IEventDispatcher;
      
      private var _volume:Number;
      
      private var _sound:Sound;
      
      private var var_2141:SoundChannel;
      
      private var var_2187:TraxData;
      
      private var var_3358:Map;
      
      private var var_185:Boolean;
      
      private var var_606:int;
      
      private var var_3912:int = 0;
      
      private var var_1870:uint;
      
      private var var_2085:Array;
      
      private var var_3163:Boolean;
      
      private var var_2313:Boolean = true;
      
      private var var_1927:uint;
      
      private var var_3969:uint = 30;
      
      private var var_2478:Boolean;
      
      private var var_2357:Boolean;
      
      private var var_2674:int;
      
      private var var_2263:int;
      
      private var var_2583:int;
      
      private var var_1994:int;
      
      private var var_2470:Timer;
      
      private var var_2238:Timer;
      
      private var var_3388:Boolean;
      
      private var var_2868:int = 0;
      
      private var var_3743:int = 0;
      
      public function TraxSequencer(param1:int, param2:TraxData, param3:Map, param4:IEventDispatcher)
      {
         super();
         name_1 = param4;
         var_606 = param1;
         _volume = 1;
         _sound = new Sound();
         var_2141 = null;
         var_3358 = param3;
         var_2187 = param2;
         var_185 = true;
         var_1870 = 0;
         var_2085 = [];
         var_3163 = false;
         var_1927 = 0;
         var_2313 = false;
         var_2478 = false;
         var_2357 = false;
         var_2674 = 0;
         var_2263 = 0;
         var_2583 = 0;
         var_1994 = 0;
      }
      
      public function set position(param1:Number) : void
      {
         var_1870 = param1 * 44100;
      }
      
      public function get volume() : Number
      {
         return _volume;
      }
      
      public function get position() : Number
      {
         return var_1870 / 44100;
      }
      
      public function get ready() : Boolean
      {
         return var_185;
      }
      
      public function set ready(param1:Boolean) : void
      {
         var_185 = param1;
      }
      
      public function get finished() : Boolean
      {
         return var_2313;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return var_2263 / 44100;
      }
      
      public function set fadeOutSeconds(param1:Number) : void
      {
         var_2263 = param1 * 44100;
      }
      
      public function get fadeInSeconds() : Number
      {
         return var_2674 / 44100;
      }
      
      public function set fadeInSeconds(param1:Number) : void
      {
         var_2674 = param1 * 44100;
      }
      
      public function get traxData() : TraxData
      {
         return var_2187;
      }
      
      public function set volume(param1:Number) : void
      {
         _volume = param1;
         if(var_2141 != null)
         {
            var_2141.soundTransform = new SoundTransform(_volume);
         }
      }
      
      public function get length() : Number
      {
         return var_1927 / 44100;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            stopImmediately();
            var_2187 = null;
            var_3358 = null;
            var_2085 = null;
            name_1 = null;
            _sound = null;
            _disposed = true;
         }
      }
      
      public function prepare() : Boolean
      {
         if(!var_185)
         {
            class_14.log("Cannot start trax playback until samples ready!");
            return false;
         }
         if(!var_3163)
         {
            if(var_2187 != null)
            {
               var_3388 = false;
               if(var_2187.hasMetaData)
               {
                  var_3388 = var_2187.metaCutMode;
               }
               if(var_3388)
               {
                  if(!prepareSequence())
                  {
                     class_14.log("Cannot start playback, prepare sequence failed!");
                     return false;
                  }
               }
               else if(!prepareLegacySequence())
               {
                  class_14.log("Cannot start playback, prepare legacy sequence failed!");
                  return false;
               }
            }
         }
         return true;
      }
      
      private function prepareLegacySequence() : Boolean
      {
         var _loc8_:int = 0;
         var _loc3_:Map = null;
         var _loc7_:TraxChannel = null;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc12_:TraxSample = null;
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         if(var_2085 == null)
         {
            return false;
         }
         var _loc1_:uint = uint(getTimer());
         _loc8_ = 0;
         while(_loc8_ < var_2187.channels.length)
         {
            _loc3_ = new Map();
            _loc7_ = var_2187.channels[_loc8_] as TraxChannel;
            _loc4_ = 0;
            _loc2_ = 0;
            _loc9_ = 0;
            while(_loc9_ < _loc7_.itemCount)
            {
               _loc5_ = _loc7_.getItem(_loc9_).id;
               (_loc12_ = var_3358.getValue(_loc5_) as TraxSample).setUsageFromSong(var_606,_loc1_);
               if(_loc12_ == null)
               {
                  class_14.log("Error in prepareLegacySequence(), sample was null!");
                  return false;
               }
               _loc11_ = getSampleBars(_loc12_.length);
               _loc6_ = _loc7_.getItem(_loc9_).length / _loc11_;
               _loc10_ = 0;
               while(_loc10_ < _loc6_)
               {
                  if(_loc5_ != 0)
                  {
                     _loc3_.add(_loc4_,_loc12_);
                  }
                  _loc2_ += _loc11_;
                  _loc4_ = _loc2_ * 88000;
                  _loc10_++;
               }
               if(var_1927 < _loc4_)
               {
                  var_1927 = _loc4_;
               }
               _loc9_++;
            }
            var_2085.push(_loc3_);
            _loc8_++;
         }
         var_3163 = true;
         return true;
      }
      
      private function prepareSequence() : Boolean
      {
         var _loc6_:int = 0;
         var _loc12_:Map = null;
         var _loc5_:TraxChannel = null;
         var _loc2_:* = 0;
         var _loc11_:* = 0;
         var _loc13_:Boolean = false;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:TraxSample = null;
         var _loc3_:int = 0;
         var _loc14_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:int = 0;
         if(var_2085 == null)
         {
            return false;
         }
         var _loc10_:uint = uint(getTimer());
         _loc6_ = 0;
         while(_loc6_ < var_2187.channels.length)
         {
            _loc12_ = new Map();
            _loc5_ = var_2187.channels[_loc6_] as TraxChannel;
            _loc2_ = 0;
            _loc11_ = 0;
            _loc13_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.itemCount)
            {
               _loc4_ = _loc5_.getItem(_loc7_).id;
               (_loc9_ = var_3358.getValue(_loc4_) as TraxSample).setUsageFromSong(var_606,_loc10_);
               if(_loc9_ == null)
               {
                  class_14.log("Error in prepareSequence(), sample was null!");
                  return false;
               }
               _loc3_ = int(_loc11_);
               _loc14_ = int(_loc2_);
               _loc8_ = getSampleBars(_loc9_.length);
               _loc1_ = _loc5_.getItem(_loc7_).length;
               while(_loc3_ < _loc11_ + _loc1_)
               {
                  if(_loc4_ != 0 || _loc13_)
                  {
                     _loc12_.add(_loc14_,_loc9_);
                     _loc13_ = false;
                  }
                  _loc3_ += _loc8_;
                  _loc14_ = _loc3_ * 88000;
                  if(_loc3_ > _loc11_ + _loc1_)
                  {
                     _loc13_ = true;
                  }
               }
               _loc2_ = (_loc11_ += _loc5_.getItem(_loc7_).length) * 88000;
               if(var_1927 < _loc2_)
               {
                  var_1927 = _loc2_;
               }
               _loc7_++;
            }
            var_2085.push(_loc12_);
            _loc6_++;
         }
         var_3163 = true;
         return true;
      }
      
      public function play(param1:Number = 0) : Boolean
      {
         if(!prepare())
         {
            return false;
         }
         removeFadeoutStopTimer();
         if(var_2141 != null)
         {
            stopImmediately();
         }
         if(var_2674 > 0)
         {
            var_2478 = true;
            var_2583 = 0;
         }
         var_2357 = false;
         var_1994 = 0;
         var_2313 = false;
         _sound.addEventListener("sampleData",onSampleData);
         var_3912 = param1 * 44100;
         var_2868 = 0;
         var_3743 = 0;
         var_2141 = _sound.play();
         volume = _volume;
         return true;
      }
      
      public function render(param1:SampleDataEvent) : Boolean
      {
         if(!prepare())
         {
            return false;
         }
         while(!var_2313)
         {
            onSampleData(param1);
         }
         return true;
      }
      
      public function stop() : Boolean
      {
         if(var_2263 > 0 && !var_2313)
         {
            stopWithFadeout();
         }
         else
         {
            playingComplete();
         }
         return true;
      }
      
      private function stopImmediately() : void
      {
         removeStopTimer();
         if(var_2141 != null)
         {
            var_2141.stop();
            var_2141 = null;
         }
         if(_sound != null)
         {
            _sound.removeEventListener("sampleData",onSampleData);
         }
      }
      
      private function stopWithFadeout() : void
      {
         if(var_2470 == null)
         {
            var_2357 = true;
            var_1994 = 0;
            var_2470 = new Timer(var_3969 + var_2263 / (44100 / 1000),1);
            var_2470.start();
            var_2470.addEventListener("timerComplete",onFadeOutComplete);
         }
      }
      
      private function getSampleBars(param1:uint) : int
      {
         if(var_3388)
         {
            return Math.round(param1 / 88000);
         }
         return Math.ceil(param1 / 88000);
      }
      
      private function getChannelSequenceOffsets() : Array
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Map = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(var_2085 != null)
         {
            _loc1_ = int(var_2085.length);
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc5_ = var_2085[_loc3_];
               _loc4_ = 0;
               while(_loc4_ < _loc5_.length && _loc5_.getKey(_loc4_) < var_1870)
               {
                  _loc4_++;
               }
               _loc2_.push(_loc4_ - 1);
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function mixChannelsIntoBuffer() : void
      {
         var _loc6_:int = 0;
         var _loc7_:Map = null;
         var _loc14_:int = 0;
         var _loc8_:TraxSample = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc13_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:* = 0;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         if(var_2085 == null)
         {
            return;
         }
         var _loc4_:Array = getChannelSequenceOffsets();
         var _loc1_:int = int(var_2085.length);
         var _loc12_:TraxChannelSample = null;
         _loc6_ = _loc1_ - 1;
         while(_loc6_ >= 0)
         {
            _loc7_ = var_2085[_loc6_];
            _loc14_ = int(_loc4_[_loc6_]);
            if((_loc8_ = _loc7_.getWithIndex(_loc14_)) == null)
            {
               _loc12_ = null;
            }
            else
            {
               _loc2_ = _loc7_.getKey(_loc14_);
               _loc5_ = var_1870 - _loc2_;
               if(_loc8_.id == 0 || _loc5_ < 0)
               {
                  _loc12_ = null;
               }
               else
               {
                  _loc12_ = new TraxChannelSample(_loc8_,_loc5_);
               }
            }
            _loc13_ = 8192;
            if(var_1927 - var_1870 < _loc13_)
            {
               _loc13_ = var_1927 - var_1870;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc13_)
            {
               _loc3_ = _loc13_;
               if(_loc14_ < _loc7_.length - 1)
               {
                  _loc10_ = _loc7_.getKey(_loc14_ + 1);
                  if(_loc13_ + var_1870 >= _loc10_)
                  {
                     _loc3_ = _loc10_ - var_1870;
                  }
               }
               if(_loc3_ > _loc13_ - _loc11_)
               {
                  _loc3_ = _loc13_ - _loc11_;
               }
               if(_loc6_ == _loc1_ - 1)
               {
                  if(_loc12_ != null)
                  {
                     _loc12_.setSample(MIXING_BUFFER,_loc11_,_loc3_);
                     _loc11_ += _loc3_;
                  }
                  else
                  {
                     _loc9_ = 0;
                     while(_loc9_ < _loc3_)
                     {
                        MIXING_BUFFER[_loc11_++] = 0;
                        _loc9_++;
                     }
                  }
               }
               else
               {
                  if(_loc12_ != null)
                  {
                     _loc12_.addSample(MIXING_BUFFER,_loc11_,_loc3_);
                  }
                  _loc11_ += _loc3_;
               }
               if(_loc11_ < _loc13_)
               {
                  _loc14_++;
                  if((_loc8_ = _loc7_.getWithIndex(_loc14_)) == null || _loc8_.id == 0)
                  {
                     _loc12_ = null;
                  }
                  else
                  {
                     _loc12_ = new TraxChannelSample(_loc8_,0);
                  }
               }
            }
            _loc6_--;
         }
      }
      
      private function checkSongFinishing() : void
      {
         var _loc1_:int = int(var_1927 < var_3912 ? var_1927 : (var_3912 > 0 ? var_3912 : var_1927));
         if(var_1870 > _loc1_ + var_3969 * (44100 / 1000) && !var_2313)
         {
            var_2313 = true;
            if(var_2238 != null)
            {
               var_2238.reset();
               var_2238.removeEventListener("timerComplete",onPlayingComplete);
            }
            var_2238 = new Timer(2,1);
            var_2238.start();
            var_2238.addEventListener("timerComplete",onPlayingComplete);
         }
         else if(var_1870 > _loc1_ - var_2263 && !var_2357)
         {
            var_2478 = false;
            var_2357 = true;
            var_1994 = 0;
         }
      }
      
      private function onSampleData(param1:SampleDataEvent) : void
      {
         if(param1.position > var_2868)
         {
            var_3743++;
            class_14.log("Audio buffer under run...");
            var_2868 = param1.position;
         }
         if(volume > 0)
         {
            mixChannelsIntoBuffer();
         }
         var _loc2_:int = 8192;
         if(var_1927 - var_1870 < _loc2_)
         {
            _loc2_ = var_1927 - var_1870;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
         }
         if(volume <= 0)
         {
            _loc2_ = 0;
         }
         writeAudioToOutputStream(param1.data,_loc2_);
         var_1870 += 8192;
         var_2868 += 8192;
         if(var_2141 != null)
         {
            var_3969 = param1.position / 44100 * 1000 - var_2141.position;
         }
         checkSongFinishing();
      }
      
      private function writeAudioToOutputStream(param1:ByteArray, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:* = 0;
         if(param2 > 0)
         {
            if(!var_2478 && !var_2357)
            {
               writeMixingBufferToOutputStream(param1,param2);
            }
            else
            {
               if(var_2478)
               {
                  _loc3_ = 1 / var_2674;
                  _loc4_ = var_2583 / var_2674;
                  var_2583 += 8192;
                  if(var_2583 > var_2674)
                  {
                     var_2478 = false;
                  }
               }
               else if(var_2357)
               {
                  _loc3_ = -1 / var_2263;
                  _loc4_ = 1 - var_1994 / var_2263;
                  var_1994 += 8192;
                  if(var_1994 > var_2263)
                  {
                     var_1994 = var_2263;
                  }
               }
               writeMixingBufferToOutputStreamWithFade(param1,param2,_loc4_,_loc3_);
            }
         }
         var _loc5_:Number = 0;
         _loc6_ = param2;
         while(_loc6_ < 8192)
         {
            param1.writeFloat(_loc5_);
            param1.writeFloat(_loc5_);
            _loc6_++;
         }
      }
      
      private function writeMixingBufferToOutputStream(param1:ByteArray, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = MIXING_BUFFER[_loc3_] * 0.000030517578125;
            param1.writeFloat(_loc4_);
            param1.writeFloat(_loc4_);
            _loc3_++;
         }
      }
      
      private function writeMixingBufferToOutputStreamWithFade(param1:ByteArray, param2:int, param3:Number, param4:Number) : void
      {
         var _loc6_:Number = 0;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            if(param3 < 0 || param3 > 1)
            {
               break;
            }
            _loc6_ = MIXING_BUFFER[_loc5_] * 0.000030517578125 * param3;
            param3 += param4;
            param1.writeFloat(_loc6_);
            param1.writeFloat(_loc6_);
            _loc5_++;
         }
         if(param3 < 0)
         {
            while(_loc5_ < param2)
            {
               param1.writeFloat(0);
               param1.writeFloat(0);
               _loc5_++;
            }
         }
         else if(param3 > 1)
         {
            while(_loc5_ < param2)
            {
               _loc6_ = MIXING_BUFFER[_loc5_] * 0.000030517578125;
               param3 += param4;
               param1.writeFloat(_loc6_);
               param1.writeFloat(_loc6_);
               _loc5_++;
            }
         }
      }
      
      private function onPlayingComplete(param1:TimerEvent) : void
      {
         if(var_2313)
         {
            playingComplete();
         }
      }
      
      private function onFadeOutComplete(param1:TimerEvent) : void
      {
         removeFadeoutStopTimer();
         playingComplete();
      }
      
      private function playingComplete() : void
      {
         stopImmediately();
         name_1.dispatchEvent(new SoundCompleteEvent("SCE_TRAX_SONG_COMPLETE",var_606));
      }
      
      private function removeFadeoutStopTimer() : void
      {
         if(var_2470 != null)
         {
            var_2470.removeEventListener("timerComplete",onFadeOutComplete);
            var_2470.reset();
            var_2470 = null;
         }
      }
      
      private function removeStopTimer() : void
      {
         if(var_2238 != null)
         {
            var_2238.reset();
            var_2238.removeEventListener("timerComplete",onPlayingComplete);
            var_2238 = null;
         }
      }
   }
}
