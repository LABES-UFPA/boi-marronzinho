import 'package:boi_marronzinho/app/data/models/constants/environment_properties.model.dart';

const EnvironmentProperties LOCAL_ENV = EnvironmentProperties(
  cacheLifespan: 60000,
  endpoint: EndpointProperties(
    projeto: 'https://c796-45-228-141-7.ngrok-free.app/api/v1',
    minio: 'https://0b88-45-228-141-7.ngrok-free.app',
    timeout: 1000,
  ),
);

const EnvironmentProperties PRODUCTION_ENV = EnvironmentProperties(
  cacheLifespan: 300000,
  endpoint: EndpointProperties(
    projeto: 'https://c796-45-228-141-7.ngrok-free.app/api/v1',
    minio: 'https://0b88-45-228-141-7.ngrok-free.app',
    timeout: 80,
  ),
);
