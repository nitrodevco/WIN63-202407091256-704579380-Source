package com.sulake.habbo.communication.messages.parser.game.lobby {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_1723

    [SecureSWF(rename="true")]
    public class class_1506 implements IMessageParser {

        public function class_1506() {
            super();
        }
        private var var_275: Vector.<class_1723>;

        private var _stuffId: int;

        public function get stuffId(): int {
            return _stuffId;
        }

        private var _endTime: int;

        public function get endTime(): int {
            return _endTime;
        }

        public function get achievements(): Vector.<class_1723> {
            return var_275;
        }

        public function flush(): Boolean {
            _stuffId = -1;
            for each(var _loc1_ in var_275) {
                _loc1_.dispose();
            }
            var_275 = new Vector.<class_1723>(0);
            _endTime = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            _stuffId = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_275.push(new class_1723(param1));
                _loc2_++;
            }
            _endTime = param1.readInteger();
            return true;
        }
    }
}
