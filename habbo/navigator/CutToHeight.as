package com.sulake.habbo.navigator {
   import com.sulake.core.window.components.ITextWindow

   public class CutToHeight implements BinarySearchTest {

        private var _value: String;

        private var _text: ITextWindow;

        private var var_1979: int;

        public function CutToHeight() {
            super();
        }

        public function test(param1: int): Boolean {
            _text.text = _value.substring(0, param1) + "...";
            return _text.textHeight > var_1979;
        }

        public function beforeSearch(param1: String, param2: ITextWindow, param3: int): void {
            _value = param1;
            _text = param2;
            var_1979 = param3;
        }
    }
}
