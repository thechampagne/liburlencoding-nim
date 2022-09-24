proc url_encoding_encode(data: cstring): ptr cchar {.importc.}

proc url_encoding_encode_binary(data: cstring, length: csize_t): ptr cchar {.importc.}

proc url_encoding_decode(data: cstring): ptr cchar {.importc.}

proc url_encoding_decode_binary(data: cstring, length: csize_t): ptr cchar {.importc.}

proc url_encoding_free(data: ptr cchar) {.importc.}

proc encode*(data: string): string =
  ## Percent-encodes every byte except alphanumerics and -, _, ., ~. Assumes UTF-8 encoding.
  ## 
  ## Example:
  ## * *
  ## let res = encode("This string will be URL encoded.")
  ## echo res
  ## * *
  ## 
  ## @param data
  ## @return encoded string
  let res = url_encoding_encode(cstring(data))
  if res == nil:
    return ""
  let str: string = $cstring(res)
  url_encoding_free(res)
  return str

proc encodeBinary*(data: string): string =
  ## Percent-encodes every byte except alphanumerics and -, _, ., ~.
  ## 
  ## Example:
  ## * *
  ## let res = encodeBinary("This string will be URL encoded.")
  ## echo res
  ## * *
  ## 
  ## @param data
  ## @return encoded string
  let res = url_encoding_encode_binary(cstring(data), csize_t(len(data)))
  if res == nil:
    return ""
  let str: string = $cstring(res)
  url_encoding_free(res)
  return str

proc decode*(data: string): string =
  ## Decode percent-encoded string assuming UTF-8 encoding.
  ## 
  ## Example:
  ## * *
  ## let res = decode("%F0%9F%91%BE%20Exterminate%21")
  ## echo res
  ## * *
  ## 
  ## @param data
  ## @return decoded string
  let res = url_encoding_decode(cstring(data))
  if res == nil:
    return ""
  let str: string = $cstring(res)
  url_encoding_free(res)
  return str

proc decodeBinary*(data: string): string =
  ## Decode percent-encoded string as binary data, in any encoding.
  ## 
  ## Example:
  ## * *
  ## let res = decodeBinary("%F1%F2%F3%C0%C1%C2")
  ## echo res
  ## * *
  ## 
  ## @param data
  ## @return decoded string
  let res = url_encoding_decode_binary(cstring(data), csize_t(len(data)))
  if res == nil:
    return ""
  let str: string = $cstring(res)
  url_encoding_free(res)
  return str