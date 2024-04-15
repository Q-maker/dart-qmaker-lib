import 'package:qcmcore/entities/abstract_models.dart';
import 'package:qcmcore/io/qcm_package.dart';
import 'package:qcmcore/models/mixin_utils.dart';
import 'package:qcmcore/models/model_utils.dart';
import 'package:qcmcore/utils/toolkit.dart' as ToolKits;

class Qcm {
  static const String
  PROPOSITION_RANDOMIZATION_TYPE_NEVER = "never",
      PROPOSITION_RANDOMIZATION_TYPE_ALWAYS = "always",
      PROPOSITION_RANDOMIZATION_TYPE_IF_NEEDED = "ifNeeded";
  static const String
  EXTRA_CONSIDER_AS_UNSCORED = "qmaker_consider_as_unscored",
  EXTRA_RATING_POLICY = "qmaker_rating_policy",
  EXTRA_CONTENT_LANGUAGE = "qmaker_content_language",
  EXTRA_ALLOWED_TIME = "qmaker_allowed_time",
  EXTRA_ALLOW_SMART_INPUT = "qmaker_allow_smart_input",
  EXTRA_MAX_SUITABLE_PROPOSITIONS_TO_RENDER = "qmaker_max_suitable_propositions_to_render",//TODO il se pourait que ce soit une property en bon et du forme
  EXTRA_MAX_SUITABLE_TRUE_ANSWERS_TO_RENDER = "qmaker_max_suitable_true_answers_to_render";//TODO il se pourait que ce soit une property en bon et du forme
  static const String TAG = "qcm";

  static const String
  TYPE_AUTO = "auto",
  TYPE_SELECT_EACH = "select_each",
  TYPE_SELECT_ALL = "select_all",
  TYPE_MULTIPLE = "multiple",
  TYPE_SINGLE = "single",
  TYPE_OPEN = "open",//supporte l'evalType=equals|match_patterne
  TYPE_SPEECH_RECOGNITION = "speech_recognition",
  TYPE_PUT_IN_ORDER = "put_in_order",
  TYPE_ENUMERATE_EACH = "enumerate_each",//supporte l'evalType=equals|match_patterne
  TYPE_ENUMERATE_ALL = "enumerate_all",
  TYPE_MATCH_EACH_COLUMN = "match_each_column",
  TYPE_MATCH_ALL_COLUMN = "match_all_column",
  TYPE_FILL_IN_EACH_BLANK = "fill_in_each_blank",//supporte l'evalType=equals|match_patterne//La difference entre enum et fill_in_the_blank: fil_in_the_blank implique que les résultat sont dans un order, enumerate ne nécessite pas que les résultats soit dans l'ordre (elle pourrait aussi faire l'objet d'une inflate de champs a la demande).
  TYPE_FILL_IN_ALL_BLANK = "fill_in_all_blank",
  TYPE_JUMBLED_WORD = "jumbled_word",//TODO plus tard doit être pris en charge avc des View adéquat
  TYPE_JUMBLED_SENTENCE = "jumbled_sentence",
  TYPE_SURROUND_ALL_RIGHT_ZONE = "surround_all_right_zone";//TODO plus tard doit être pris en charge avc des View adéquat

}

class Question extends QcmEntity{
  static const String TAG = "question";

}

class Proposition extends QcmEntity{
  static const String TAG = "proposition";
  static const String
  INPUT_TYPE_DEFAULT = "default",
  INPUT_TYPE_VOICE_RECOGNITION_EXTRA = "voice_recognition",
  INPUT_TYPE_KEYBOARD = "keyboard",
  INPUT_TYPE_DRAWING = "drawing";
  static const String
  EXTRA_OPTIONAL = "qmaker_optional",//true or false
  EXTRA_MOST_SUITABLE_ANSWER = "qmaker_most_suitable",//true or false
  EXTRA_POINTS = "qmaker_points",
  EXTRA_LABEL_INPUT_METHOD = "qmaker_input_method",
  EXTRA_LABEL_INPUT_MASK = "qmaker_input_mask",
  EXTRA_SUCCESSFUL_ANSWER_EXAMPLE = "qmaker_successful_answer_example",
  EXTRA_CLUE_TEXT = "qmaker_clue_text",
  EXTRA_EXPECTED_LABEL_MINIMUM_LEVENSHTEIN_DISTANCE = "qmaker_expected_label_minimum_levenshtein_distance";

  static const String
  EVAL_TYPE_EQUALS = "equals",
  EVAL_TYPE_LABEL_EQUALS = "label_equals",
  EVAL_TYPE_LABEL_MATCH_PATTERN = "label_match_pattern",
  EVAL_TYPE_LABEL_CONTAINS = "label_contains",
  EVAL_TYPE_LABEL_LEVENSHTEIN_DISTANCE = "label_levenshtein_distance",
  EVAL_TYPE_MATH_LABEL_EQUALS = "math_label_equals";

  bool truth = false;
  bool caseSensitive = false;
  String? _evalType;

  String get evalType => _evalType ?? EVAL_TYPE_EQUALS;

  set evalType(String value) {
    _evalType = value;
  }

  @override
  void fillAsModel<T extends QcmEntity>(T qcmEntity) {
    if(qcmEntity is Proposition) {
      truth = qcmEntity.truth;
      caseSensitive = qcmEntity.caseSensitive;
      _evalType = qcmEntity._evalType;
    }
    super.fillAsModel(qcmEntity);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      ...toJson(),
      "truth": truth,
      "caseSensitive": caseSensitive,
      "evalType": evalType
    };
    return json;
  }

}

class Comment extends QcmEntity{

}

abstract class QcmEntity with JsonAble{
  static const String
  TEXT_ENGINE_DEFAULT_EXTRAS = "default",
  TEXT_ENGINE_PLAIN_TEXT_EXTRAS = "plain",
  TEXT_ENGINE_HTML_EXTRAS = "html",
  TEXT_ENGINE_MARKDOWN_EXTRAS = "md",
  TEXT_ENGINE_MATH_FORMULA_LATEX_EXTRAS = "LaTex",
  TEXT_ENGINE_MATH_FORMULA_KATEX_EXTRAS = "KaTex";

  static const String
  TEXT_SCALE_TYPE_FIT_CENTER = "FIT_CENTER",
  TEXT_SCALE_TYPE_CENTER_INSIDE = "CENTER_INSIDE",
  TEXT_SCALE_TYPE_FIT_START = "FIT_START",
  TEXT_SCALE_TYPE_FIT_XY = "FIT_XY",
  TEXT_SCALE_TYPE_FIT_END = "FIT_END",
  TEXT_SCALE_TYPE_CENTER = "CENTER",
  TEXT_SCALE_TYPE_CENTER_CROP = "CENTER_CROP",
  TEXT_SCALE_TYPE_MATRIX = "MATRIX";

  static const String
  EXTRA_CONTENT_LANGUAGE = Qcm.EXTRA_CONTENT_LANGUAGE,
  EXTRA_TEXT_ENGINE = "qmaker_text_engine",
  EXTRA_TEXT_SIZE = "qmaker_text_size",
  EXTRA_IMAGE_SCALE_TYPE = "qmaker_image_scale_type",
  EXTRA_RESOURCE_CONTENT_TYPE_OF_PREFIX = "qmaker_resource_content_type_of_";//image/gif

  String createdAtToString = ToolKits.dateNowFormatted();//System.currentTimeMillis();
  String? updatedAtToString;
  String? label, text;
  final UriMap uriMap = UriMap();//si je doit retirer ceci en final, je doit tester toutes les implications.
  final Map<String, dynamic> extras = {};

  QcmEntity({String? createdAt, this.updatedAtToString, this.label, this.text, UriMap? uriMap, Map<String, dynamic>? extras}){
    updatedAtToString ??= createdAt;
    if(uriMap != null) {
      this.uriMap.addAll(uriMap);
    }
    if(extras != null) {
      this.extras.addAll(extras);
    }
  }

  void fillAsModel<T extends QcmEntity>(T qcmEntity) {
    createdAtToString = qcmEntity.createdAtToString;
    updatedAtToString = qcmEntity.updatedAtToString;
    label = qcmEntity.label;
    text = qcmEntity.text;
    uriMap.addAll(qcmEntity.uriMap);
    extras.addAll(qcmEntity.extras);
  }

  void notifyUpdated() {
    this.updatedAtToString = ToolKits.dateNowFormatted();
  }

  set updatedAt(DateTime? dateTime) {
    updatedAtToString = dateTime == null? null : ToolKits.formatToDateTime(dateTime);
  }

  set createdAt(DateTime dateTime) {
    createdAtToString = ToolKits.formatToDateTime(dateTime);
  }

  DateTime? get updatedAt {
    try {
      return ToolKits.parseDateTime(updatedAtToString!);
    } catch(e) {
      return null;
    }
  }

  DateTime get createdAt {
      return ToolKits.parseDateTime(createdAtToString);
  }

  bool hasExtras() => extras.isNotEmpty;

  @override
  Map<String, dynamic> toJson() {
   Map<String, dynamic> json = {
     "createdAt": createdAtToString,
     "uriMap": uriMap,
     "extras": extras
   };
   if(updatedAtToString != null) {
     json["updatedAt"] = updatedAtToString;
   }
   if(label != null) {
     json["label"] = label;
   }
   if(text != null) {
     json["text"] = text;
   }
   return json;
  }


}

class UriMap extends MapWrapper<String, String> with JsonAble{
  UriMap({Map<String, String>? data}) : super(data ?? <String, String>{});

  _put(String key, String? uri) {
    if(uri!= null) {
      this[key] = uri;
    }else {
      remove(key);
    }
  }

  set image(String? uri){
    _put(Resource.TYPE_IMAGES, uri);
  }

  set sound(String? uri){
    _put(Resource.TYPE_SOUNDS, uri);
  }

  set font(String? uri){
    _put(Resource.TYPE_FONTS, uri);
  }

  set video(String? uri){
    _put(Resource.TYPE_VIDEOS, uri);
  }

  set animation(String? uri){
    _put(Resource.TYPE_ANIMATIONS, uri);
  }

  String? get image => this[Resource.TYPE_IMAGES];

  String? get sound => this[Resource.TYPE_SOUNDS];

  String? get font => this[Resource.TYPE_FONTS];

  String? get video => this[Resource.TYPE_VIDEOS];

  String? get animation => this[Resource.TYPE_ANIMATIONS];

  @override
  Map<String, dynamic> toJson() {
   return this;
  }

}