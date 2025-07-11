package com.sulake.habbo.communication.messages.incoming.room.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1683 {

        public function class_1683(param1: IMessageDataWrapper) {
            super();
            var_496 = param1.readInteger();
            _name = param1.readString();
            var_360 = param1.readInteger();
            var_426 = param1.readString();
            var_609 = param1.readString();
        }
        private var var_496: int;
        private var var_360: int;

        private var var_426: String;

        private var var_609: String;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get webId(): int {
            return var_496;
        }

        public function get level(): int {
            return var_360;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get owner(): String {
            return var_609;
        }

        public function dispose(): void {
            var_496 = 0;
            _name = "";
            var_360 = 0;
            var_426 = "";
            var_609 = "";
        }
    }
}
