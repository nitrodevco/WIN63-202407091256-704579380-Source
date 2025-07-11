package com.sulake.habbo.communication.messages.incoming.inventory.badges {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.badges.class_1555

    [SecureSWF(rename="true")]
    public class class_683 extends MessageEvent {

        public function class_683(param1: Function) {
            super(param1, class_1555);
        }

        public function getParser(): class_1555 {
            return _parser as class_1555;
        }
    }
}
