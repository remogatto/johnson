# FIXME: This file is very specific to Mac OS X right now.

require "rbconfig"

if Config::CONFIG["arch"] =~ /universal-darwin/
  case `uname -smr`.chomp
  when "i386" then ENV["ARCHFLAGS"] = "-arch -386"
  when "ppc" then ENV["ARCHFLAGS"] = "-arch ppc"
  end
end

require "mkmf"

$CFLAGS << " -Werror -Wall -Wextra -Wunused -Wfloat-equal -Wshadow -Wcast-qual"
$CFLAGS << " -Wwrite-strings -Wconversion -Wmissing-noreturn -Winline"
$LIBS   << " -lstdc++ -lc -framework JavaScriptCore"

dir_config "javascriptcore"
create_makefile "javascriptcore"
