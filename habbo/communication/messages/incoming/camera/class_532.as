package com.sulake.habbo.communication.messages.incoming.camera {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.camera.class_1356

    [SecureSWF(rename="true")]
    public class class_532 extends MessageEvent {

        public function class_532(param1: Function) {
            super(param1, class_1356);
        }

        public function getParser(): class_1356 {
            return this._parser as class_1356;
        }
    }
}
