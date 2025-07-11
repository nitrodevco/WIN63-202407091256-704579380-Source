package com.sulake.habbo.communication.messages.incoming.error {
   import com.sulake.core.communication.messages.IMessageEvent
   import com.sulake.core.communication.messages.MessageEvent
   import com.sulake.habbo.communication.messages.parser.error.class_1334

   [SecureSWF(rename="true")]
    public class class_231 extends MessageEvent implements IMessageEvent {

        public function class_231(param1: Function) {
            super(param1, class_1334);
        }

        public function getParser(): class_1334 {
            return this._parser as class_1334;
        }
    }
}
