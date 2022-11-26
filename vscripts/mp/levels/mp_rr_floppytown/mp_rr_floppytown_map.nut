untyped


global function Floppytown_MapInit_Map


void function Floppytown_MapInit_Map()
{
    AddCallback_EntitiesDidLoad( Floppytown )
}

void function Floppytown()
{
    //Starting Origin, Change this to a origin in a map 
    vector originOffset = < 2000, 2000, 6000 >

    var dataTable = GetDataTable( $"datatable/mp_rr_floppytown.rpak" )
    int numRows = GetDatatableRowCount( dataTable )

    int originColumn = GetDataTableColumnByName( dataTable, "origin" )
    int anglesColumn = GetDataTableColumnByName( dataTable, "angles" )
    int scaleColumn = GetDataTableColumnByName( dataTable, "scale" )
    int fadeColumn = GetDataTableColumnByName( dataTable, "fade" )
    int mantleColumn = GetDataTableColumnByName( dataTable, "mantle" )
    int mdlColumn = GetDataTableColumnByName( dataTable, "mdl" )


    for ( int i = 0 ; i < numRows; i++ )
    {
        vector origin = GetDataTableVector( dataTable, i, originColumn )
        vector angles = GetDataTableVector( dataTable, i, anglesColumn )
        float scale = GetDataTableFloat( dataTable, i, scaleColumn )
        float fade = GetDataTableFloat( dataTable, i, fadeColumn )
        bool mantle = GetDataTableBool( dataTable, i, mantleColumn )
        asset mdl = GetDataTableAsset( dataTable, i, mdlColumn )

        if ( mdl == $"mdl/dev/yes.rmdl" )
        {
            ZiplineUtility zipline

            string us = UniqueString( "Zipline" )

            zipline = Zipline_Register( us, origin + originOffset, angles )
                Zipline_SetSkin( zipline, eZiplineSkinType.INVISIBLE )
            RegisteredZipline_Init( zipline )
            printt( angles )
        }
        else
        {
            MapEditor_CreateProp( mdl, origin + originOffset, angles, mantle, fade, -1, scale )
        }
    }
}
