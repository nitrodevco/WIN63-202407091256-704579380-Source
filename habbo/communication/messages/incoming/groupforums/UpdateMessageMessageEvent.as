package com.sulake.habbo.communication.messages.incoming.groupforums {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.groupforums.class_1627

    [SecureSWF(rename="true")]
    public class UpdateMessageMessageEvent extends MessageEvent implements IMessageEvent {

        public function UpdateMessageMessageEvent(param1: Function) {
            super(param1, class_1627);
        }

        public function getParser(): class_1627 {
            return this._parser as class_1627;
        }
    }
}
