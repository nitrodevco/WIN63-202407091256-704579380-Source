package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class HumanThrowsSnowballAtHumanEventData extends SnowWarGameEventData {

        public function HumanThrowsSnowballAtHumanEventData(param1: int) {
            super(param1);
        }
        private var var_977: int;
        private var var_1377: int;
        private var var_795: int;

        public function get humanGameObjectId(): int {
            return var_977;
        }

        public function get targetHumanGameObjectId(): int {
            return var_1377;
        }

        public function get trajectory(): int {
            return var_795;
        }

        override public function parse(param1: IMessageDataWrapper): void {
            var_977 = param1.readInteger();
            var_1377 = param1.readInteger();
            var_795 = param1.readInteger();
        }
    }
}
