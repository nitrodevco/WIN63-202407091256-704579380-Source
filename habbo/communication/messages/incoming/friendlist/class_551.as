package com.sulake.habbo.communication.messages.incoming.friendlist {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.friendlist.class_1378

    [SecureSWF(rename="true")]
    public class class_551 extends MessageEvent implements IMessageEvent {

        public function class_551(param1: Function) {
            super(param1, class_1378);
        }

        public function getParser(): class_1378 {
            return this._parser as class_1378;
        }
    }
}
