package com.sulake.habbo.communication.messages.parser.inventory.avatareffect {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1256 implements IMessageParser {

        public function class_1256() {
            super();
        }
        private var var_329: int;
        private var var_622: int;
        private var var_377: int;
        private var var_927: Boolean;

        public function get type(): int {
            return var_329;
        }

        public function get subType(): int {
            return var_622;
        }

        public function get duration(): int {
            return var_377;
        }

        public function get isPermanent(): Boolean {
            return var_927;
        }

        public function flush(): Boolean {
            var_329 = 0;
            var_622 = 0;
            var_377 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_329 = param1.readInteger();
            var_622 = param1.readInteger();
            var_377 = param1.readInteger();
            var_927 = param1.readBoolean();
            return true;
        }
    }
}
