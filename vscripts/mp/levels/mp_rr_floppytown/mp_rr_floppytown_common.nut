untyped

#if SERVER || CLIENT
    global function Floppytown_MapInit_Common
#endif // SERVER || CLIENT

#if SERVER || CLIENT
    void function Floppytown_MapInit_Common()
    {
        Floppytown_MapInit_Developer()
    }
#endif // SERVER || CLIENT