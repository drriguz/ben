import 'package:ben_app/plugins/bank_card/bank_card.dart';
import 'package:ben_app/plugins/certificate/certificate_card.dart';
import 'package:ben_app/util/strings.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class CertificateCardItem extends GeneralIconItem<CertificateCard> {
  const CertificateCardItem({Key key, CertificateCard model})
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
      case CertificateCardType.PASSPORT:
        return "护照";
      case CertificateCardType.ID:
        return "身份证";
      case CertificateCardType.DRIVER_LICENSE:
        return "驾驶证";
      case CertificateCardType.VEHICLE_LICENSE:
        return "行驶证";
    }
    return "";
  }

  @override
  String getTitle() {
    return model.title;
  }
}
