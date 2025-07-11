package com.sulake.habbo.sound
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class HabboSoundBase implements class_3371
   {
       
      
      private var var_2141:SoundChannel = null;
      
      private var var_1808:Boolean;
      
      private var _volume:Number;
      
      private var var_3724:int;
      
      protected var _soundObject:Sound = null;
      
      public function HabboSoundBase(param1:Sound, param2:int = 0)
      {
         super();
         _soundObject = param1;
         _soundObject.addEventListener("complete",onComplete);
         _volume = 1;
         var_1808 = false;
         var_3724 = param2;
      }
      
      protected function getSoundObject() : Sound
      {
         return _soundObject;
      }
      
      protected function getSoundChannel() : SoundChannel
      {
         return var_2141;
      }
      
      protected function setSoundChannel(param1:SoundChannel) : void
      {
         var_2141 = param1;
      }
      
      protected function setComplete(param1:Boolean) : void
      {
         var_1808 = param1;
      }
      
      public function dispose() : void
      {
         stop();
         var_2141 = null;
         _soundObject = null;
      }
      
      public function play(param1:Number = 0) : Boolean
      {
         var_1808 = false;
         var_2141 = _soundObject.play(0,var_3724);
         setChannelVolume(_volume);
         return true;
      }
      
      public function stop() : Boolean
      {
         if(var_2141)
         {
            var_2141.stop();
         }
         return true;
      }
      
      public function get volume() : Number
      {
         return _volume;
      }
      
      public function set volume(param1:Number) : void
      {
         _volume = param1;
         setChannelVolume(param1);
      }
      
      protected function setChannelVolume(param1:Number) : void
      {
         if(var_2141 != null)
         {
            var_2141.soundTransform = new SoundTransform(param1);
         }
      }
      
      public function get position() : Number
      {
         return var_2141.position;
      }
      
      public function set position(param1:Number) : void
      {
      }
      
      public function get length() : Number
      {
         return _soundObject.length;
      }
      
      public function get ready() : Boolean
      {
         return !_soundObject.isBuffering;
      }
      
      public function get finished() : Boolean
      {
         return !var_1808;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return 0;
      }
      
      public function set fadeOutSeconds(param1:Number) : void
      {
      }
      
      public function get fadeInSeconds() : Number
      {
         return 0;
      }
      
      public function set fadeInSeconds(param1:Number) : void
      {
      }
      
      private function onComplete(param1:Event) : void
      {
         var_1808 = true;
      }
   }
}
