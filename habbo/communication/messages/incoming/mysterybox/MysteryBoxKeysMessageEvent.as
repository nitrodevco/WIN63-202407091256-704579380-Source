package com.sulake.habbo.communication.messages.incoming.mysterybox {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.mysterybox.class_1470

    [SecureSWF(rename="true")]
    public class MysteryBoxKeysMessageEvent extends MessageEvent implements IMessageEvent {

        public function MysteryBoxKeysMessageEvent(param1: Function) {
            super(param1, class_1470);
        }

        public function getParser(): class_1470 {
            return _parser as class_1470;
        }
    }
}
