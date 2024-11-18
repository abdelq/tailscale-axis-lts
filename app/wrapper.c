#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    openlog("tailscaled", LOG_PID | LOG_CONS, LOG_USER);

    int exit_code = EXIT_SUCCESS;
    if (execv("lib/tailscaled", argv) == -1) {
        syslog(LOG_ERR, "Failed to execute tailscaled: %s", strerror(errno));
        exit_code = EXIT_FAILURE;
    }

    closelog();
    return exit_code;
}
