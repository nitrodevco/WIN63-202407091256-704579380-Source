package com.sulake.habbo.communication.messages.incoming.room.engine {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1304

    [SecureSWF(rename="true")]
    public class RoomVisualizationSettingsEvent extends MessageEvent {

        public function RoomVisualizationSettingsEvent(param1: Function) {
            super(param1, class_1304);
        }

        public function getParser(): class_1304 {
            return _parser as class_1304;
        }
    }
}
