package com.sulake.habbo.communication.messages.incoming.callforhelp {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.callforhelp.class_1607

    [SecureSWF(rename="true")]
    public class class_642 extends MessageEvent implements IMessageEvent {

        public function class_642(param1: Function) {
            super(param1, class_1607);
        }

        public function getParser(): class_1607 {
            return _parser as class_1607;
        }
    }
}
