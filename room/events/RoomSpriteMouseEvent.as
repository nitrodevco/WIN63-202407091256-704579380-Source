package com.sulake.room.events
{
   public class RoomSpriteMouseEvent
   {
       
      
      private var var_329:String = "";
      
      private var var_4154:String = "";
      
      private var var_4149:String = "";
      
      private var var_4279:String = "";
      
      private var var_4286:Number = 0;
      
      private var var_4345:Number = 0;
      
      private var var_1000:Number = 0;
      
      private var var_862:Number = 0;
      
      private var _ctrlKey:Boolean = false;
      
      private var _altKey:Boolean = false;
      
      private var _shiftKey:Boolean = false;
      
      private var var_4376:Boolean = false;
      
      private var var_4701:int = 0;
      
      private var var_4617:int = 0;
      
      public function RoomSpriteMouseEvent(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:Number, param7:Number = 0, param8:Number = 0, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false)
      {
         super();
         var_329 = param1;
         var_4154 = param2;
         var_4149 = param3;
         var_4279 = param4;
         var_4286 = param5;
         var_4345 = param6;
         var_1000 = param7;
         var_862 = param8;
         _ctrlKey = param9;
         _altKey = param10;
         _shiftKey = param11;
         var_4376 = param12;
      }
      
      public function get type() : String
      {
         return var_329;
      }
      
      public function get eventId() : String
      {
         return var_4154;
      }
      
      public function get canvasId() : String
      {
         return var_4149;
      }
      
      public function get spriteTag() : String
      {
         return var_4279;
      }
      
      public function get screenX() : Number
      {
         return var_4286;
      }
      
      public function get screenY() : Number
      {
         return var_4345;
      }
      
      public function get localX() : Number
      {
         return var_1000;
      }
      
      public function get localY() : Number
      {
         return var_862;
      }
      
      public function get ctrlKey() : Boolean
      {
         return _ctrlKey;
      }
      
      public function get altKey() : Boolean
      {
         return _altKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return _shiftKey;
      }
      
      public function get buttonDown() : Boolean
      {
         return var_4376;
      }
      
      public function get spriteOffsetX() : int
      {
         return var_4701;
      }
      
      public function set spriteOffsetX(param1:int) : void
      {
         var_4701 = param1;
      }
      
      public function get spriteOffsetY() : int
      {
         return var_4617;
      }
      
      public function set spriteOffsetY(param1:int) : void
      {
         var_4617 = param1;
      }
   }
}
