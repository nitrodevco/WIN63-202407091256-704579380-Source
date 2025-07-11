package com.sulake.habbo.communication.messages.parser.poll {
    [SecureSWF(rename="true")]
    public class class_1664 {

        public static const const_329: int = 0;

        public static const const_403: int = 1;

        public static const const_343: int = 2;

        public static const const_319: int = 3;

        public function class_1664() {
            super();
            _children = new Vector.<class_1664>();
            var_631 = new Vector.<class_1687>();
        }
        private var var_516: int;
        private var var_945: int;
        private var var_1025: int;
        private var var_1233: int;
        private var var_1101: String;
        private var var_1276: int;
        private var var_763: int;
        private var var_631: Vector.<class_1687>;

        private var _children: Vector.<class_1664>;

        public function get children(): Vector.<class_1664> {
            return _children;
        }

        public function set children(param1: Vector.<class_1664>): void {
            _children = param1;
        }

        public function get questionId(): int {
            return var_516;
        }

        public function set questionId(param1: int): void {
            var_516 = param1;
        }

        public function get questionType(): int {
            return var_945;
        }

        public function set questionType(param1: int): void {
            var_945 = param1;
        }

        public function get sortOrder(): int {
            return var_1025;
        }

        public function set sortOrder(param1: int): void {
            var_1025 = param1;
        }

        public function get questionText(): String {
            return var_1101;
        }

        public function set questionText(param1: String): void {
            var_1101 = param1;
        }

        public function get questionCategory(): int {
            return var_1233;
        }

        public function set questionCategory(param1: int): void {
            var_1233 = param1;
        }

        public function get questionAnswerType(): int {
            return var_1276;
        }

        public function set questionAnswerType(param1: int): void {
            var_1276 = param1;
        }

        public function get questionAnswerCount(): int {
            return var_763;
        }

        public function set questionAnswerCount(param1: int): void {
            var_763 = param1;
        }

        public function get questionChoices(): Vector.<class_1687> {
            return var_631;
        }

        public function set questionChoices(param1: Vector.<class_1687>): void {
            var_631 = param1;
        }
    }
}
