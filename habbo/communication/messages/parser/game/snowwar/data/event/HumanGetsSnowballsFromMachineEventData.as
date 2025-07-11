package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class HumanGetsSnowballsFromMachineEventData extends SnowWarGameEventData {

        public function HumanGetsSnowballsFromMachineEventData(param1: int) {
            super(param1);
        }
        private var var_977: int;
        private var var_1176: int;

        public function get humanGameObjectId(): int {
            return var_977;
        }

        public function get snowBallMachineReference(): int {
            return var_1176;
        }

        override public function parse(param1: IMessageDataWrapper): void {
            var_977 = param1.readInteger();
            var_1176 = param1.readInteger();
        }
    }
}
