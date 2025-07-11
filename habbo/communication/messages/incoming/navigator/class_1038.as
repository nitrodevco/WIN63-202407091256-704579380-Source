package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1539

    [SecureSWF(rename="true")]
    public class class_1038 extends MessageEvent implements IMessageEvent {

        public function class_1038(param1: Function) {
            super(param1, class_1539);
        }

        public function getParser(): class_1539 {
            return _parser as class_1539;
        }
    }
}
