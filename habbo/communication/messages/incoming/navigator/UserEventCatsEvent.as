package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.navigator.class_1129

    [SecureSWF(rename="true")]
    public class UserEventCatsEvent extends MessageEvent implements IMessageEvent {

        public function UserEventCatsEvent(param1: Function) {
            super(param1, class_1129);
        }

        public function getParser(): class_1129 {
            return this._parser as class_1129;
        }
    }
}
