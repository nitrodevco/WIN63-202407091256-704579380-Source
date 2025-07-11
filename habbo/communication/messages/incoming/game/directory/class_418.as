package com.sulake.habbo.communication.messages.incoming.game.directory {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.directory.class_1527

    [SecureSWF(rename="true")]
    public class class_418 extends MessageEvent implements IMessageEvent {

        public function class_418(param1: Function) {
            super(param1, class_1527);
        }

        public function getParser(): class_1527 {
            return this._parser as class_1527;
        }
    }
}
