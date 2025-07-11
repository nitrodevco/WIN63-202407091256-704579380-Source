package com.sulake.habbo.communication.messages.incoming.room.camera {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.camera.class_1476

    [SecureSWF(rename="true")]
    public class class_380 extends MessageEvent {

        public function class_380(param1: Function) {
            super(param1, class_1476);
        }

        public function getParser(): class_1476 {
            return _parser as class_1476;
        }
    }
}
