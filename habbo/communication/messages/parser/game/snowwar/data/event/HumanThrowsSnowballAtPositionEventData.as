package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class HumanThrowsSnowballAtPositionEventData extends SnowWarGameEventData {

        public function HumanThrowsSnowballAtPositionEventData(param1: int) {
            super(param1);
        }
        private var var_977: int;
        private var var_932: int;
        private var var_1081: int;
        private var var_795: int;

        public function get humanGameObjectId(): int {
            return var_977;
        }

        public function get targetX(): int {
            return var_932;
        }

        public function get targetY(): int {
            return var_1081;
        }

        public function get trajectory(): int {
            return var_795;
        }

        override public function parse(param1: IMessageDataWrapper): void {
            var_977 = param1.readInteger();
            var_932 = param1.readInteger();
            var_1081 = param1.readInteger();
            var_795 = param1.readInteger();
        }
    }
}
