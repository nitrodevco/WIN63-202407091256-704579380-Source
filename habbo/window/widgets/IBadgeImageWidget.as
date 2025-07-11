package com.sulake.habbo.window.widgets {
    import com.sulake.core.window.class_3420
    import com.sulake.core.window.utils.class_3501

    public interface IBadgeImageWidget extends class_3420, class_3501 {

        function get type(): String;

        function set type(param1: String): void;

        function get badgeId(): String;

        function set badgeId(param1: String): void;

        function get groupId(): int;

        function set groupId(param1: int): void;
    }
}
