package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.events.RoomSessionWordQuizEvent;
   import com.sulake.habbo.communication.messages.parser.poll.class_1276;
   import com.sulake.habbo.communication.messages.parser.poll.class_1364;
   import com.sulake.habbo.communication.messages.parser.poll.class_1534;
   import com.sulake.habbo.communication.messages.incoming.poll.class_277;
   import com.sulake.habbo.communication.messages.incoming.poll.class_507;
   import com.sulake.habbo.communication.messages.incoming.poll.class_719;
   
   public class WordQuizHandler extends BaseHandler
   {
       
      
      public function WordQuizHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(!param1)
         {
            return;
         }
         param1.addMessageEvent(new class_277(onQuestionStatus));
         param1.addMessageEvent(new class_719(onQuestionAnsweredEvent));
         param1.addMessageEvent(new class_507(onQuestionFinishedEvent));
      }
      
      private function onQuestionStatus(param1:class_277) : void
      {
         var _loc4_:RoomSessionWordQuizEvent = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_1662);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_1534 = param1.getParser();
         (_loc4_ = new RoomSessionWordQuizEvent("RWPUW_NEW_QUESTION",_loc3_,_loc2_.pollId)).question = _loc2_.question;
         _loc4_.duration = _loc2_.duration;
         _loc4_.pollType = _loc2_.pollType;
         _loc4_.questionId = _loc2_.questionId;
         _loc4_.pollId = _loc2_.pollId;
         listener.events.dispatchEvent(_loc4_);
      }
      
      private function onQuestionAnsweredEvent(param1:class_719) : void
      {
         var _loc4_:RoomSessionWordQuizEvent = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_1662);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_1364 = param1.getParser();
         (_loc4_ = new RoomSessionWordQuizEvent("RWPUW_QUESTION_ANSWERED",_loc3_,_loc2_.userId)).value = _loc2_.value;
         _loc4_.userId = _loc2_.userId;
         _loc4_.answerCounts = _loc2_.answerCounts;
         listener.events.dispatchEvent(_loc4_);
      }
      
      private function onQuestionFinishedEvent(param1:class_507) : void
      {
         var _loc4_:RoomSessionWordQuizEvent = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_1662);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_1276 = param1.getParser();
         (_loc4_ = new RoomSessionWordQuizEvent("RWPUW_QUESION_FINSIHED",_loc3_)).questionId = _loc2_.questionId;
         _loc4_.answerCounts = _loc2_.answerCounts;
         listener.events.dispatchEvent(_loc4_);
      }
   }
}
