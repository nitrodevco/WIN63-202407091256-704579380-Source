package com.sulake.core.runtime {
   import flash.utils.getQualifiedClassName;

   internal final class InterfaceStructList implements IDisposable {

      private var _interfaceStructs: Array;

      public function InterfaceStructList() {
         _interfaceStructs = [];
         super();
      }

      public function get length(): uint {
         return _interfaceStructs.length;
      }

      public function get disposed(): Boolean {
         return _interfaceStructs == null;
      }

      public function dispose(): void {
         if (!_interfaceStructs) return;
         for each (var struct: InterfaceStruct in _interfaceStructs) {
            struct.dispose();
         }
         _interfaceStructs = null;
      }

      public function insert(struct: InterfaceStruct): uint {
         _interfaceStructs.push(struct);
         return _interfaceStructs.length;
      }

      public function remove(index: uint): InterfaceStruct {
         if (index < _interfaceStructs.length) {
            var struct: InterfaceStruct = _interfaceStructs[index];
            _interfaceStructs.splice(index, 1);
            return struct;
         }
         throw new Error("Index out of range!");
      }

      public function find(iid: IID): IUnknown {
         var className: String = getQualifiedClassName(iid);
         for each (var struct: InterfaceStruct in _interfaceStructs) {
            if (struct.iis == className) {
               return struct.unknown;
            }
         }
         return null;
      }

      public function getStructByInterface(iid: IID): InterfaceStruct {
         var className: String = getQualifiedClassName(iid);
         for each (var struct: InterfaceStruct in _interfaceStructs) {
            if (struct.iis == className) {
               return struct;
            }
         }
         return null;
      }

      public function getIndexByInterface(iid: IID): int {
         var className: String = getQualifiedClassName(iid);
         for (var i: int = 0; i < _interfaceStructs.length; i++) {
            if (_interfaceStructs[i].iis == className) {
               return i;
            }
         }
         return -1;
      }

      public function mapStructsByInterface(iid: IID, resultArray: Array): uint {
         var className: String = getQualifiedClassName(iid);
         var count: uint = 0;
         for each (var struct: InterfaceStruct in _interfaceStructs) {
            if (struct.iis == className) {
               resultArray.push(struct);
               count++;
            }
         }
         return count;
      }

      public function getStructByImplementor(unknown: IUnknown): InterfaceStruct {
         for each (var struct: InterfaceStruct in _interfaceStructs) {
            if (struct.unknown == unknown) {
               return struct;
            }
         }
         return null;
      }

      public function getIndexByImplementor(unknown: IUnknown): int {
         for (var i: int = 0; i < _interfaceStructs.length; i++) {
            if (_interfaceStructs[i].unknown == unknown) {
               return i;
            }
         }
         return -1;
      }

      public function mapStructsByImplementor(unknown: IUnknown, resultArray: Array): uint {
         var count: uint = 0;
         for each (var struct: InterfaceStruct in _interfaceStructs) {
            if (struct.unknown == unknown) {
               resultArray.push(struct);
               count++;
            }
         }
         return count;
      }

      public function getStructByIndex(index: uint): InterfaceStruct {
         return index < _interfaceStructs.length ? _interfaceStructs[index] : null;
      }

      public function getTotalReferenceCount(): uint {
         var totalReferences: uint = 0;
         for each (var struct: InterfaceStruct in _interfaceStructs) {
            totalReferences += struct.references;
         }
         return totalReferences;
      }
   }
}
