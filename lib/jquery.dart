library tekartik_jquery;

import 'dart:js';
import 'dart:html';
import 'package:tekartik_utils/string_enum.dart';
import 'package:tekartik_utils/js_utils.dart';
import 'package:pub_semver/pub_semver.dart';

part 'src/jobject_base.dart';
part 'src/jelement.dart';
part 'src/jobject_element.dart';
part 'src/jelementlist.dart';
part 'src/jeffects.dart';

Version get jQueryVersionMin => new Version(2, 1, 4);
Version get jQueryVersionDefault => new Version(2, 1, 4);

JsObject _querySelector(String selector) {
  return _callJQuery([selector]);
}

JsObject _callJQuery(List args) {
  return context.callMethod('jQuery', args);
}

/**
 * used to version
 */
//dynamic __callJQuery(List args) {
//  return context.callMethod('jQuery', args);
//}

@deprecated
JsObject queryElement(Element element) {
  return _queryElement(element);
}

JsObject get jsDocument {
  return _callJQuery([document]);
}

JsObject jsElement(Element element) {
  return _queryElement(element);
}

JsObject _queryElement(Element element) {
  return _callJQuery([element]);
}

JsObject _queryElementList(List<Element> elements) {
  JsObject jsObject = _callJQuery([]); // Notice the enclosed empty array
  //devPrint(jsObjectToDebugString(jsObject));

  // jsObject = jsObject.callMethod('add', elements);
  // as of 2014-06-05 this is the best solutions as above does not work
  elements.forEach((Element element) {
    jsObject = jsObject.callMethod('add', [element]);
    //devPrint(jsObjectToDebugString(jsObject));
  });
  return jsObject;
}

class JQuery {
  JsObject _jsObject;
  JsObject get jsObject => _jsObject;
  JQuery._(this._jsObject);

  Version _version;
  Version get version {
    if (_version == null) {
      _version = new Version.parse(fn('jquery'));
    }
    return _version;
  }

  fn(Object key) => _jsObject['fn'][key];
  operator [](Object key) => _jsObject[key];

}

JQuery _jQuery;

JsObject get _jsQuery => context['jQuery'];

/**
 * raw js jQuery object
 * only to use to test if jquery is loaded
 */
@deprecated
JsObject get jsQuery => _jsQuery;

JQuery get jQuery {
  if (_jQuery == null) {
    _jQuery = new JQuery._(_jsQuery);
    if (_jQuery._jsObject == null) {
      throw("Missing jQuery");
    }
    // test version
    var versionMin = jQueryVersionMin;
    if (_jQuery.version < jQueryVersionMin) {
      throw("jquery: invalid jQuery version '${_jQuery.version}' expected min $versionMin");
    }
  }
  return _jQuery;
}


JElement jQuerySelector(String selector) {
  return new JElement(_querySelector(selector));
}

JElementList jQuerySelectorAll(String selector) {
  return new JElementList(_querySelector(selector));
}

/*
JObjectElement jQueryElement(Element element) {
  return new JObjectElement(_queryElement(element));
}
*/

JElement jElement(Element element) {
  return new JElement(_queryElement(element));
}

JElementList jElementList(List<Element> elements) {
  return new JElementList(_queryElementList(elements));
}

// e.g. 2.1.0
@deprecated
String get jQueryVersion => context['jQuery']['fn']['jquery'];
