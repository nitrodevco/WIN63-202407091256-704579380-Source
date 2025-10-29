package com.sulake.habbo.communication.messages.incoming.groupforums {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.groupforums.class_1189

    [SecureSWF(rename="true")]
    public class ForumDataMessageEvent extends MessageEvent implements IMessageEvent {

        public function ForumDataMessageEvent(param1: Function) {
            super(param1, class_1189);
        }

        public function getParser(): class_1189 {
            return this._parser as class_1189;
        }
    }
}
