package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class MachineCreatesSnowballEventData extends SnowWarGameEventData {

        public function MachineCreatesSnowballEventData(param1: int) {
            super(param1);
        }
        private var var_1176: int;

        public function get snowBallMachineReference(): int {
            return var_1176;
        }

        override public function parse(param1: IMessageDataWrapper): void {
            var_1176 = param1.readInteger();
        }
    }
}
