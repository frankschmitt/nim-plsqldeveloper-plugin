import winim/lean
import sugar # for easier declaration of function pointers

var pluginId: int

let
  # Menu entry ids
  ID_TAB_NIM = 1 
  ID_GROUP_FLYWAY = 10

  # Menu entry captions
  TAB_NAME_NIM = "TAB=Nim plugin"
  GROUP_NAME_FLYWAY = "GROUP=Flyway"
  ITEM_NAME_VERSIONED_MIGRATION = "ITEM=Versioned migration"
  ITEM_NAME_REPEATABLE_MIGRATION = "ITEM=Repeatable migration"
  ITEM_NAME_ABOUT = "ITEM=About"
  # misc info
  VERSION_INFO = "Nim Pl/SQL Developer plugin, V0.1"
 
#type fptr2 = (proc():bool) {.cdecl.}
#type 
#  fptr2 = (() -> bool) {.cdecl.}

# crashes compiler!
# type fptr2 = ptr (() -> bool)
type Fptr2 = ptr (() -> bool)

var IDE_Connected*: Fptr2
#Seek* = proc (context: PRWops, offset: int, whence: int): int{.cdecl.}

#proc RegisterCallback(index: int; addr: ptr) {.cdecl,exportc,dynlib.} = 
proc RegisterCallback(index: int) {.cdecl,exportc,dynlib.} = 
  if index == 11:
    #IDE_Connected = cast[Fptr2](addr)
    print("x")
  
#begin
#case Index of
#10 : @IDE_MenuState := Addr;
#11 : @IDE_Connected := Addr;
#12 : @IDE_GetConnectionInfo := Addr;
#13 : @IDE_GetBrowserInfo := Addr;
#end;
#end;

###########################################
# helper functions
###########################################
proc CreateVersionedMigration() =  
    #let api = API.lock().unwrap();
    #let sql = (api.ide_get_selected_text)();
    # construct filename: V<timestamp>_<basename>.sql
    # we include milliseconds in the timestamp to avoid collisions if two developers create migrations
    # at the exact same second
    #let now = Utc::now();
    #let version = now.format("V%Y_%m_%d_%H_%M_%S%.3f__");
    # let basename =  get_save_file_name();
    # let filename = format!("{}{}", version, basename.into_string().expect("Invalid basename"));
    #write_sql_to_file(sql, filename)
    MessageBox(0, "Create versioned migration", "Hier koennte Ihr Text stehen", 0)



###########################################
# PL/SQL Developer Plugin API
###########################################
  
# Identify the plugin 
proc IdentifyPlugIn(id: int): cstring {.cdecl,exportc,dynlib.} = 
  pluginId = id
  result = "Nim PL/SQL Developer Plugin"

# Show an about message
proc About(): cstring {.cdecl,exportc,dynlib.} = 
    MessageBox(0, VERSION_INFO, "About Nim PL/SQL Developer Plugin", 0)
    # return an empty string to indicate to the host app that we take care of showing the dialog ourselves
    result = "" 

# Create menu items (ribbon tab, group, item)
proc CreateMenuItem(Index: int): cstring {.cdecl,exportc,dynlib.} = 
    if Index == ID_TAB_NIM:
      result = TAB_NAME_NIM
    elif Index == ID_GROUP_FLYWAY:
      result = GROUP_NAME_FLYWAY
    elif Index == 11:
      result = ITEM_NAME_VERSIONED_MIGRATION
    elif Index == 12: 
      result = ITEM_NAME_REPEATABLE_MIGRATION
    elif Index == 13:
      result = ITEM_NAME_ABOUT
    else:
      result = ""

# Menu click events
proc OnMenuClick(Index: int) {.cdecl,exportc,dynlib.} = 
    if Index == 12:
      CreateVersionedMigration()
    else: 
      discard About()

