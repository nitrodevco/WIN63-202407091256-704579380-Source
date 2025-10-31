package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class UserNameChangedMessageEventParser implements IMessageParser {

        public function UserNameChangedMessageEventParser() {
            super();
        }
        private var var_496: int;
        private var var_280: int;

        private var _newName: String;

        public function get newName(): String {
            return _newName;
        }

        public function get webId(): int {
            return var_496;
        }

        public function get id(): int {
            return var_280;
        }

        public function flush(): Boolean {
            var_496 = -1;
            var_280 = -1;
            _newName = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_496 = param1.readInteger();
            var_280 = param1.readInteger();
            _newName = param1.readString();
            return true;
        }
    }
}
