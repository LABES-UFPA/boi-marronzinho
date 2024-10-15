import 'package:boi_marronzinho/app/data/models/constants/environment_properties.model.dart';

/// Representing local environment configuration
const EnvironmentProperties LOCAL_ENV = EnvironmentProperties(
  cacheLifespan: 60000, // 1 minute
  endpoint: EndpointProperties(
    projeto: 'https://5337-45-228-141-19.ngrok-free.app/api/v1',
    timeout: 1000,
  ),
);

/// Representing production environment configuration
const EnvironmentProperties PRODUCTION_ENV = EnvironmentProperties(
  cacheLifespan: 300000, // 5 minutes
  endpoint: EndpointProperties(
    projeto: 'https://5337-45-228-141-19.ngrok-free.app/api/v1',
    timeout: 80,
  ),
);
