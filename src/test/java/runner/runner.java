package runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Runner de JUnit 5 que descubre y ejecuta todos los .feature de classpath:features.
 *
 * - parallel(1): ejecución SERIAL. Las pruebas modifican el estado remoto del
 *   torniquete y el historial del dron; en paralelo se interferirían entre sí.
 * - reportDir: reportes HTML de Karate en target/karate-reports.
 * - outputCucumberJson: genera los JSON compatibles con Cucumber (trazabilidad).
 * - El filtro por tag llega por -Dkarate.options="--tags @Issue-N" (ver build.gradle).
 */
public class runner {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:features")
                .reportDir("target/karate-reports")
                .outputCucumberJson(true)
                .parallel(1);

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
