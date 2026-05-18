
package inet.node.sdh;

//
// SDH Add-Drop Multiplexer (ADM).
// Capaz de insertar tráfico PDH en una trama SDH y extraer tráfico para entregarlo localmente o reenviarlo.
//
simple SDHADM
{
    parameters:
        int stmLevel = default(1);             // STM-n level (1, 4, 16...)
        int numTributaries = default(1);       // Número de tributarios PDH
        bool allowMixedInsertion = default(false);        
        @display("i=block/routing");
        @class(SDHADM);
        
        //SIGNAL
        @signal[STM_RE];
        @signal[PDH_R];
        @signal[PDH_T];
        
        //STATISTIC
        @statistic[STM_RE](title="STM Reenviadas"; source=STM_RE; record=vector, count);
        @statistic[PDH_R](title="PDH Recibidos"; source=PDH_R; record=vector, count);
        @statistic[PDH_T](title="PDH Transmitidos"; source=PDH_T; record=vector, count);
        
        
    gates:
        input pdhIn[numTributaries];
        output pdhOut[numTributaries];
        input lineIn[];  // Entradas desde otros ADM o LTE
        output lineOut[]; // Salidas hacia otros ADM o LTE
}

