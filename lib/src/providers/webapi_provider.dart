import 'package:dio/dio.dart';

class WebApiProvider {
  static late final String _baseUrl;

  // Setter para configurar la URL base de la API
  static set baseUrl(String url) => _baseUrl = url;

  // Retorna una instancia de Dio configurada con la URL base
  Dio getApiClient() {
    return Dio(BaseOptions(
      baseUrl: _baseUrl,
    ));
  }
}
