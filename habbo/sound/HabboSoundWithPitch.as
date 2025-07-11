package com.sulake.habbo.sound
{
   import com.sulake.core.runtime.IUpdateReceiver;
   import flash.media.Sound;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   
   public class HabboSoundWithPitch extends HabboSoundBase implements IUpdateReceiver
   {
       
      
      private const SILENCE_MS:uint = 50;
      
      private const FADEIN_MS:uint = 175;
      
      private var var_3279:Number;
      
      private var var_3514:Sound;
      
      private var var_1987:ByteArray;
      
      private var var_4408:int;
      
      private var var_3858:uint = 0;
      
      private var var_3700:uint = 0;
      
      private var var_3611:Boolean = false;
      
      public function HabboSoundWithPitch(param1:Sound, param2:Number = 1)
      {
         super(param1);
         var_3279 = param2;
         var_3514 = new Sound();
         extractMonoSamples();
         setPitch(var_3279);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_3514 = null;
         if(var_1987 != null)
         {
            var_1987.clear();
            var_1987 = null;
         }
      }
      
      override public function play(param1:Number = 0) : Boolean
      {
         stop();
         var_3700 = var_3858;
         var_3611 = false;
         setComplete(false);
         setSoundChannel(var_3514.play(0,0,new SoundTransform(0)));
         return true;
      }
      
      override public function stop() : Boolean
      {
         if(getSoundChannel() != null)
         {
            getSoundChannel().stop();
         }
         return true;
      }
      
      public function update(param1:uint) : void
      {
         var_3858 += param1;
         var _loc2_:uint = uint(var_3858 - var_3700);
         if(var_3700 > 0 && _loc2_ < 50)
         {
            setChannelVolume(0);
         }
         else if(var_3700 > 0 && _loc2_ >= 50 && _loc2_ < 175)
         {
            setChannelVolume(volume * (_loc2_ / 175));
         }
         else if(!var_3611)
         {
            setChannelVolume(volume);
            var_3611 = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1987 == null;
      }
      
      public function setPitch(param1:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         var_3279 = param1;
         var _loc6_:ByteArray = new ByteArray();
         var _loc3_:uint = uint(int(var_1987.length / 4 * var_3279));
         var _loc2_:Number = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_ && int(_loc2_) * 4 < var_1987.length)
         {
            var_1987.position = int(_loc2_) * 4;
            _loc5_ = var_1987.readFloat();
            _loc6_.writeFloat(_loc5_);
            _loc6_.writeFloat(_loc5_);
            _loc2_ += var_3279;
            _loc4_++;
         }
         _loc6_.position = 0;
         var_3514.loadPCMFromByteArray(_loc6_,_loc6_.length / 8,"float");
      }
      
      private function extractMonoSamples() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc1_:ByteArray = new ByteArray();
         _soundObject.extract(_loc1_,int(_soundObject.length * 44.1),0);
         var_1987 = new ByteArray();
         var_4408 = _loc1_.length / 8;
         _loc1_.position = 0;
         _loc2_ = 0;
         while(_loc2_ < var_4408)
         {
            _loc3_ = _loc1_.readFloat();
            _loc1_.readFloat();
            var_1987.writeFloat(_loc3_);
            _loc2_++;
         }
      }
   }
}
