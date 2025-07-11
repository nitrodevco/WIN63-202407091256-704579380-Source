package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class HumanLeftGameEventData extends SnowWarGameEventData {

        public function HumanLeftGameEventData(param1: int) {
            super(param1);
        }
        private var var_977: int;

        public function get humanGameObjectId(): int {
            return var_977;
        }

        override public function parse(param1: IMessageDataWrapper): void {
            var_977 = param1.readInteger();
        }
    }
}
