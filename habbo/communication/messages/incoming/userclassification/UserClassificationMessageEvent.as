package com.sulake.habbo.communication.messages.incoming.userclassification {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.userclassification.class_1201

    [SecureSWF(rename="true")]
    public class UserClassificationMessageEvent extends MessageEvent {

        public function UserClassificationMessageEvent(param1: Function) {
            super(param1, class_1201);
        }

        public function getParser(): class_1201 {
            return _parser as class_1201;
        }
    }
}
