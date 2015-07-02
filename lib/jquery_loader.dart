library tekartik_jquery_loader;

import 'package:tekartik_utils/js_utils.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:tekartik_jquery/jquery.dart';
import 'dart:async';
import 'jquery.dart';

Future<JQuery> loadJQuery({Version version}) async {
  if (version == null) {
    version = jQueryVersionDefault;
  }

  // already loaded?
  if (jsQuery != null) {
    if (jQuery.version < version) {
      throw("jQuery version expected $version but currently loaded is ${jQuery.version}");
    }
    return jQuery;
  }

  // load jquery
  // for 2.1.0 await loadJavascriptScript("packages/tekartik_jquery_asset/jquery/$version/jquery-$version.min.js");
  await loadJavascriptScript("packages/tekartik_jquery_asset/$version/jquery-$version.min.js");
  return jQuery;
}
