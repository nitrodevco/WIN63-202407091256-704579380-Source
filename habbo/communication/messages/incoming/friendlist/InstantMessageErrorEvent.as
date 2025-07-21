package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.friendlist.class_1375

    [SecureSWF(rename="true")]
    public class InstantMessageErrorEvent extends MessageEvent implements IMessageEvent {

        public function InstantMessageErrorEvent(param1: Function) {
            super(param1, class_1375);
        }

        public function getParser(): class_1375 {
            return this._parser as class_1375;
        }
    }
}
