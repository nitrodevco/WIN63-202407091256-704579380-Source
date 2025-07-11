package com.sulake.room.renderer
{
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   
   [SecureSWF(rename="true")]
   public class class_2015 extends Component implements IRoomRendererFactory
   {
       
      
      public function class_2015(param1:IContext, param2:uint = 0)
      {
         super(param1,param2);
      }
      
      public function createRenderer() : IRoomRenderer
      {
         return new class_3447(this);
      }
   }
}
