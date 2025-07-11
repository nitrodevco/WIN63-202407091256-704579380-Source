package com.sulake.habbo.communication.messages.parser.groupforums {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1666 {

        public static function readFromMessage(param1: IMessageDataWrapper): class_1666 {
            var _loc2_: class_1666 = new class_1666();
            _loc2_.messageId = param1.readInteger();
            _loc2_.messageIndex = param1.readInteger();
            _loc2_.authorId = param1.readInteger();
            _loc2_.authorName = param1.readString();
            _loc2_.authorFigure = param1.readString();
            _loc2_.creationTimeAsSecondsAgo = param1.readInteger();
            _loc2_.messageText = param1.readString();
            _loc2_.state = param1.readByte();
            _loc2_.adminId = param1.readInteger();
            _loc2_.adminName = param1.readString();
            _loc2_.adminOperationTimeAsSeccondsAgo = param1.readInteger();
            _loc2_.authorPostCount = param1.readInteger();
            return _loc2_;
        }

        public function class_1666() {
            super();
        }
        private var var_293: int;
        private var var_1338: int;
        private var var_1506: int;
        private var var_345: int;
        private var var_639: String;

        private var var_832: String;

        private var var_1293: String;

        private var var_149: int;

        private var var_902: int;

        private var var_850: String;

        private var var_1511: int;

        private var var_1065: int;

        private var _groupId: int;

        public function get groupId(): int {
            return _groupId;
        }

        private var _creationTime: int;

        public function get creationTime(): int {
            return _creationTime;
        }

        public function set creationTime(param1: int): void {
            _creationTime = param1;
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

        public function get adminOperationTimeAsSeccondsAgo(): int {
            return var_1511;
        }

        public function set adminOperationTimeAsSeccondsAgo(param1: int): void {
            var_1511 = param1;
        }

        public function get MessageId(): int {
            return var_293;
        }

        public function set MessageId(param1: int): void {
            var_293 = param1;
        }

        public function get authorName(): String {
            return var_832;
        }

        public function set authorName(param1: String): void {
            var_832 = param1;
        }

        public function get authorFigure(): String {
            return var_1293;
        }

        public function set authorFigure(param1: String): void {
            var_1293 = param1;
        }

        public function get threadId(): int {
            return var_345;
        }

        public function set threadId(param1: int): void {
            var_345 = param1;
        }

        public function get messageId(): int {
            return var_293;
        }

        public function set messageId(param1: int): void {
            var_293 = param1;
        }

        public function get messageIndex(): int {
            return var_1338;
        }

        public function set messageIndex(param1: int): void {
            var_1338 = param1;
        }

        public function set groupID(param1: int): void {
            _groupId = param1;
        }

        public function get authorId(): int {
            return var_1506;
        }

        public function set authorId(param1: int): void {
            var_1506 = param1;
        }

        public function get creationTimeAsSecondsAgo(): int {
            return _creationTime;
        }

        public function set creationTimeAsSecondsAgo(param1: int): void {
            _creationTime = param1;
        }

        public function get messageText(): String {
            return var_639;
        }

        public function set messageText(param1: String): void {
            var_639 = param1;
        }

        public function get authorPostCount(): int {
            return var_1065;
        }

        public function set authorPostCount(param1: int): void {
            var_1065 = param1;
        }
    }
}
