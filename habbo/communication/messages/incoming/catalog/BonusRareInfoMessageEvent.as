package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1416

    [SecureSWF(rename="true")]
    public class BonusRareInfoMessageEvent extends MessageEvent implements IMessageEvent {

        public function BonusRareInfoMessageEvent(param1: Function) {
            super(param1, class_1416);
        }

        public function getParser(): class_1416 {
            return this._parser as class_1416;
        }
    }
}
