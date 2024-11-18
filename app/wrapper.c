#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    int exit_code = EXIT_SUCCESS;
    openlog("tailscaled", LOG_PID | LOG_CONS, LOG_USER);

    argv[0] = "/usr/local/packages/tailscaled/lib/tailscaled";
    if (execv(argv[0], argv) == -1) {
        syslog(LOG_ERR, "Failed to execute tailscaled: %s", strerror(errno));
        exit_code = EXIT_FAILURE;
    }

    closelog();
    return exit_code;
}
