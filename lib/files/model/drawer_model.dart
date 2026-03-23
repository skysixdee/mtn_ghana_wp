class DrawerModel {
  String title;
  String routeName;
  bool isContainSubMenu;
  bool isDevider;

  DrawerModel(this.title, this.routeName,
      {this.isContainSubMenu = false, this.isDevider = false});
}
