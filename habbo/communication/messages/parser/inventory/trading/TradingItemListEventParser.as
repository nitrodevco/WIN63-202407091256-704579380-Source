package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_1704;

    [SecureSWF(rename = "true")]
        public class TradingItemListEventParser implements IMessageParser
        {

            public function TradingItemListEventParser()
            {
                super();
            }
            private var var_652:int;
        private var var_288:Array;
        private var var_588:int;
        private var var_534:int;
        private var var_568:int;
        private var var_359:Array;
        private var var_651:int;
        private var var_618:int;

        public function get firstUserID():int
        {
            return var_652;
        }

        public function get firstUserItemArray():Array
        {
            return var_288;
        }

        public function get firstUserNumItems():int
        {
            return var_588;
        }

        public function get firstUserNumCredits():int
        {
            return var_534;
        }

        public function get secondUserID():int
        {
            return var_568;
        }

        public function get secondUserItemArray():Array
        {
            return var_359;
        }

        public function get secondUserNumItems():int
        {
            return var_651;
        }

        public function get secondUserNumCredits():int
        {
            return var_618;
        }

        public function flush():Boolean
        {
            var_652 = -1;
            var_288 = null;
            var_588 = 0;
            var_534 = 0;
            var_568 = -1;
            var_359 = null;
            var_651 = 0;
            var_618 = 0;
            return true;
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var_652 = param1.readInteger();
            var_288 = [];
            if (!parseItemData(param1, var_288))
            {
                return false;
            }
            var_588 = param1.readInteger();
            var_534 = param1.readInteger();
            var_568 = param1.readInteger();
            var_359 = [];
            if (!parseItemData(param1, var_359))
            {
                return false;
            }
            var_651 = param1.readInteger();
            var_618 = param1.readInteger();
            return true;
        }

        private function parseItemData(param1:IMessageDataWrapper, param2:Array):Boolean
        {
            var _loc3_:int = 0;
            _loc3_ = param1.readInteger();
            while (_loc3_ > 0)
            {
                param2.push(new class_1704(param1));
                _loc3_--;
            }
            return true;
        }
    }
}
