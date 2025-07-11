package com.sulake.core.runtime {
    [SecureSWF(rename="true")]
    internal class ComponentInterfaceQueue implements IDisposable {

        private var var_443: IID;

        private var var_318: Boolean;

        private var _receivers: Vector.<Function>;

        public function ComponentInterfaceQueue(param1: IID) {
            super();
            var_443 = param1;
            _receivers = new Vector.<Function>();
            var_318 = false;
        }

        public function get identifier(): IID {
            return var_443;
        }

        public function get disposed(): Boolean {
            return var_318;
        }

        public function get receivers(): Vector.<Function> {
            return _receivers;
        }

        public function dispose(): void {
            if (!var_318) {
                var_318 = true;
                var_443 = null;
                while (_receivers.length > 0) {
                    _receivers.pop();
                }
                _receivers = null;
            }
        }
    }
}
