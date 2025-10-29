package com.sulake.habbo.communication.messages.incoming.groupforums {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.groupforums.class_1511

    [SecureSWF(rename="true")]
    public class ThreadMessagesMessageEvent extends MessageEvent implements IMessageEvent {

        public function ThreadMessagesMessageEvent(param1: Function) {
            super(param1, class_1511);
        }

        public function getParser(): class_1511 {
            return this._parser as class_1511;
        }
    }
}
