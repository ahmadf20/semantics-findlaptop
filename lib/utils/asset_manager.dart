class AssetManager {
  static String getBrandIcon(String brandName) {
    late String icon = '';

    if (brandName != "Vero") {
      icon = brandName.toLowerCase();
    } else {
      icon = 'chuwi';
    }

    return 'assets/icons/icon-$icon.png';
  }
}
