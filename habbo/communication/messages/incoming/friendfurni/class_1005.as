package com.sulake.habbo.communication.messages.incoming.friendfurni {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.friendfurni.class_1299

    [SecureSWF(rename="true")]
    public class class_1005 extends MessageEvent implements IMessageEvent {

        public function class_1005(param1: Function) {
            super(param1, class_1299);
        }

        public function getParser(): class_1299 {
            return _parser as class_1299;
        }
    }
}
