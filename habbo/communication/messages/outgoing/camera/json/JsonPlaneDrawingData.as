package com.sulake.habbo.communication.messages.outgoing.camera.json {
    [SecureSWF(rename="false")]
    public class JsonPlaneDrawingData {

        public function JsonPlaneDrawingData() {
            var_682 = new Vector.<JsonPoint>();
            var_461 = [];
            var_666 = [];
            super();
        }
        private var var_30: Number;
        private var var_682: Vector.<JsonPoint>;
        private var var_461: Array;

        private var var_1139: Boolean;

        private var var_666: Array;

        private var _color: uint;

        public function get color(): uint {
            return _color;
        }

        public function set color(param1: uint): void {
            _color = param1;
        }

        public function get z(): Number {
            return var_30;
        }

        public function set z(param1: Number): void {
            var_30 = param1;
        }

        public function get cornerPoints(): Vector.<JsonPoint> {
            return var_682;
        }

        public function get masks(): Array {
            return var_461;
        }

        public function get bottomAligned(): Boolean {
            return var_1139;
        }

        public function get texCols(): Array {
            return var_666;
        }

        public function addCornerPoint(param1: int, param2: int): void {
            var_682.push(new JsonPoint(param1, param2));
        }

        public function addMask(param1: JsonMaskDrawingData): void {
            var_461.push(param1);
        }

        public function setBottomAligned(param1: Boolean): void {
            var_1139 = param1;
        }

        public function addTexCol(param1: JsonTextureColumnData): void {
            var_666.push(param1);
        }
    }
}
