package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.quest.class_1167

    [SecureSWF(rename="true")]
    public class class_548 extends MessageEvent implements IMessageEvent {

        public function class_548(param1: Function) {
            super(param1, class_1167);
        }

        public function getParser(): class_1167 {
            return _parser as class_1167;
        }
    }
}
