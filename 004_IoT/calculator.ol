include "common.iol"
include "console.iol"

// "http://localhost:8080/sum?x=5&y=6"

inputPort In {
  Location: "datagram://localhost:8000"
  Protocol: coap {
    .osc.sum.contentFormat = "json"
  }
  Interfaces: CalculatorInterface
}

inputPort In2 {
 Location: "socket://localhost:9000"
 Protocol: mqtt {
  .broker = "socket://localhost:1883";
  .osc.sum << {
   .format = "json",
   .QoS = 2, // exactly once QoS
   .alias = "myReq/sum",
   .aliasResponse = "myRes/sum"
  }
 }
 Interfaces: CalculatorInterface
}





main
{
  sum( a )( b ){
    println@Console( a.x + " + " + a.y )();
    b = a.x + a.y
  }
}
