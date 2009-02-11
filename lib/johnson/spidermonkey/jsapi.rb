require "ffi"

module Johnson
  module SpiderMonkey
    module JSAPI
      extend FFI::Library

      ffi_lib "js"

      attach_function :JS_GetImplementationVersion, [], :string
      attach_function :JS_Init, [:uint], :pointer # JS_NewRuntime
      attach_function :JS_Finish, [:pointer], :void # JS_DestroyRuntime
    end
  end
end
