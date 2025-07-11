package com.sulake.habbo.communication.messages.incoming.friendfurni {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.friendfurni.class_1260

    [SecureSWF(rename="true")]
    public class class_541 extends MessageEvent implements IMessageEvent {

        public function class_541(param1: Function) {
            super(param1, class_1260);
        }

        public function getParser(): class_1260 {
            return _parser as class_1260;
        }
    }
}
