package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1322

    [SecureSWF(rename="true")]
    public class class_883 extends MessageEvent implements IMessageEvent {

        public function class_883(param1: Function) {
            super(param1, class_1322);
        }

        public function getParser(): class_1322 {
            return _parser as class_1322;
        }
    }
}
