package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1586

    [SecureSWF(rename="true")]
    public class ClubGiftInfoEvent extends MessageEvent implements IMessageEvent {

        public function ClubGiftInfoEvent(param1: Function) {
            super(param1, class_1586);
        }

        public function getParser(): class_1586 {
            return this._parser as class_1586;
        }
    }
}
