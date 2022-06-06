global function InitR5RPlaylistPanel
global function RefreshUIPlaylists

struct
{
	var menu
	var panel

	table<var, string> playlist_button_table
} file

void function InitR5RPlaylistPanel( var panel )
{
	file.panel = panel
	file.menu = GetParentMenu( file.panel )
}

void function RefreshUIPlaylists()
{
	//Get Playlists Array
	array<string> playlists = GetPlaylists()

	//Get Number Of Playlists
	int number_of_playlists = playlists.len()

	//Currently supports upto 18 playlists
	//Amos and I talked and will setup a page system or somthing else when needed
	if(number_of_playlists > 18)
		number_of_playlists = 18

	for( int i=0; i < number_of_playlists; i++ ) {

		//Set playlist text
		Hud_SetText( Hud_GetChild( file.panel, "PlaylistText" + i ), GetUIPlaylistName(playlists[i]))

		//Set the playlist ui visibility to true
		Hud_SetVisible( Hud_GetChild( file.panel, "PlaylistText" + i ), true )
		Hud_SetVisible( Hud_GetChild( file.panel, "PlaylistBtn" + i ), true )
		Hud_SetVisible( Hud_GetChild( file.panel, "PlaylistPanel" + i ), true )

		//If button already has a evenhandler remove it
		var button = Hud_GetChild( file.panel, "PlaylistBtn" + i )
		if ( button in file.playlist_button_table ) {
			Hud_RemoveEventHandler( button, UIE_CLICK, SelectServerPlaylist )
			delete file.playlist_button_table[button]
		}

		//Add the Even handler for the button
		Hud_AddEventHandler( Hud_GetChild( file.panel, "PlaylistBtn" + i ), UIE_CLICK, SelectServerPlaylist )

		//Add the button and playlist to a table
		file.playlist_button_table[Hud_GetChild( file.panel, "PlaylistBtn" + i )] <- playlists[i]
	}
}

array<string> function GetPlaylists()
{
	array<string> playlists

	//Setup available playlists array
	foreach( string playlist in GetAvailablePlaylists())
	{
		//Check playlist visibility
		if(!GetPlaylistVarBool( playlist, "visible", false ))
			continue

		//Add playlist to the array
		playlists.append(playlist)
	}

	return playlists
}

void function SelectServerPlaylist( var button )
{
	//Set selected server playlist
	SetSelectedServerPlaylist(file.playlist_button_table[button])
}