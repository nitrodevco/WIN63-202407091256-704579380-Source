package com.sulake.habbo.communication.messages.incoming.mysterybox {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.mysterybox.class_1408

    [SecureSWF(rename="true")]
    public class GotMysteryBoxPrizeMessageEvent extends MessageEvent implements IMessageEvent {

        public function GotMysteryBoxPrizeMessageEvent(param1: Function) {
            super(param1, class_1408);
        }

        public function getParser(): class_1408 {
            return _parser as class_1408;
        }
    }
}
