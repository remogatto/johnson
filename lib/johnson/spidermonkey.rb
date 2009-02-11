require "johnson/spidermonkey/jsapi"

module Johnson
  module SpiderMonkey
    VERSION = JSAPI::JS_GetImplementationVersion()
  end
end
