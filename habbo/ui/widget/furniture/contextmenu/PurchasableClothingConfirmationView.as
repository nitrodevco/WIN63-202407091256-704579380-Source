package com.sulake.habbo.ui.widget.furniture.contextmenu
{
    import assets.class_14

    import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.habbo.communication.messages.outgoing.register.class_675;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.CustomizeAvatarWithFurniMessageComposer;
   
   public class PurchasableClothingConfirmationView implements IDisposable
   {
      
      private static const PRODUCT_PAGE_UKNOWN:int = -1;
      
      private static const PRODUCT_PAGE_CLOTHING:int = 0;
      
      private static const const_533:String = "header_button_close";
      
      private static const const_560:String = "save_button";
      
      private static const const_613:String = "cancel_text";
      
      private static const const_510:String = "ok_button";
      
      private static const const_700:String = "avatar_preview";
       
      
      private var _window:IWindowContainer;
      
      private var var_318:Boolean = false;
      
      private var var_1629:FurnitureContextMenuWidget;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assets:IAssetLibrary;
      
      private var var_3490:int = -1;
      
      private var var_2047:class_3365;
      
      private var _newFigureString:String;
      
      public function PurchasableClothingConfirmationView(param1:FurnitureContextMenuWidget)
      {
         super();
         var_1629 = param1;
         _windowManager = param1.windowManager;
         _assets = var_1629.assets;
      }
      
      public function dispose() : void
      {
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function open(param1:int) : void
      {
         var _loc7_:Array = null;
         var _loc5_:int = var_1629.handler.roomSession.roomId;
         var _loc6_:IRoomObject;
         if((_loc6_ = var_1629.handler.roomEngine.getRoomObject(_loc5_,param1,10)) != null)
         {
            var_2047 = var_1629.handler.getFurniData(_loc6_);
            var_3490 = _loc6_.getId();
            var _loc3_:int = -1;
            var _loc2_:Vector.<int> = new Vector.<int>(0);
            switch(var_2047.category - 23)
            {
               case 0:
                  _loc3_ = 0;
                  _loc7_ = var_2047.customParams.split(",");
                  for each(var _loc4_ in _loc7_)
                  {
                     if(var_1629.handler.container.avatarRenderManager.isValidFigureSetForGender(parseInt(_loc4_),var_1629.handler.container.sessionDataManager.gender))
                     {
                        _loc2_.push(parseInt(_loc4_));
                     }
                  }
                  break;
               default:
                  class_14.log("[PurchasableClothingConfirmationView.open()] Unsupported furniture category: " + var_2047.category);
            }
            _newFigureString = var_1629.handler.container.avatarRenderManager.getFigureStringWithFigureIds(var_1629.handler.container.sessionDataManager.figure,var_1629.handler.container.sessionDataManager.gender,_loc2_);
            if(var_1629.handler.container.inventory.hasBoundFigureSetFurniture(var_2047.className))
            {
               var_1629.handler.container.connection.send(new class_675(_newFigureString,var_1629.handler.container.sessionDataManager.gender));
            }
            else
            {
               setWindowContent(_loc3_);
               _window.visible = true;
            }
            return;
         }
      }
      
      private function setWindowContent(param1:int) : void
      {
         var _loc3_:String = null;
         var_1629.localizations.registerParameter("useproduct.widget.title.bind_clothing","name",var_2047.localizedName);
         if(!_window)
         {
            _loc3_ = "use_product_widget_frame_plant_seed_xml";
            _window = _windowManager.buildFromXML(_assets.getAssetByName(_loc3_).content as XML) as IWindowContainer;
            addClickListener("header_button_close");
            _window.center();
         }
         _window.caption = "${useproduct.widget.title.bind_clothing}";
         var_1629.localizations.registerParameter("useproduct.widget.text.bind_clothing","productName",var_2047.localizedName);
         var _loc2_:class_3514 = _window as class_3514;
         _loc2_.content.removeChildAt(0);
         var _loc4_:IWindowContainer = createWindow(param1);
         _loc2_.content.addChild(_loc4_);
         switch(param1)
         {
            case 0:
               addClickListener("save_button");
               addClickListener("cancel_text");
               refreshAvatar();
               _window.invalidate();
               return;
            default:
               throw new Error("Invalid type for use product confirmation content apply: " + param1);
         }
      }
      
      private function createWindow(param1:int) : IWindowContainer
      {
         var _loc2_:IAsset = null;
         var _loc3_:* = null;
         switch(param1)
         {
            case 0:
               _loc2_ = _assets.getAssetByName("use_product_controller_purchasable_clothing_xml");
               return _windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
            default:
               throw new Error("Invalid type for view content creation: " + param1);
         }
      }
      
      private function refreshAvatar() : void
      {
         var _loc1_:IWidgetWindow = IWidgetWindow(_window.findChildByName("avatar_preview"));
         var _loc2_:IAvatarImageWidget = IAvatarImageWidget(_loc1_.widget);
         _loc2_.figure = _newFigureString;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",onMouseClick);
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_text":
            case "ok_button":
               close();
               break;
            case "save_button":
               var_1629.handler.container.connection.send(new CustomizeAvatarWithFurniMessageComposer(var_3490));
               var_1629.handler.container.connection.send(new class_675(_newFigureString,var_1629.handler.container.sessionDataManager.gender));
               close();
         }
      }
   }
}
