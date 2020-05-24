import winim/lean

var pluginId: int

let
  # Menu entries
  TAB_NAME_NIM = "TAB=Nim plugin"
  GROUP_NAME_FLYWAY = "GROUP=Flyway"
  ITEM_NAME_VERSIONED_MIGRATION = "ITEM=Versioned migration"
  ITEM_NAME_REPEATABLE_MIGRATION = "ITEM=Repeatable migration"
  ITEM_NAME_ABOUT = "ITEM=About"
  # misc info
  VERSION_INFO = "Nim Pl/SQL Developer plugin, V0.1"
  
  
# Identify the plugin 
proc IdentifyPlugIn(id: int): cstring {.cdecl,exportc,dynlib.} = 
  pluginId = id
  result = "Nim PL/SQL Developer Plugin"

proc CreateMenuItem(Index: int): cstring {.cdecl,exportc,dynlib.} = 
    if Index == 1:
      result = TAB_NAME_NIM
    elif Index == 10:
      result = GROUP_NAME_FLYWAY
    elif Index == 11:
      result = ITEM_NAME_VERSIONED_MIGRATION
    elif Index == 12: 
      result = ITEM_NAME_REPEATABLE_MIGRATION
    elif Index == 13:
      result = ITEM_NAME_ABOUT
    else:
      result = ""

proc OnMenuClick(Index: int) {.cdecl,exportc,dynlib.} = 
    MessageBox(0, VERSION_INFO, "About Nim PL/SQL Developer Plugin", 0)
