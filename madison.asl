/*  MADiSON Autosplitter
    v0.0.3 --- By FailCake (edunad) & Hazzytje (Pointer wizard <3)

    CHANGELOG:
    - Added more items
    - Fix item pointers
*/


state("MADiSON", "v1.1.0") { }

startup {
    settings.Add("splitgroup", true, "SPLIT SETTINGS");
    settings.Add("reset", false, "REALLY Enable time reset on mainmenu (sets it to 0:00)", "splitgroup");
    settings.SetToolTip("reset", "Same as normal reset, but i wanted a default off option.");

    settings.Add("keygroup", true, "Keys");
    settings.Add("maskKey", false, "\"MASK\" KEY", "keygroup");
    settings.Add("redKey", false, "\"RED\" KEY", "keygroup");
    settings.Add("heartKey", false, "\"HEART\" KEY", "keygroup");
    settings.Add("confessionaryKey", false, "\"CONFESSIONARY\" KEY", "keygroup");
    settings.Add("jKey", false, "\"J\" KEY", "keygroup");
    settings.Add("clockKey", false, "\"CLOCKROOM\" KEY", "keygroup");
    settings.Add("studyKey", false, "\"STUDY\" KEY", "keygroup");
    // settings.Add("triangularKey", false, 'TRIANGULAR KEY', "keygroup"); // TODO

    // -----------------------
    settings.Add("clockgroup", true, "Clocks");
    settings.Add("unfinishedClock", false, "UNFINISHED CLOCK", "clockgroup");
    settings.Add("clock_1", false, "TWELVE O´CLOCK - FIRST", "clockgroup"); // TODO
    settings.SetToolTip("clock_1", "Only the first clock will trigger the split");

    // -----------------------
    settings.Add("portraitgroup", true, "Portraits");
    settings.Add("ovalPortrait", false, "OVAL PORTRAIT - GRANDPA", "portraitgroup");
    settings.Add("circlePortrait", false, "CIRCLE PORTRAIT - MAN", "portraitgroup");
    settings.Add("hexaPortrait", false, "HEXAGONAL PORTRAIT - GRANDMA", "portraitgroup");
    settings.Add("squarePortrait", false, "SQUARE PORTRAIT - KID", "portraitgroup");
    settings.Add("diamondPortrait", false, "DIAMOND PORTRAIT - LADY", "portraitgroup");

    // -----------------------
    settings.Add("candlegroup", true, "Candles");
    settings.Add("yellowCandle", false, "YELLOW CANDLE", "candlegroup");
    settings.Add("blueCandle", false, "BLUE CANDLE", "candlegroup");
    settings.Add("redCandle", false, "RED CANDLE", "candlegroup");
    settings.Add("greenCandle", false, "GREEN CANDLE", "candlegroup");

    // -----------------------
    settings.Add("cameragroup", true, "Camera");
    settings.Add("yourPhotos", false, "YOUR PHOTOS", "cameragroup");
    settings.SetToolTip("yourPhotos", "The first picture you take");
    settings.Add("camera", false, "INSTANT CAMERA", "cameragroup");

    // -----------------------
    settings.Add("boxgroup", true, "Boxes");
    settings.Add("sunBox", false, "SUNBOX", "boxgroup");
    settings.Add("moonBox_1", false, "MOONBOX - CLOSED", "boxgroup");
    // settings.Add("moonBox", false, "MOONBOX OPENED", "boxgroup"); // TODO


    // -----------------------
    settings.Add("medalliongroup", true, "Medallions");
    settings.Add("medalion_1", false, "SOLAR MEDALLION - FIRST", "medalliongroup"); // TODO other medalions
    settings.SetToolTip("medalion_1", "Only the first medallion will trigger the split");

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
    settings.Add("i", false, "LETTER \"i\"", "othergroup"); // i letter for MADiSON
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
        {"TWELVE O´CLOCK", "clock_1"},

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
        {"MOONBOX", "moonBox_1"},

        {"SOLAR MEDALLION", "medalion_1"},

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
    vars.inventoryBase = 0x0159D5E8;
    vars.sceneBase = 0x015CCAD8;

    vars.gameBase = modules.Where(m => m.ModuleName == "GameAssembly.dll").First().BaseAddress;
    vars.ptrInventoryOffset = vars.gameBase + vars.inventoryBase;
    vars.ptrSceneOffset = vars.gameBase + vars.sceneBase;

    Func<int> getInventorySize = () => {
		IntPtr ptr;
        new DeepPointer(vars.ptrInventoryOffset, 0x490, 0x438, 0x738, 0x18, 0x40, 0x18).DerefOffsets(memory, out ptr);
        return memory.ReadValue<int>(ptr);
	};
	vars.getInventorySize = getInventorySize;

    Func<int, string> getItem = (index) => {
        IntPtr ptr;
        new DeepPointer(vars.ptrInventoryOffset, 0x490, 0x438, 0x738, 0x18, 0x40, 0x10, (0x20 + (index * 0x8)), 0x28, 0x14).DerefOffsets(memory, out ptr);
        return memory.ReadString(ptr, 128);
	};
	vars.getItem = getItem;

    Func<string> getScene = () => {
        IntPtr ptr;
        new DeepPointer(vars.ptrSceneOffset, 0x18, 0xB8, 0, 0x50, 0x14).DerefOffsets(memory, out ptr);
        return memory.ReadString(ptr, 128);
	};
	vars.getScene = getScene;

    vars.__itemCheck.Clear();
    old.__inventory_size = 0;
}

start {
    if(vars.getScene == null) return false;
    return vars.getScene() == "ChapterOne [Final]";
}

reset {
    return settings["reset"] && vars.getScene() == "MainMenu";
}

update {
    if (timer.CurrentPhase == TimerPhase.Running) {
        // GET AMOUNT OF ITEMS IN INVENTORY
        current.__inventory_size = vars.getInventorySize();
        if(current.__inventory_size <= 0 || current.__inventory_size > vars.maxInventory) return;
        if(current.__inventory_size == old.__inventory_size) return;
        // -----------------

        for (int i = 0; i < current.__inventory_size; ++i) {
            vars.__inventory[i] = vars.getItem(i); // TODO: Grab item ID as well
        }
    } else {
        vars.__itemCheck.Clear(); // RESET INVENTORY
    }
}

split {
    if(timer.CurrentPhase != TimerPhase.Running) return false;

    if(current.__inventory_size <= 0 || current.__inventory_size > vars.maxInventory) return false;
    if(current.__inventory_size == old.__inventory_size) return false;

    for (int i = 0; i < current.__inventory_size; ++i) {
        string itemName = vars.__inventory[i];
        if(vars.__itemCheck.Contains(itemName) || !vars.__gameItems.ContainsKey(itemName)) continue; // Already checked

        vars.__itemCheck.Add(itemName);
        return settings[vars.__gameItems[itemName]];
    }

    return false;
}