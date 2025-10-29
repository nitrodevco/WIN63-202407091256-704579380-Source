package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.catalog.class_1565

    [SecureSWF(rename="true")]
    public class BuildersClubSubscriptionStatusMessageEvent extends MessageEvent implements IMessageEvent {

        public function BuildersClubSubscriptionStatusMessageEvent(param1: Function) {
            super(param1, class_1565);
        }

        public function getParser(): class_1565 {
            return this._parser as class_1565;
        }
    }
}
