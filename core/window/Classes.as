package com.sulake.core.window
{
   import com.sulake.core.window.components.*;
   import flash.utils.Dictionary;
   
   public class Classes
   {
      
      protected static var var_1636:Dictionary;
       
      
      public function Classes()
      {
         super();
      }
      
      public static function init() : void
      {
         if(!var_1636)
         {
            var_1636 = new Dictionary();
            var_1636[0] = WindowController;
            var_1636[40] = ActivatorController;
            var_1636[2] = BackgroundController;
            var_1636[30] = BorderController;
            var_1636[17] = BoxSizerController;
            var_1636[45] = BubbleController;
            var_1636[46] = WindowController;
            var_1636[47] = WindowController;
            var_1636[48] = WindowController;
            var_1636[49] = WindowController;
            var_1636[60] = ButtonController;
            var_1636[61] = ButtonController;
            var_1636[67] = SelectableButtonController;
            var_1636[68] = SelectableButtonController;
            var_1636[69] = SelectableButtonController;
            var_1636[21] = BitmapWrapperController;
            var_1636[70] = CheckBoxController;
            var_1636[4] = ContainerController;
            var_1636[41] = ContainerButtonController;
            var_1636[72] = CloseButtonController;
            var_1636[20] = DisplayObjectWrapperController;
            var_1636[76] = ScrollBarLiftController;
            var_1636[102] = DropMenuController;
            var_1636[103] = DropMenuItemController;
            var_1636[105] = DropListController;
            var_1636[106] = DropListItemController;
            var_1636[15] = FormattedTextController;
            var_1636[35] = FrameController;
            var_1636[6] = HeaderController;
            var_1636[11] = HTMLTextController;
            var_1636[1] = IconController;
            var_1636[79] = IconButtonController;
            var_1636[50] = ItemListController;
            var_1636[51] = ItemListController;
            var_1636[50] = ItemListController;
            var_1636[52] = ItemGridController;
            var_1636[54] = ItemGridController;
            var_1636[53] = ItemGridController;
            var_1636[12] = TextLabelController;
            var_1636[14] = TextLinkController;
            var_1636[78] = PasswordFieldController;
            var_1636[71] = RadioButtonController;
            var_1636[5] = RegionController;
            var_1636[120] = ScalerController;
            var_1636[130] = ScrollBarController;
            var_1636[131] = ScrollBarController;
            var_1636[139] = ButtonController;
            var_1636[137] = ButtonController;
            var_1636[138] = ButtonController;
            var_1636[136] = ButtonController;
            var_1636[132] = ScrollBarLiftController;
            var_1636[133] = ScrollBarLiftController;
            var_1636[134] = WindowController;
            var_1636[135] = WindowController;
            var_1636[56] = ScrollableItemListWindow;
            var_1636[140] = ScrollableItemGridWindow;
            var_1636[42] = SelectorController;
            var_1636[43] = SelectorListController;
            var_1636[23] = StaticBitmapWrapperController;
            var_1636[93] = TabButtonController;
            var_1636[94] = TabContainerButtonController;
            var_1636[90] = ContainerController;
            var_1636[91] = TabContextController;
            var_1636[92] = SelectorListController;
            var_1636[10] = TextController;
            var_1636[77] = TextFieldController;
            var_1636[8] = ToolTipController;
            var_1636[16] = WidgetWindowController;
         }
      }
      
      public static function getWindowClassByType(param1:uint) : Class
      {
         return var_1636[param1];
      }
   }
}
