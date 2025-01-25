import 'package:get/get.dart';
import 'package:scanpackage/translations/en.dart';
import 'package:scanpackage/translations/es.dart';


class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': En.values,
        'es': Es.values,
      };
}
