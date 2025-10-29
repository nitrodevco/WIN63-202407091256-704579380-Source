package com.sulake.habbo.communication.messages.incoming.camera {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.camera.class_1151

    [SecureSWF(rename="true")]
    public class CameraPurchaseOKMessageEvent extends MessageEvent {

        public function CameraPurchaseOKMessageEvent(param1: Function) {
            super(param1, class_1151);
        }

        public function getParser(): class_1151 {
            return this._parser as class_1151;
        }
    }
}
