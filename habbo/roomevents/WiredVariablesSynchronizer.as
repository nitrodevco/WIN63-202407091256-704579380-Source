package com.sulake.habbo.roomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_1286;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.class_3556;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariablesHashEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariablesDiffsEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariablesHashMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariablesDiffsMessageComposer;
   
   public class WiredVariablesSynchronizer implements IDisposable
   {
      
      private static var STATUS_IDLE:int = 0;
      
      private static var STATUS_AWAIT_HASH:int = 1;
      
      private static var STATUS_AWAIT_DIFFS:int = 2;
      
      private static var REQUEST_OFFSET:int = 800;
      
      private static var INVALIDATE_REQUEST_OFFSET:int = 4000;
       
      
      private var _disposed:Boolean;
      
      private var var_2185:Number = -1;
      
      private var _status:int;
      
      private var _allVariablesHash:int;
      
      private var var_2112:Dictionary = null;
      
      private var _variableIdToHash:Dictionary = null;
      
      private var _listeners:Vector.<Function>;
      
      private var name_1:HabboUserDefinedRoomEvents;
      
      private var _messageEvents:Array;
      
      public function WiredVariablesSynchronizer(param1:HabboUserDefinedRoomEvents)
      {
         _status = STATUS_IDLE;
         _listeners = new Vector.<Function>();
         super();
         this.name_1 = param1;
         _messageEvents = [];
         _messageEvents.push(new WiredAllVariablesHashEvent(onAllVariablesHashEvent));
         _messageEvents.push(new WiredAllVariablesDiffsEvent(onAllVariablesDiffEvent));
         for each(var _loc2_ in _messageEvents)
         {
            name_1.communication.addHabboConnectionMessageEvent(_loc2_);
         }
      }
      
      private static function nonInternalVariablesSort(param1:WiredVariable, param2:WiredVariable) : int
      {
         var _loc4_:String = param1.variableName.toLowerCase();
         var _loc3_:String = param2.variableName.toLowerCase();
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         if(_loc4_ > _loc3_)
         {
            return 1;
         }
         return 0;
      }
      
      private static function internalVariablesSort(param1:WiredVariable, param2:WiredVariable) : int
      {
         if(param1.variableId < param2.variableId)
         {
            return 1;
         }
         if(param1.variableId > param2.variableId)
         {
            return -1;
         }
         return 0;
      }
      
      public function getAllVariables(param1:Function, param2:Boolean = true, param3:int = 0) : Boolean
      {
         if(_status != STATUS_IDLE && var_2185 < getTimer() - INVALIDATE_REQUEST_OFFSET)
         {
            _status = STATUS_IDLE;
         }
         if(_status != STATUS_IDLE)
         {
            addListener(param1);
            return false;
         }
         if(var_2185 > getTimer() - REQUEST_OFFSET)
         {
            param1(sortedCachedVariables);
            return true;
         }
         if(!param2 && var_2112 != null)
         {
            param1(sortedCachedVariables);
            return true;
         }
         var_2185 = getTimer();
         _status = STATUS_AWAIT_HASH;
         addListener(param1);
         if(param3 != 0)
         {
            onAllVariablesHash(param3);
         }
         else
         {
            name_1.send(new WiredGetAllVariablesHashMessageComposer());
         }
         return false;
      }
      
      private function onAllVariablesHashEvent(param1:WiredAllVariablesHashEvent) : void
      {
         onAllVariablesHash(param1.getParser().allVariablesHash);
      }
      
      private function onAllVariablesHash(param1:int) : void
      {
         if(_status != STATUS_AWAIT_HASH)
         {
            return;
         }
         var_2185 = getTimer();
         if(param1 == _allVariablesHash)
         {
            updateListeners();
            _status = STATUS_IDLE;
         }
         else
         {
            _allVariablesHash = param1;
            _status = STATUS_AWAIT_DIFFS;
            name_1.send(new WiredGetAllVariablesDiffsMessageComposer(_variableIdToHash));
         }
      }
      
      private function onAllVariablesDiffEvent(param1:WiredAllVariablesDiffsEvent) : void
      {
         if(_status != STATUS_AWAIT_DIFFS)
         {
            return;
         }
         var_2185 = getTimer();
         var _loc2_:class_1286 = param1.getParser();
         _allVariablesHash = _loc2_.allVariablesHash;
         if(var_2112 == null)
         {
            var_2112 = new Dictionary();
            _variableIdToHash = new Dictionary();
         }
         deleteVariablesInCache(_loc2_.removedVariables);
         updateVariablesInCache(_loc2_.addedOrUpdated);
         if(_loc2_.isLastChunk)
         {
            updateListeners();
            _status = STATUS_IDLE;
         }
      }
      
      private function deleteVariablesInCache(param1:Vector.<Number>) : void
      {
         for each(var _loc2_ in param1)
         {
            if(_loc2_ in var_2112)
            {
               delete var_2112[_loc2_];
               delete _variableIdToHash[_loc2_];
            }
         }
      }
      
      private function updateVariablesInCache(param1:Dictionary) : void
      {
         var _loc3_:int = 0;
         for(var _loc2_ in param1)
         {
            _loc3_ = int(param1[_loc2_]);
            var_2112[_loc2_.variableId] = _loc2_;
            _variableIdToHash[_loc2_.variableId] = _loc3_;
         }
      }
      
      private function get sortedCachedVariables() : Vector.<WiredVariable>
      {
         if(var_2112 == null)
         {
            return new Vector.<WiredVariable>();
         }
         var _loc1_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         var _loc2_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         for each(var _loc3_ in var_2112)
         {
            if(_loc3_.availabilityType == class_3556.var_2975)
            {
               _loc2_.push(_loc3_);
            }
            else
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sort(nonInternalVariablesSort);
         _loc2_.sort(internalVariablesSort);
         return _loc1_.concat(_loc2_);
      }
      
      private function addListener(param1:Function) : void
      {
         if(_listeners.indexOf(param1) == -1)
         {
            _listeners.push(param1);
         }
      }
      
      public function removeListener(param1:Function) : void
      {
         var _loc2_:int = _listeners.indexOf(param1);
         if(_loc2_ != -1)
         {
            _listeners.removeAt(_loc2_);
         }
      }
      
      private function updateListeners() : void
      {
         var _loc1_:Vector.<WiredVariable> = sortedCachedVariables;
         for each(var _loc2_ in _listeners)
         {
            _loc2_(_loc1_);
         }
         _listeners.splice(0,_listeners.length);
      }
      
      public function clear() : void
      {
         _listeners = new Vector.<Function>();
         var_2112 = null;
         _variableIdToHash = null;
         _allVariablesHash = 0;
         var_2185 = -1;
         _status = STATUS_IDLE;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _listeners = null;
         var_2185 = -1;
         _status = STATUS_IDLE;
         _allVariablesHash = 0;
         var_2112 = null;
         _variableIdToHash = null;
         for each(var _loc1_ in _messageEvents)
         {
            name_1.communication.removeHabboConnectionMessageEvent(_loc1_);
         }
         _messageEvents = null;
         name_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
