untyped

global function CodeCallback_MapInit


void function CodeCallback_MapInit()
{
    SetConVarInt( "gl_clear_color_buffer", 1 )

    Floppytown_MapInit_Common()
    Floppytown_MapInit_Map()
    
    AddCallback_OnClientConnected( TPPlayerToMap )
}

void function TPPlayerToMap( entity player )
{
    #if DEVELOPER
        if ( player == gp()[0] )
        {
            thread ThreadTPPlayerToMap( player )
        }
    #endif // DEVELOPER
}

void function ThreadTPPlayerToMap( entity player )
{
    wait 1

    player.SetOrigin( < 2000, 2000, 6000 > + < 0, 0, 200 > )
}