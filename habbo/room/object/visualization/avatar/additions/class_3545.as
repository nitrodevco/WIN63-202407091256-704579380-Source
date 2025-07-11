package com.sulake.habbo.room.object.visualization.avatar.additions {
    import com.sulake.core.runtime.IDisposable
    import com.sulake.room.object.visualization.IRoomObjectSprite

    public interface class_3545 extends IDisposable {

        function get id(): int;

        function update(param1: IRoomObjectSprite, param2: Number): void;

        function animate(param1: IRoomObjectSprite): Boolean;
    }
}
