package com.sulake.habbo.communication.messages.parser.sound {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.sound.class_1648

    [SecureSWF(rename="true")]
    public class class_1387 implements IMessageParser {

        public function class_1387() {
            super();
        }
        private var var_371: int;
        private var var_731: Array;

        public function get synchronizationCount(): int {
            return var_371;
        }

        public function get playList(): Array {
            return var_731;
        }

        public function flush(): Boolean {
            var_371 = -1;
            var_731 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc6_: int = 0;
            var _loc7_: int = 0;
            var _loc4_: int = 0;
            var _loc5_: String = null;
            var _loc2_: String = null;
            var_371 = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            _loc6_ = 0;
            while (_loc6_ < _loc3_) {
                _loc7_ = param1.readInteger();
                _loc4_ = param1.readInteger();
                _loc5_ = param1.readString();
                _loc2_ = param1.readString();
                var_731.push(new class_1648(_loc7_, _loc4_, _loc5_, _loc2_));
                _loc6_++;
            }
            return true;
        }
    }
}
