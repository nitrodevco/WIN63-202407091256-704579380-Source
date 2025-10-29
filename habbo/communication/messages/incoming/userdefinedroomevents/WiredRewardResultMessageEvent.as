package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_1403

    [SecureSWF(rename="true")]
    public class WiredRewardResultMessageEvent extends MessageEvent implements IMessageEvent {

        public static const const_374: int = 6;

        public static const const_363: int = 7;

        public function WiredRewardResultMessageEvent(param1: Function) {
            super(param1, class_1403);
        }

        public function getParser(): class_1403 {
            return this._parser as class_1403;
        }
    }
}
