package com.sulake.habbo.room {
    public class AssetCallbackInfo {

        public function AssetCallbackInfo(param1: int) {
            super();
            this._id = param1;
            this._listeners = new Vector.<IGetImageListener>();
        }

        private var _id: int;

        private var _listeners: Vector.<IGetImageListener>;

        public function get listeners(): Vector.<IGetImageListener> {
            return _listeners;
        }

        public function get id(): int {
            return _id;
        }
    }
}
