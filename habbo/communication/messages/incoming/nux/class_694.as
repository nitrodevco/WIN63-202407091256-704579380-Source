package com.sulake.habbo.communication.messages.incoming.nux {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.nux.class_1215

    [SecureSWF(rename="true")]
    public class class_694 extends MessageEvent implements IMessageEvent {

        public function class_694(param1: Function) {
            super(param1, class_1215);
        }

        public function getParser(): class_1215 {
            return _parser as class_1215;
        }
    }
}
