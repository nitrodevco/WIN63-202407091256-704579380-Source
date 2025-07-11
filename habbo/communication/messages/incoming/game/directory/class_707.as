package com.sulake.habbo.communication.messages.incoming.game.directory {
    import com.sulake.core.communication.messages.IMessageEvent
    import com.sulake.core.communication.messages.MessageEvent
    import com.sulake.habbo.communication.messages.parser.game.directory.class_1269

    [SecureSWF(rename="true")]
    public class class_707 extends MessageEvent implements IMessageEvent {

        public function class_707(param1: Function) {
            super(param1, class_1269);
        }

        public function getParser(): class_1269 {
            return this._parser as class_1269;
        }
    }
}
