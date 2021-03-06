#property version   "1.00"
#property strict

#include <websockets.mqh>

input string   Host = "http://localhost:8080";
input int      HeatBeatPeriod = 45;

int commandPingMilliseconds = 20;

int OnInit() {

  WS_SetHeader( "account", AccountNumber() );
  WS_Init(Host , HeatBeatPeriod );  
  WS_SendCommand( "test" + GetTickCount() );

  EventSetMillisecondTimer(commandPingMilliseconds);
  
  return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
  EventKillTimer();
  Deinit();
}

void OnTick() {

}

void OnTimer() {
  string cmd = WS_GetCommand();

  if(cmd != "") {
    Print("cmd: " + cmd);
    WS_SendCommand( "test" + GetTickCount() );
  }
  
//  Print("sending command");
//  WS_SendCommand( "test" + GetTickCount() );
}