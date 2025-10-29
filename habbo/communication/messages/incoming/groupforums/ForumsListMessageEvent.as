package com.sulake.habbo.communication.messages.incoming.groupforums {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.groupforums.class_1563

    [SecureSWF(rename="true")]
    public class ForumsListMessageEvent extends MessageEvent implements IMessageEvent {

        public function ForumsListMessageEvent(param1: Function) {
            super(param1, class_1563);
        }

        public function getParser(): class_1563 {
            return class_1563(this._parser);
        }
    }
}
