package com.sulake.habbo.sound.music
{
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_3371;
   import com.sulake.habbo.communication.messages.incoming.sound.class_1648;
   
   public class SongDataEntry extends class_1648 implements ISongInfo
   {
       
      
      private var _soundObject:class_3371 = null;
      
      private var var_1447:String;
      
      private var var_4811:int = -1;
      
      public function SongDataEntry(param1:int, param2:int, param3:String, param4:String, param5:class_3371)
      {
         _soundObject = param5;
         var_1447 = "";
         super(param1,param2,param3,param4);
      }
      
      override public function get id() : int
      {
         return var_606;
      }
      
      override public function get length() : int
      {
         return var_835;
      }
      
      override public function get name() : String
      {
         return _songName;
      }
      
      override public function get creator() : String
      {
         return var_994;
      }
      
      public function get loaded() : Boolean
      {
         return _soundObject == null ? false : _soundObject.ready;
      }
      
      public function get soundObject() : class_3371
      {
         return _soundObject;
      }
      
      public function get songData() : String
      {
         return var_1447;
      }
      
      public function get diskId() : int
      {
         return var_4811;
      }
      
      public function set soundObject(param1:class_3371) : void
      {
         _soundObject = param1;
      }
      
      public function set songData(param1:String) : void
      {
         var_1447 = param1;
      }
      
      public function set diskId(param1:int) : void
      {
         var_4811 = param1;
      }
   }
}
