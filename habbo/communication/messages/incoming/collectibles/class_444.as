package com.sulake.habbo.communication.messages.incoming.collectibles {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.collectibles.class_1418

    [SecureSWF(rename="true")]
    public class class_444 extends MessageEvent implements IMessageEvent {

        public function class_444(param1: Function) {
            super(param1, class_1418);
        }

        public function getParser(): class_1418 {
            return _parser as class_1418;
        }
    }
}
