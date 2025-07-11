package com.sulake.habbo.room {
    [SecureSWF(rename="true")]
    public interface IRoomContentListener {

        function iconLoaded(param1: int, param2: String, param3: Boolean): void;
    }
}
