#include <stdio.h>
#include <fcntl.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <linux/uinput.h>
#include "virtual_controller.h"

int setEventType(int fd, unsigned short eventType)
{
  return ioctl(fd, UI_SET_EVBIT, eventType);
}

int setKeyCode(int fd, unsigned short keyCode)
{
  return ioctl(fd, UI_SET_KEYBIT, keyCode);
}

int setRelCode(int fd, unsigned short relCode)
{
  return ioctl(fd, UI_SET_RELBIT, relCode);
}

int setAbsCode(int fd, unsigned short absCode, int min, int max)
{
  int a = ioctl(fd, UI_SET_ABSBIT, absCode);
  if (a < 0)
    return a;

  struct uinput_abs_setup setup = {
      .code = absCode,
      .absinfo = {
          max = max,
          min = min,
      },
  };

  int b = ioctl(fd, UI_ABS_SETUP, &setup);
  return b;
}

int emitEvent(int fd, unsigned short type, unsigned short code, int value)
{
  struct input_event ie;
  ie.type = type;
  ie.code = code;
  ie.value = value;
  ie.time.tv_sec = 0;
  ie.time.tv_usec = 0;

  return write(fd, &ie, sizeof(ie));
}

int createDevice(int fd, const char *deviceName, unsigned short vendor, unsigned short product)
{
  struct uinput_setup setup;

  memset(&setup, 0, sizeof(setup));
  strcpy(setup.name, deviceName);
  setup.id.bustype = BUS_USB;
  setup.id.vendor = 0x1234;
  setup.id.product = 0x5678;

  int a = ioctl(fd, UI_DEV_SETUP, &setup);
  int b = ioctl(fd, UI_DEV_CREATE);
  sleep(1);

  return a >= 0 && b >= 0 ? 0 : -1;
}

int destroyDevice(int fd)
{
  sleep(1);
  return ioctl(fd, UI_DEV_DESTROY);
}

int openRequest()
{
  return open("/dev/uinput", O_WRONLY, O_NONBLOCK);
}

int closeRequest(int fd)
{
  return close(fd);
}
