package com.sulake.habbo.communication.messages.incoming.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1684 {

        public function class_1684(param1: IMessageDataWrapper = null) {
            super();
            var_280 = param1.readInteger();
            _fileName = param1.readString();
            _maskFileName = param1.readString();
        }
        private var var_280: int;

        private var _fileName: String;

        public function get fileName(): String {
            return _fileName;
        }

        private var _maskFileName: String;

        public function get maskFileName(): String {
            return _maskFileName;
        }

        public function get id(): int {
            return var_280;
        }
    }
}
