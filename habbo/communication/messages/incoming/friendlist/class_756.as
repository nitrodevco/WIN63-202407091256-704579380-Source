package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.friendlist.class_1567

    [SecureSWF(rename="true")]
    public class class_756 extends MessageEvent implements IMessageEvent {

        public function class_756(param1: Function) {
            super(param1, class_1567);
        }

        public function getParser(): class_1567 {
            return _parser as class_1567;
        }
    }
}
