package com.sulake.habbo.room.messages {
    import com.sulake.room.messages.RoomObjectUpdateMessage
    import com.sulake.room.utils.IVector3d

    public class RoomObjectMoveUpdateMessage extends RoomObjectUpdateMessage {

        public function RoomObjectMoveUpdateMessage(param1: IVector3d, param2: IVector3d, param3: IVector3d, param4: Number = NaN, param5: Boolean = false, param6: Boolean = false) {
            super(param1, param3);
            _isSlideUpdate = param5;
            var_1822 = param2;
            _animationTime = param4;
            _skipPositionUpdate = param6;
        }
        private var var_1822: IVector3d;

        private var _isSlideUpdate: Boolean;

        public function get isSlideUpdate(): Boolean {
            return _isSlideUpdate;
        }

        private var _animationTime: Number;

        public function get animationTime(): Number {
            return _animationTime;
        }

        private var _skipPositionUpdate: Boolean;

        public function get skipPositionUpdate(): Boolean {
            return _skipPositionUpdate;
        }

        public function get targetLoc(): IVector3d {
            if (var_1822 == null) {
                return loc;
            }
            return var_1822;
        }

        public function get realTargetLoc(): IVector3d {
            return var_1822;
        }
    }
}
