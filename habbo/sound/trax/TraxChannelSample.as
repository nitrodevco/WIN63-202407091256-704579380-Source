package com.sulake.habbo.sound.trax
{
   public class TraxChannelSample
   {
       
      
      private var var_4249:TraxSample = null;
      
      private var _offset:int = 0;
      
      public function TraxChannelSample(param1:TraxSample, param2:int)
      {
         super();
         var_4249 = param1;
         _offset = param2;
      }
      
      public function setSample(param1:Vector.<int>, param2:int, param3:int) : void
      {
         _offset = var_4249.setSample(param1,param2,param3,_offset);
      }
      
      public function addSample(param1:Vector.<int>, param2:int, param3:int) : void
      {
         _offset = var_4249.addSample(param1,param2,param3,_offset);
      }
   }
}
