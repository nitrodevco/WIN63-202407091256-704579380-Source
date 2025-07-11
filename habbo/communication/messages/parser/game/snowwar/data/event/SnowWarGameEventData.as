package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class SnowWarGameEventData {

        public static const const_115: int = 1;

        public static const const_279: int = 2;

        public static const const_203: int = 3;

        public static const const_367: int = 4;

        public static const const_349: int = 7;

        public static const const_277: int = 8;

        public static const const_95: int = 11;

        public static const const_106: int = 12;

        public static function create(param1: int): SnowWarGameEventData {
            switch (param1 - 1) {
                case 0:
                    return new HumanLeftGameEventData(param1);
                case 1:
                    return new NewMoveTargetEventData(param1);
                case 2:
                    return new HumanThrowsSnowballAtHumanEventData(param1);
                case 3:
                    return new HumanThrowsSnowballAtPositionEventData(param1);
                case 6:
                    return new HumanStartsToMakeASnowballEventData(param1);
                case 7:
                    return new CreateSnowballEventData(param1);
                case 10:
                    return new MachineCreatesSnowballEventData(param1);
                case 11:
                    return new HumanGetsSnowballsFromMachineEventData(param1);
                default:
                    return null;
            }
        }

        public function SnowWarGameEventData(param1: int) {
            super();
            var_280 = param1;
        }
        private var var_280: int;

        public function get id(): int {
            return var_280;
        }

        public function set id(param1: int): void {
            var_280 = param1;
        }

        public function parse(param1: IMessageDataWrapper): void {
        }
    }
}
