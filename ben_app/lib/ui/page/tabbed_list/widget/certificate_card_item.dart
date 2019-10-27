import 'package:ben_app/ui/model/certificate_model.dart';
import 'package:ben_app/util/strings.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class CertificateCardItem extends AbstractDataListItem<CertificateModel> {
  const CertificateCardItem({Key key, CertificateModel model})
      : super(key: key, model: model);

  @override
  String getDescription() {
    return Strings.masking(model.number);
  }

  @override
  ImageProvider getItemIcon() {
    return AssetImage("assets/passport.png");
  }

  @override
  String getSubtitle() {
    switch (model.type) {
      case CertificateType.PASSPORT:
        return "护照";
      case CertificateType.ID:
        return "身份证";
      case CertificateType.DRIVER_LICENSE:
        return "驾驶证";
      case CertificateType.VEHICLE_LICENSE:
        return "行驶证";
    }
    return "";
  }

  @override
  String getTitle() {
    return model.title;
  }
}
