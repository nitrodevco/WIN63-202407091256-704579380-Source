package com.sulake.habbo.communication.messages.incoming.inventory.trading {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1547

    [SecureSWF(rename="true")]
    public class class_144 extends MessageEvent {

        public function class_144(param1: Function, param2: Class) {
            super(param1, param2);
        }

        public function getParser(): class_1547 {
            return _parser as class_1547;
        }
    }
}
