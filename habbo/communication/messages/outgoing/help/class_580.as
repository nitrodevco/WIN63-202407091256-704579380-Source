package com.sulake.habbo.communication.messages.outgoing.help {
   import com.sulake.core.communication.messages.IMessageComposer

   [SecureSWF(rename="true")]
    public class class_580 implements IMessageComposer {

        public function class_580(param1: String) {
            super();
            _searchString = param1;
        }
        private var _searchString: String;

        public function getMessageArray(): Array {
            return [_searchString];
        }

        public function dispose(): void {
        }
    }
}
