package com.sulake.habbo.communication.messages.incoming.inventory.badges {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.inventory.badges.class_1181

    [SecureSWF(rename="true")]
    public class BadgesEvent extends MessageEvent {

        public function BadgesEvent(param1: Function) {
            super(param1, class_1181);
        }

        public function getParser(): class_1181 {
            return _parser as class_1181;
        }
    }
}
