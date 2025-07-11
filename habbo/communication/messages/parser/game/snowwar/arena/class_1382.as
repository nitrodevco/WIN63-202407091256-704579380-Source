package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1382 implements IMessageParser {

        public function class_1382() {
            super();
        }
        private var var_418: int;
        private var var_576: String;

        public function get userId(): int {
            return var_418;
        }

        public function get chatMessage(): String {
            return var_576;
        }

        public function flush(): Boolean {
            var_418 = -1;
            var_576 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_418 = param1.readInteger();
            var_576 = param1.readString();
            return true;
        }
    }
}
