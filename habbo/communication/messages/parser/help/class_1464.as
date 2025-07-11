package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1464 implements IMessageParser {

        public function class_1464() {
            super();
        }
        private var var_1121: int;
        private var var_1169: String;

        private var var_830: int;
        private var var_1030: String;

        private var _requesterName: String;

        public function get requesterName(): String {
            return _requesterName;
        }

        private var _guideName: String;

        public function get guideName(): String {
            return _guideName;
        }

        public function get requesterUserId(): int {
            return var_1121;
        }

        public function get requesterFigure(): String {
            return var_1169;
        }

        public function get guideUserId(): int {
            return var_830;
        }

        public function get guideFigure(): String {
            return var_1030;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1121 = param1.readInteger();
            _requesterName = param1.readString();
            var_1169 = param1.readString();
            var_830 = param1.readInteger();
            _guideName = param1.readString();
            var_1030 = param1.readString();
            return true;
        }
    }
}
