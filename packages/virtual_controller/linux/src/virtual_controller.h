int setEventType(int fd, unsigned short eventType);
int setKeyCode(int fd, unsigned short keyCode);
int setRelCode(int fd, unsigned short relCode);
int setAbsCode(int fd, unsigned short absCode, int min, int max);
int emitEvent(int fd, unsigned short type, unsigned short code, int value);
int createDevice(int fd, const char *deviceName, unsigned short vendor, unsigned short product);
int destroyDevice(int fd);
int openRequest();
int closeRequest(int fd);