package com.sulake.habbo.communication.messages.incoming.inventory.trading {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1549

    [SecureSWF(rename="true")]
    public class class_262 extends MessageEvent {

        public function class_262(param1: Function, param2: Class) {
            super(param1, param2);
        }

        public function getParser(): class_1549 {
            return _parser as class_1549;
        }
    }
}
