package com.sulake.habbo.communication.messages.parser.room.session {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class RoomQueueStatusMessageEventParser implements IMessageParser {

        public function RoomQueueStatusMessageEventParser() {
            var_238 = new Map();
            super();
        }
        private var var_238: Map;

        private var var_936: int = 0;

        private var _flatId: int = 0;

        public function get flatId(): int {
            return _flatId;
        }

        public function get activeTarget(): int {
            return var_936;
        }

        public function flush(): Boolean {
            var_238.reset();
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc6_: class_1634 = null;
            var _loc7_: int = 0;
            var _loc2_: String = null;
            var _loc5_: int = 0;
            var _loc8_: int = 0;
            var_238.reset();
            _flatId = param1.readInteger();
            var _loc4_: int = param1.readInteger();
            _loc7_ = 0;
            while (_loc7_ < _loc4_) {
                _loc2_ = param1.readString();
                _loc5_ = param1.readInteger();
                if (_loc7_ == 0) {
                    var_936 = _loc5_;
                }
                _loc6_ = new class_1634(_loc2_, _loc5_);
                _loc3_ = param1.readInteger();
                _loc8_ = 0;
                while (_loc8_ < _loc3_) {
                    _loc6_.addQueue(param1.readString(), param1.readInteger());
                    _loc8_++;
                }
                var_238.add(_loc6_.target, _loc6_);
                _loc7_++;
            }
            return true;
        }

        public function getQueueSetTargets(): Array {
            return var_238.getKeys();
        }

        public function getQueueSet(param1: int): class_1634 {
            return var_238.getValue(param1) as class_1634;
        }
    }
}
