package com.sulake.habbo.avatar.actions
{
   import com.sulake.core.utils.Map;
   import flash.utils.Dictionary;
   
   public class ActionDefinition implements class_3576
   {
       
      
      private var var_280:String;
      
      private var var_149:String;
      
      private var var_4432:int;
      
      private var var_4792:String;
      
      private var var_4278:String;
      
      private var var_4778:String;
      
      private var var_2500:String;
      
      private var _isMain:Boolean = false;
      
      private var _isDefault:Boolean = false;
      
      private var var_4352:Boolean = false;
      
      private var var_4555:Boolean = false;
      
      private var var_3714:Array;
      
      private var var_4062:Boolean;
      
      private var var_2288:Map;
      
      private var var_1664:Dictionary;
      
      private var _params:Dictionary;
      
      private var var_4787:String = "";
      
      public function ActionDefinition(param1:XML)
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         var_3714 = [];
         var_1664 = new Dictionary();
         _params = new Dictionary();
         super();
         var_280 = String(param1.@id);
         var_149 = String(param1.@state);
         var_4432 = parseInt(param1.@precedence);
         var_4792 = String(param1.@activepartset);
         var_4278 = String(param1.@assetpartdefinition);
         var_4778 = String(param1.@lay);
         var_2500 = String(param1.@geometrytype);
         _isMain = Boolean(parseInt(param1.@main));
         _isDefault = Boolean(parseInt(param1.@isdefault));
         var_4352 = Boolean(parseInt(param1.@animation));
         var_4555 = param1.@startfromframezero == "true";
         var_4062 = param1.@preventheadturn == "true";
         var _loc3_:String = String(param1.@prevents);
         if(_loc3_ != "")
         {
            var_3714 = _loc3_.split(",");
         }
         for each(var _loc2_ in param1.param)
         {
            _loc6_ = String(_loc2_.@id);
            _loc7_ = String(_loc2_.@value);
            if(_loc6_ == "default")
            {
               var_4787 = _loc7_;
            }
            else
            {
               _params[_loc6_] = _loc7_;
            }
         }
         for each(var _loc5_ in param1.type)
         {
            _loc4_ = String(_loc5_.@id);
            var_1664[_loc4_] = new ActionType(_loc5_);
         }
      }
      
      public function setOffsets(param1:String, param2:int, param3:Array) : void
      {
         if(var_2288 == null)
         {
            var_2288 = new Map();
         }
         if(var_2288.getValue(param1) == null)
         {
            var_2288.add(param1,new Map());
         }
         var _loc4_:Map;
         (_loc4_ = var_2288.getValue(param1)).add(param2,param3);
      }
      
      public function getOffsets(param1:String, param2:int) : Array
      {
         if(var_2288 == null)
         {
            return null;
         }
         var _loc3_:Map = var_2288.getValue(param1) as Map;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getValue(param2) as Array;
      }
      
      public function getParameterValue(param1:String) : String
      {
         if(param1 == "")
         {
            return "";
         }
         var _loc2_:String = String(_params[param1]);
         if(_loc2_ == null)
         {
            _loc2_ = var_4787;
         }
         return _loc2_;
      }
      
      private function getTypePrevents(param1:String) : Array
      {
         if(param1 == "")
         {
            return [];
         }
         var _loc2_:ActionType = var_1664[param1];
         if(_loc2_ != null)
         {
            return _loc2_.prevents;
         }
         return [];
      }
      
      public function toString() : String
      {
         return "[ActionDefinition]\nid:           " + id + "\n" + "state:        " + state + "\n" + "main:         " + isMain + "\n" + "default:      " + isDefault + "\n" + "geometry:     " + state + "\n" + "precedence:   " + precedence + "\n" + "activepartset:" + activePartSet + "\n" + "activepartdef:" + assetPartDefinition + "";
      }
      
      public function get id() : String
      {
         return var_280;
      }
      
      public function get state() : String
      {
         return var_149;
      }
      
      public function get precedence() : int
      {
         return var_4432;
      }
      
      public function get activePartSet() : String
      {
         return var_4792;
      }
      
      public function get isMain() : Boolean
      {
         return _isMain;
      }
      
      public function get isDefault() : Boolean
      {
         return _isDefault;
      }
      
      public function get assetPartDefinition() : String
      {
         return var_4278;
      }
      
      public function get lay() : String
      {
         return var_4778;
      }
      
      public function get geometryType() : String
      {
         return var_2500;
      }
      
      public function get isAnimation() : Boolean
      {
         return var_4352;
      }
      
      public function getPrevents(param1:String = "") : Array
      {
         return var_3714.concat(getTypePrevents(param1));
      }
      
      public function getPreventHeadTurn(param1:String = "") : Boolean
      {
         if(param1 == "")
         {
            return var_4062;
         }
         var _loc2_:ActionType = var_1664[param1];
         if(_loc2_ != null)
         {
            return _loc2_.preventHeadTurn;
         }
         return var_4062;
      }
      
      public function isAnimated(param1:String) : Boolean
      {
         if(param1 == "")
         {
            return true;
         }
         var _loc2_:ActionType = var_1664[param1];
         if(_loc2_ != null)
         {
            return _loc2_.isAnimated;
         }
         return true;
      }
      
      public function get startFromFrameZero() : Boolean
      {
         return var_4555;
      }
      
      public function get params() : Dictionary
      {
         return _params;
      }
   }
}
