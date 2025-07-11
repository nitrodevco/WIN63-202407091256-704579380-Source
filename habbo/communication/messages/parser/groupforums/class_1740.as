package com.sulake.habbo.communication.messages.parser.groupforums {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1740 {

        public static function readFromMessage(param1: IMessageDataWrapper): class_1740 {
            var _loc2_: class_1740 = new class_1740();
            _loc2_.threadId = param1.readInteger();
            _loc2_.threadAuthorId = param1.readInteger();
            _loc2_.threadAuthorName = param1.readString();
            _loc2_.header = param1.readString();
            _loc2_.isSticky = param1.readBoolean();
            _loc2_.isLocked = param1.readBoolean();
            _loc2_.creationTimeAsSecondsAgo = param1.readInteger();
            _loc2_.nMessages = param1.readInteger();
            _loc2_.nUnreadMessages = param1.readInteger();
            _loc2_.lastMessageId = param1.readInteger();
            _loc2_.lastMessageAuthorId = param1.readInteger();
            _loc2_.lastMessageAuthorName = param1.readString();
            _loc2_.lastMessageTimeAsSecondsAgo = param1.readInteger();
            _loc2_.state = param1.readByte();
            _loc2_.adminId = param1.readInteger();
            _loc2_.adminName = param1.readString();
            _loc2_.adminOperationTimeAsSecondsAgo = param1.readInteger();
            return _loc2_;
        }

        public function class_1740() {
            super();
        }
        private var var_345: int;
        private var var_985: int;
        private var var_1044: String;
        private var var_1371: int;
        private var var_778: int;
        private var var_972: int;
        private var var_234: int;
        private var var_193: int;
        private var var_249: String;
        private var var_223: int;
        private var var_149: int;
        private var var_902: int;
        private var var_850: String;
        private var var_840: int;
        private var var_944: Boolean;
        private var var_1317: Boolean;

        private var _header: String;

        public function get header(): String {
            return _header;
        }

        public function set header(param1: String): void {
            _header = param1;
        }

        public function get adminOperationTimeAsSecondsAgo(): int {
            return var_840;
        }

        public function set adminOperationTimeAsSecondsAgo(param1: int): void {
            var_840 = param1;
        }

        public function get lastMessageTimeAsSecondsAgo(): int {
            return var_223;
        }

        public function set lastMessageTimeAsSecondsAgo(param1: int): void {
            var_223 = param1;
        }

        public function get threadId(): int {
            return var_345;
        }

        public function set threadId(param1: int): void {
            var_345 = param1;
        }

        public function get threadAuthorId(): int {
            return var_985;
        }

        public function set threadAuthorId(param1: int): void {
            var_985 = param1;
        }

        public function get threadAuthorName(): String {
            return var_1044;
        }

        public function set threadAuthorName(param1: String): void {
            var_1044 = param1;
        }

        public function get creationTimeAsSecondsAgo(): int {
            return var_1371;
        }

        public function set creationTimeAsSecondsAgo(param1: int): void {
            var_1371 = param1;
        }

        public function get lastMessageId(): int {
            return var_234;
        }

        public function set lastMessageId(param1: int): void {
            var_234 = param1;
        }

        public function get lastMessageAuthorId(): int {
            return var_193;
        }

        public function set lastMessageAuthorId(param1: int): void {
            var_193 = param1;
        }

        public function get lastMessageAuthorName(): String {
            return var_249;
        }

        public function set lastMessageAuthorName(param1: String): void {
            var_249 = param1;
        }

        public function get nMessages(): int {
            return var_778;
        }

        public function set nMessages(param1: int): void {
            var_778 = param1;
        }

        public function get nUnreadMessages(): int {
            return var_972;
        }

        public function set nUnreadMessages(param1: int): void {
            var_972 = param1;
        }

        public function get state(): int {
            return var_149;
        }

        public function set state(param1: int): void {
            var_149 = param1;
        }

        public function get adminId(): int {
            return var_902;
        }

        public function set adminId(param1: int): void {
            var_902 = param1;
        }

        public function get adminName(): String {
            return var_850;
        }

        public function set adminName(param1: String): void {
            var_850 = param1;
        }

        public function get isSticky(): Boolean {
            return var_944;
        }

        public function set isSticky(param1: Boolean): void {
            var_944 = param1;
        }

        public function get isLocked(): Boolean {
            return var_1317;
        }

        public function set isLocked(param1: Boolean): void {
            var_1317 = param1;
        }
    }
}
