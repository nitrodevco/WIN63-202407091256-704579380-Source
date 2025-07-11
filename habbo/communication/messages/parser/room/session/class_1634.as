package com.sulake.habbo.communication.messages.parser.room.session {
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class class_1634 {

        public function class_1634(param1: String, param2: int) {
            super();
            _name = param1;
            var_294 = param2;
            var_472 = new Map();
        }
        private var var_294: int;

        private var var_472: Map;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get target(): int {
            return var_294;
        }

        public function get queueTypes(): Array {
            return var_472.getKeys();
        }

        public function getQueueSize(param1: String): int {
            return var_472.getValue(param1);
        }

        public function addQueue(param1: String, param2: int): void {
            var_472.add(param1, param2);
        }
    }
}
