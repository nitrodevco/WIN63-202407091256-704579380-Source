package com.sulake.habbo.communication.messages.incoming.camera {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.camera.class_1427

    [SecureSWF(rename="true")]
    public class ThumbnailStatusMessageEvent extends MessageEvent {

        public function ThumbnailStatusMessageEvent(param1: Function) {
            super(param1, class_1427);
        }

        public function getParser(): class_1427 {
            return this._parser as class_1427;
        }
    }
}
