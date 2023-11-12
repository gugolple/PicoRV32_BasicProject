AC_INIT([firmware], [1.0], [juanignacio.croce@gmail.com])
    AM_INIT_AUTOMAKE([-Wall -Werror foreign subdir-objects])
    AM_CONDITIONAL([HOST_RISCV], [test "x$host" = xriscv32-unknown-elf])
    AC_PROG_CC
    AM_PROG_AS
    AC_CONFIG_HEADERS([config.h])
    AC_CONFIG_FILES([
        Makefile
])
AC_OUTPUT
