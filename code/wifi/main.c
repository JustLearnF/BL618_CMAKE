#include "bl618_wifi.h"

void main() {
  board_init();
  printf("WIFI test demo\n");

  bl618_wifi_init();
  bl618_wifi_ap_start("woganjuebudui","suibiannibahaha");
  while (1)
  {
    /* code */
  }
}