untyped


global function ClientCodeCallback_MapInit


void function ClientCodeCallback_MapInit()
{
    Floppytown_MapInit_Common()

    ServerCallback_ToneMapping( 16.0, 2.0, 0.1, 0.75 )
}
