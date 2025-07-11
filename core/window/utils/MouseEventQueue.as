package com.sulake.core.window.utils {
    import flash.events.IEventDispatcher
    import flash.events.MouseEvent
    import flash.geom.Point

    public class MouseEventQueue extends GenericEventQueue {

        protected var var_3871: Point;

        public function MouseEventQueue(param1: IEventDispatcher) {
            super(param1);
            var_3871 = new Point();
            var_155.addEventListener("click", mouseEventListener, false);
            var_155.addEventListener("doubleClick", mouseEventListener, false);
            var_155.addEventListener("mouseDown", mouseEventListener, false);
            var_155.addEventListener("mouseMove", mouseEventListener, false);
            var_155.addEventListener("mouseUp", mouseEventListener, false);
            var_155.addEventListener("mouseWheel", mouseEventListener, false);
        }

        public function get mousePosition(): Point {
            return var_3871;
        }

        override public function dispose(): void {
            if (!_disposed) {
                var_155.removeEventListener("click", mouseEventListener, false);
                var_155.removeEventListener("doubleClick", mouseEventListener, false);
                var_155.removeEventListener("mouseDown", mouseEventListener, false);
                var_155.removeEventListener("mouseMove", mouseEventListener, false);
                var_155.removeEventListener("mouseUp", mouseEventListener, false);
                var_155.removeEventListener("mouseWheel", mouseEventListener, false);
                super.dispose();
            }
        }

        private function mouseEventListener(param1: MouseEvent): void {
            var_3871.x = param1.stageX;
            var_3871.y = param1.stageY;
            _eventArray.push(param1);
        }
    }
}
