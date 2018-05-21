include "common.iol"
include "console.iol"

outputPort Calculator {
  Location: "datagram://localhost:8000"
  Protocol: coap { 
    .osc.sum << { 
      .contentFormat = "json",
      .messageType = "CON",
      .messageCode = "POST"
    }
  }
  Interfaces: CalculatorInterface
}

// outputPort Calculator {
//  Location: "socket://localhost:1883"
//  Protocol: mqtt {
//   .osc.sum << {
//    .format = "json",
//    .QoS = 2, // exactly once QoS
//    .alias = "myReq/sum",
//    .aliasResponse = "myRes/sum"
//   }
//  }
//  Interfaces: CalculatorInterface
// }
 
main
{
  root.x = 17;
  root.y = 25;
  sum@Calculator( root )( sum );
	println@Console( "sum: " + sum )()
}