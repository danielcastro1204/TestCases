function fn() {
    // URL base del backend del taller. Puede sobrescribirse sin tocar el código:
    //   ./gradlew test -DbaseUrl=http://localhost:8080/api/
    var baseUrl = karate.properties['baseUrl']
        || 'https://taller-de-tecnicas-de-prueba-de-caja.onrender.com/api/';

    var config = {
        env: karate.env || 'dev',
        baseUrl: baseUrl
    };

    // Render (plan gratuito) puede tardar en "despertar" tras inactividad:
    // se usan tiempos de espera amplios para no confundir arranque en frío con un fallo.
    karate.configure('connectTimeout', 30000);
    karate.configure('readTimeout', 60000);

    // Simplifica y formatea el JSON de requests y responses en el reporte
    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);

    return config;
}
