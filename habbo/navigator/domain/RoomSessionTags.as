package com.sulake.habbo.navigator.domain
{
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_868;
   
   public class RoomSessionTags
   {
       
      
      private var _tag1:String;
      
      private var _tag2:String;
      
      public function RoomSessionTags(param1:String, param2:String)
      {
         super();
         _tag1 = param1;
         _tag2 = param2;
      }
      
      public function getMsg() : class_868
      {
         return new class_868(_tag1,_tag2);
      }
   }
}
