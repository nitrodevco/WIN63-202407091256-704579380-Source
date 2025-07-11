package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.quest.class_1147

    [SecureSWF(rename="true")]
    public class class_836 extends MessageEvent implements IMessageEvent {

        public function class_836(param1: Function) {
            super(param1, class_1147);
        }

        public function getParser(): class_1147 {
            return _parser as class_1147;
        }
    }
}
