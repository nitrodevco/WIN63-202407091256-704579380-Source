package com.sulake.habbo.communication.messages.outgoing.camera.json {
    [SecureSWF(rename="false")]
    public class JsonTextureColumnData {

        public function JsonTextureColumnData() {
            var_713 = [];
            super();
        }
        private var var_713: Array;

        public function get assetNames(): Array {
            return var_713;
        }

        public function addAssetName(param1: String): void {
            var_713.push(param1);
        }
    }
}
