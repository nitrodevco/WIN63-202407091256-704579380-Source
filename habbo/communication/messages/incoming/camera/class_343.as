package com.sulake.habbo.communication.messages.incoming.camera {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.camera.class_1295

    [SecureSWF(rename="true")]
    public class class_343 extends MessageEvent {

        public function class_343(param1: Function) {
            super(param1, class_1295);
        }

        public function getParser(): class_1295 {
            return this._parser as class_1295;
        }
    }
}
