package com.sulake.habbo.communication.messages.parser.groupforums {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1754 {

        public static function readFromMessage(param1: IMessageDataWrapper): class_1754 {
            return fillFromMessage(new class_1754(), param1);
        }

        internal static function fillFromMessage(param1: class_1754, param2: IMessageDataWrapper): class_1754 {
            param1._groupId = param2.readInteger();
            param1._name = param2.readString();
            param1.var_363 = param2.readString();
            param1._icon = param2.readString();
            param1.var_150 = param2.readInteger();
            param1.var_1545 = param2.readInteger();
            param1.var_105 = param2.readInteger();
            param1.var_73 = param2.readInteger();
            param1.var_234 = param2.readInteger();
            param1.var_193 = param2.readInteger();
            param1.var_249 = param2.readString();
            param1.var_223 = param2.readInteger();
            return param1;
        }

        public function class_1754() {
            super();
        }
        private var var_363: String;
        private var var_150: int;

        private var var_1545: int;

        private var var_105: int;

        private var var_73: int;

        private var var_234: int;

        private var var_193: int;

        private var var_249: String;

        private var var_223: int;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        private var _icon: String;

        public function get icon(): String {
            return _icon;
        }

        public function get description(): String {
            return var_363;
        }

        public function get totalThreads(): int {
            return var_150;
        }

        public function get leaderboardScore(): int {
            return var_1545;
        }

        public function get totalMessages(): int {
            return var_105;
        }

        public function get unreadMessages(): int {
            return var_73;
        }

        public function get lastMessageId(): int {
            return var_234;
        }

        public function get lastMessageAuthorId(): int {
            return var_193;
        }

        public function get lastMessageAuthorName(): String {
            return var_249;
        }

        public function get lastMessageTimeAsSecondsAgo(): int {
            return var_223;
        }

        public function get lastReadMessageId(): int {
            return var_105 - var_73;
        }

        public function set lastReadMessageId(param1: int): void {
            var_73 = var_105 - param1;
            if (var_73 < 0) {
                var_73 = 0;
            }
        }

        public function updateFrom(param1: class_1754): void {
            var_150 = param1.var_150;
            var_105 = param1.var_105;
            var_73 = param1.var_73;
            var_193 = param1.var_193;
            var_249 = param1.var_249;
            var_234 = param1.var_234;
            var_223 = param1.var_223;
        }

        public function addNewThread(param1: class_1740): void {
            var_193 = param1.lastMessageAuthorId;
            var_249 = param1.lastMessageAuthorName;
            var_234 = param1.lastMessageId;
            var_223 = param1.lastMessageTimeAsSecondsAgo;
            var_150++;
            var_105++;
            var_73 = 0;
        }
    }
}
