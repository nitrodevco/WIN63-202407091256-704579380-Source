package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.core.utils.Map
    import com.sulake.habbo.communication.messages.parser.users.class_1243

    [SecureSWF(rename="true")]
    public class RelationshipStatusInfoEvent extends MessageEvent implements IMessageEvent {

        public function RelationshipStatusInfoEvent(param1: Function) {
            super(param1, class_1243);
        }

        public function get userId(): int {
            return (_parser as class_1243).userId;
        }

        public function get relationshipStatusMap(): Map {
            return (_parser as class_1243).relationshipStatusMap;
        }
    }
}
