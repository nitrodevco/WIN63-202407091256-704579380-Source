package com.sulake.habbo.communication.messages.parser.room.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1496 implements IMessageParser {

        public function class_1496() {
            super();
        }
        private var var_393: int;
        private var var_338: Array;
        private var var_269: Array;

        public function get petId(): int {
            return var_393;
        }

        public function get allCommands(): Array {
            return var_338;
        }

        public function get enabledCommands(): Array {
            return var_269;
        }

        public function flush(): Boolean {
            var_393 = -1;
            var_338 = null;
            var_269 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_393 = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            var_338 = [];
            while (_loc3_-- > 0) {
                var_338.push(param1.readInteger());
            }
            var _loc2_: int = param1.readInteger();
            var_269 = [];
            while (_loc2_-- > 0) {
                var_269.push(param1.readInteger());
            }
            return true;
        }
    }
}
