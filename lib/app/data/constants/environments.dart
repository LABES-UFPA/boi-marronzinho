import 'package:boi_marronzinho/app/data/models/constants/environment_properties.model.dart';

const EnvironmentProperties LOCAL_ENV = EnvironmentProperties(
  cacheLifespan: 60000,
  endpoint: EndpointProperties(
    projeto: 'https://f17c-45-228-141-19.ngrok-free.app/api/v1',
    minio: 'https://38c4-45-228-141-19.ngrok-free.app',
    timeout: 1000,
  ),
);

const EnvironmentProperties PRODUCTION_ENV = EnvironmentProperties(
  cacheLifespan: 300000,
  endpoint: EndpointProperties(
    projeto: 'https://5337-45-228-141-19.ngrok-free.app/api/v1',
    minio: 'https://38c4-45-228-141-19.ngrok-free.app',
    timeout: 80,
  ),
);
