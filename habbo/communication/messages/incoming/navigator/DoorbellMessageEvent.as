package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1320

    [SecureSWF(rename="true")]
    public class DoorbellMessageEvent extends MessageEvent implements IMessageEvent {

        public function DoorbellMessageEvent(param1: Function) {
            super(param1, class_1320);
        }

        public function get userName(): String {
            return (this._parser as class_1320).userName;
        }
    }
}
