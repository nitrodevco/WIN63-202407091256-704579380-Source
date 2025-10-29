package com.sulake.habbo.communication.messages.incoming.groupforums {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.groupforums.class_1436

    [SecureSWF(rename="true")]
    public class ForumThreadsMessageEvent extends MessageEvent implements IMessageEvent {

        public function ForumThreadsMessageEvent(param1: Function) {
            super(param1, class_1436);
        }

        public function getParser(): class_1436 {
            return this._parser as class_1436;
        }
    }
}
