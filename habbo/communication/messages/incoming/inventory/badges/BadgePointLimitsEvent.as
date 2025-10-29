package com.sulake.habbo.communication.messages.incoming.inventory.badges {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.badges.class_1224

    [SecureSWF(rename="true")]
    public class BadgePointLimitsEvent extends MessageEvent {

        public function BadgePointLimitsEvent(param1: Function) {
            super(param1, class_1224);
        }

        public function getParser(): class_1224 {
            return _parser as class_1224;
        }
    }
}
