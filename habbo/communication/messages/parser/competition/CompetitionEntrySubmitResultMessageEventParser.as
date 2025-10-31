package com.sulake.habbo.communication.messages.parser.competition {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    import flash.utils.Dictionary

    [SecureSWF(rename="true")]
    public class CompetitionEntrySubmitResultMessageEventParser implements IMessageParser {

        public static const const_88: int = 0;

        public static const const_135: int = 1;

        public static const const_28: int = 2;

        public static const const_45: int = 3;

        public static const const_141: int = 4;

        public static const const_262: int = 5;

        public static const const_71: int = 6;

        public function CompetitionEntrySubmitResultMessageEventParser() {
            super();
        }
        private var var_427: int;
        private var var_891: String;
        private var var_152: int;
        private var var_267: Array;
        private var var_311: Dictionary;

        public function get goalId(): int {
            return var_427;
        }

        public function get goalCode(): String {
            return var_891;
        }

        public function get result(): int {
            return var_152;
        }

        public function get requiredFurnis(): Array {
            return var_267;
        }

        public function flush(): Boolean {
            var_267 = null;
            var_311 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var_427 = param1.readInteger();
            var_891 = param1.readString();
            var_152 = param1.readInteger();
            var_267 = [];
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_267.push(param1.readString());
                _loc2_++;
            }
            var_311 = new Dictionary();
            _loc3_ = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_311[param1.readString()] = "";
                _loc2_++;
            }
            return true;
        }

        public function isMissing(param1: String): Boolean {
            return var_311[param1] != null;
        }
    }
}
