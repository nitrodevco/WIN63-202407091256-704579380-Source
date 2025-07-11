package com.sulake.habbo.communication.login {
    public class AvatarData {

        public function AvatarData(param1: Object) {
            super();
            if (param1 != null) {
                var_1369 = param1.uniqueId;
                _name = param1.name;
                var_962 = param1.motto;
                var_426 = param1.figureString;
                var_129 = param1.gender;
                _last_access = param1.lastWebAccess;
                var_1516 = param1.habboClubMember == "true";
                var_1548 = param1.buildersClubMember == "true";
                _creationTime = param1.creationTime;
            }
        }
        private var var_280: int;
        private var var_1369: String;
        private var var_962: String;

        private var var_426: String;

        private var var_129: String;
        private var var_1516: Boolean;
        private var var_1548: Boolean;
        private var _creationTime: String;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function set name(param1: String): void {
            _name = param1;
        }

        private var _head_figure: String;

        public function get head_figure(): String {
            return _head_figure;
        }

        private var _last_access: int;

        public function get last_access(): int {
            return _last_access;
        }

        public function get id(): int {
            return var_280;
        }

        public function set id(param1: int): void {
            var_280 = param1;
        }

        public function get uniqueId(): String {
            return var_1369;
        }

        public function get motto(): String {
            return var_962;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get gender(): String {
            return var_129;
        }
    }
}
