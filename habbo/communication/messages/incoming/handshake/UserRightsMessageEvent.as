package com.sulake.habbo.communication.messages.incoming.handshake {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.handshake.class_1435

    [SecureSWF(rename="true")]
    public class UserRightsMessageEvent extends MessageEvent implements IMessageEvent {

        public function UserRightsMessageEvent(param1: Function) {
            super(param1, class_1435);
        }

        public function get clubLevel(): int {
            return (this._parser as class_1435).clubLevel;
        }

        public function get securityLevel(): int {
            return (this._parser as class_1435).securityLevel;
        }

        public function get isAmbassador(): Boolean {
            return (this._parser as class_1435).isAmbassador;
        }
    }
}
