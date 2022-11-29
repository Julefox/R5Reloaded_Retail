untyped


global function Floppytown_MapInit_Map

const vector MAP_OFFSET = < 2000, 2000, 6000 >

const asset NESSY_MODEL = $"mdl/domestic/nessy_doll.rmdl"


void function Floppytown_MapInit_Map()
{
    AddCallback_EntitiesDidLoad( Floppytown )
    AddCallback_EntitiesDidLoad( Nessy )
}

void function Floppytown()
{
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

        MapEditor_CreateProp( mdl, origin + MAP_OFFSET, angles, mantle, fade, -1, scale )
    }
}

void function Nessy()
{
    PrecacheModel( NESSY_MODEL )

    array < vector > origin = [ < -3008.3000, 2149.9300, 1709.7700 > ]
    array < vector > angles = [ < 0.0000, -114.3300, 0.0000 > ]

    if ( origin.len() != angles.len() ) return

    int numLocation = RandomIntRange( 0, origin.len() )

    CreatePropDynamic( NESSY_MODEL, origin[numLocation] + MAP_OFFSET, angles[numLocation], 6, -1 )
}
