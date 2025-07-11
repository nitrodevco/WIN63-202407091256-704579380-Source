package com.sulake.habbo.room.object.data {
    public class HighScoreData {

        public function HighScoreData() {
            _users = [];
            super();
            var_367 = -1;
        }
        private var var_367: int;

        private var _users: Array;

        public function get users(): Array {
            return _users;
        }

        public function set users(param1: Array): void {
            _users = param1;
        }

        public function get score(): int {
            return var_367;
        }

        public function set score(param1: int): void {
            var_367 = param1;
        }

        public function addUser(param1: String): void {
            _users.push(param1);
        }
    }
}
