package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1312

    [SecureSWF(rename="true")]
    public class class_509 extends MessageEvent implements IMessageEvent {

        public function class_509(param1: Function) {
            super(param1, class_1312);
        }

        public function getParser(): class_1312 {
            return _parser as class_1312;
        }
    }
}
