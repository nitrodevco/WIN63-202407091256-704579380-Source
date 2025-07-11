package com.sulake.habbo.communication.messages.parser.game.snowwar.data.event {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class NewMoveTargetEventData extends SnowWarGameEventData {

        public function NewMoveTargetEventData(param1: int) {
            super(param1);
        }
        private var var_977: int;
        private var var_31: int;
        private var var_28: int;

        public function get humanGameObjectId(): int {
            return var_977;
        }

        public function get x(): int {
            return var_31;
        }

        public function get y(): int {
            return var_28;
        }

        override public function parse(param1: IMessageDataWrapper): void {
            var_977 = param1.readInteger();
            var_31 = param1.readInteger();
            var_28 = param1.readInteger();
        }
    }
}
