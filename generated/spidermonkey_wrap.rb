
require 'rubygems'
require 'ffi'
module SpiderMonkey
  extend FFI::Library
  ffi_lib 'lib/johnson/spidermonkey.so'
  JS_BYTES_PER_BYTE = 1
  JS_BYTES_PER_SHORT = 2
  JS_BYTES_PER_INT = 4
  JS_BYTES_PER_LONG = 8
  DEBUG = 1
  JSOP_NOP = 0
  JSOP_PUSH = 1
  JSOP_FORARG = 10
  JSOP_VARINC = 100
  JSOP_ARGDEC = 101
  JSOP_VARDEC = 102
  JSOP_FORIN = 103
  JSOP_FORNAME = 104
  JSOP_FORPROP = 105
  JSOP_FORELEM = 106
  JSOP_POPN = 107
  JSOP_BINDNAME = 108
  JSOP_SETNAME = 109
  JSOP_FORVAR = 11
  JSOP_THROW = 110
  JSOP_IN = 111
  JSOP_INSTANCEOF = 112
  JSOP_DEBUGGER = 113
  JSOP_GOSUB = 114
  JSOP_RETSUB = 115
  JSOP_EXCEPTION = 116
  JSOP_LINENO = 117
  JSOP_CONDSWITCH = 118
  JSOP_CASE = 119
  JSOP_DUP = 12
  JSOP_DEFAULT = 120
  JSOP_EVAL = 121
  JSOP_ENUMELEM = 122
  JSOP_GETTER = 123
  JSOP_SETTER = 124
  JSOP_DEFFUN = 125
  JSOP_DEFCONST = 126
  JSOP_DEFVAR = 127
  JSOP_ANONFUNOBJ = 128
  JSOP_NAMEDFUNOBJ = 129
  JSOP_DUP2 = 13
  JSOP_SETLOCALPOP = 130
  JSOP_GROUP = 131
  JSOP_SETCALL = 132
  JSOP_TRY = 133
  JSOP_FINALLY = 134
  JSOP_SWAP = 135
  JSOP_ARGSUB = 136
  JSOP_ARGCNT = 137
  JSOP_DEFLOCALFUN = 138
  JSOP_GOTOX = 139
  JSOP_SETCONST = 14
  JSOP_IFEQX = 140
  JSOP_IFNEX = 141
  JSOP_ORX = 142
  JSOP_ANDX = 143
  JSOP_GOSUBX = 144
  JSOP_CASEX = 145
  JSOP_DEFAULTX = 146
  JSOP_TABLESWITCHX = 147
  JSOP_LOOKUPSWITCHX = 148
  JSOP_BACKPATCH = 149
  JSOP_BITOR = 15
  JSOP_BACKPATCH_POP = 150
  JSOP_THROWING = 151
  JSOP_SETRVAL = 152
  JSOP_RETRVAL = 153
  JSOP_GETGVAR = 154
  JSOP_SETGVAR = 155
  JSOP_INCGVAR = 156
  JSOP_DECGVAR = 157
  JSOP_GVARINC = 158
  JSOP_GVARDEC = 159
  JSOP_BITXOR = 16
  JSOP_REGEXP = 160
  JSOP_DEFXMLNS = 161
  JSOP_ANYNAME = 162
  JSOP_QNAMEPART = 163
  JSOP_QNAMECONST = 164
  JSOP_QNAME = 165
  JSOP_TOATTRNAME = 166
  JSOP_TOATTRVAL = 167
  JSOP_ADDATTRNAME = 168
  JSOP_ADDATTRVAL = 169
  JSOP_BITAND = 17
  JSOP_BINDXMLNAME = 170
  JSOP_SETXMLNAME = 171
  JSOP_XMLNAME = 172
  JSOP_DESCENDANTS = 173
  JSOP_FILTER = 174
  JSOP_ENDFILTER = 175
  JSOP_TOXML = 176
  JSOP_TOXMLLIST = 177
  JSOP_XMLTAGEXPR = 178
  JSOP_XMLELTEXPR = 179
  JSOP_EQ = 18
  JSOP_XMLOBJECT = 180
  JSOP_XMLCDATA = 181
  JSOP_XMLCOMMENT = 182
  JSOP_XMLPI = 183
  JSOP_CALLPROP = 184
  JSOP_GETFUNNS = 185
  JSOP_FOREACH = 186
  JSOP_DELDESC = 187
  JSOP_UINT24 = 188
  JSOP_INDEXBASE = 189
  JSOP_NE = 19
  JSOP_RESETBASE = 190
  JSOP_RESETBASE0 = 191
  JSOP_STARTXML = 192
  JSOP_STARTXMLEXPR = 193
  JSOP_CALLELEM = 194
  JSOP_STOP = 195
  JSOP_GETXPROP = 196
  JSOP_CALLXMLNAME = 197
  JSOP_TYPEOFEXPR = 198
  JSOP_ENTERBLOCK = 199
  JSOP_POPV = 2
  JSOP_LT = 20
  JSOP_LEAVEBLOCK = 200
  JSOP_GETLOCAL = 201
  JSOP_SETLOCAL = 202
  JSOP_INCLOCAL = 203
  JSOP_DECLOCAL = 204
  JSOP_LOCALINC = 205
  JSOP_LOCALDEC = 206
  JSOP_FORLOCAL = 207
  JSOP_FORCONST = 208
  JSOP_ENDITER = 209
  JSOP_LE = 21
  JSOP_GENERATOR = 210
  JSOP_YIELD = 211
  JSOP_ARRAYPUSH = 212
  JSOP_FOREACHKEYVAL = 213
  JSOP_ENUMCONSTELEM = 214
  JSOP_LEAVEBLOCKEXPR = 215
  JSOP_GETTHISPROP = 216
  JSOP_GETARGPROP = 217
  JSOP_GETVARPROP = 218
  JSOP_GETLOCALPROP = 219
  JSOP_GT = 22
  JSOP_INDEXBASE1 = 220
  JSOP_INDEXBASE2 = 221
  JSOP_INDEXBASE3 = 222
  JSOP_CALLGVAR = 223
  JSOP_CALLVAR = 224
  JSOP_CALLARG = 225
  JSOP_CALLLOCAL = 226
  JSOP_INT8 = 227
  JSOP_INT32 = 228
  JSOP_LENGTH = 229
  JSOP_GE = 23
  JSOP_LSH = 24
  JSOP_RSH = 25
  JSOP_URSH = 26
  JSOP_ADD = 27
  JSOP_SUB = 28
  JSOP_MUL = 29
  JSOP_ENTERWITH = 3
  JSOP_DIV = 30
  JSOP_MOD = 31
  JSOP_NOT = 32
  JSOP_BITNOT = 33
  JSOP_NEG = 34
  JSOP_NEW = 35
  JSOP_DELNAME = 36
  JSOP_DELPROP = 37
  JSOP_DELELEM = 38
  JSOP_TYPEOF = 39
  JSOP_LEAVEWITH = 4
  JSOP_VOID = 40
  JSOP_INCNAME = 41
  JSOP_INCPROP = 42
  JSOP_INCELEM = 43
  JSOP_DECNAME = 44
  JSOP_DECPROP = 45
  JSOP_DECELEM = 46
  JSOP_NAMEINC = 47
  JSOP_PROPINC = 48
  JSOP_ELEMINC = 49
  JSOP_RETURN = 5
  JSOP_NAMEDEC = 50
  JSOP_PROPDEC = 51
  JSOP_ELEMDEC = 52
  JSOP_GETPROP = 53
  JSOP_SETPROP = 54
  JSOP_GETELEM = 55
  JSOP_SETELEM = 56
  JSOP_CALLNAME = 57
  JSOP_CALL = 58
  JSOP_NAME = 59
  JSOP_GOTO = 6
  JSOP_DOUBLE = 60
  JSOP_STRING = 61
  JSOP_ZERO = 62
  JSOP_ONE = 63
  JSOP_NULL = 64
  JSOP_THIS = 65
  JSOP_FALSE = 66
  JSOP_TRUE = 67
  JSOP_OR = 68
  JSOP_AND = 69
  JSOP_IFEQ = 7
  JSOP_TABLESWITCH = 70
  JSOP_LOOKUPSWITCH = 71
  JSOP_STRICTEQ = 72
  JSOP_STRICTNE = 73
  JSOP_CLOSURE = 74
  JSOP_EXPORTALL = 75
  JSOP_EXPORTNAME = 76
  JSOP_IMPORTALL = 77
  JSOP_IMPORTPROP = 78
  JSOP_IMPORTELEM = 79
  JSOP_IFNE = 8
  JSOP_OBJECT = 80
  JSOP_POP = 81
  JSOP_POS = 82
  JSOP_TRAP = 83
  JSOP_GETARG = 84
  JSOP_SETARG = 85
  JSOP_GETVAR = 86
  JSOP_SETVAR = 87
  JSOP_UINT16 = 88
  JSOP_NEWINIT = 89
  JSOP_ARGUMENTS = 9
  JSOP_ENDINIT = 90
  JSOP_INITPROP = 91
  JSOP_INITELEM = 92
  JSOP_DEFSHARP = 93
  JSOP_USESHARP = 94
  JSOP_INCARG = 95
  JSOP_INCVAR = 96
  JSOP_DECARG = 97
  JSOP_DECVAR = 98
  JSOP_ARGINC = 99

  JSVERSION_UNKNOWN = -1
  JSVERSION_DEFAULT = 0
  JSVERSION_1_0 = 100
  JSVERSION_1_1 = 110
  JSVERSION_1_2 = 120
  JSVERSION_1_3 = 130
  JSVERSION_1_4 = 140
  JSVERSION_ECMA_3 = 148
  JSVERSION_1_5 = 150
  JSVERSION_1_6 = 160
  JSVERSION_1_7 = 170
  JSVERSION_1_8 = 180
  JSVERSION_LATEST = JSVERSION_1_8

  JSTYPE_VOID = 0
  JSTYPE_OBJECT = 1
  JSTYPE_FUNCTION = 2
  JSTYPE_STRING = 3
  JSTYPE_NUMBER = 4
  JSTYPE_BOOLEAN = 5
  JSTYPE_NULL = 6
  JSTYPE_XML = 7
  JSTYPE_LIMIT = 8

  JSProto_LIMIT = 0

  JSACC_PROTO = 0
  JSACC_PARENT = 1
  JSACC_IMPORT = 2
  JSACC_WATCH = 3
  JSACC_READ = 4
  JSACC_WRITE = 8
  JSACC_LIMIT = 9

  JSENUMERATE_INIT = 0
  JSENUMERATE_NEXT = 1
  JSENUMERATE_DESTROY = 2

  callback(:JSPropertyOp, [ :pointer, :pointer, :long, :pointer ], :int)
  callback(:JSNewEnumerateOp, [ :pointer, :pointer, :int, :pointer, :pointer ], :int)
  callback(:JSEnumerateOp, [ :pointer, :pointer ], :int)
  callback(:JSResolveOp, [ :pointer, :pointer, :long ], :int)
  callback(:JSNewResolveOp, [ :pointer, :pointer, :long, :uint, :pointer ], :int)
  callback(:JSConvertOp, [ :pointer, :pointer, :int, :pointer ], :int)
  callback(:JSFinalizeOp, [ :pointer, :pointer ], :void)
  callback(:JSStringFinalizeOp, [ :pointer, :pointer ], :void)
  callback(:JSGetObjectOps, [ :pointer, :pointer ], :pointer)
  callback(:JSCheckAccessOp, [ :pointer, :pointer, :long, :int, :pointer ], :int)
  callback(:JSXDRObjectOp, [ :pointer, :pointer ], :int)
  callback(:JSHasInstanceOp, [ :pointer, :pointer, :long, :pointer ], :int)
  callback(:JSMarkOp, [ :pointer, :pointer, :pointer ], :uint)
  callback(:JSTraceOp, [ :pointer, :pointer ], :void)
  callback(:JSTraceCallback, [ :pointer, :pointer, :uint ], :void)
  callback(:JSTraceNamePrinter, [ :pointer, :string, :uint ], :void)
  callback(:JSReserveSlotsOp, [ :pointer, :pointer ], :uint)
  callback(:JSNewObjectMapOp, [ :pointer, :int, :pointer, :pointer, :pointer ], :pointer)
  callback(:JSObjectMapOp, [ :pointer, :pointer ], :void)
  callback(:JSLookupPropOp, [ :pointer, :pointer, :long, :pointer, :pointer ], :int)
  callback(:JSDefinePropOp, [ :pointer, :pointer, :long, :long, :JSPropertyOp, :JSPropertyOp, :uint, :pointer ], :int)
  callback(:JSPropertyIdOp, [ :pointer, :pointer, :long, :pointer ], :int)
  callback(:JSAttributesOp, [ :pointer, :pointer, :long, :pointer, :pointer ], :int)
  callback(:JSCheckAccessIdOp, [ :pointer, :pointer, :long, :int, :pointer, :pointer ], :int)
  callback(:JSObjectOp, [ :pointer, :pointer ], :pointer)
  callback(:JSIteratorOp, [ :pointer, :pointer, :int ], :pointer)
  callback(:JSPropertyRefOp, [ :pointer, :pointer, :pointer ], :void)
  callback(:JSSetObjectSlotOp, [ :pointer, :pointer, :uint, :pointer ], :int)
  callback(:JSGetRequiredSlotOp, [ :pointer, :pointer, :uint ], :long)
  callback(:JSSetRequiredSlotOp, [ :pointer, :pointer, :uint, :long ], :int)
  callback(:JSGetMethodOp, [ :pointer, :pointer, :long, :pointer ], :pointer)
  callback(:JSSetMethodOp, [ :pointer, :pointer, :long, :pointer ], :int)
  callback(:JSEnumerateValuesOp, [ :pointer, :pointer, :int, :pointer, :pointer, :pointer ], :int)
  callback(:JSEqualityOp, [ :pointer, :pointer, :long, :pointer ], :int)
  callback(:JSConcatenateOp, [ :pointer, :pointer, :long, :pointer ], :int)
  callback(:JSNative, [ :pointer, :pointer, :uint, :pointer, :pointer ], :int)
  callback(:JSFastNative, [ :pointer, :uint, :pointer ], :int)
  JSCONTEXT_NEW = 0
  JSCONTEXT_DESTROY = 1

  callback(:JSContextCallback, [ :pointer, :uint ], :int)
  JSGC_BEGIN = 0
  JSGC_END = 1
  JSGC_MARK_END = 2
  JSGC_FINALIZE_END = 3

  callback(:JSGCCallback, [ :pointer, :int ], :int)
  callback(:JSTraceDataOp, [ :pointer, :pointer ], :void)
  callback(:JSOperationCallback, [ :pointer ], :int)
  callback(:JSBranchCallback, [ :pointer, :pointer ], :int)
  callback(:JSErrorReporter, [ :pointer, :string, :pointer ], :void)
  JSEXN_NONE = -1
  JSEXN_ERR = 0
  JSEXN_INTERNALERR = 1
  JSEXN_EVALERR = 2
  JSEXN_RANGEERR = 3
  JSEXN_REFERENCEERR = 4
  JSEXN_SYNTAXERR = 5
  JSEXN_TYPEERR = 6
  JSEXN_URIERR = 7
  JSEXN_LIMIT = 8

  class JSErrorFormatString < FFI::Struct
    layout(
           :format, :pointer,
           :argCount, :ushort,
           :exnType, :short
    )
    def format=(str)
      @format = FFI::MemoryPointer.from_string(str)
      self[:format] = @format
    end
    def format
      @format.get_string(0)
    end

  end
  callback(:JSErrorCallback, [ :pointer, :string, :uint ], JSErrorFormatString)
  callback(:JSLocaleToUpperCase, [ :pointer, :pointer, :pointer ], :int)
  callback(:JSLocaleToLowerCase, [ :pointer, :pointer, :pointer ], :int)
  callback(:JSLocaleCompare, [ :pointer, :pointer, :pointer, :pointer ], :int)
  callback(:JSLocaleToUnicode, [ :pointer, :string, :pointer ], :int)
  callback(:JSPrincipalsTranscoder, [ :pointer, :pointer ], :int)
  callback(:JSObjectPrincipalsFinder, [ :pointer, :pointer ], :pointer)
  attach_function :JS_Assert, [ :string, :string, :int ], :void
  JS_BASIC_STATS = 1
  class JSBasicStats < FFI::Struct
    layout(
           :num, :uint,
           :max, :uint,
           :sum, :double,
           :sqsum, :double,
           :logscale, :uint,
           :hist, [:uint, 11]
    )
  end
  attach_function :JS_BasicStatsAccum, [ :pointer, :uint ], :void
  attach_function :JS_MeanAndStdDev, [ :uint, :double, :double, :pointer ], :double
  attach_function :JS_DumpBasicStats, [ :pointer, :string, :pointer ], :void
  attach_function :JS_DumpHistogram, [ :pointer, :pointer ], :void
  class JSCallsite < FFI::Struct
    layout(
           :pc, :uint,
           :name, :pointer,
           :library, :pointer,
           :offset, :int,
           :parent, :pointer,
           :siblings, :pointer,
           :kids, :pointer,
           :handy, :pointer
    )
    def name=(str)
      @name = FFI::MemoryPointer.from_string(str)
      self[:name] = @name
    end
    def name
      @name.get_string(0)
    end
    def library=(str)
      @library = FFI::MemoryPointer.from_string(str)
      self[:library] = @library
    end
    def library
      @library.get_string(0)
    end

  end
  JSVAL_OBJECT = 0x0
  JSVAL_INT = 0x1
  JSVAL_DOUBLE = 0x2
  JSVAL_STRING = 0x4
  JSVAL_BOOLEAN = 0x6
  JSVAL_TAGBITS = 3
  JSVAL_INT_BITS = 31
  JSPROP_ENUMERATE = 0x01
  JSPROP_READONLY = 0x02
  JSPROP_PERMANENT = 0x04
  JSPROP_EXPORTED = 0x08
  JSPROP_GETTER = 0x10
  JSPROP_SETTER = 0x20
  JSPROP_SHARED = 0x40
  JSPROP_INDEX = 0x80
  JSFUN_LAMBDA = 0x08
  JSFUN_GETTER = 0x10
  JSFUN_SETTER = 0x20
  JSFUN_BOUND_METHOD = 0x40
  JSFUN_HEAVYWEIGHT = 0x80
  JSFUN_THISP_STRING = 0x0100
  JSFUN_THISP_NUMBER = 0x0200
  JSFUN_THISP_BOOLEAN = 0x0400
  JSFUN_THISP_PRIMITIVE = 0x0700
  JSFUN_FAST_NATIVE = 0x0800
  JSFUN_FLAGS_MASK = 0x0ff8
  JSFUN_STUB_GSOPS = 0x1000
  JSFUN_GENERIC_NATIVE = 0x08
  attach_function :JS_Now, [  ], :long
  attach_function :JS_GetNaNValue, [ :pointer ], :long
  attach_function :JS_GetNegativeInfinityValue, [ :pointer ], :long
  attach_function :JS_GetPositiveInfinityValue, [ :pointer ], :long
  attach_function :JS_GetEmptyStringValue, [ :pointer ], :long
  attach_function :JS_ConvertArguments, [ :pointer, :uint, :pointer, :string, :varargs ], :int
  attach_function :JS_PushArguments, [ :pointer, :pointer, :string, :varargs ], :pointer
  attach_function :JS_PopArguments, [ :pointer, :pointer ], :void
  attach_function :JS_ConvertValue, [ :pointer, :long, :int, :pointer ], :int
  attach_function :JS_ValueToObject, [ :pointer, :long, :pointer ], :int
  attach_function :JS_ValueToFunction, [ :pointer, :long ], :pointer
  attach_function :JS_ValueToConstructor, [ :pointer, :long ], :pointer
  attach_function :JS_ValueToString, [ :pointer, :long ], :pointer
  attach_function :JS_ValueToNumber, [ :pointer, :long, :pointer ], :int
  attach_function :JS_ValueToECMAInt32, [ :pointer, :long, :pointer ], :int
  attach_function :JS_ValueToECMAUint32, [ :pointer, :long, :pointer ], :int
  attach_function :JS_ValueToInt32, [ :pointer, :long, :pointer ], :int
  attach_function :JS_ValueToUint16, [ :pointer, :long, :pointer ], :int
  attach_function :JS_ValueToBoolean, [ :pointer, :long, :pointer ], :int
  attach_function :JS_TypeOfValue, [ :pointer, :long ], :int
  attach_function :JS_GetTypeName, [ :pointer, :int ], :string
  attach_function :JS_Init, [ :uint ], :pointer
  attach_function :JS_Finish, [ :pointer ], :void
  attach_function :JS_ShutDown, [  ], :void
  attach_function :JS_GetRuntimePrivate, [ :pointer ], :pointer
  attach_function :JS_SetRuntimePrivate, [ :pointer, :pointer ], :void
  attach_function :JS_BeginRequest, [ :pointer ], :void
  attach_function :JS_EndRequest, [ :pointer ], :void
  attach_function :JS_YieldRequest, [ :pointer ], :void
  attach_function :JS_SuspendRequest, [ :pointer ], :int
  attach_function :JS_ResumeRequest, [ :pointer, :int ], :void
  attach_function :JS_Lock, [ :pointer ], :void
  attach_function :JS_Unlock, [ :pointer ], :void
  attach_function :JS_SetContextCallback, [ :pointer, :JSContextCallback ], :JSContextCallback
  attach_function :JS_NewContext, [ :pointer, :uint ], :pointer
  attach_function :JS_DestroyContext, [ :pointer ], :void
  attach_function :JS_DestroyContextNoGC, [ :pointer ], :void
  attach_function :JS_DestroyContextMaybeGC, [ :pointer ], :void
  attach_function :JS_GetContextPrivate, [ :pointer ], :pointer
  attach_function :JS_SetContextPrivate, [ :pointer, :pointer ], :void
  attach_function :JS_GetRuntime, [ :pointer ], :pointer
  attach_function :JS_ContextIterator, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetVersion, [ :pointer ], :int
  attach_function :JS_SetVersion, [ :pointer, :int ], :int
  attach_function :JS_VersionToString, [ :int ], :string
  attach_function :JS_StringToVersion, [ :string ], :int
  attach_function :JS_GetOptions, [ :pointer ], :uint
  attach_function :JS_SetOptions, [ :pointer, :uint ], :uint
  attach_function :JS_ToggleOptions, [ :pointer, :uint ], :uint
  attach_function :JS_GetImplementationVersion, [  ], :string
  attach_function :JS_GetGlobalObject, [ :pointer ], :pointer
  attach_function :JS_SetGlobalObject, [ :pointer, :pointer ], :void
  attach_function :JS_InitStandardClasses, [ :pointer, :pointer ], :int
  attach_function :JS_ResolveStandardClass, [ :pointer, :pointer, :long, :pointer ], :int
  attach_function :JS_EnumerateStandardClasses, [ :pointer, :pointer ], :int
  attach_function :JS_EnumerateResolvedStandardClasses, [ :pointer, :pointer, :pointer ], :pointer
  attach_function :JS_GetClassObject, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :JS_GetScopeChain, [ :pointer ], :pointer
  attach_function :JS_GetGlobalForObject, [ :pointer, :pointer ], :pointer
  attach_function :JS_ComputeThis, [ :pointer, :pointer ], :long
  attach_function :JS_malloc, [ :pointer, :uint ], :pointer
  attach_function :JS_realloc, [ :pointer, :pointer, :uint ], :pointer
  attach_function :JS_free, [ :pointer, :pointer ], :void
  attach_function :JS_strdup, [ :pointer, :string ], :string
  attach_function :JS_NewDouble, [ :pointer, :double ], :pointer
  attach_function :JS_NewDoubleValue, [ :pointer, :double, :pointer ], :int
  attach_function :JS_NewNumberValue, [ :pointer, :double, :pointer ], :int
  attach_function :JS_AddRoot, [ :pointer, :pointer ], :int
  attach_function :JS_AddNamedRoot, [ :pointer, :pointer, :string ], :int
  attach_function :JS_AddNamedRootRT, [ :pointer, :pointer, :string ], :int
  attach_function :JS_RemoveRoot, [ :pointer, :pointer ], :int
  attach_function :JS_RemoveRootRT, [ :pointer, :pointer ], :int
  attach_function :JS_ClearNewbornRoots, [ :pointer ], :void
  attach_function :JS_EnterLocalRootScope, [ :pointer ], :int
  attach_function :JS_LeaveLocalRootScope, [ :pointer ], :void
  attach_function :JS_LeaveLocalRootScopeWithResult, [ :pointer, :long ], :void
  attach_function :JS_ForgetLocalRoot, [ :pointer, :pointer ], :void
  attach_function :JS_DumpNamedRoots, [ :pointer, callback([ :string, :pointer, :pointer ], :void), :pointer ], :void
  JS_MAP_GCROOT_NEXT = 0
  JS_MAP_GCROOT_STOP = 1
  JS_MAP_GCROOT_REMOVE = 2
  callback(:JSGCRootMapFun, [ :pointer, :string, :pointer ], :int)
  attach_function :JS_MapGCRoots, [ :pointer, :JSGCRootMapFun, :pointer ], :uint
  attach_function :JS_LockGCThing, [ :pointer, :pointer ], :int
  attach_function :JS_LockGCThingRT, [ :pointer, :pointer ], :int
  attach_function :JS_UnlockGCThing, [ :pointer, :pointer ], :int
  attach_function :JS_UnlockGCThingRT, [ :pointer, :pointer ], :int
  attach_function :JS_SetExtraGCRoots, [ :pointer, :JSTraceDataOp, :pointer ], :void
  attach_function :JS_MarkGCThing, [ :pointer, :pointer, :string, :pointer ], :void
  JSTRACE_OBJECT = 0
  JSTRACE_DOUBLE = 1
  JSTRACE_STRING = 2
  class JSTracer < FFI::Struct
    layout(
           :context, :pointer,
           :callback, :JSTraceCallback,
           :debugPrinter, :JSTraceNamePrinter,
           :debugPrintArg, :pointer,
           :debugPrintIndex, :uint
    )
    def callback=(cb)
      @callback = cb
      self[:callback] = @callback
    end
    def callback
      @callback
    end
    def debugPrinter=(cb)
      @debugPrinter = cb
      self[:debugPrinter] = @debugPrinter
    end
    def debugPrinter
      @debugPrinter
    end

  end
  attach_function :JS_CallTracer, [ :pointer, :pointer, :uint ], :void
  attach_function :JS_TraceChildren, [ :pointer, :pointer, :uint ], :void
  attach_function :JS_TraceRuntime, [ :pointer ], :void
  attach_function :JS_PrintTraceThingInfo, [ :string, :uint, :pointer, :pointer, :uint, :int ], :void
  attach_function :JS_DumpHeap, [ :pointer, :pointer, :pointer, :uint, :pointer, :uint, :pointer ], :int
  attach_function :JS_GC, [ :pointer ], :void
  attach_function :JS_MaybeGC, [ :pointer ], :void
  attach_function :JS_SetGCCallback, [ :pointer, :JSGCCallback ], :JSGCCallback
  attach_function :JS_SetGCCallbackRT, [ :pointer, :JSGCCallback ], :JSGCCallback
  attach_function :JS_IsGCMarkingTracer, [ :pointer ], :int
  attach_function :JS_IsAboutToBeFinalized, [ :pointer, :pointer ], :int
  JSGC_MAX_BYTES = 0
  JSGC_MAX_MALLOC_BYTES = 1
  JSGC_STACKPOOL_LIFESPAN = 2

  attach_function :JS_SetGCParameter, [ :pointer, :int, :uint ], :void
  attach_function :JS_AddExternalStringFinalizer, [ :JSStringFinalizeOp ], :int
  attach_function :JS_RemoveExternalStringFinalizer, [ :JSStringFinalizeOp ], :int
  attach_function :JS_NewExternalString, [ :pointer, :pointer, :uint, :int ], :pointer
  attach_function :JS_GetExternalStringGCType, [ :pointer, :pointer ], :int
  attach_function :JS_SetThreadStackLimit, [ :pointer, :ulong ], :void
  attach_function :JS_SetScriptStackQuota, [ :pointer, :uint ], :void
  class JSClass < FFI::Struct
    layout(
           :name, :pointer,
           :flags, :uint,
           :addProperty, :JSPropertyOp,
           :delProperty, :JSPropertyOp,
           :getProperty, :JSPropertyOp,
           :setProperty, :JSPropertyOp,
           :enumerate, :JSEnumerateOp,
           :resolve, :JSResolveOp,
           :convert, :JSConvertOp,
           :finalize, :JSFinalizeOp,
           :getObjectOps, :JSGetObjectOps,
           :checkAccess, :JSCheckAccessOp,
           :call, :JSNative,
           :construct, :JSNative,
           :xdrObject, :JSXDRObjectOp,
           :hasInstance, :JSHasInstanceOp,
           :mark, :JSMarkOp,
           :reserveSlots, :JSReserveSlotsOp
    )
    def name=(str)
      @name = FFI::MemoryPointer.from_string(str)
      self[:name] = @name
    end
    def name
      @name.get_string(0)
    end
    def addProperty=(cb)
      @addProperty = cb
      self[:addProperty] = @addProperty
    end
    def addProperty
      @addProperty
    end
    def delProperty=(cb)
      @delProperty = cb
      self[:delProperty] = @delProperty
    end
    def delProperty
      @delProperty
    end
    def getProperty=(cb)
      @getProperty = cb
      self[:getProperty] = @getProperty
    end
    def getProperty
      @getProperty
    end
    def setProperty=(cb)
      @setProperty = cb
      self[:setProperty] = @setProperty
    end
    def setProperty
      @setProperty
    end
    def enumerate=(cb)
      @enumerate = cb
      self[:enumerate] = @enumerate
    end
    def enumerate
      @enumerate
    end
    def resolve=(cb)
      @resolve = cb
      self[:resolve] = @resolve
    end
    def resolve
      @resolve
    end
    def convert=(cb)
      @convert = cb
      self[:convert] = @convert
    end
    def convert
      @convert
    end
    def finalize=(cb)
      @finalize = cb
      self[:finalize] = @finalize
    end
    def finalize
      @finalize
    end
    def getObjectOps=(cb)
      @getObjectOps = cb
      self[:getObjectOps] = @getObjectOps
    end
    def getObjectOps
      @getObjectOps
    end
    def checkAccess=(cb)
      @checkAccess = cb
      self[:checkAccess] = @checkAccess
    end
    def checkAccess
      @checkAccess
    end
    def call=(cb)
      @call = cb
      self[:call] = @call
    end
    def call
      @call
    end
    def construct=(cb)
      @construct = cb
      self[:construct] = @construct
    end
    def construct
      @construct
    end
    def xdrObject=(cb)
      @xdrObject = cb
      self[:xdrObject] = @xdrObject
    end
    def xdrObject
      @xdrObject
    end
    def hasInstance=(cb)
      @hasInstance = cb
      self[:hasInstance] = @hasInstance
    end
    def hasInstance
      @hasInstance
    end
    def mark=(cb)
      @mark = cb
      self[:mark] = @mark
    end
    def mark
      @mark
    end
    def reserveSlots=(cb)
      @reserveSlots = cb
      self[:reserveSlots] = @reserveSlots
    end
    def reserveSlots
      @reserveSlots
    end

  end
  class JSExtendedClass < FFI::Struct
    layout(
           :base, JSClass,
           :equality, :JSEqualityOp,
           :outerObject, :JSObjectOp,
           :innerObject, :JSObjectOp,
           :iteratorObject, :JSIteratorOp,
           :wrappedObject, :JSObjectOp,
           :reserved0, callback([  ], :void),
           :reserved1, callback([  ], :void),
           :reserved2, callback([  ], :void)
    )
    def equality=(cb)
      @equality = cb
      self[:equality] = @equality
    end
    def equality
      @equality
    end
    def outerObject=(cb)
      @outerObject = cb
      self[:outerObject] = @outerObject
    end
    def outerObject
      @outerObject
    end
    def innerObject=(cb)
      @innerObject = cb
      self[:innerObject] = @innerObject
    end
    def innerObject
      @innerObject
    end
    def iteratorObject=(cb)
      @iteratorObject = cb
      self[:iteratorObject] = @iteratorObject
    end
    def iteratorObject
      @iteratorObject
    end
    def wrappedObject=(cb)
      @wrappedObject = cb
      self[:wrappedObject] = @wrappedObject
    end
    def wrappedObject
      @wrappedObject
    end
    def reserved0=(cb)
      @reserved0 = cb
      self[:reserved0] = @reserved0
    end
    def reserved0
      @reserved0
    end
    def reserved1=(cb)
      @reserved1 = cb
      self[:reserved1] = @reserved1
    end
    def reserved1
      @reserved1
    end
    def reserved2=(cb)
      @reserved2 = cb
      self[:reserved2] = @reserved2
    end
    def reserved2
      @reserved2
    end

  end
  JSCLASS_HAS_PRIVATE = (1 << 0)
  JSCLASS_NEW_ENUMERATE = (1 << 1)
  JSCLASS_NEW_RESOLVE = (1 << 2)
  JSCLASS_PRIVATE_IS_NSISUPPORTS = (1 << 3)
  JSCLASS_SHARE_ALL_PROPERTIES = (1 << 4)
  JSCLASS_NEW_RESOLVE_GETS_START = (1 << 5)
  JSCLASS_CONSTRUCT_PROTOTYPE = (1 << 6)
  JSCLASS_DOCUMENT_OBSERVER = (1 << 7)
  JSCLASS_RESERVED_SLOTS_SHIFT = 8
  JSCLASS_RESERVED_SLOTS_WIDTH = 8
  JSCLASS_HIGH_FLAGS_SHIFT = (8+8)
  JSCLASS_IS_EXTENDED = (1 << ((8+8) +0))
  JSCLASS_IS_ANONYMOUS = (1 << ((8+8) +1))
  JSCLASS_IS_GLOBAL = (1 << ((8+8) +2))
  JSCLASS_MARK_IS_TRACE = (1 << ((8+8) +3))
  JSCLASS_CACHED_PROTO_SHIFT = ((8+8) +8)
  JSCLASS_CACHED_PROTO_WIDTH = 8
  class JSObjectOps < FFI::Struct
    layout(
           :newObjectMap, :JSNewObjectMapOp,
           :destroyObjectMap, :JSObjectMapOp,
           :lookupProperty, :JSLookupPropOp,
           :defineProperty, :JSDefinePropOp,
           :getProperty, :JSPropertyIdOp,
           :setProperty, :JSPropertyIdOp,
           :getAttributes, :JSAttributesOp,
           :setAttributes, :JSAttributesOp,
           :deleteProperty, :JSPropertyIdOp,
           :defaultValue, :JSConvertOp,
           :enumerate, :JSNewEnumerateOp,
           :checkAccess, :JSCheckAccessIdOp,
           :thisObject, :JSObjectOp,
           :dropProperty, :JSPropertyRefOp,
           :call, :JSNative,
           :construct, :JSNative,
           :xdrObject, :JSXDRObjectOp,
           :hasInstance, :JSHasInstanceOp,
           :setProto, :JSSetObjectSlotOp,
           :setParent, :JSSetObjectSlotOp,
           :trace, :JSTraceOp,
           :clear, :JSFinalizeOp,
           :getRequiredSlot, :JSGetRequiredSlotOp,
           :setRequiredSlot, :JSSetRequiredSlotOp
    )
    def newObjectMap=(cb)
      @newObjectMap = cb
      self[:newObjectMap] = @newObjectMap
    end
    def newObjectMap
      @newObjectMap
    end
    def destroyObjectMap=(cb)
      @destroyObjectMap = cb
      self[:destroyObjectMap] = @destroyObjectMap
    end
    def destroyObjectMap
      @destroyObjectMap
    end
    def lookupProperty=(cb)
      @lookupProperty = cb
      self[:lookupProperty] = @lookupProperty
    end
    def lookupProperty
      @lookupProperty
    end
    def defineProperty=(cb)
      @defineProperty = cb
      self[:defineProperty] = @defineProperty
    end
    def defineProperty
      @defineProperty
    end
    def getProperty=(cb)
      @getProperty = cb
      self[:getProperty] = @getProperty
    end
    def getProperty
      @getProperty
    end
    def setProperty=(cb)
      @setProperty = cb
      self[:setProperty] = @setProperty
    end
    def setProperty
      @setProperty
    end
    def getAttributes=(cb)
      @getAttributes = cb
      self[:getAttributes] = @getAttributes
    end
    def getAttributes
      @getAttributes
    end
    def setAttributes=(cb)
      @setAttributes = cb
      self[:setAttributes] = @setAttributes
    end
    def setAttributes
      @setAttributes
    end
    def deleteProperty=(cb)
      @deleteProperty = cb
      self[:deleteProperty] = @deleteProperty
    end
    def deleteProperty
      @deleteProperty
    end
    def defaultValue=(cb)
      @defaultValue = cb
      self[:defaultValue] = @defaultValue
    end
    def defaultValue
      @defaultValue
    end
    def enumerate=(cb)
      @enumerate = cb
      self[:enumerate] = @enumerate
    end
    def enumerate
      @enumerate
    end
    def checkAccess=(cb)
      @checkAccess = cb
      self[:checkAccess] = @checkAccess
    end
    def checkAccess
      @checkAccess
    end
    def thisObject=(cb)
      @thisObject = cb
      self[:thisObject] = @thisObject
    end
    def thisObject
      @thisObject
    end
    def dropProperty=(cb)
      @dropProperty = cb
      self[:dropProperty] = @dropProperty
    end
    def dropProperty
      @dropProperty
    end
    def call=(cb)
      @call = cb
      self[:call] = @call
    end
    def call
      @call
    end
    def construct=(cb)
      @construct = cb
      self[:construct] = @construct
    end
    def construct
      @construct
    end
    def xdrObject=(cb)
      @xdrObject = cb
      self[:xdrObject] = @xdrObject
    end
    def xdrObject
      @xdrObject
    end
    def hasInstance=(cb)
      @hasInstance = cb
      self[:hasInstance] = @hasInstance
    end
    def hasInstance
      @hasInstance
    end
    def setProto=(cb)
      @setProto = cb
      self[:setProto] = @setProto
    end
    def setProto
      @setProto
    end
    def setParent=(cb)
      @setParent = cb
      self[:setParent] = @setParent
    end
    def setParent
      @setParent
    end
    def trace=(cb)
      @trace = cb
      self[:trace] = @trace
    end
    def trace
      @trace
    end
    def clear=(cb)
      @clear = cb
      self[:clear] = @clear
    end
    def clear
      @clear
    end
    def getRequiredSlot=(cb)
      @getRequiredSlot = cb
      self[:getRequiredSlot] = @getRequiredSlot
    end
    def getRequiredSlot
      @getRequiredSlot
    end
    def setRequiredSlot=(cb)
      @setRequiredSlot = cb
      self[:setRequiredSlot] = @setRequiredSlot
    end
    def setRequiredSlot
      @setRequiredSlot
    end

  end
  class JSXMLObjectOps < FFI::Struct
    layout(
           :base, JSObjectOps,
           :getMethod, :JSGetMethodOp,
           :setMethod, :JSSetMethodOp,
           :enumerateValues, :JSEnumerateValuesOp,
           :equality, :JSEqualityOp,
           :concatenate, :JSConcatenateOp
    )
    def getMethod=(cb)
      @getMethod = cb
      self[:getMethod] = @getMethod
    end
    def getMethod
      @getMethod
    end
    def setMethod=(cb)
      @setMethod = cb
      self[:setMethod] = @setMethod
    end
    def setMethod
      @setMethod
    end
    def enumerateValues=(cb)
      @enumerateValues = cb
      self[:enumerateValues] = @enumerateValues
    end
    def enumerateValues
      @enumerateValues
    end
    def equality=(cb)
      @equality = cb
      self[:equality] = @equality
    end
    def equality
      @equality
    end
    def concatenate=(cb)
      @concatenate = cb
      self[:concatenate] = @concatenate
    end
    def concatenate
      @concatenate
    end

  end
  class JSProperty < FFI::Struct
    layout(
           :id, :long
    )
  end
  class JSIdArray < FFI::Struct
    layout(
           :length, :int,
           :vector, [:long, 1]
    )
  end
  attach_function :JS_DestroyIdArray, [ :pointer, :pointer ], :void
  attach_function :JS_ValueToId, [ :pointer, :long, :pointer ], :int
  attach_function :JS_IdToValue, [ :pointer, :long, :pointer ], :int
  JSRESOLVE_QUALIFIED = 0x01
  JSRESOLVE_ASSIGNING = 0x02
  JSRESOLVE_DETECTING = 0x04
  JSRESOLVE_DECLARING = 0x08
  JSRESOLVE_CLASSNAME = 0x10
  attach_function :JS_PropertyStub, [ :pointer, :pointer, :long, :pointer ], :int
  attach_function :JS_EnumerateStub, [ :pointer, :pointer ], :int
  attach_function :JS_ResolveStub, [ :pointer, :pointer, :long ], :int
  attach_function :JS_ConvertStub, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :JS_FinalizeStub, [ :pointer, :pointer ], :void
  class JSConstDoubleSpec < FFI::Struct
    layout(
           :dval, :double,
           :name, :pointer,
           :flags, :uchar,
           :spare, [:uchar, 3]
    )
    def name=(str)
      @name = FFI::MemoryPointer.from_string(str)
      self[:name] = @name
    end
    def name
      @name.get_string(0)
    end

  end
  class JSPropertySpec < FFI::Struct
    layout(
           :name, :pointer,
           :tinyid, :char,
           :flags, :uchar,
           :getter, :JSPropertyOp,
           :setter, :JSPropertyOp
    )
    def name=(str)
      @name = FFI::MemoryPointer.from_string(str)
      self[:name] = @name
    end
    def name
      @name.get_string(0)
    end
    def getter=(cb)
      @getter = cb
      self[:getter] = @getter
    end
    def getter
      @getter
    end
    def setter=(cb)
      @setter = cb
      self[:setter] = @setter
    end
    def setter
      @setter
    end

  end
  class JSFunctionSpec < FFI::Struct
    layout(
           :name, :pointer,
           :call, :JSNative,
           :nargs, :ushort,
           :flags, :ushort,
           :extra, :uint
    )
    def name=(str)
      @name = FFI::MemoryPointer.from_string(str)
      self[:name] = @name
    end
    def name
      @name.get_string(0)
    end
    def call=(cb)
      @call = cb
      self[:call] = @call
    end
    def call
      @call
    end

  end
  attach_function :JS_InitClass, [ :pointer, :pointer, :pointer, :pointer, :JSNative, :uint, :pointer, :pointer, :pointer, :pointer ], :pointer
  attach_function :JS_GetClass, [ :pointer ], :pointer
  attach_function :JS_InstanceOf, [ :pointer, :pointer, :pointer, :pointer ], :int
  attach_function :JS_HasInstance, [ :pointer, :pointer, :long, :pointer ], :int
  attach_function :JS_GetPrivate, [ :pointer, :pointer ], :pointer
  attach_function :JS_SetPrivate, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_GetInstancePrivate, [ :pointer, :pointer, :pointer, :pointer ], :pointer
  attach_function :JS_GetPrototype, [ :pointer, :pointer ], :pointer
  attach_function :JS_SetPrototype, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_GetParent, [ :pointer, :pointer ], :pointer
  attach_function :JS_SetParent, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_GetConstructor, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetObjectId, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_NewObject, [ :pointer, :pointer, :pointer, :pointer ], :pointer
  attach_function :JS_NewObjectWithGivenProto, [ :pointer, :pointer, :pointer, :pointer ], :pointer
  attach_function :JS_SealObject, [ :pointer, :pointer, :int ], :int
  attach_function :JS_ConstructObject, [ :pointer, :pointer, :pointer, :pointer ], :pointer
  attach_function :JS_ConstructObjectWithArguments, [ :pointer, :pointer, :pointer, :pointer, :uint, :pointer ], :pointer
  attach_function :JS_DefineObject, [ :pointer, :pointer, :string, :pointer, :pointer, :uint ], :pointer
  attach_function :JS_DefineConstDoubles, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_DefineProperties, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_DefineProperty, [ :pointer, :pointer, :string, :long, :JSPropertyOp, :JSPropertyOp, :uint ], :int
  attach_function :JS_GetPropertyAttributes, [ :pointer, :pointer, :string, :pointer, :pointer ], :int
  attach_function :JS_GetPropertyAttrsGetterAndSetter, [ :pointer, :pointer, :string, :pointer, :pointer, :pointer, :pointer ], :int
  attach_function :JS_SetPropertyAttributes, [ :pointer, :pointer, :string, :uint, :pointer ], :int
  attach_function :JS_DefinePropertyWithTinyId, [ :pointer, :pointer, :string, :char, :long, :JSPropertyOp, :JSPropertyOp, :uint ], :int
  attach_function :JS_AliasProperty, [ :pointer, :pointer, :string, :string ], :int
  attach_function :JS_AlreadyHasOwnProperty, [ :pointer, :pointer, :string, :pointer ], :int
  attach_function :JS_HasProperty, [ :pointer, :pointer, :string, :pointer ], :int
  attach_function :JS_LookupProperty, [ :pointer, :pointer, :string, :pointer ], :int
  attach_function :JS_LookupPropertyWithFlags, [ :pointer, :pointer, :string, :uint, :pointer ], :int
  attach_function :JS_GetProperty, [ :pointer, :pointer, :string, :pointer ], :int
  attach_function :JS_GetMethodById, [ :pointer, :pointer, :long, :pointer, :pointer ], :int
  attach_function :JS_GetMethod, [ :pointer, :pointer, :string, :pointer, :pointer ], :int
  attach_function :JS_SetProperty, [ :pointer, :pointer, :string, :pointer ], :int
  attach_function :JS_DeleteProperty, [ :pointer, :pointer, :string ], :int
  attach_function :JS_DeleteProperty2, [ :pointer, :pointer, :string, :pointer ], :int
  attach_function :JS_DefineUCProperty, [ :pointer, :pointer, :pointer, :uint, :long, :JSPropertyOp, :JSPropertyOp, :uint ], :int
  attach_function :JS_GetUCPropertyAttributes, [ :pointer, :pointer, :pointer, :uint, :pointer, :pointer ], :int
  attach_function :JS_GetUCPropertyAttrsGetterAndSetter, [ :pointer, :pointer, :pointer, :uint, :pointer, :pointer, :pointer, :pointer ], :int
  attach_function :JS_SetUCPropertyAttributes, [ :pointer, :pointer, :pointer, :uint, :uint, :pointer ], :int
  attach_function :JS_DefineUCPropertyWithTinyId, [ :pointer, :pointer, :pointer, :uint, :char, :long, :JSPropertyOp, :JSPropertyOp, :uint ], :int
  attach_function :JS_AlreadyHasOwnUCProperty, [ :pointer, :pointer, :pointer, :uint, :pointer ], :int
  attach_function :JS_HasUCProperty, [ :pointer, :pointer, :pointer, :uint, :pointer ], :int
  attach_function :JS_LookupUCProperty, [ :pointer, :pointer, :pointer, :uint, :pointer ], :int
  attach_function :JS_GetUCProperty, [ :pointer, :pointer, :pointer, :uint, :pointer ], :int
  attach_function :JS_SetUCProperty, [ :pointer, :pointer, :pointer, :uint, :pointer ], :int
  attach_function :JS_DeleteUCProperty2, [ :pointer, :pointer, :pointer, :uint, :pointer ], :int
  attach_function :JS_NewArrayObject, [ :pointer, :int, :pointer ], :pointer
  attach_function :JS_IsArrayObject, [ :pointer, :pointer ], :int
  attach_function :JS_GetArrayLength, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_SetArrayLength, [ :pointer, :pointer, :uint ], :int
  attach_function :JS_HasArrayLength, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_DefineElement, [ :pointer, :pointer, :int, :long, :JSPropertyOp, :JSPropertyOp, :uint ], :int
  attach_function :JS_AliasElement, [ :pointer, :pointer, :string, :int ], :int
  attach_function :JS_AlreadyHasOwnElement, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :JS_HasElement, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :JS_LookupElement, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :JS_GetElement, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :JS_SetElement, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :JS_DeleteElement, [ :pointer, :pointer, :int ], :int
  attach_function :JS_DeleteElement2, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :JS_ClearScope, [ :pointer, :pointer ], :void
  attach_function :JS_Enumerate, [ :pointer, :pointer ], :pointer
  attach_function :JS_NewPropertyIterator, [ :pointer, :pointer ], :pointer
  attach_function :JS_NextProperty, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_CheckAccess, [ :pointer, :pointer, :long, :int, :pointer, :pointer ], :int
  attach_function :JS_SetCheckObjectAccessCallback, [ :pointer, :JSCheckAccessOp ], :JSCheckAccessOp
  attach_function :JS_GetReservedSlot, [ :pointer, :pointer, :uint, :pointer ], :int
  attach_function :JS_SetReservedSlot, [ :pointer, :pointer, :uint, :long ], :int
  class JSPrincipals < FFI::Struct
    layout(
           :codebase, :pointer,
           :getPrincipalArray, callback([ :pointer, :pointer ], :pointer),
           :globalPrivilegesEnabled, callback([ :pointer, :pointer ], :int),
           :refcount, :int,
           :destroy, callback([ :pointer, :pointer ], :void),
           :subsume, callback([ :pointer, :pointer ], :int)
    )
    def codebase=(str)
      @codebase = FFI::MemoryPointer.from_string(str)
      self[:codebase] = @codebase
    end
    def codebase
      @codebase.get_string(0)
    end
    def getPrincipalArray=(cb)
      @getPrincipalArray = cb
      self[:getPrincipalArray] = @getPrincipalArray
    end
    def getPrincipalArray
      @getPrincipalArray
    end
    def globalPrivilegesEnabled=(cb)
      @globalPrivilegesEnabled = cb
      self[:globalPrivilegesEnabled] = @globalPrivilegesEnabled
    end
    def globalPrivilegesEnabled
      @globalPrivilegesEnabled
    end
    def destroy=(cb)
      @destroy = cb
      self[:destroy] = @destroy
    end
    def destroy
      @destroy
    end
    def subsume=(cb)
      @subsume = cb
      self[:subsume] = @subsume
    end
    def subsume
      @subsume
    end

  end
  attach_function :JS_SetPrincipalsTranscoder, [ :pointer, :JSPrincipalsTranscoder ], :JSPrincipalsTranscoder
  attach_function :JS_SetObjectPrincipalsFinder, [ :pointer, :JSObjectPrincipalsFinder ], :JSObjectPrincipalsFinder
  attach_function :JS_NewFunction, [ :pointer, :JSNative, :uint, :uint, :pointer, :string ], :pointer
  attach_function :JS_GetFunctionObject, [ :pointer ], :pointer
  attach_function :JS_GetFunctionName, [ :pointer ], :string
  attach_function :JS_GetFunctionId, [ :pointer ], :pointer
  attach_function :JS_GetFunctionFlags, [ :pointer ], :uint
  attach_function :JS_GetFunctionArity, [ :pointer ], :ushort
  attach_function :JS_ObjectIsFunction, [ :pointer, :pointer ], :int
  attach_function :JS_DefineFunctions, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_DefineFunction, [ :pointer, :pointer, :string, :JSNative, :uint, :uint ], :pointer
  attach_function :JS_DefineUCFunction, [ :pointer, :pointer, :pointer, :uint, :JSNative, :uint, :uint ], :pointer
  attach_function :JS_CloneFunctionObject, [ :pointer, :pointer, :pointer ], :pointer
  attach_function :JS_BufferIsCompilableUnit, [ :pointer, :pointer, :string, :uint ], :int
  attach_function :JS_CompileScript, [ :pointer, :pointer, :string, :uint, :string, :uint ], :pointer
  attach_function :JS_CompileScriptForPrincipals, [ :pointer, :pointer, :pointer, :string, :uint, :string, :uint ], :pointer
  attach_function :JS_CompileUCScript, [ :pointer, :pointer, :pointer, :uint, :string, :uint ], :pointer
  attach_function :JS_CompileUCScriptForPrincipals, [ :pointer, :pointer, :pointer, :pointer, :uint, :string, :uint ], :pointer
  attach_function :JS_CompileFile, [ :pointer, :pointer, :string ], :pointer
  attach_function :JS_CompileFileHandle, [ :pointer, :pointer, :string, :pointer ], :pointer
  attach_function :JS_CompileFileHandleForPrincipals, [ :pointer, :pointer, :string, :pointer, :pointer ], :pointer
  attach_function :JS_NewScriptObject, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetScriptObject, [ :pointer ], :pointer
  attach_function :JS_DestroyScript, [ :pointer, :pointer ], :void
  attach_function :JS_CompileFunction, [ :pointer, :pointer, :string, :uint, :pointer, :string, :uint, :string, :uint ], :pointer
  attach_function :JS_CompileFunctionForPrincipals, [ :pointer, :pointer, :pointer, :string, :uint, :pointer, :string, :uint, :string, :uint ], :pointer
  attach_function :JS_CompileUCFunction, [ :pointer, :pointer, :string, :uint, :pointer, :pointer, :uint, :string, :uint ], :pointer
  attach_function :JS_CompileUCFunctionForPrincipals, [ :pointer, :pointer, :pointer, :string, :uint, :pointer, :pointer, :uint, :string, :uint ], :pointer
  attach_function :JS_DecompileScript, [ :pointer, :pointer, :string, :uint ], :pointer
  attach_function :JS_DecompileFunction, [ :pointer, :pointer, :uint ], :pointer
  attach_function :JS_DecompileFunctionBody, [ :pointer, :pointer, :uint ], :pointer
  attach_function :JS_ExecuteScript, [ :pointer, :pointer, :pointer, :pointer ], :int
  JSEXEC_PROLOG = 0
  JSEXEC_MAIN = 1

  attach_function :JS_ExecuteScriptPart, [ :pointer, :pointer, :pointer, :int, :pointer ], :int
  attach_function :JS_EvaluateScript, [ :pointer, :pointer, :string, :uint, :string, :uint, :pointer ], :int
  attach_function :JS_EvaluateScriptForPrincipals, [ :pointer, :pointer, :pointer, :string, :uint, :string, :uint, :pointer ], :int
  attach_function :JS_EvaluateUCScript, [ :pointer, :pointer, :pointer, :uint, :string, :uint, :pointer ], :int
  attach_function :JS_EvaluateUCScriptForPrincipals, [ :pointer, :pointer, :pointer, :pointer, :uint, :string, :uint, :pointer ], :int
  attach_function :JS_CallFunction, [ :pointer, :pointer, :pointer, :uint, :pointer, :pointer ], :int
  attach_function :JS_CallFunctionName, [ :pointer, :pointer, :string, :uint, :pointer, :pointer ], :int
  attach_function :JS_CallFunctionValue, [ :pointer, :pointer, :long, :uint, :pointer, :pointer ], :int
  JS_OPERATION_WEIGHT_BASE = 4096
  attach_function :JS_SetOperationCallback, [ :pointer, :JSOperationCallback, :uint ], :void
  attach_function :JS_ClearOperationCallback, [ :pointer ], :void
  attach_function :JS_GetOperationCallback, [ :pointer ], :JSOperationCallback
  attach_function :JS_GetOperationLimit, [ :pointer ], :uint
  attach_function :JS_SetOperationLimit, [ :pointer, :uint ], :void
  attach_function :JS_SetBranchCallback, [ :pointer, :JSBranchCallback ], :JSBranchCallback
  attach_function :JS_IsRunning, [ :pointer ], :int
  attach_function :JS_IsConstructing, [ :pointer ], :int
  attach_function :JS_IsAssigning, [ :pointer ], :int
  attach_function :JS_SetCallReturnValue2, [ :pointer, :long ], :void
  attach_function :JS_SaveFrameChain, [ :pointer ], :pointer
  attach_function :JS_RestoreFrameChain, [ :pointer, :pointer ], :void
  attach_function :JS_NewString, [ :pointer, :string, :uint ], :pointer
  attach_function :JS_NewStringCopyN, [ :pointer, :string, :uint ], :pointer
  attach_function :JS_NewStringCopyZ, [ :pointer, :string ], :pointer
  attach_function :JS_InternString, [ :pointer, :string ], :pointer
  attach_function :JS_NewUCString, [ :pointer, :pointer, :uint ], :pointer
  attach_function :JS_NewUCStringCopyN, [ :pointer, :pointer, :uint ], :pointer
  attach_function :JS_NewUCStringCopyZ, [ :pointer, :pointer ], :pointer
  attach_function :JS_InternUCStringN, [ :pointer, :pointer, :uint ], :pointer
  attach_function :JS_InternUCString, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetStringBytes, [ :pointer ], :string
  attach_function :JS_GetStringChars, [ :pointer ], :pointer
  attach_function :JS_GetStringLength, [ :pointer ], :uint
  attach_function :JS_CompareStrings, [ :pointer, :pointer ], :int
  attach_function :JS_NewGrowableString, [ :pointer, :pointer, :uint ], :pointer
  attach_function :JS_NewDependentString, [ :pointer, :pointer, :uint, :uint ], :pointer
  attach_function :JS_ConcatStrings, [ :pointer, :pointer, :pointer ], :pointer
  attach_function :JS_UndependString, [ :pointer, :pointer ], :pointer
  attach_function :JS_MakeStringImmutable, [ :pointer, :pointer ], :int
  attach_function :JS_CStringsAreUTF8, [  ], :int
  attach_function :JS_SetCStringsAreUTF8, [  ], :void
  attach_function :JS_EncodeCharacters, [ :pointer, :pointer, :uint, :string, :pointer ], :int
  attach_function :JS_DecodeBytes, [ :pointer, :string, :uint, :pointer, :pointer ], :int
  attach_function :JS_EncodeString, [ :pointer, :pointer ], :string
  class JSLocaleCallbacks < FFI::Struct
    layout(
           :localeToUpperCase, :JSLocaleToUpperCase,
           :localeToLowerCase, :JSLocaleToLowerCase,
           :localeCompare, :JSLocaleCompare,
           :localeToUnicode, :JSLocaleToUnicode,
           :localeGetErrorMessage, :JSErrorCallback
    )
    def localeToUpperCase=(cb)
      @localeToUpperCase = cb
      self[:localeToUpperCase] = @localeToUpperCase
    end
    def localeToUpperCase
      @localeToUpperCase
    end
    def localeToLowerCase=(cb)
      @localeToLowerCase = cb
      self[:localeToLowerCase] = @localeToLowerCase
    end
    def localeToLowerCase
      @localeToLowerCase
    end
    def localeCompare=(cb)
      @localeCompare = cb
      self[:localeCompare] = @localeCompare
    end
    def localeCompare
      @localeCompare
    end
    def localeToUnicode=(cb)
      @localeToUnicode = cb
      self[:localeToUnicode] = @localeToUnicode
    end
    def localeToUnicode
      @localeToUnicode
    end
    def localeGetErrorMessage=(cb)
      @localeGetErrorMessage = cb
      self[:localeGetErrorMessage] = @localeGetErrorMessage
    end
    def localeGetErrorMessage
      @localeGetErrorMessage
    end

  end
  attach_function :JS_SetLocaleCallbacks, [ :pointer, :pointer ], :void
  attach_function :JS_GetLocaleCallbacks, [ :pointer ], :pointer
  attach_function :JS_ReportError, [ :pointer, :string, :varargs ], :void
  attach_function :JS_ReportErrorNumber, [ :pointer, :JSErrorCallback, :pointer, :uint, :varargs ], :void
  attach_function :JS_ReportErrorNumberUC, [ :pointer, :JSErrorCallback, :pointer, :uint, :varargs ], :void
  attach_function :JS_ReportWarning, [ :pointer, :string, :varargs ], :int
  attach_function :JS_ReportErrorFlagsAndNumber, [ :pointer, :uint, :JSErrorCallback, :pointer, :uint, :varargs ], :int
  attach_function :JS_ReportErrorFlagsAndNumberUC, [ :pointer, :uint, :JSErrorCallback, :pointer, :uint, :varargs ], :int
  attach_function :JS_ReportOutOfMemory, [ :pointer ], :void
  attach_function :JS_ReportAllocationOverflow, [ :pointer ], :void
  class JSErrorReport < FFI::Struct
    layout(
           :filename, :pointer,
           :lineno, :uint,
           :linebuf, :pointer,
           :tokenptr, :pointer,
           :uclinebuf, :pointer,
           :uctokenptr, :pointer,
           :flags, :uint,
           :errorNumber, :uint,
           :ucmessage, :pointer,
           :messageArgs, :pointer
    )
    def filename=(str)
      @filename = FFI::MemoryPointer.from_string(str)
      self[:filename] = @filename
    end
    def filename
      @filename.get_string(0)
    end
    def linebuf=(str)
      @linebuf = FFI::MemoryPointer.from_string(str)
      self[:linebuf] = @linebuf
    end
    def linebuf
      @linebuf.get_string(0)
    end
    def tokenptr=(str)
      @tokenptr = FFI::MemoryPointer.from_string(str)
      self[:tokenptr] = @tokenptr
    end
    def tokenptr
      @tokenptr.get_string(0)
    end

  end
  JSREPORT_ERROR = 0x0
  JSREPORT_WARNING = 0x1
  JSREPORT_EXCEPTION = 0x2
  JSREPORT_STRICT = 0x4
  attach_function :JS_SetErrorReporter, [ :pointer, :JSErrorReporter ], :JSErrorReporter
  JSREG_FOLD = 0x01
  JSREG_GLOB = 0x02
  JSREG_MULTILINE = 0x04
  JSREG_STICKY = 0x08
  attach_function :JS_NewRegExpObject, [ :pointer, :string, :uint, :uint ], :pointer
  attach_function :JS_NewUCRegExpObject, [ :pointer, :pointer, :uint, :uint ], :pointer
  attach_function :JS_SetRegExpInput, [ :pointer, :pointer, :int ], :void
  attach_function :JS_ClearRegExpStatics, [ :pointer ], :void
  attach_function :JS_ClearRegExpRoots, [ :pointer ], :void
  attach_function :JS_IsExceptionPending, [ :pointer ], :int
  attach_function :JS_GetPendingException, [ :pointer, :pointer ], :int
  attach_function :JS_SetPendingException, [ :pointer, :long ], :void
  attach_function :JS_ClearPendingException, [ :pointer ], :void
  attach_function :JS_ReportPendingException, [ :pointer ], :int
  attach_function :JS_SaveExceptionState, [ :pointer ], :pointer
  attach_function :JS_RestoreExceptionState, [ :pointer, :pointer ], :void
  attach_function :JS_DropExceptionState, [ :pointer, :pointer ], :void
  attach_function :JS_ErrorFromException, [ :pointer, :long ], :pointer
  attach_function :JS_ThrowReportedError, [ :pointer, :string, :pointer ], :int
  attach_function :JS_ThrowStopIteration, [ :pointer ], :int
  attach_function :JS_GetContextThread, [ :pointer ], :long
  attach_function :JS_SetContextThread, [ :pointer ], :long
  attach_function :JS_ClearContextThread, [ :pointer ], :long
  JS_GC_ZEAL = 1
  attach_function :JS_SetGCZeal, [ :pointer, :uchar ], :void
  JS_HASH_BITS = 32
  JS_GOLDEN_RATIO = 0x9E3779B9
  callback(:JSHashFunction, [ :pointer ], :uint)
  callback(:JSHashComparator, [ :pointer, :pointer ], :int)
  callback(:JSHashEnumerator, [ :pointer, :int, :pointer ], :int)
  HT_ENUMERATE_NEXT = 0
  HT_ENUMERATE_STOP = 1
  HT_ENUMERATE_REMOVE = 2
  class JSHashAllocOps < FFI::Struct
    layout(
           :allocTable, callback([ :pointer, :uint ], :pointer),
           :freeTable, callback([ :pointer, :pointer ], :void),
           :allocEntry, callback([ :pointer, :pointer ], :pointer),
           :freeEntry, callback([ :pointer, :pointer, :uint ], :void)
    )
    def allocTable=(cb)
      @allocTable = cb
      self[:allocTable] = @allocTable
    end
    def allocTable
      @allocTable
    end
    def freeTable=(cb)
      @freeTable = cb
      self[:freeTable] = @freeTable
    end
    def freeTable
      @freeTable
    end
    def allocEntry=(cb)
      @allocEntry = cb
      self[:allocEntry] = @allocEntry
    end
    def allocEntry
      @allocEntry
    end
    def freeEntry=(cb)
      @freeEntry = cb
      self[:freeEntry] = @freeEntry
    end
    def freeEntry
      @freeEntry
    end

  end
  HT_FREE_VALUE = 0
  HT_FREE_ENTRY = 1
  class JSHashEntry < FFI::Struct
    layout(
           :next, :pointer,
           :keyHash, :uint,
           :key, :pointer,
           :value, :pointer
    )
  end
  class JSHashTable < FFI::Struct
    layout(
           :buckets, :pointer,
           :nentries, :uint,
           :shift, :uint,
           :keyHash, :JSHashFunction,
           :keyCompare, :JSHashComparator,
           :valueCompare, :JSHashComparator,
           :allocOps, :pointer,
           :allocPool, :pointer
    )
    def keyHash=(cb)
      @keyHash = cb
      self[:keyHash] = @keyHash
    end
    def keyHash
      @keyHash
    end
    def keyCompare=(cb)
      @keyCompare = cb
      self[:keyCompare] = @keyCompare
    end
    def keyCompare
      @keyCompare
    end
    def valueCompare=(cb)
      @valueCompare = cb
      self[:valueCompare] = @valueCompare
    end
    def valueCompare
      @valueCompare
    end

  end
  attach_function :JS_NewHashTable, [ :uint, :JSHashFunction, :JSHashComparator, :JSHashComparator, :pointer, :pointer ], :pointer
  attach_function :JS_HashTableDestroy, [ :pointer ], :void
  attach_function :JS_HashTableRawLookup, [ :pointer, :uint, :pointer ], :pointer
  attach_function :JS_HashTableRawAdd, [ :pointer, :pointer, :uint, :pointer, :pointer ], :pointer
  attach_function :JS_HashTableRawRemove, [ :pointer, :pointer, :pointer ], :void
  attach_function :JS_HashTableAdd, [ :pointer, :pointer, :pointer ], :pointer
  attach_function :JS_HashTableRemove, [ :pointer, :pointer ], :int
  attach_function :JS_HashTableEnumerateEntries, [ :pointer, :JSHashEnumerator, :pointer ], :int
  attach_function :JS_HashTableLookup, [ :pointer, :pointer ], :pointer
  attach_function :JS_HashTableDump, [ :pointer, :JSHashEnumerator, :pointer ], :int
  attach_function :JS_HashString, [ :pointer ], :uint
  attach_function :JS_CompareValues, [ :pointer, :pointer ], :int
  JS_BITS_PER_UINT32_LOG2 = 5
  JS_BITS_PER_UINT32 = 32
  JSTRAP_ERROR = 0
  JSTRAP_CONTINUE = 1
  JSTRAP_RETURN = 2
  JSTRAP_THROW = 3
  JSTRAP_LIMIT = 4

  callback(:JSTrapHandler, [ :pointer, :pointer, :pointer, :pointer, :pointer ], :int)
  callback(:JSWatchPointHandler, [ :pointer, :pointer, :long, :long, :pointer, :pointer ], :int)
  callback(:JSNewScriptHook, [ :pointer, :string, :uint, :pointer, :pointer, :pointer ], :void)
  callback(:JSDestroyScriptHook, [ :pointer, :pointer, :pointer ], :void)
  callback(:JSSourceHandler, [ :string, :uint, :pointer, :uint, :pointer, :pointer ], :void)
  callback(:JSInterpreterHook, [ :pointer, :pointer, :int, :pointer, :pointer ], :pointer)
  callback(:JSObjectHook, [ :pointer, :pointer, :int, :pointer ], :void)
  callback(:JSDebugErrorHook, [ :pointer, :string, :pointer, :pointer ], :int)
  class JSDebugHooks < FFI::Struct
    layout(
           :interruptHandler, :JSTrapHandler,
           :interruptHandlerData, :pointer,
           :newScriptHook, :JSNewScriptHook,
           :newScriptHookData, :pointer,
           :destroyScriptHook, :JSDestroyScriptHook,
           :destroyScriptHookData, :pointer,
           :debuggerHandler, :JSTrapHandler,
           :debuggerHandlerData, :pointer,
           :sourceHandler, :JSSourceHandler,
           :sourceHandlerData, :pointer,
           :executeHook, :JSInterpreterHook,
           :executeHookData, :pointer,
           :callHook, :JSInterpreterHook,
           :callHookData, :pointer,
           :objectHook, :JSObjectHook,
           :objectHookData, :pointer,
           :throwHook, :JSTrapHandler,
           :throwHookData, :pointer,
           :debugErrorHook, :JSDebugErrorHook,
           :debugErrorHookData, :pointer
    )
    def interruptHandler=(cb)
      @interruptHandler = cb
      self[:interruptHandler] = @interruptHandler
    end
    def interruptHandler
      @interruptHandler
    end
    def newScriptHook=(cb)
      @newScriptHook = cb
      self[:newScriptHook] = @newScriptHook
    end
    def newScriptHook
      @newScriptHook
    end
    def destroyScriptHook=(cb)
      @destroyScriptHook = cb
      self[:destroyScriptHook] = @destroyScriptHook
    end
    def destroyScriptHook
      @destroyScriptHook
    end
    def debuggerHandler=(cb)
      @debuggerHandler = cb
      self[:debuggerHandler] = @debuggerHandler
    end
    def debuggerHandler
      @debuggerHandler
    end
    def sourceHandler=(cb)
      @sourceHandler = cb
      self[:sourceHandler] = @sourceHandler
    end
    def sourceHandler
      @sourceHandler
    end
    def executeHook=(cb)
      @executeHook = cb
      self[:executeHook] = @executeHook
    end
    def executeHook
      @executeHook
    end
    def callHook=(cb)
      @callHook = cb
      self[:callHook] = @callHook
    end
    def callHook
      @callHook
    end
    def objectHook=(cb)
      @objectHook = cb
      self[:objectHook] = @objectHook
    end
    def objectHook
      @objectHook
    end
    def throwHook=(cb)
      @throwHook = cb
      self[:throwHook] = @throwHook
    end
    def throwHook
      @throwHook
    end
    def debugErrorHook=(cb)
      @debugErrorHook = cb
      self[:debugErrorHook] = @debugErrorHook
    end
    def debugErrorHook
      @debugErrorHook
    end

  end
  callback(:JSTempValueTrace, [ :pointer, :pointer ], :void)
  class JSTempValueUnion < FFI::Union
    layout(
           :value, :long,
           :object, :pointer,
           :string, :pointer,
           :xml, :pointer,
           :qname, :pointer,
           :nspace, :pointer,
           :trace, :JSTempValueTrace,
           :sprop, :pointer,
           :weakRoots, :pointer,
           :parseContext, :pointer,
           :script, :pointer,
           :array, :pointer
    )
    def trace=(cb)
      @trace = cb
      self[:trace] = @trace
    end
    def trace
      @trace
    end

  end
  class JSTempValueRooter < FFI::Struct
    layout(
           :down, :pointer,
           :count, :long,
           :u, JSTempValueUnion
    )
  end
  attach_function :js_UntrapScriptCode, [ :pointer, :pointer ], :pointer
  attach_function :JS_SetTrap, [ :pointer, :pointer, :pointer, :JSTrapHandler, :pointer ], :int
  attach_function :JS_GetTrapOpcode, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_ClearTrap, [ :pointer, :pointer, :pointer, :pointer, :pointer ], :void
  attach_function :JS_ClearScriptTraps, [ :pointer, :pointer ], :void
  attach_function :JS_ClearAllTraps, [ :pointer ], :void
  attach_function :JS_HandleTrap, [ :pointer, :pointer, :pointer, :pointer ], :int
  attach_function :JS_SetInterrupt, [ :pointer, :JSTrapHandler, :pointer ], :int
  attach_function :JS_ClearInterrupt, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_SetWatchPoint, [ :pointer, :pointer, :long, :JSWatchPointHandler, :pointer ], :int
  attach_function :JS_ClearWatchPoint, [ :pointer, :pointer, :long, :pointer, :pointer ], :int
  attach_function :JS_ClearWatchPointsForObject, [ :pointer, :pointer ], :int
  attach_function :JS_ClearAllWatchPoints, [ :pointer ], :int
  attach_function :JS_PCToLineNumber, [ :pointer, :pointer, :pointer ], :uint
  attach_function :JS_LineNumberToPC, [ :pointer, :pointer, :uint ], :pointer
  attach_function :JS_GetFunctionScript, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetFunctionNative, [ :pointer, :pointer ], :JSNative
  attach_function :JS_GetFunctionFastNative, [ :pointer, :pointer ], :JSFastNative
  attach_function :JS_GetScriptPrincipals, [ :pointer, :pointer ], :pointer
  attach_function :JS_FrameIterator, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetFrameScript, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetFramePC, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetScriptedCaller, [ :pointer, :pointer ], :pointer
  attach_function :JS_StackFramePrincipals, [ :pointer, :pointer ], :pointer
  attach_function :JS_EvalFramePrincipals, [ :pointer, :pointer, :pointer ], :pointer
  attach_function :JS_GetFrameAnnotation, [ :pointer, :pointer ], :pointer
  attach_function :JS_SetFrameAnnotation, [ :pointer, :pointer, :pointer ], :void
  attach_function :JS_GetFramePrincipalArray, [ :pointer, :pointer ], :pointer
  attach_function :JS_IsNativeFrame, [ :pointer, :pointer ], :int
  attach_function :JS_GetFrameObject, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetFrameScopeChain, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetFrameCallObject, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetFrameThis, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetFrameFunction, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetFrameFunctionObject, [ :pointer, :pointer ], :pointer
  attach_function :JS_IsConstructorFrame, [ :pointer, :pointer ], :int
  attach_function :JS_IsDebuggerFrame, [ :pointer, :pointer ], :int
  attach_function :JS_GetFrameReturnValue, [ :pointer, :pointer ], :long
  attach_function :JS_SetFrameReturnValue, [ :pointer, :pointer, :long ], :void
  attach_function :JS_GetFrameCalleeObject, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetScriptFilename, [ :pointer, :pointer ], :string
  attach_function :JS_GetScriptBaseLineNumber, [ :pointer, :pointer ], :uint
  attach_function :JS_GetScriptLineExtent, [ :pointer, :pointer ], :uint
  attach_function :JS_GetScriptVersion, [ :pointer, :pointer ], :int
  attach_function :JS_SetNewScriptHookProc, [ :pointer, :JSNewScriptHook, :pointer ], :void
  attach_function :JS_SetDestroyScriptHookProc, [ :pointer, :JSDestroyScriptHook, :pointer ], :void
  attach_function :JS_EvaluateUCInStackFrame, [ :pointer, :pointer, :pointer, :uint, :string, :uint, :pointer ], :int
  attach_function :JS_EvaluateInStackFrame, [ :pointer, :pointer, :string, :uint, :string, :uint, :pointer ], :int
  class JSPropertyDesc < FFI::Struct
    layout(
           :id, :long,
           :value, :long,
           :flags, :uchar,
           :spare, :uchar,
           :slot, :ushort,
           :alias, :long
    )
  end
  JSPD_ENUMERATE = 0x01
  JSPD_READONLY = 0x02
  JSPD_PERMANENT = 0x04
  JSPD_ALIAS = 0x08
  JSPD_ARGUMENT = 0x10
  JSPD_VARIABLE = 0x20
  JSPD_EXCEPTION = 0x40
  JSPD_ERROR = 0x80
  class JSPropertyDescArray < FFI::Struct
    layout(
           :length, :uint,
           :array, :pointer
    )
  end
  attach_function :JS_PropertyIterator, [ :pointer, :pointer ], :pointer
  attach_function :JS_GetPropertyDesc, [ :pointer, :pointer, :pointer, :pointer ], :int
  attach_function :JS_GetPropertyDescArray, [ :pointer, :pointer, :pointer ], :int
  attach_function :JS_PutPropertyDescArray, [ :pointer, :pointer ], :void
  attach_function :JS_SetDebuggerHandler, [ :pointer, :JSTrapHandler, :pointer ], :int
  attach_function :JS_SetSourceHandler, [ :pointer, :JSSourceHandler, :pointer ], :int
  attach_function :JS_SetExecuteHook, [ :pointer, :JSInterpreterHook, :pointer ], :int
  attach_function :JS_SetCallHook, [ :pointer, :JSInterpreterHook, :pointer ], :int
  attach_function :JS_SetObjectHook, [ :pointer, :JSObjectHook, :pointer ], :int
  attach_function :JS_SetThrowHook, [ :pointer, :JSTrapHandler, :pointer ], :int
  attach_function :JS_SetDebugErrorHook, [ :pointer, :JSDebugErrorHook, :pointer ], :int
  attach_function :JS_GetObjectTotalSize, [ :pointer, :pointer ], :uint
  attach_function :JS_GetFunctionTotalSize, [ :pointer, :pointer ], :uint
  attach_function :JS_GetScriptTotalSize, [ :pointer, :pointer ], :uint
  attach_function :JS_GetTopScriptFilenameFlags, [ :pointer, :pointer ], :uint
  attach_function :JS_GetScriptFilenameFlags, [ :pointer ], :uint
  attach_function :JS_FlagScriptFilenamePrefix, [ :pointer, :string, :uint ], :int
  JSFILENAME_NULL = 0xffffffff
  JSFILENAME_SYSTEM = 0x00000001
  JSFILENAME_PROTECTED = 0x00000002
  attach_function :JS_IsSystemObject, [ :pointer, :pointer ], :int
  attach_function :JS_NewSystemObject, [ :pointer, :pointer, :pointer, :pointer, :int ], :pointer
  attach_function :JS_GetGlobalDebugHooks, [ :pointer ], :pointer
  attach_function :JS_SetContextDebugHooks, [ :pointer, :pointer ], :pointer
  class JSObjectMap < FFI::Struct
    layout(
           :nrefs, :int,
           :ops, :pointer,
           :freeslot, :uint
    )
  end
  JS_INITIAL_NSLOTS = 6
  class JSObject < FFI::Struct
    layout(
           :map, :pointer,
           :fslots, [:long, 6],
           :dslots, :pointer
    )
  end
  JSSLOT_PROTO = 0
  JSSLOT_PARENT = 1
  JSSLOT_CLASS = 2
  JSSLOT_PRIVATE = 3
  JSSLOT_BLOCK_DEPTH = (3+1)
  attach_function :js_NewWithObject, [ :pointer, :pointer, :pointer, :int ], :pointer
  attach_function :js_NewBlockObject, [ :pointer ], :pointer
  attach_function :js_CloneBlockObject, [ :pointer, :pointer, :pointer, :pointer ], :pointer
  attach_function :js_PutBlockObject, [ :pointer, :int ], :int
  class JSSharpObjectMap < FFI::Struct
    layout(
           :depth, :int,
           :sharpgen, :uint,
           :table, :pointer
    )
  end
  SHARP_ID_SHIFT = 2
  attach_function :js_EnterSharpObject, [ :pointer, :pointer, :pointer, :pointer ], :pointer
  attach_function :js_LeaveSharpObject, [ :pointer, :pointer ], :void
  attach_function :js_TraceSharpMap, [ :pointer, :pointer ], :void
  attach_function :js_HasOwnPropertyHelper, [ :pointer, :JSLookupPropOp, :pointer ], :int
  attach_function :js_InitBlockClass, [ :pointer, :pointer ], :pointer
  attach_function :js_InitEval, [ :pointer, :pointer ], :pointer
  attach_function :js_InitObjectClass, [ :pointer, :pointer ], :pointer
  attach_function :js_InitObjectMap, [ :pointer, :int, :pointer, :pointer ], :void
  attach_function :js_NewObjectMap, [ :pointer, :int, :pointer, :pointer, :pointer ], :pointer
  attach_function :js_DestroyObjectMap, [ :pointer, :pointer ], :void
  attach_function :js_HoldObjectMap, [ :pointer, :pointer ], :pointer
  attach_function :js_DropObjectMap, [ :pointer, :pointer, :pointer ], :pointer
  attach_function :js_GetClassId, [ :pointer, :pointer, :pointer ], :int
  attach_function :js_NewObject, [ :pointer, :pointer, :pointer, :pointer, :uint ], :pointer
  attach_function :js_NewObjectWithGivenProto, [ :pointer, :pointer, :pointer, :pointer, :uint ], :pointer
  attach_function :js_GetClassObject, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :js_SetClassObject, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :js_FindClassObject, [ :pointer, :pointer, :long, :pointer ], :int
  attach_function :js_ConstructObject, [ :pointer, :pointer, :pointer, :pointer, :uint, :pointer ], :pointer
  attach_function :js_FinalizeObject, [ :pointer, :pointer ], :void
  attach_function :js_AllocSlot, [ :pointer, :pointer, :pointer ], :int
  attach_function :js_FreeSlot, [ :pointer, :pointer, :uint ], :void
  JSVAL_INT_MAX_STRING = 1073741823
  attach_function :js_CheckForStringIndex, [ :long, :pointer, :pointer, :int ], :long
  attach_function :js_AddNativeProperty, [ :pointer, :pointer, :long, :JSPropertyOp, :JSPropertyOp, :uint, :uint, :uint, :int ], :pointer
  attach_function :js_ChangeNativePropertyAttrs, [ :pointer, :pointer, :pointer, :uint, :uint, :JSPropertyOp, :JSPropertyOp ], :pointer
  attach_function :js_DefineProperty, [ :pointer, :pointer, :long, :long, :JSPropertyOp, :JSPropertyOp, :uint, :pointer ], :int
  attach_function :js_DefineNativeProperty, [ :pointer, :pointer, :long, :long, :JSPropertyOp, :JSPropertyOp, :uint, :uint, :int, :pointer ], :int
  attach_function :js_LookupProperty, [ :pointer, :pointer, :long, :pointer, :pointer ], :int
  attach_function :js_LookupPropertyWithFlags, [ :pointer, :pointer, :long, :uint, :pointer, :pointer ], :int
  attach_function :js_FindPropertyHelper, [ :pointer, :long, :pointer, :pointer, :pointer, :pointer ], :int
  attach_function :js_FindProperty, [ :pointer, :long, :pointer, :pointer, :pointer ], :int
  attach_function :js_FindIdentifierBase, [ :pointer, :long, :pointer ], :pointer
  attach_function :js_NativeGet, [ :pointer, :pointer, :pointer, :pointer, :pointer ], :int
  attach_function :js_NativeSet, [ :pointer, :pointer, :pointer, :pointer ], :int
  attach_function :js_GetPropertyHelper, [ :pointer, :pointer, :long, :pointer, :pointer ], :int
  attach_function :js_GetProperty, [ :pointer, :pointer, :long, :pointer ], :int
  attach_function :js_SetPropertyHelper, [ :pointer, :pointer, :long, :pointer, :pointer ], :int
  attach_function :js_SetProperty, [ :pointer, :pointer, :long, :pointer ], :int
  attach_function :js_GetAttributes, [ :pointer, :pointer, :long, :pointer, :pointer ], :int
  attach_function :js_SetAttributes, [ :pointer, :pointer, :long, :pointer, :pointer ], :int
  attach_function :js_DeleteProperty, [ :pointer, :pointer, :long, :pointer ], :int
  attach_function :js_DefaultValue, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :js_NewIdArray, [ :pointer, :int ], :pointer
  attach_function :js_SetIdArrayLength, [ :pointer, :pointer, :int ], :pointer
  attach_function :js_Enumerate, [ :pointer, :pointer, :int, :pointer, :pointer ], :int
  attach_function :js_TraceNativeIteratorStates, [ :pointer ], :void
  attach_function :js_CheckAccess, [ :pointer, :pointer, :long, :int, :pointer, :pointer ], :int
  attach_function :js_Call, [ :pointer, :pointer, :uint, :pointer, :pointer ], :int
  attach_function :js_Construct, [ :pointer, :pointer, :uint, :pointer, :pointer ], :int
  attach_function :js_HasInstance, [ :pointer, :pointer, :long, :pointer ], :int
  attach_function :js_SetProtoOrParent, [ :pointer, :pointer, :uint, :pointer ], :int
  attach_function :js_IsDelegate, [ :pointer, :pointer, :long, :pointer ], :int
  attach_function :js_GetClassPrototype, [ :pointer, :pointer, :long, :pointer ], :int
  attach_function :js_SetClassPrototype, [ :pointer, :pointer, :pointer, :uint ], :int
  attach_function :js_PrimitiveToObject, [ :pointer, :pointer ], :int
  attach_function :js_ValueToObject, [ :pointer, :long, :pointer ], :int
  attach_function :js_ValueToNonNullObject, [ :pointer, :long ], :pointer
  attach_function :js_TryValueOf, [ :pointer, :pointer, :int, :pointer ], :int
  attach_function :js_TryMethod, [ :pointer, :pointer, :pointer, :uint, :pointer, :pointer ], :int
  attach_function :js_XDRObject, [ :pointer, :pointer ], :int
  attach_function :js_TraceObject, [ :pointer, :pointer ], :void
  attach_function :js_PrintObjectSlotName, [ :pointer, :string, :uint ], :void
  attach_function :js_Clear, [ :pointer, :pointer ], :void
  attach_function :js_GetRequiredSlot, [ :pointer, :pointer, :uint ], :long
  attach_function :js_SetRequiredSlot, [ :pointer, :pointer, :uint, :long ], :int
  attach_function :js_CheckScopeChainValidity, [ :pointer, :pointer, :string ], :pointer
  attach_function :js_CheckPrincipalsAccess, [ :pointer, :pointer, :pointer, :pointer ], :int
  attach_function :js_GetWrappedObject, [ :pointer, :pointer ], :pointer
  attach_function :js_ComputeFilename, [ :pointer, :pointer, :pointer, :pointer ], :string

end
