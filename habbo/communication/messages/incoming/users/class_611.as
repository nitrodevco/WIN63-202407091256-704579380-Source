package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.core.utils.Map
    import com.sulake.habbo.communication.messages.parser.users.class_1495

    [SecureSWF(rename="true")]
    public class class_611 extends MessageEvent implements IMessageEvent {

        public function class_611(param1: Function) {
            super(param1, class_1495);
        }

        public function get badges(): Map {
            return (_parser as class_1495).badges;
        }
    }
}
