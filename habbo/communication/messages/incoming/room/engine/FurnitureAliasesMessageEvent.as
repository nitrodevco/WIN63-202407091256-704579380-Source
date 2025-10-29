package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1548

    [SecureSWF(rename="true")]
    public class FurnitureAliasesMessageEvent extends MessageEvent {

        public function FurnitureAliasesMessageEvent(param1: Function) {
            super(param1, class_1548);
        }

        public function getParser(): class_1548 {
            return _parser as class_1548;
        }
    }
}
