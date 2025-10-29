package com.sulake.habbo.communication.messages.incoming.camera {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.camera.class_1488

    [SecureSWF(rename="true")]
    public class CameraPublishStatusMessageEvent extends MessageEvent {

        public function CameraPublishStatusMessageEvent(param1: Function) {
            super(param1, class_1488);
        }

        public function getParser(): class_1488 {
            return this._parser as class_1488;
        }
    }
}
