/*  MADiSON Autosplitter
    v0.0.4 --- By FailCake (edunad) & Hazzytje (Pointer wizard <3)

    CHANGELOG:
    - Items on settings are now sorted by appearance
    - Added Triangular key
    - Added concrete block
*/


state("MADiSON", "v1.1.0") { }

startup {

    settings.Add("splitgroup", true, "Splits"); // In order of appearance
    settings.Add("sunBox", false, "Sunbox", "splitgroup");
    settings.Add("handle", false, "Handle", "splitgroup");
    settings.Add("hammer", false, "Hammer", "splitgroup");

    settings.Add("camera", false, "Instant Camera", "splitgroup");
    settings.Add("yourPhotos", false, "Your Photos - FIRST PICTURE", "splitgroup");
    settings.SetToolTip("yourPhotos", "The first picture you take");

    settings.Add("studyKey", false, "Study Key", "splitgroup");
    settings.Add("ovalPortrait", false, "Grandpa Portrait", "splitgroup");
    settings.Add("rustedNail", false, "Rusted Nail", "splitgroup");

    settings.Add("jKey", false, "J Key - Safe Key", "splitgroup");
    settings.Add("tape1", false, "Tape #1", "splitgroup");
    settings.Add("notebook", false, "Luca's Notebook", "splitgroup");
    settings.Add("triangularKey_1", false, "Triangular Key - FIRST KEY", "splitgroup"); // TODO other TRIANGULAR KEY
    settings.SetToolTip("triangularKey_1", "[WIP] Only the first triangular key will trigger the split");

    settings.Add("medalion_1", false, "Solar Medallion - FIRST MEDALLION", "splitgroup"); // TODO other medalions
    settings.SetToolTip("medalion_1", "[WIP] Only the first medallion will trigger the split");

    settings.Add("moonBox_1", false, "Moonbox", "splitgroup");

    settings.Add("heartKey", false, "Heart Key", "splitgroup");

    settings.Add("diamondPortrait", false, "♦ Diamond Portrait - LADY", "splitgroup");
    settings.Add("squarePortrait", false, "◼ Square Portrait - KID", "splitgroup");

    settings.Add("oldSlides", false, "Old Slides", "splitgroup");
    settings.Add("circlePortrait", false, "● Circle Portrait - MAN", "splitgroup");
    settings.Add("hexaPortrait", false, "⬢ Hexagon Portrait - GRANDMA", "splitgroup");
    // MEDALION 2 ---
    // LIGHER --- ?

    settings.Add("yellowCandle", false, "Yellow Candle", "splitgroup");
    settings.Add("redCandle", false, "Red Candle", "splitgroup");
    settings.Add("blueCandle", false, "Blue Candle", "splitgroup");
    settings.Add("greenCandle", false, "Green Candle", "splitgroup");

    settings.Add("confessionaryKey", false, "Confessionary Key", "splitgroup");
    settings.Add("i", false, "Letter \"i\"", "splitgroup"); // i letter for MADiSON
    settings.Add("skull", false, "MADiSON Hale's Skull", "splitgroup");
    settings.Add("redKey", false, "Red Door Key", "splitgroup");
    settings.Add("crowbar", false, "Crowbar", "splitgroup");
    settings.Add("weedingRing", false, "Weeding Ring", "splitgroup");
    // TRIANGULAR KEY 2 ---
    settings.Add("boltCutter", false, "Bolt Cutter", "splitgroup");
    // MOON BOX - OPENED --- 2
    settings.Add("tape3", false, "Tape #3", "splitgroup");
    // CONCRETE BLOCK
    settings.Add("concrete_block_1", false, "Concrete Block - TOILET", "splitgroup");
    settings.SetToolTip("concrete_block_1", "[WIP] Only the first concrete block will trigger the split");

    settings.Add("clockKey", false, "Clock Room Key", "splitgroup");

    settings.Add("clock_1", false, "Clock - GREEN SAFE", "splitgroup"); // TODO
    settings.SetToolTip("clock_1", "[WIP] Only the first clock will trigger the split");

    settings.Add("unfinishedClock", false, "Unfinished Clock", "splitgroup");
    settings.Add("maskKey", false, "Johnny's Key - RED SAFE KEY", "splitgroup");

    // Settings
    settings.Add("settingsgroup", true, "Settings"); // In order of appearance
    settings.Add("reset_mainmenu", false, "Reset on mainmenu", "settingsgroup");

    // MISSING:
    /*settings.Add("brokenShovel", false, "BROKEN SHOVEL", "othergroup"); // ???
    settings.Add("shovel", false, "SHOVEL", "othergroup"); // ???
    settings.Add("tapeBad", false, "TAPE \"DO NOT LISTEN\"", "tapegroup");
    settings.Add("tape2", false, "TAPE #2", "tapegroup");*/
    // ----------------------------------------

    // Game settings
    vars.maxInventory = 10; // Old versions it used to be 7?
    // ----

    // INTERNAL
    vars.__inventory_size = 0;
    vars.__inventory = new string[vars.maxInventory];
    vars.__itemCheck = new List<string>();

    vars.__gameItems = new Dictionary<string, string>() {
        {"\"MASK\" KEY", "maskKey"}, // JOHNNY'S KEY
        {"\"RED\" KEY", "redKey"},
        {"\"HEART\" KEY", "heartKey"},
        {"\"CONFESSIONARY\" KEY", "confessionaryKey"},
        {"\"J\" KEY", "jKey"},
        {"\"CLOCK\" KEY", "clockKey"},
        {"\"STUDY\" KEY", "studyKey"},
        {"TRIANGULAR KEY", "triangularKey_1"},

        {"CONCRETE BLOCK", "concrete_block_1"},

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
    return settings["reset_mainmenu"] && vars.getScene() == "MainMenu";
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