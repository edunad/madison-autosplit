// MADiSON Autosplitter
// By Hazzytje & FailCake

state("MADiSON", "v1.1.0") {
    //IntPtr inventoryPtr: "MADiSON.exe", 0x015F0BB8;
}

startup {

}

init {
    vars.inventoryPtr = 0x015F0BB8;
    vars.gameBase = modules.Where(m => m.ModuleName == "GameAssembly.dll").First().BaseAddress;
    vars.maxItems = 10;
}

start {
	return true;
}

update {
    current.inventory = new string[vars.maxItems];

    //for (int i = 0; i < current.inventory.Length; ++i) {
        IntPtr ptr;
        new DeepPointer(vars.gameBase + vars.inventoryPtr, 0, 0x5D0, 0x5A8, 0xA0, 0x40, 0x10, 0x20, 0x28, 0x14).DerefOffsets(memory, out ptr);
        string itemTEXT = memory.ReadString(ptr, 256);

        //current.inventory[i] = itemTEXT;
        print(itemTEXT);
    //}
}