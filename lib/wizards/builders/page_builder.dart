import 'package:eliud_core_model/model/app_bar_model.dart';
import 'package:eliud_core_model/model/app_model.dart';
import 'package:eliud_core_model/model/drawer_model.dart';
import 'package:eliud_core_model/model/home_menu_model.dart';

class PageBuilder {
  final String uniqueId;
  final String pageId;
  final AppModel app;
  final String memberId;
  final HomeMenuModel theHomeMenu;
  final AppBarModel theAppBar;
  final DrawerModel leftDrawer;
  final DrawerModel rightDrawer;

  PageBuilder(
    this.uniqueId,
    this.pageId,
    this.app,
    this.memberId,
    this.theHomeMenu,
    this.theAppBar,
    this.leftDrawer,
    this.rightDrawer,
  );
}
