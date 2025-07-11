package com.sulake.habbo.communication.messages.incoming.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1665 {

        public function class_1665(param1: IMessageDataWrapper, param2: int = 0, param3: int = 0) {
            super();
            var_427 = param2;
            var_479 = param3;
            if (param1 != null) {
                var_427 = param1.readInteger();
                var_479 = param1.readInteger();
                var_967 = param1.readInteger();
            }
        }
        private var var_427: int;
        private var var_479: int;
        private var var_967: int;

        public function get goalId(): int {
            return var_427;
        }

        public function get pageIndex(): int {
            return var_479;
        }

        public function get pageCount(): int {
            return var_967;
        }
    }
}
