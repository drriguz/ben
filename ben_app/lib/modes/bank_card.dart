/**
 * Ref:https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?cardNo=6222005865412565805&cardBinCheck=true
 */
enum CardType {
  DEBIT,
  CREDIT,
}

class BankCard {
  final String bank;
  final String title;
  final CardType type;
  final String number;

  const BankCard({this.bank, this.title, this.type, this.number});
}
