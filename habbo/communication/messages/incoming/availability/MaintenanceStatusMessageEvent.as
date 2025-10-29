package com.sulake.habbo.communication.messages.incoming.availability {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.availability.class_1211

    [SecureSWF(rename="true")]
    public class MaintenanceStatusMessageEvent extends MessageEvent implements IMessageEvent {

        public function MaintenanceStatusMessageEvent(param1: Function) {
            super(param1, class_1211);
        }

        public function getParser(): class_1211 {
            return _parser as class_1211;
        }
    }
}
