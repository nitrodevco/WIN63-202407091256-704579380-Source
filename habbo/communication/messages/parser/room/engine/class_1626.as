package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1626 implements IMessageParser {

        public function class_1626() {
            super();
        }
        private var var_871: int;
        private var var_903: int;

        private var _status: int;

        public function get status(): int {
            return _status;
        }

        private var _habboGroupName: String;

        public function get habboGroupName(): String {
            return _habboGroupName;
        }

        public function get roomIndex(): int {
            return var_871;
        }

        public function get habboGroupId(): int {
            return var_903;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_871 = param1.readInteger();
            var_903 = param1.readInteger();
            _status = param1.readInteger();
            _habboGroupName = param1.readString();
            return true;
        }
    }
}
