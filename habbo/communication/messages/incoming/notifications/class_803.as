package com.sulake.habbo.communication.messages.incoming.notifications {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.notifications.class_1559

    [SecureSWF(rename="true")]
    public class class_803 extends MessageEvent implements IMessageEvent {

        public function class_803(param1: Function) {
            super(param1, class_1559);
        }

        public function get enabled(): Boolean {
            return (_parser as class_1559).enabled;
        }
    }
}
