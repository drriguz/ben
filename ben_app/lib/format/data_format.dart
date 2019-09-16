/*
  <masterPassword>       = 1125482715
  <masterPasswordHash>   = sha256(sha256(<masterPassword>))
  <transformedMasterKey> = argon2d(2, 1024, <masterPasswordHash>, <transformSeed>)
  <headerHashKey>        = sha512(<masterSeed> + <transformedMasterKey>)
  <itemHashKey>          = sha512(<itemId> + <transformedMasterKey>)
 */
import 'dart:typed_data';

abstract class Header {
  int _type;
  String _value;

  int get type => _type;

  String get value => _value;
}

abstract class Item {
  String _id;
  int _type;
  Uint8List _content;
  Uint8List _checksum;

  String get id => _id;

  int get type => _type;

  Uint8List get content => _content;

  Uint8List get checksum => _checksum;
}
