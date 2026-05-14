//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package inet.node.sdh.p2pNetworkExtended;

import inet.node.sdh.SDHLTE;
import inet.node.sdh.PDHSource;
import inet.node.sdh.PDHSink;

//
// Bidirectional SDH network: each LTE has a source and a sink connected to it.
//
network p2pNetworkExtended
{
    types:
        channel FiberLine extends ned.DatarateChannel
        {
            parameters:
                datarate = default(155.52Mbps);
                delay = 2us;
                @display("m=arrow,ls=blue,2");
        }

    submodules:
        sourceA: PDHSource {
            @display("p=80,138");
        }

        sinkA: PDHSink {
            @display("p=80,239");
        }

        lteA: SDHLTE {
            parameters:
                stmLevel = default(1);
                numTributaries = default(1);
                useProtection = default(false);
                @display("p=300,200");
        }

        lteB: SDHLTE {
            parameters:
                stmLevel = default(1);
                numTributaries = default(1);
                useProtection = default(false);
                @display("p=500,200");
        }

        sourceB: PDHSource {
            @display("p=700,150");
        }

        sinkB: PDHSink {
            @display("p=700,250");
        }

        sourceA2: PDHSource {
            @display("p=176,77");
        }

        sinkA1: PDHSink {
            @display("p=153,273");
        }

        sourceB1: PDHSource {
            @display("p=649,77");
        }

        sinkB1: PDHSink {
            @display("p=619,312");
        }

    connections allowunconnected:
        sourceA.out --> lteA.pdhIn++;
        lteA.lineOut++ --> FiberLine --> lteB.lineIn++;  // Línea operativa
        lteA.lineOut++ --> FiberLine --> lteB.lineIn++;  // Línea de protección
        lteB.pdhOut++ --> sinkB.in;

        sourceB.out --> lteB.pdhIn++;
        lteB.lineOut++ --> FiberLine --> lteA.lineIn++;  // Línea operativa inversa
        lteB.lineOut++ --> FiberLine --> lteA.lineIn++;  // Línea de protección inversa
        lteA.pdhOut++ --> sinkA.in;

        sourceA2.out --> lteA.pdhIn++;
        lteA.pdhOut++ --> sinkA1.in;

        lteB.pdhOut++ --> sinkB1.in;

        sourceB1.out --> lteB.pdhIn++;
}
