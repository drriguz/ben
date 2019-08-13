import '../entity/tables.dart';

abstract class AbstractRepository {
  Future<List<MetaDataEntity>> getMetaDatas();

  Future<void> createOrUpdateMetaData(final MetaDataEntity entity);

  Future<void> deleteMetaData(final MetaDataEntity entity);

  Future<List<SecretDataEntity>> getSecrets();

  Future<List<SecretDataEntity>> getSecretsByType(final DataType type);

  Future<void> createSecretData(final SecretDataEntity entity);

  Future<void> updateSecretData(final int id, final SecretDataEntity entity);

  Future<void> deleteSecretData(final SecretDataEntity entity);
}
