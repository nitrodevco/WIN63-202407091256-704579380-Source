package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPollUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const OFFER:String = "RWPUW_OFFER";
      
      public static const ERROR:String = "RWPUW_ERROR";
      
      public static const CONTENT:String = "RWPUW_CONTENT";
       
      
      private var var_280:int = -1;
      
      private var var_449:String;
      
      private var _headline:String;
      
      private var var_268:int = 0;
      
      private var _startMessage:String = "";
      
      private var _endMessage:String = "";
      
      private var _questionArray:Array = null;
      
      private var var_4824:String = "";
      
      private var var_782:Boolean = false;
      
      public function RoomWidgetPollUpdateEvent(param1:int, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         var_280 = param1;
         super(param2,param3,param4);
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get summary() : String
      {
         return var_449;
      }
      
      public function set summary(param1:String) : void
      {
         var_449 = param1;
      }
      
      public function get headline() : String
      {
         return _headline;
      }
      
      public function set headline(param1:String) : void
      {
         _headline = param1;
      }
      
      public function get numQuestions() : int
      {
         return var_268;
      }
      
      public function set numQuestions(param1:int) : void
      {
         var_268 = param1;
      }
      
      public function get startMessage() : String
      {
         return _startMessage;
      }
      
      public function set startMessage(param1:String) : void
      {
         _startMessage = param1;
      }
      
      public function get endMessage() : String
      {
         return _endMessage;
      }
      
      public function set endMessage(param1:String) : void
      {
         _endMessage = param1;
      }
      
      public function get questionArray() : Array
      {
         return _questionArray;
      }
      
      public function set questionArray(param1:Array) : void
      {
         _questionArray = param1;
      }
      
      public function get pollType() : String
      {
         return var_4824;
      }
      
      public function set pollType(param1:String) : void
      {
         var_4824 = param1;
      }
      
      public function get npsPoll() : Boolean
      {
         return var_782;
      }
      
      public function set npsPoll(param1:Boolean) : void
      {
         var_782 = param1;
      }
   }
}
