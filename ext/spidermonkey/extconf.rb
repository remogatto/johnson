# FIXME: This file is very specific to Mac OS X right now.

ENV["ARCHFLAGS"] = "-arch #{`uname -p` =~ /powerpc/ ? 'ppc' : 'i386'}"

require "mkmf"

# macports specific
$LIBPATH << "/opt/local/lib"
$CFLAGS  << " -I/opt/local/include"

$CFLAGS  << " -DXP_UNIX"
$CFLAGS  << " -W -Wall -Wextra -Wunused -Wfloat-equal -Wcast-qual"
$CFLAGS  << " -Wwrite-strings -Wconversion -Wmissing-noreturn -Winline"
$LIBS    << " -ljs"

dir_config "spidermonkey"
create_makefile "spidermonkey"
