package com.sulake.habbo.session.events
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.session.IRoomSession;
   import flash.utils.Dictionary;
   
   public class RoomSessionWordQuizEvent extends RoomSessionEvent
   {
      
      public static const const_470:String = "RWPUW_NEW_QUESTION";
      
      public static const FINISHED:String = "RWPUW_QUESION_FINSIHED";
      
      public static const const_468:String = "RWPUW_QUESTION_ANSWERED";
       
      
      private var var_280:int = -1;
      
      private var var_490:String = null;
      
      private var var_607:int = -1;
      
      private var var_516:int = -1;
      
      private var var_377:int = -1;
      
      private var var_53:Dictionary = null;
      
      private var var_418:int = -1;
      
      private var _value:String;
      
      private var var_308:Map;
      
      public function RoomSessionWordQuizEvent(param1:String, param2:IRoomSession, param3:int = -1)
      {
         var_280 = param3;
         super(param1,param2);
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get pollType() : String
      {
         return var_490;
      }
      
      public function set pollType(param1:String) : void
      {
         var_490 = param1;
      }
      
      public function get pollId() : int
      {
         return var_607;
      }
      
      public function set pollId(param1:int) : void
      {
         var_607 = param1;
      }
      
      public function get questionId() : int
      {
         return var_516;
      }
      
      public function set questionId(param1:int) : void
      {
         var_516 = param1;
      }
      
      public function get duration() : int
      {
         return var_377;
      }
      
      public function set duration(param1:int) : void
      {
         var_377 = param1;
      }
      
      public function get question() : Dictionary
      {
         return var_53;
      }
      
      public function set question(param1:Dictionary) : void
      {
         var_53 = param1;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function set userId(param1:int) : void
      {
         var_418 = param1;
      }
      
      public function get value() : String
      {
         return _value;
      }
      
      public function set value(param1:String) : void
      {
         _value = param1;
      }
      
      public function get answerCounts() : Map
      {
         return var_308;
      }
      
      public function set answerCounts(param1:Map) : void
      {
         var_308 = param1;
      }
   }
}
