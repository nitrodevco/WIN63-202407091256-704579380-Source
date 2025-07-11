package com.sulake.habbo.communication.messages.incoming.quest {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.quest.class_1394

    [SecureSWF(rename="true")]
    public class class_946 extends MessageEvent implements IMessageEvent {

        public function class_946(param1: Function) {
            super(param1, class_1394);
        }

        public function getParser(): class_1394 {
            return _parser as class_1394;
        }
    }
}
