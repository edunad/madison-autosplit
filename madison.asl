/*  MADiSON Autosplitter
    v0.0.1 --- By FailCake (edunad) & Hazzytje (Pointer wizard <3)

    CHANGELOG:
    - Added items & item checking by name
*/


state("MADiSON", "v1.1.0") { }

startup {
    settings.Add("splitgroup", true, "SPLIT SETTINGS");
    settings.Add("autoskip", false, "AUTO-SKIP TO END ON MAINMENU", "splitgroup");

    settings.Add("keygroup", true, "Keys");
    settings.Add("maskKey", false, "\"MASK\" KEY", "keygroup");
    settings.Add("redKey", false, "\"RED\" KEY", "keygroup");
    settings.Add("heartKey", false, "\"HEART\" KEY", "keygroup");
    settings.Add("confessionaryKey", false, "\"CONFESSIONARY\" KEY", "keygroup");
    settings.Add("jKey", false, "\"J\" KEY", "keygroup");
    settings.Add("clockKey", false, "\"CLOCK\" KEY", "keygroup");
    settings.Add("studyKey", false, "\"STUDY\" KEY", "keygroup");
    // settings.Add("triangularKey", false, 'TRIANGULAR KEY', "keygroup"); // TODO

    // -----------------------
    settings.Add("clockgroup", true, "Clocks");
    settings.Add("unfinishedClock", false, "UNFINISHED CLOCK", "clockgroup");

    // -----------------------
    settings.Add("portraitgroup", true, "Portraits");
    settings.Add("ovalPortrait", false, "GRANDPA PORTRAIT", "portraitgroup");
    settings.Add("circlePortrait", false, "CIRCLE PORTRAIT", "portraitgroup");
    settings.Add("hexaPortrait", false, "HEXAGONAL PORTRAIT", "portraitgroup");
    settings.Add("squarePortrait", false, "SQUARE PORTRAIT", "portraitgroup");
    settings.Add("diamondPortrait", false, "DIAMOND PORTRAIT", "portraitgroup");

    // -----------------------
    settings.Add("candlegroup", true, "Candles");
    settings.Add("yellowCandle", false, "YELLOW CANDLE", "candlegroup");
    settings.Add("blueCandle", false, "BLUE CANDLE", "candlegroup");
    settings.Add("redCandle", false, "RED CANDLE", "candlegroup");
    settings.Add("greenCandle", false, "GREEN CANDLE", "candlegroup");

    // -----------------------
    settings.Add("cameragroup", true, "Camera");
    settings.Add("yourPhotos", false, "YOUR PHOTOS", "cameragroup");
    settings.Add("camera", false, "INSTANT CAMERA", "cameragroup");


    // -----------------------
    settings.Add("boxgroup", true, "Boxes");
    settings.Add("sunBox", false, "SUNBOX", "boxgroup");
    settings.Add("moonBox", false, "MOONBOX", "boxgroup");
    // settings.Add("moonBox", false, "MOONBOX OPENED", "boxgroup"); // TODO


    // -----------------------
    /* TODO
    settings.Add("medalliongroup", true, "Medallions");
    settings.Add("medalion", false, "SOLAR MEDALLION", "medalliongroup"); // TODO
    */

    // -----------------------
    settings.Add("tapegroup", true, "Tapes");
    settings.Add("tapeBad", false, "TAPE \"DO NOT LISTEN\"", "tapegroup");
    settings.Add("tape3", false, "TAPE #3", "tapegroup");
    settings.Add("tape2", false, "TAPE #2", "tapegroup");
    settings.Add("tape1", false, "TAPE #1", "tapegroup");

    // -----------------------
    settings.Add("othergroup", true, "Other");
    settings.Add("boltCutter", false, "BOLT CUTTER", "othergroup");
    settings.Add("rustedNail", false, "RUSTED NAIL", "othergroup");
    settings.Add("oldSlides", false, "OLD SLIDES", "othergroup");
    settings.Add("handle", false, "HANDLE", "othergroup");
    settings.Add("skull", false, "MADISON HALE'S SKULL", "othergroup");
    settings.Add("crowbar", false, "CROWBAR", "othergroup");
    settings.Add("notebook", false, "LUCA'S NOTEBOOK", "othergroup");
    settings.Add("hammer", false, "HAMMER", "othergroup");
    settings.Add("brokenShovel", false, "BROKEN SHOVEL", "othergroup"); // ???
    settings.Add("shovel", false, "SHOVEL", "othergroup"); // ???
    settings.Add("i", false, "\"i\" LETTER", "othergroup"); // i letter for MADiSON
    settings.Add("weedingRing", false, "WEDDING RING", "othergroup");

    // ----------------------------------------

    // Game settings
    vars.maxInventory = 10; // Old versions it used to be 7?
    // ----

    // INTERNAL
    vars.__inventory_size = 0;
    vars.__inventory = new string[vars.maxInventory];
    vars.__itemCheck = new List<string>();

    vars.__gameItems = new Dictionary<string, string>() {
        {"\"MASK\" KEY", "maskKey"},
        {"\"RED\" KEY", "redKey"},
        {"\"HEART\" KEY", "heartKey"},
        {"\"CONFESSIONARY\" KEY", "confessionaryKey"},
        {"\"J\" KEY", "jKey"},
        {"\"CLOCK\" KEY", "clockKey"},
        {"\"STUDY\" KEY", "studyKey"},

        {"UNFINISHED CLOCK", "unfinishedClock"},

        {"OVAL PORTRAIT", "ovalPortrait"},
        {"CIRCLE PORTRAIT", "circlePortrait"},
        {"HEXAGONAL PORTRAIT", "hexaPortrait"},
        {"SQUARE PORTRAIT", "squarePortrait"},
        {"DIAMOND PORTRAIT", "diamondPortrait"},

        {"YELLOW CANDLE", "yellowCandle"},
        {"BLUE CANDLE", "blueCandle"},
        {"RED CANDLE", "redCandle"},
        {"GREEN CANDLE", "greenCandle"},

        {"YOUR PHOTOS", "yourPhotos"},
        {"INSTANT CAMERA", "camera"},

        {"SUNBOX", "sunBox"},
        {"MOONBOX", "moonBox"},

        {"TAPE \"DO NOT LISTEN\"", "tapeBad"},
        {"TAPE #3", "tape3"},
        {"TAPE #2", "tape2"},
        {"TAPE #1", "tape1"},

        {"BOLT CUTTER", "boltCutter"},
        {"RUSTED NAIL", "rustedNail"},
        {"OLD SLIDES", "oldSlides"},
        {"HANDLE", "handle"},
        {"MADISON HALE'S SKULL", "skull"},
        {"CROWBAR", "crowbar"},
        {"LUCA'S NOTEBOOK", "notebook"},
        {"HAMMER", "hammer"},
        {"BROKEN SHOVEL", "brokenShovel"}, // ??
        {"SHOVEL", "shovel"}, // ??
        {"\"i\"", "i"},
        {"WEDDING RING", "weedingRing"},
    };
    // ---
}

init {
    vars.inventoryBase = 0x015F0BB8;
    vars.sceneBase = 0x015CCAD8;

    vars.gameBase = modules.Where(m => m.ModuleName == "GameAssembly.dll").First().BaseAddress;
    vars.ptrInventoryOffset = vars.gameBase + vars.inventoryBase;
    vars.ptrSceneOffset = vars.gameBase + vars.sceneBase;

    Func<int> getInventorySize = () => {
		IntPtr ptr;
        new DeepPointer(vars.ptrInventoryOffset, 0x5D0, 0x5A8, 0xA0, 0x40, 0x18).DerefOffsets(memory, out ptr);
        return memory.ReadValue<int>(ptr);
	};
	vars.getInventorySize = getInventorySize;

    Func<int, string> getItem = (index) => {
        IntPtr ptr;
        new DeepPointer(vars.ptrInventoryOffset, 0x5D0, 0x5A8, 0xA0, 0x40, 0x10, (0x20 + (index * 0x8)), 0x28, 0x14).DerefOffsets(memory, out ptr);
        return memory.ReadString(ptr, 128);
	};
	vars.getItem = getItem;

    Func<string> getScene = () => {
        IntPtr ptr;
        new DeepPointer(vars.ptrSceneOffset, 0x18, 0xB8, 0, 0x50, 0x14).DerefOffsets(memory, out ptr);
        return memory.ReadString(ptr, 128);
	};
	vars.getScene = getScene;
}

start {
    return vars.getScene() == "ChapterOne [Final]";
}

reset {
    return !settings["autoskip"] && vars.getScene() == "MainMenu";
}

update {
    // RESET VARS
    if (timer.CurrentPhase != TimerPhase.Running) {
        vars.__itemCheck.Clear();
    } else {
        // GET AMOUNT OF ITEMS IN INVENTORY
        vars.__inventory_size = vars.getInventorySize();
        if(vars.__inventory_size <= 0 || vars.__inventory_size > vars.maxInventory) return;
        // -----------------

        for (int i = 0; i < vars.__inventory_size; ++i) {
            vars.__inventory[i] = vars.getItem(i); // TODO: Grab item ID as well
        }
    }
}

split {
    if(timer.CurrentPhase != TimerPhase.Running) return false;

    // Split all times until end
    if(vars.getScene() == "MainMenu" && settings["autoskip"]) {
        return true;
    }

    if(vars.__inventory_size <= 0 || vars.__inventory_size > vars.maxInventory) return false;
    for (int i = 0; i < vars.__inventory_size; ++i) {
        string item = vars.__inventory[i];
        if(vars.__itemCheck.Contains(item) || !vars.__gameItems.ContainsKey(item)) continue; // Already checked

        vars.__itemCheck.Add(item);
        return settings[vars.__gameItems[item]];
    }

    return false;
}