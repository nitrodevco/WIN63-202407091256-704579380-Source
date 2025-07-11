package com.sulake.habbo.communication.messages.parser.game.snowwar.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.parser.room.engine.class_1642
    import com.sulake.habbo.room.IStuffData

    public class FuseObjectData {

        public function FuseObjectData() {
            super();
        }
        private var var_280: int;

        private var var_31: int;

        private var var_28: int;

        private var var_913: int;

        private var var_863: int;

        private var var_46: int;

        private var var_1210: int;

        private var var_1386: int;

        private var var_1272: Boolean;

        private var var_1091: IStuffData;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get id(): int {
            return var_280;
        }

        public function get x(): int {
            return var_31;
        }

        public function get y(): int {
            return var_28;
        }

        public function get xDimension(): int {
            return var_913;
        }

        public function get yDimension(): int {
            return var_863;
        }

        public function get height(): int {
            return var_46;
        }

        public function get direction(): int {
            return var_1210;
        }

        public function get altitude(): int {
            return var_1386;
        }

        public function get canStandOn(): Boolean {
            return var_1272;
        }

        public function get stuffData(): IStuffData {
            return var_1091;
        }

        public function parse(param1: IMessageDataWrapper): void {
            _name = param1.readString();
            var_280 = param1.readInteger();
            var_31 = param1.readInteger();
            var_28 = param1.readInteger();
            var_913 = param1.readInteger();
            var_863 = param1.readInteger();
            var_46 = param1.readInteger();
            var_1210 = param1.readInteger();
            var_1386 = param1.readInteger();
            var_1272 = param1.readBoolean();
            var_1091 = class_1642.parseStuffData(param1);
        }
    }
}
