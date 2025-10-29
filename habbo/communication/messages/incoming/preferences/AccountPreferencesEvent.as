package com.sulake.habbo.communication.messages.incoming.preferences {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.preferences.class_1413

    [SecureSWF(rename="true")]
    public class AccountPreferencesEvent extends MessageEvent implements IMessageEvent {

        public function AccountPreferencesEvent(param1: Function) {
            super(param1, class_1413);
        }

        public function getParser(): class_1413 {
            return this._parser as class_1413;
        }
    }
}
