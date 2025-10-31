package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.core.utils.Map
    import com.sulake.habbo.communication.messages.parser.users.RelationshipStatusInfoEventParser

    [SecureSWF(rename="true")]
    public class RelationshipStatusInfoEvent extends MessageEvent implements IMessageEvent {

        public function RelationshipStatusInfoEvent(param1: Function) {
            super(param1, RelationshipStatusInfoEventParser);
        }

        public function get userId(): int {
            return (_parser as RelationshipStatusInfoEventParser).userId;
        }

        public function get relationshipStatusMap(): Map {
            return (_parser as RelationshipStatusInfoEventParser).relationshipStatusMap;
        }
    }
}
