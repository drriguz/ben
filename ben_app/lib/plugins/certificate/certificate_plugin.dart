import 'package:ben_app/plugins/abstract_plugin.dart';
import 'package:ben_app/plugins/certificate/certificate_model.dart';
import 'package:flutter/material.dart';

class CertificatePlugin extends AbstractPlugin<CertificateModel> {
  CertificatePlugin(int pluginId)
      : super(pluginId, "证件", (_) => CertificateModel.fromMap(_));
}
