///
//  Generated code. Do not modify.
//  source: data_formats.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class NoteMeta extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('NoteMeta', createEmptyInstance: create)
    ..aOS(1, 'title')
    ..hasRequiredFields = false
  ;

  NoteMeta._() : super();
  factory NoteMeta() => create();
  factory NoteMeta.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NoteMeta.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  NoteMeta clone() => NoteMeta()..mergeFromMessage(this);
  NoteMeta copyWith(void Function(NoteMeta) updates) => super.copyWith((message) => updates(message as NoteMeta));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NoteMeta create() => NoteMeta._();
  NoteMeta createEmptyInstance() => create();
  static $pb.PbList<NoteMeta> createRepeated() => $pb.PbList<NoteMeta>();
  @$core.pragma('dart2js:noInline')
  static NoteMeta getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NoteMeta>(create);
  static NoteMeta _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);
}

