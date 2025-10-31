package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class SpecialRoomEffectMessageEventParser implements IMessageParser {

        public function SpecialRoomEffectMessageEventParser() {
            super();
        }
        private var var_580: int = -1;

        public function get effectId(): int {
            return var_580;
        }

        public function flush(): Boolean {
            var_580 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_580 = param1.readInteger();
            return true;
        }
    }
}
