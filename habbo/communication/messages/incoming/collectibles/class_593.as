package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1617

    [SecureSWF(rename="true")]
    public class class_593 extends MessageEvent implements IMessageEvent {

        public function class_593(param1: Function) {
            super(param1, class_1617);
        }

        public function getParser(): class_1617 {
            return _parser as class_1617;
        }
    }
}
