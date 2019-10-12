enum CertificateCardType {
  ID,
  DRIVER_LICENSE,
  VEHICLE_LICENSE,
  PASSPORT,
}

class CertificateCard {
  final String title;
  final CertificateCardType type;
  final String number;

  const CertificateCard({this.title, this.type, this.number});
}
