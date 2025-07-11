package com.sulake.habbo.communication.messages.incoming.help {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.help.class_1348

    [SecureSWF(rename="true")]
    public class class_302 extends MessageEvent implements IMessageEvent {

        public function class_302(param1: Function) {
            super(param1, class_1348);
        }

        public function getParser(): class_1348 {
            return _parser as class_1348;
        }
    }
}
