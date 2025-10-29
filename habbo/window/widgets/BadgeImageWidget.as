package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.class_3501;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.habbo.window.enum.class_3550;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.incoming.users.GroupDetailsChangedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   
   public class BadgeImageWidget implements IBadgeImageWidget
   {
      
      public static const TYPE:String = "badge_image";
      
      private static const const_743:String = "badge_image:type";
      
      private static const const_1198:String = "badge_image:badge_id";
      
      private static const TYPE_DEFAULT:PropertyStruct = new PropertyStruct("badge_image:type","normal","String",false,class_3550.ALL);
      
      private static const ID_DEFAULT:PropertyStruct = new PropertyStruct("badge_image:badge_id","","String");
       
      
      private var _disposed:Boolean;
      
      private var var_1759:IWidgetWindow;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_3089:Boolean;
      
      private var var_509:IWindowContainer;
      
      private var _bitmap:IStaticBitmapWrapperWindow;
      
      private var var_1819:IRegionWindow;
      
      private var var_329:String;
      
      private var var_372:String;
      
      private var _groupId:int;
      
      private var var_3396:GroupDetailsChangedMessageEvent;
      
      private var var_2920:HabboGroupBadgesMessageEvent;
      
      public function BadgeImageWidget(param1:IWidgetWindow, param2:HabboWindowManagerComponent)
      {
         var_329 = String(TYPE_DEFAULT.value);
         var_372 = String(ID_DEFAULT.value);
         super();
         var_1759 = param1;
         _windowManager = param2;
         var_509 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("badge_image_xml").content as XML) as IWindowContainer;
         _bitmap = var_509.findChildByName("bitmap") as IStaticBitmapWrapperWindow;
         var_1819 = var_509.findChildByName("region") as IRegionWindow;
         var_1819.addEventListener("WME_CLICK",onClick);
         var_1759.rootWindow = var_509;
         var_509.width = var_1759.width;
         var_509.height = var_1759.height;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            groupId = 0;
            if(var_1819 != null)
            {
               var_1819.removeEventListener("WME_CLICK",onClick);
               var_1819.dispose();
               var_1819 = null;
            }
            _bitmap = null;
            if(var_509 != null)
            {
               var_509.dispose();
               var_509 = null;
            }
            if(var_1759 != null)
            {
               var_1759.rootWindow = null;
               var_1759 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc2_:Array = [];
         if(_disposed)
         {
            return _loc2_;
         }
         _loc2_.push(TYPE_DEFAULT.withValue(var_329));
         _loc2_.push(ID_DEFAULT.withValue(var_372));
         for each(var _loc1_ in _bitmap.properties)
         {
            if(_loc1_.key != "asset_uri")
            {
               _loc2_.push(_loc1_.withNameSpace("badge_image"));
            }
         }
         return _loc2_;
      }
      
      public function set properties(param1:Array) : void
      {
         var_3089 = true;
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "badge_image:type":
                  type = String(_loc2_.value);
                  break;
               case "badge_image:badge_id":
                  badgeId = String(_loc2_.value);
            }
            if(_loc2_.key != "badge_image:asset_uri")
            {
               _loc3_.push(_loc2_.withoutNameSpace());
            }
         }
         _bitmap.properties = _loc3_;
         var_3089 = false;
         refresh();
      }
      
      public function get type() : String
      {
         return var_329;
      }
      
      public function set type(param1:String) : void
      {
         var_329 = param1;
         refresh();
      }
      
      public function get badgeId() : String
      {
         return var_372;
      }
      
      public function set badgeId(param1:String) : void
      {
         var_372 = param1;
         refresh();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
         var _loc2_:Boolean = var_329 == "group" && _groupId > 0;
         if(_windowManager != null && _windowManager.communication != null)
         {
            if(!_loc2_ && var_2920 != null)
            {
               _windowManager.communication.removeHabboConnectionMessageEvent(var_3396);
               _windowManager.communication.removeHabboConnectionMessageEvent(var_2920);
               var_3396 = null;
               var_2920 = null;
            }
            else if(_loc2_ && var_2920 == null)
            {
               var_3396 = new GroupDetailsChangedMessageEvent(onGroupDetailsChanged);
               var_2920 = new HabboGroupBadgesMessageEvent(onHabboGroupBadges);
               _windowManager.communication.addHabboConnectionMessageEvent(var_3396);
               _windowManager.communication.addHabboConnectionMessageEvent(var_2920);
            }
         }
      }
      
      public function get bitmapData() : BitmapData
      {
         return class_3501(_bitmap).bitmapData;
      }
      
      public function get pivotPoint() : uint
      {
         return _bitmap.pivotPoint;
      }
      
      public function set pivotPoint(param1:uint) : void
      {
         _bitmap.pivotPoint = param1;
         _bitmap.invalidate();
      }
      
      public function get stretchedX() : Boolean
      {
         return _bitmap.stretchedX;
      }
      
      public function set stretchedX(param1:Boolean) : void
      {
         _bitmap.stretchedX = param1;
         _bitmap.invalidate();
      }
      
      public function get stretchedY() : Boolean
      {
         return _bitmap.stretchedY;
      }
      
      public function set stretchedY(param1:Boolean) : void
      {
         _bitmap.stretchedY = param1;
         _bitmap.invalidate();
      }
      
      public function get zoomX() : Number
      {
         return _bitmap.zoomX;
      }
      
      public function set zoomX(param1:Number) : void
      {
         _bitmap.zoomX = param1;
         _bitmap.invalidate();
      }
      
      public function get zoomY() : Number
      {
         return _bitmap.zoomY;
      }
      
      public function set zoomY(param1:Number) : void
      {
         _bitmap.zoomY = param1;
         _bitmap.invalidate();
      }
      
      public function get greyscale() : Boolean
      {
         return _bitmap.greyscale;
      }
      
      public function set greyscale(param1:Boolean) : void
      {
         _bitmap.greyscale = param1;
         _bitmap.invalidate();
      }
      
      public function get etchingColor() : uint
      {
         return _bitmap.etchingColor;
      }
      
      public function set etchingColor(param1:uint) : void
      {
         _bitmap.etchingColor = param1;
         _bitmap.invalidate();
      }
      
      public function get fitSizeToContents() : Boolean
      {
         return _bitmap.fitSizeToContents;
      }
      
      public function set fitSizeToContents(param1:Boolean) : void
      {
         _bitmap.fitSizeToContents = param1;
         _bitmap.invalidate();
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(_groupId > 0)
         {
            _windowManager.communication.connection.send(new GetHabboGroupDetailsMessageComposer(_groupId,true));
         }
      }
      
      private function refresh() : void
      {
         if(var_3089)
         {
            return;
         }
         _bitmap.assetUri = assetUri;
         _bitmap.invalidate();
      }
      
      private function get assetUri() : String
      {
         var _loc1_:String = "";
         if(var_372 != null && var_372.length > 0)
         {
            switch(var_329)
            {
               case "normal":
                  _loc1_ = "${image.library.url}album1584/" + var_372 + ".png";
                  break;
               case "group":
                  _loc1_ = _windowManager.getProperty("group.badge.url").replace("%imagerdata%",var_372);
                  break;
               case "perk":
                  _loc1_ = "${image.library.url}perk/" + var_372 + ".png";
            }
         }
         return _loc1_;
      }
      
      private function forceRefresh(param1:int, param2:String) : void
      {
         if(param1 != _groupId)
         {
            return;
         }
         var_372 = param2;
         _windowManager.resourceManager.removeAsset(assetUri);
         refresh();
      }
      
      private function onGroupDetailsChanged(param1:GroupDetailsChangedMessageEvent) : void
      {
         forceRefresh(param1.groupId,var_372);
      }
      
      private function onHabboGroupBadges(param1:HabboGroupBadgesMessageEvent) : void
      {
         if(param1.badges.hasKey(_groupId))
         {
            forceRefresh(_groupId,param1.badges[_groupId]);
         }
      }
      
      public function get etchingPoint() : Point
      {
         return new Point(0,1);
      }
      
      public function get wrapX() : Boolean
      {
         return false;
      }
      
      public function set wrapX(param1:Boolean) : void
      {
      }
      
      public function get wrapY() : Boolean
      {
         return false;
      }
      
      public function set wrapY(param1:Boolean) : void
      {
      }
      
      public function get rotation() : Number
      {
         return 0;
      }
      
      public function set rotation(param1:Number) : void
      {
      }
   }
}
