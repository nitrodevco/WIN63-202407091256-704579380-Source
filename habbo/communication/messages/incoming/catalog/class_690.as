package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1308

    [SecureSWF(rename="true")]
    public class class_690 extends MessageEvent implements IMessageEvent {

        public function class_690(param1: Function) {
            super(param1, class_1308);
        }

        public function get errorCode(): String {
            return (_parser as class_1308).errorCode;
        }
    }
}
