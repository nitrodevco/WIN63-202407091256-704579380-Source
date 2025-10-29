package com.sulake.habbo.communication.messages.incoming.mysterybox {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.mysterybox.class_1362

    [SecureSWF(rename="true")]
    public class ShowMysteryBoxWaitMessageEvent extends MessageEvent implements IMessageEvent {

        public function ShowMysteryBoxWaitMessageEvent(param1: Function) {
            super(param1, class_1362);
        }

        public function getParser(): class_1362 {
            return _parser as class_1362;
        }
    }
}
