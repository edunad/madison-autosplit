/*  MADiSON Autosplitter
    v0.0.8 --- By FailCake (edunad) & Hazzytje (Pointer wizard <3)

    GAME VERSIONS:
    - v1.1.0 = 27136000

    CHANGELOG:
    - Memory scanning improvements
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
    // settings.Add("i", false, "Letter \"i\"", "splitgroup"); // Not detected on inventory
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

    // INTERNAL
    vars.__itemCheck = new List<string>();
    vars.__maxInventory = 10; // Old versions it used to be 8

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
        // {"\"i\"", "i"}, // Not detected on inventory
        {"WEDDING RING", "weedingRing"},
    };
    // ---
}

init {
    vars.inventoryBase = 0x00;
    vars.sceneBase = 0x00;

    vars.gameAssembly = modules.Where(m => m.ModuleName == "GameAssembly.dll").First();
    if(vars.gameAssembly.ModuleMemorySize == 27136000) {
        vars.inventoryBase = 0x0159D5E8;
        vars.sceneBase = 0x015CCAD8;
    }else {
        print("[WARNING] Invalid MADiSON game version");
        print("[WARNING] Could not find pointers");
    }

    vars.gameBase = vars.gameAssembly.BaseAddress;
    vars.ptrInventoryOffset = vars.gameBase + vars.inventoryBase;
    vars.ptrSceneOffset = vars.gameBase + vars.sceneBase;

	vars.watchers = new MemoryWatcherList();
    vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(vars.ptrInventoryOffset, 0x490, 0x438, 0x738, 0x18, 0x40, 0x18)) { Name = "inventorySize" });
    vars.watchers.Add(new StringWatcher(new DeepPointer(vars.ptrSceneOffset, 0x18, 0xB8, 0, 0x50, 0x14), ReadStringType.AutoDetect, 255) { Name = "scene" });

    for (int i = 0; i < vars.__maxInventory; ++i)
        vars.watchers.Add(new StringWatcher(new DeepPointer(vars.ptrInventoryOffset, 0x490, 0x438, 0x738, 0x18, 0x40, 0x10, (0x20 + (i * 0x8)), 0x28, 0x14), ReadStringType.AutoDetect, 255) { Name = "item_" + i });

    vars.__itemCheck.Clear();
}

start {
    if(vars.watchers == null) return false;
    if(vars.watchers["scene"].Current == vars.watchers["scene"].Old) return false;
    return vars.watchers["scene"].Current == "ChapterOne [Final]";
}

reset {
    if(vars.watchers == null) return false;
    return settings["reset_mainmenu"] && vars.watchers["scene"].Current == "MainMenu";
}

update {
    if(vars.watchers == null) return;
    vars.watchers.UpdateAll(game);

    if (timer.CurrentPhase == TimerPhase.Running) return;
    vars.__itemCheck.Clear(); // RESET INVENTORY
}

split {
    if(timer.CurrentPhase != TimerPhase.Running) return false;

    if(vars.watchers["inventorySize"].Current <= 0 || vars.watchers["inventorySize"].Current > vars.__maxInventory) return false;
    if(vars.watchers["inventorySize"].Current == vars.watchers["inventorySize"].Old) return false;

    for (int i = 0; i < vars.watchers["inventorySize"].Current; ++i) {
        string itemName = vars.watchers["item_" + i].Current;
        if(vars.__itemCheck.Contains(itemName) || !vars.__gameItems.ContainsKey(itemName)) continue; // Already checked

        vars.__itemCheck.Add(itemName);
        return settings[vars.__gameItems[itemName]];
    }

    return false;
}
