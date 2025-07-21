package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.friendlist.class_1500

    [SecureSWF(rename="true")]
    public class NewConsoleMessageEvent extends MessageEvent implements IMessageEvent {

        public function NewConsoleMessageEvent(param1: Function) {
            super(param1, class_1500);
        }

        public function getParser(): class_1500 {
            return this._parser as class_1500;
        }
    }
}
