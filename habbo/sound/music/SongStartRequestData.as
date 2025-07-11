package com.sulake.habbo.sound.music
{
   import flash.utils.getTimer;
   
   public class SongStartRequestData
   {
       
      
      private var var_606:int;
      
      private var var_4051:Number;
      
      private var _playLength:Number;
      
      private var _playRequestTime:int;
      
      private var var_4862:Number;
      
      private var var_4409:Number;
      
      public function SongStartRequestData(param1:int, param2:Number, param3:Number, param4:Number = 2, param5:Number = 1)
      {
         super();
         var_606 = param1;
         var_4051 = param2;
         _playLength = param3;
         var_4862 = param4;
         var_4409 = param5;
         _playRequestTime = getTimer();
      }
      
      public function get songId() : int
      {
         return var_606;
      }
      
      public function get startPos() : Number
      {
         if(var_4051 < 0)
         {
            return 0;
         }
         return var_4051 + (getTimer() - _playRequestTime) / 1000;
      }
      
      public function get playLength() : Number
      {
         return _playLength;
      }
      
      public function get fadeInSeconds() : Number
      {
         return var_4862;
      }
      
      public function get fadeOutSeconds() : Number
      {
         return var_4409;
      }
   }
}
