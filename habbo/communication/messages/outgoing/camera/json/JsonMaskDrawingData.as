package com.sulake.habbo.communication.messages.outgoing.camera.json {
    [SecureSWF(rename="false")]
    public class JsonMaskDrawingData {

        public function JsonMaskDrawingData(param1: String, param2: JsonPoint, param3: Boolean, param4: Boolean) {
            super();
            this._name = param1;
            this.var_587 = param2;
            this._flipH = param3;
            this._flipV = param4;
        }
        private var var_587: JsonPoint;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        private var _flipH: Boolean;

        public function get flipH(): Boolean {
            return _flipH;
        }

        private var _flipV: Boolean;

        public function get flipV(): Boolean {
            return _flipV;
        }

        public function get location(): JsonPoint {
            return var_587;
        }
    }
}
