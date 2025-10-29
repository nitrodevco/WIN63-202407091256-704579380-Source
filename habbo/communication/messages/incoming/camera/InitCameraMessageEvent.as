package com.sulake.habbo.communication.messages.incoming.camera {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.camera.class_1282

    [SecureSWF(rename="true")]
    public class InitCameraMessageEvent extends MessageEvent {

        public function InitCameraMessageEvent(param1: Function) {
            super(param1, class_1282);
        }

        public function getParser(): class_1282 {
            return this._parser as class_1282;
        }
    }
}
