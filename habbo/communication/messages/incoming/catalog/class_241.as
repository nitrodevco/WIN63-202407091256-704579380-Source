package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1220

    [SecureSWF(rename="true")]
    public class class_241 extends MessageEvent implements IMessageEvent {

        public function class_241(param1: Function) {
            super(param1, class_1220);
        }

        public function get productName(): String {
            return (_parser as class_1220).productName;
        }

        public function get productDescription(): String {
            return (_parser as class_1220).productDescription;
        }
    }
}
