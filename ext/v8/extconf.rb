# this needs to happen before mkmf is required.
ENV["ARCHFLAGS"] = "-arch #{`uname -p` =~ /powerpc/ ? 'ppc' : 'i386'}"

require "mkmf"

$CFLAGS << " -O3 -Wall -Wextra -Wcast-qual -Wwrite-strings -Wconversion -Wmissing-noreturn"

find_header("v8.h", "../../vendor/v8/include")

$LOCAL_LIBS << "../../vendor/v8/libv8.a"

# http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/100255
CONFIG['LDSHARED'] = "g++ -shared"

create_makefile("johnson/rubyv8")
