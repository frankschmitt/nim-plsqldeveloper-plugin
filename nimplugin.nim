import winim/lean

# C++: char* IdentifyPlugIn(int ID)
# proc IdentifyPlugin(id: int): cstring {.importc, cdecl.} = 
#proc IdentifyPlugin(id: int): cstring {.stdcall,exportc,dynlib.} = 
proc IdentifyPlugIn(id: int): cstring {.cdecl,exportc,dynlib.} = 
  result = "Nim PL/SQL Developer Plugin"


proc CreateMenuItem(Index: int): cstring {.cdecl,exportc,dynlib.} = 
    if Index == 1: 
      result = "About"
    else:
      result = ""

proc OnMenuClick(Index: int) {.cdecl,exportc,dynlib.} = 
    MessageBox(0, "Hello, world !", "Nim is Powerful", 0)
