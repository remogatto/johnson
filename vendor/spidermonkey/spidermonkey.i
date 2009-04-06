%module spidermonkey

%{
require 'rubygems'
require 'ffi'
module SpiderMonkey
  extend FFI::Library
  ffi_lib 'lib/johnson/spidermonkey.so'
%}

#define XP_UNIX
#define JS_BYTES_PER_BYTE 1
#define JS_BYTES_PER_SHORT 2
#define JS_BYTES_PER_INT 4
#define JS_HAVE_LONG_LONG
#define JS_BYTES_PER_LONG 8

typedef int jsrefcount;
typedef void* jsval;
typedef int jsint;
typedef unsigned int jsatomid;
typedef long ptrdiff_t;

%include jsotypes.h
%include jstypes.h
%include jscompat.h
%include jslong.h
%include jspubtd.h
%include jsutil.h
%include jsapi.h

%include jshash.h
%include jsprvtd.h
%include jsobj.h

%{
end
%}
