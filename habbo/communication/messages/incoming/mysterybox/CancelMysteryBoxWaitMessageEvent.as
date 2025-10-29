package com.sulake.habbo.communication.messages.incoming.mysterybox {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.mysterybox.class_1283

    [SecureSWF(rename="true")]
    public class CancelMysteryBoxWaitMessageEvent extends MessageEvent implements IMessageEvent {

        public function CancelMysteryBoxWaitMessageEvent(param1: Function) {
            super(param1, class_1283);
        }

        public function getParser(): class_1283 {
            return _parser as class_1283;
        }
    }
}
