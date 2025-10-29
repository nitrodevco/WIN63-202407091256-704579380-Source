package com.sulake.habbo.communication.messages.incoming.room.furniture {
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.room.furniture.class_1314

    [SecureSWF(rename="true")]
    public class YoutubeDisplayVideoMessageEvent extends MessageEvent {

        public function YoutubeDisplayVideoMessageEvent(param1: Function) {
            super(param1, class_1314);
        }

        public function getParser(): class_1314 {
            return parser as class_1314;
        }
    }
}
