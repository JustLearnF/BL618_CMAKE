#ifndef __BL618_WIFI_H_
#define __BL618_WIFI_H_
#include "stdint.h"
#include "FreeRTOS.h"
#include "task.h"
#include "timers.h"
#include "mem.h"
#include "bflb_irq.h"
#include "bl616_glb.h"
#include "bflb_mtimer.h"
#include "board.h"
#include "bflb_i2c.h"
#include "bflb_cam.h"
#include "bflb_mjpeg.h"

//wifi 头文件
#include <lwip/tcpip.h>
#include <lwip/sockets.h>
#include <lwip/netdb.h>

// #include "export/bl_fw_api.h"
#include "bl_fw_api.h"
#include "wifi_mgmr_ext.h"
#include "wifi_mgmr.h"

//wifi 头文件
#include "bl616_glb.h"
#include "bflb_gpio.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define DBG_TAG "MAIN"
#include "log.h"
#ifdef __BL618_WIFI_C_
#define BL618_WIFI_EXT
#else
#define BL618_WIFI_EXT extern
#endif

#ifndef null
#define null (void *)0
#endif

#ifndef false
#define false (1 == 0)
#endif

#ifndef true
#define true (1 == 1)
#endif

#define BL618_WIFI_STACK_SIZE (1024 * 2)
#define BL618_WIFI_TASK_PRIORITY_FW (25)

// wifi 初始化
BL618_WIFI_EXT void bl618_wifi_init(void);
BL618_WIFI_EXT uint8_t bl618_wifi_connect(char *ssid, char *passwd);
BL618_WIFI_EXT void bl618_wifi_callback_register(void (*bl618_wifi_callback)(void), uint32_t code);
BL618_WIFI_EXT void bl618_wifi_callback_unregister(uint32_t code);
BL618_WIFI_EXT uint8_t bl618_wifi_ap_start(uint8_t *ssid, uint8_t *pwd);
#endif
