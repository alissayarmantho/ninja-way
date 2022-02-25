import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlController extends GetxController {
  Future<void> openNavigationMap(
      double oriLat, double oriLong, double destLat, double destLong) async {
    var url =
        'https://www.google.com/maps/dir/?api=1&origin=$oriLat,$oriLong&destination=$destLat,$destLong&travelmode=driving&dir_action=navigate';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
  }
}
