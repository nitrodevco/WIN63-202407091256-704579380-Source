package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class PresentOpenedMessageEventParser implements IMessageParser {

        public function PresentOpenedMessageEventParser() {
            super();
        }
        private var var_125: String;
        private var var_390: int;
        private var var_394: String;
        private var var_1155: int;
        private var var_1103: String;

        private var _placedInRoom: Boolean;

        public function get placedInRoom(): Boolean {
            return _placedInRoom;
        }

        private var _petFigureString: String;

        public function get petFigureString(): String {
            return _petFigureString;
        }

        public function get itemType(): String {
            return var_125;
        }

        public function get classId(): int {
            return var_390;
        }

        public function get productCode(): String {
            return var_394;
        }

        public function get placedItemId(): int {
            return var_1155;
        }

        public function get placedItemType(): String {
            return var_1103;
        }

        public function flush(): Boolean {
            var_125 = "";
            var_390 = 0;
            var_394 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_125 = param1.readString();
            var_390 = param1.readInteger();
            var_394 = param1.readString();
            var_1155 = param1.readInteger();
            var_1103 = param1.readString();
            _placedInRoom = param1.readBoolean();
            _petFigureString = param1.readString();
            return true;
        }
    }
}
