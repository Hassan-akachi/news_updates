class QP{
  const QP._();
 //query parameter is built
  static Map<String ,String> apiQP({ required String apiKey, required String country}) =>{
    "country" : country,
    "apiKey" : apiKey
  };
}