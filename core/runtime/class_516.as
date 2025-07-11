package com.sulake.core.runtime {
    [SecureSWF(rename="true")]
    public class class_516 implements ICoreErrorReporter {

        public function class_516() {
            super();
        }

        public function logError(param1: String, param2: Boolean, param3: int = -1, param4: Error = null): void {
            class_14.log(param1, param4 != null ? param4.getStackTrace() : "");
        }

        public function set errorLogger(param1: ICoreErrorLogger): void {
        }
    }
}
