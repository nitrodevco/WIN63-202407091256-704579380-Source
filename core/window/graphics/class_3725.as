package com.sulake.core.window.graphics
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.class_3540;
   import com.sulake.core.window.graphics.renderer.*;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class class_3725
   {
      
      public static const WINDOW_STATE_DEFAULT:String = "default";
      
      public static const WINDOW_STATE_ACTIVE:String = "active";
      
      public static const const_478:String = "focused";
      
      public static const WINDOW_STATE_HOVERING:String = "hovering";
      
      public static const const_493:String = "selected";
      
      public static const const_463:String = "pressed";
      
      public static const const_477:String = "disabled";
      
      public static const const_479:String = "locked";
       
      
      public function class_3725()
      {
         super();
      }
      
      public static function parseSkinDescription(param1:XML, param2:XMLList, param3:ISkinRenderer, param4:String, param5:IAssetLibrary) : void
      {
         var _loc8_:XML = null;
         var _loc10_:XMLList = null;
         var _loc21_:XMLList = null;
         var _loc19_:* = 0;
         var _loc13_:* = 0;
         var _loc22_:XML = null;
         var _loc11_:XMLList = null;
         var _loc7_:* = 0;
         var _loc20_:* = 0;
         var _loc14_:* = 0;
         var _loc18_:XML = null;
         var _loc6_:Map = new Map();
         var _loc12_:XMLList;
         if((_loc12_ = param1.child("variables")).length() > 0)
         {
            if((_loc10_ = (_loc8_ = _loc12_[0]).child("variable")).length())
            {
               class_3540.parseVariableList(_loc10_,_loc6_);
            }
         }
         var _loc9_:Dictionary = new Dictionary();
         var _loc17_:XMLList;
         if((_loc17_ = param1.child("templates"))[0])
         {
            parseTemplateList(param3,_loc17_[0],_loc9_,_loc6_,param5);
         }
         var _loc15_:Dictionary = new Dictionary();
         var _loc16_:XMLList;
         if((_loc16_ = param1.child("layouts"))[0])
         {
            if(param4 == null)
            {
               parseLayoutList(param3,_loc16_[0],_loc15_,_loc6_);
            }
            else
            {
               _loc19_ = uint((_loc21_ = _loc16_[0].child("layout")).length());
               _loc13_ = 0;
               while(_loc13_ < _loc19_)
               {
                  if((_loc22_ = _loc21_[_loc13_]).attribute("name") == param4)
                  {
                     parseLayout(param3,_loc22_,_loc15_,_loc6_);
                     break;
                  }
                  _loc13_++;
               }
            }
         }
         if(param2.length() == 0)
         {
            param2 = param1.child("states");
         }
         if(param2.length() > 0)
         {
            if(param4 == null)
            {
               parseRenderStateList(param3,param2[0],_loc15_,_loc6_);
            }
            else
            {
               _loc7_ = uint((_loc11_ = param2[0].child("state")).length());
               _loc20_ = 0;
               _loc14_ = 0;
               while(_loc14_ < _loc7_)
               {
                  if((_loc18_ = _loc11_[_loc14_]).attribute("layout") == param4)
                  {
                     parseState(param3,_loc18_,_loc15_,_loc6_);
                     _loc20_++;
                  }
                  _loc14_++;
               }
            }
         }
      }
      
      protected static function parseLayout(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc7_:String = null;
         var _loc8_:XML = null;
         var _loc9_:XMLList = null;
         _loc7_ = param2.attribute("name");
         var _loc10_:* = param2.attribute("transparent") == "true";
         var _loc5_:String = param2.attribute("blendMode");
         var _loc6_:SkinLayout = new SkinLayout(_loc7_,_loc10_,_loc5_);
         var _loc11_:XMLList;
         if((_loc11_ = param2.child("entities")).length() > 0)
         {
            if((_loc9_ = (_loc8_ = _loc11_[0]).child("entity")).length())
            {
               parseLayoutEntityList(param1,_loc6_,_loc9_,param4);
            }
         }
         param3[_loc7_] = _loc6_;
         param1.addLayout(_loc6_);
      }
      
      protected static function parseLayoutList(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc6_:* = 0;
         var _loc8_:XML = null;
         var _loc7_:XMLList;
         var _loc5_:uint = uint((_loc7_ = param2.child("layout")).length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = _loc7_[_loc6_];
            parseLayout(param1,_loc8_,param3,param4);
            _loc6_++;
         }
      }
      
      protected static function parseLayoutEntity(param1:XML, param2:Map) : SkinLayoutEntity
      {
         var _loc4_:String = null;
         var _loc6_:SkinLayoutEntity = null;
         var _loc5_:* = 0;
         var _loc3_:String = null;
         var _loc7_:XML = null;
         var _loc8_:XMLList = null;
         _loc3_ = param1.attribute("id");
         _loc5_ = uint(_loc3_ == null ? 0 : uint(_loc3_));
         _loc3_ = param1.attribute("name");
         _loc4_ = _loc3_ == null ? "" : _loc3_;
         _loc6_ = new SkinLayoutEntity(_loc5_,_loc4_);
         _loc3_ = param1.attribute("colorize");
         _loc6_.colorize = _loc3_ == "" ? true : _loc3_ == "true";
         _loc3_ = null;
         if((_loc8_ = param1.child("color")).length() > 0)
         {
            _loc3_ = String(_loc7_ = _loc8_[0]);
            if(_loc3_ != null)
            {
               if(_loc3_.charAt(0) == "$")
               {
                  _loc3_ = String(param2[_loc3_.slice(1,_loc3_.length)]);
               }
            }
         }
         _loc6_.color = _loc3_ == null ? 0 : uint(_loc3_);
         _loc3_ = null;
         if((_loc8_ = param1.child("blend")).length() > 0)
         {
            _loc3_ = String(_loc7_ = _loc8_[0]);
            if(_loc3_ != null)
            {
               if(_loc3_.charAt(0) == "$")
               {
                  _loc3_ = String(param2[_loc3_.slice(1,_loc3_.length)]);
               }
            }
         }
         _loc6_.blend = _loc3_ == null ? 4294967295 : uint(_loc3_);
         if((_loc8_ = param1.child("scale")).length() > 0)
         {
            _loc3_ = (_loc7_ = _loc8_[0]).attribute("horizontal");
            if(_loc3_ != null)
            {
               if(_loc3_.charAt(0) == "$")
               {
                  _loc3_ = String(param2[_loc3_.slice(1,_loc3_.length)]);
               }
            }
            switch(_loc3_.toLowerCase())
            {
               case "fixed":
                  _loc6_.scaleH = 0;
                  break;
               case "move":
                  _loc6_.scaleH = 1;
                  break;
               case "strech":
                  _loc6_.scaleH = 2;
                  break;
               case "tiled":
                  _loc6_.scaleH = 4;
                  break;
               case "center":
                  _loc6_.scaleH = 8;
            }
            _loc3_ = _loc7_.attribute("vertical");
            if(_loc3_ != null)
            {
               if(_loc3_.charAt(0) == "$")
               {
                  _loc3_ = String(param2[_loc3_.slice(1,_loc3_.length)]);
               }
            }
            switch(_loc3_.toLowerCase())
            {
               case "fixed":
                  _loc6_.scaleV = 0;
                  break;
               case "move":
                  _loc6_.scaleV = 1;
                  break;
               case "strech":
                  _loc6_.scaleV = 2;
                  break;
               case "tiled":
                  _loc6_.scaleV = 4;
                  break;
               case "center":
                  _loc6_.scaleV = 8;
            }
         }
         if((_loc8_ = param1.child("region")).length() > 0)
         {
            _loc7_ = (_loc8_ = (_loc7_ = _loc8_[0]).child("Rectangle"))[0];
            _loc6_.region = new Rectangle();
            _loc3_ = _loc7_.attribute("x");
            _loc6_.region.x = Number(_loc3_.charAt(0) == "$" ? param2[_loc3_.slice(1,_loc3_.length)] : _loc3_);
            _loc3_ = _loc7_.attribute("y");
            _loc6_.region.y = Number(_loc3_.charAt(0) == "$" ? param2[_loc3_.slice(1,_loc3_.length)] : _loc3_);
            _loc3_ = _loc7_.attribute("width");
            _loc6_.region.width = Number(_loc3_.charAt(0) == "$" ? param2[_loc3_.slice(1,_loc3_.length)] : _loc3_);
            _loc3_ = _loc7_.attribute("height");
            _loc6_.region.height = Number(_loc3_.charAt(0) == "$" ? param2[_loc3_.slice(1,_loc3_.length)] : _loc3_);
         }
         return _loc6_;
      }
      
      protected static function parseLayoutEntityList(param1:ISkinRenderer, param2:SkinLayout, param3:XMLList, param4:Map) : void
      {
         var _loc7_:SkinLayoutEntity = null;
         var _loc6_:* = 0;
         var _loc5_:uint = uint(param3.length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            if((_loc7_ = parseLayoutEntity(param3[_loc6_],param4)) != null)
            {
               param2.addChild(_loc7_);
            }
            _loc6_++;
         }
      }
      
      protected static function parseTemplateList(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map, param5:IAssetLibrary) : void
      {
         var _loc9_:* = 0;
         var _loc11_:XML = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc7_:BitmapSkinTemplate = null;
         var _loc15_:XMLList = null;
         var _loc10_:XML = null;
         var _loc14_:XMLList = null;
         var _loc6_:XMLList;
         var _loc8_:uint = uint((_loc6_ = param2.child("template")).length());
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            if((_loc12_ = (_loc11_ = _loc6_[_loc9_]).attribute("name")) != null)
            {
               if(_loc12_.charAt(0) == "$")
               {
                  _loc12_ = String(param4[_loc12_.slice(1,_loc12_.length)]);
               }
            }
            if((_loc13_ = _loc11_.attribute("asset")) != null)
            {
               if(_loc13_.charAt(0) == "$")
               {
                  _loc13_ = String(param4[_loc13_.slice(1,_loc13_.length)]);
               }
            }
            _loc7_ = new BitmapSkinTemplate(_loc12_,param5.getAssetByName(_loc13_));
            if((_loc15_ = _loc11_.child("entities")).length() > 0)
            {
               if((_loc14_ = (_loc10_ = _loc15_[0]).child("entity")).length())
               {
                  parseTemplateEntityList(param1,_loc7_,_loc14_,param4);
               }
            }
            param3[_loc12_] = _loc7_;
            param1.addTemplate(_loc7_);
            _loc9_++;
         }
      }

      protected static function parseTemplateEntityList(param1:ISkinRenderer, param2:BitmapSkinTemplate, param3:XMLList, param4:Map) : void
      {
         var _loc10_:XML = null;
         var _loc15_:XMLList = null;
         var _loc16_:XML = null;
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc6_:String = null;
         var _loc12_:String = null;
         var _loc9_:String = null;
         var _loc13_:* = 0;
         var _loc14_:Rectangle = null;
         var _loc8_:int = 0;
         var _loc5_:int = param3.length();
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc10_ = param3[_loc8_];
            _loc6_ = _loc10_.attribute("name").toString();
            _loc12_ = String(_loc6_.charAt(0) == "$" ? param4[_loc6_.slice(1,_loc6_.length)] : _loc6_);
            _loc6_ = _loc10_.attribute("type").toString();
            _loc9_ = String(_loc6_.charAt(0) == "$" ? param4[_loc6_.slice(1,_loc6_.length)] : _loc6_);
            _loc6_ = _loc10_.attribute("id").toString();
            _loc13_ = uint(_loc6_.charAt(0) == "$" ? param4[_loc6_.slice(1,_loc6_.length)] : _loc6_);

            if((_loc15_ = _loc10_.child("region")).length() > 0)
            {
               _loc16_ = (_loc15_ = (_loc16_ = _loc15_[0]).child("Rectangle"))[0];
               _loc14_ = new Rectangle();
               _loc6_ = _loc16_.attribute("x").toString();
               _loc14_.x = Number(_loc6_.charAt(0) == "$" ? param4[_loc6_.slice(1,_loc6_.length)] : _loc6_);
               _loc6_ = _loc16_.attribute("y").toString();
               _loc14_.y = Number(_loc6_.charAt(0) == "$" ? param4[_loc6_.slice(1,_loc6_.length)] : _loc6_);
               _loc6_ = _loc16_.attribute("width").toString();
               _loc14_.width = Number(_loc6_.charAt(0) == "$" ? param4[_loc6_.slice(1,_loc6_.length)] : _loc6_);
               _loc6_ = _loc16_.attribute("height").toString();
               _loc14_.height = Number(_loc6_.charAt(0) == "$" ? param4[_loc6_.slice(1,_loc6_.length)] : _loc6_);
            }

            param2.addChild(new BitmapSkinTemplateEntity(_loc12_, _loc9_, _loc13_, _loc14_));
            _loc8_++;
         }
      }

      protected static function parseState(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc6_:XML = null;
         var _loc7_:XMLList = null;
         var _loc10_:Map = null;
         var _loc15_:String = null;
         var _loc14_:Object = null;

         var _loc12_:String = param2.attribute("name").toString();
         if (_loc12_.charAt(0) == "$")
         {
            _loc12_ = String(param4[_loc12_.slice(1)]);
         }

         var _loc11_:String = param2.attribute("layout").toString();
         if (_loc11_.charAt(0) == "$")
         {
            _loc11_ = String(param4[_loc11_.slice(1)]);
         }

         var _loc5_:String = param2.attribute("template").toString();
         if (_loc5_.charAt(0) == "$")
         {
            _loc5_ = String(param4[_loc5_.slice(1)]);
         }

         var _loc8_:ISkinLayout = param3[_loc11_];
         if (_loc8_ == null)
         {
            throw new Error("State " + _loc12_ + " has invalid layout reference " + _loc11_ + "!");
         }

         var _loc9_:XMLList = param2.child("variables");
         if (_loc9_.length() > 0)
         {
            _loc6_ = _loc9_[0];
            _loc7_ = _loc6_.child("variable");
            if (_loc7_.length())
            {
               _loc10_ = new Map();
               class_3540.parseVariableList(_loc7_, _loc10_);
               for (_loc15_ in _loc10_)
               {
                  _loc14_ = _loc10_[_loc15_];
                  if (_loc14_ is String)
                  {
                     var _loc14Str:String = _loc14_ as String;
                     if (_loc14Str.charAt(0) == "$")
                     {
                        _loc14_ = param4[_loc14Str.slice(1)];
                        _loc10_[_loc15_] = _loc14_;
                     }
                  }
               }
            }
         }

         var _loc13_:uint = 0;
         switch (_loc12_)
         {
            case "active":
               _loc13_ = 1;
               break;
            case "default":
               _loc13_ = 0;
               break;
            case "focused":
               _loc13_ = 2;
               break;
            case "disabled":
               _loc13_ = 32;
               break;
            case "hovering":
               _loc13_ = 4;
               break;
            case "pressed":
               _loc13_ = 16;
               break;
            case "selected":
               _loc13_ = 8;
               break;
            case "locked":
               _loc13_ = 64;
               break;
            default:
               throw new Error("Unknown window state: \"" + _loc12_ + "\"!");
         }

         param1.registerLayoutForRenderState(_loc13_, _loc11_);
         param1.registerTemplateForRenderState(_loc13_, _loc5_);
      }
      
      protected static function parseRenderStateList(param1:ISkinRenderer, param2:XML, param3:Dictionary, param4:Map) : void
      {
         var _loc7_:* = 0;
         var _loc6_:XMLList;
         var _loc5_:uint = uint((_loc6_ = param2.child("state")).length());
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            parseState(param1,_loc6_[_loc7_],param3,param4);
            _loc7_++;
         }
      }
   }
}
