/**
 * @brief High resolution sleep.
 *
 * http://pubs.opengroup.org/onlinepubs/9699919799/functions/nanosleep.html
 *
 * @note rmtp is ignored, as signals are not implemented.
 */
#ifdef __cplusplus
extern "C" {
#endif

int _nanosleep( const struct timespec * rqtp, struct timespec * rmtp );
int _vTaskDelay( const TickType_t xTicksToDelay );
time_t _time( time_t * tloc );
int32_t setPref(const char *domain, const char *key, uint8_t type, uint8_t *value, size_t byteCount);
int32_t initPref(const char * ns);
int32_t clearPref(const char * ns);
int32_t getPref_u32(const char *domain, const char *key, uint8_t type, uint32_t *val);
int32_t getPref_str(const char *domain, const char *key, uint8_t type, char * buf, size_t *outLen);
#ifdef __cplusplus
}
#endif
