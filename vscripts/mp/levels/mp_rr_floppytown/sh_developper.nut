untyped

#if SERVER || CLIENT
    global function Floppytown_MapInit_Developer
#endif // SERVER || CLIENT

#if SERVER || CLIENT
    global struct PingTraceResultsTest
    {
        entity player
        vector endPos
        vector surfaceNormal
        float  hitDist
        entity hitEnt
        bool   success = false

        entity pingedEnt
        vector pingedEntPos

        TraceResults & tr
    }
    global PingTraceResultsTest pingTraceResultsTest
#endif // SERVER || CLIENT


#if SERVER || CLIENT
    void function Floppytown_MapInit_Developer()
    {
        #if SERVER
            AddClientCommandCallback( "GetEnt", ClientCommand_GetEnt )
            AddClientCommandCallback( "DebugTriggers", ClientCommand_DebugTriggers )
        #endif // SERVER
    }
#endif // SERVER || CLIENT


#if SERVER
    bool function ClientCommand_GetEnt( entity player, array<string> args )
    {
        GetEntityTouched( player )
    return true }
#endif // SERVER


#if SERVER || CLIENT
    PingTraceResultsTest function GetEntityTouched( entity player )
    {
        const int colGroup = TRACE_COLLISION_GROUP_NONE
        const int colMask = ( TRACE_MASK_VISIBLE_AND_NPCS | CONTENTS_BLOCKLOS | CONTENTS_BLOCK_PING | CONTENTS_HITBOX )

        TraceResults tr = PingTraceForPlayer( player, 9000, colMask, colGroup )

        PingTraceResultsTest result
        if ( ConsiderPingTraceFailedFloppytown( tr ) )
        {
            result.success = false
        }
        else
        {        
            result.player = player
            result.endPos = tr.endPos
            result.surfaceNormal = tr.surfaceNormal
            result.hitDist = ( tr.fraction * 9000 )
            result.hitEnt = tr.hitEnt
            result.success = true
        }
        result.tr = tr

        if ( result.hitEnt == null )
        {
            return result
        }
        else
        {
            #if SERVER
                pingTraceResultsTest.pingedEnt = result.hitEnt
                pingTraceResultsTest.pingedEntPos = result.hitEnt.GetOrigin()
                printt( "" )
                printt( "		TraceResults:		" )
                printt( "===========================" )
                printt( "Ent:                   " + result.hitEnt )
                printt( "ModelName:             " + result.hitEnt.GetModelName() )
                printt( "Angles:                " + result.hitEnt.GetAngles() )
                printt(	"Real Origin:           " + result.hitEnt.GetOrigin() )
                printt(	"Ping Origin:           " + result.endPos )

                printt( "W: " + GetEntWidth ( result.hitEnt ) + " D: " + GetEntDepth ( result.hitEnt ) + " H: " + GetEntHeight( result.hitEnt ) )
                printt( "===========================" )
                printt( "" )

                DebugDrawAxis( result.hitEnt.GetOrigin(), result.hitEnt.GetAngles(), 6.0, 30, < 0, 0, 0 > )

            #endif // SERVER
        }

        return result
    }

    bool function ConsiderPingTraceFailedFloppytown( TraceResults tr )
    {
        if ( tr.hitSky )
            return true
        if ( tr.fraction >= 0.99 )
            return true
        
        return false
    }
#endif // SERVER || CLIENT

#if SERVER
    bool function ClientCommand_DebugTriggers( entity player, array<string> args )
    {
        foreach( ent in GetEntArrayByClass_Expensive( "trigger_cylinder" ) )
        {
            DebugDrawCylinder( ent.GetOrigin(), ent.GetAngles() + < -90, 0, 0 >, ent.GetRadius(), ent.GetAboveHeight(), 55, 120, 194, false, 40.0 )
            DebugDrawCylinder( ent.GetOrigin(), ent.GetAngles() + < -90, 45, 0 >, ent.GetRadius(), ent.GetAboveHeight(), 55, 120, 194, false, 40.0 )
        }
    return true }
#endif // SERVER
