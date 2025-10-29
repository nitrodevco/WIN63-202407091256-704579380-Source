package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1391

    [SecureSWF(rename="true")]
    public class BuildersClubPlacementWarningMessageEvent extends MessageEvent {

        public function BuildersClubPlacementWarningMessageEvent(param1: Function) {
            super(param1, class_1391);
        }

        public function getParser(): class_1391 {
            return _parser as class_1391;
        }
    }
}
