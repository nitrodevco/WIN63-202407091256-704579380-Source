package com.sulake.habbo.communication.messages.incoming.notifications {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.notifications.class_1335

    import flash.utils.Dictionary

    [SecureSWF(rename="true")]
    public class class_289 extends MessageEvent implements IMessageEvent {

        public function class_289(param1: Function) {
            super(param1, class_1335);
        }

        public function get points(): Dictionary {
            return (_parser as class_1335).points;
        }
    }
}
