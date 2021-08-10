
--[[
	> pKustom - Made by BrainFuck.
	> ultimate propkill script
]]

-- BrainFuck: STEAM_0:1:149906042


// PC
local PC = {
	// misc shit
	friends = {},
	enemies = {},
	props_oldcolor = {},
	xray_invis = false,
	chams_invis = false,
	dangerous = false,
	Spectators = {},
	shotting = false,
	localplayerpos = {},
	key,

	// settings shit
	tracers_settings = false,
	esp_settings = false,
	chams_settings = false,
	xray_settings = false,
	propboxes_settings = false,
	playerboxes_settings = false,
	crosshair_settings = false,
	skybox_settings = false,
	eyetrace_settings = false,

	// surfer analyzer shit (beta version, removed from the script for now)
	RegisteredPlayerPositions = {},
	current_streak = {},
	similar_paths = {},
	how_many_times = {},
	idk_how_to_call_this = 0,
	-- paths_todraw = {},
	interval = 250,
	streak_needed = 10,
	accuracy_dist = 500,
}

RunConsoleCommand("cl_updaterate", 1000)
RunConsoleCommand("cl_cmdrate", 0)
RunConsoleCommand("cl_interp", 0)
RunConsoleCommand("rate", 51200)
-- RunConsoleCommand("mat_fastspecular", 0)

CreateMaterial( "White9", "UnlitGeneric", { [ "$basetexture" ] = "models/debug/debugwhite", [ "$nocull" ] = 1, [ "$model" ] = 1 } ); -- fixing the debugwhite shit material

// CONVARS THERE
CreateClientConVar("PC_bhop", 1, true, false)
CreateClientConVar("PC_FOVEnable", 1, true, false)
CreateClientConVar("PC_FOVNumber", "125", true, false)
CreateClientConVar("PC_FOV_VELOCITY", 0, true, false)
CreateClientConVar("PC_SAVEFPS", 1, true, false)

CreateClientConVar("PC_tracers", 1, true, false)
CreateClientConVar("PC_tracers_beam", 1, true, false)
CreateClientConVar("PC_tracers_beam_mat", "sprites/tp_beam001", true, false)
CreateClientConVar("PC_tracers_beam_col", "0,125,255", true, false)
CreateClientConVar("PC_tracers_beam_opacity", 255, true, false)
CreateClientConVar("PC_tracers_line", 1, true, false)
CreateClientConVar("PC_tracers_line_col", "0,255,125", true, false)
CreateClientConVar("PC_tracers_line_opacity", 255, true, false)
CreateClientConVar("PC_tracers_settings", 0, false, false)

CreateClientConVar("PC_esp", 1, true, false)
CreateClientConVar("PC_esp_font", "DebugFixed", true, false)
CreateClientConVar("PC_esp_col1", "255,255,255", true, false)
CreateClientConVar("PC_esp_opacity1", 255, true, false)
CreateClientConVar("PC_esp_col2", "50,50,50", true, false)
CreateClientConVar("PC_esp_opacity2", 255, true, false)
CreateClientConVar("PC_esp_bones", 0, true, false)
CreateClientConVar("PC_esp_bones_mat", "trails/laser", true, false)
CreateClientConVar("PC_esp_bones_width", 10, true, false)
CreateClientConVar("PC_esp_bones_width_dist_adaptive", 1, true, false)
CreateClientConVar("PC_esp_bones_col", "0,255,150", true, false)
CreateClientConVar("PC_esp_bones_opacity", 255, true, false)
CreateClientConVar("PC_esp_settings", 0, false, false)

CreateClientConVar("PC_trajectory", 1, true, false)
CreateClientConVar("PC_trajectory_col", "0,150,255", true, false)
CreateClientConVar("PC_trajectory_opacity", 150, true, false)

CreateClientConVar("PC_p2p", 1, true, false)
CreateClientConVar("PC_p2p_col", "0,255,155,100", true, false)

CreateClientConVar("PC_xray", 1, true, false)
CreateClientConVar("PC_xray_propsound", 1, true, false)
CreateClientConVar("PC_xray_distance_limit", 8000, true, false)
CreateClientConVar("PC_xray_mat1", "!White9", true, false)
CreateClientConVar("PC_xray_col_mat1", "0,255,0", true, false)
CreateClientConVar("PC_xray_opacity_mat1", 100, true, false)
CreateClientConVar("PC_xray_mat2", "models/wireframe", true, false)
CreateClientConVar("PC_xray_col_mat2", "0,0,255", true, false)
CreateClientConVar("PC_xray_opacity_mat2", 100, true, false)
CreateClientConVar("PC_xray_multimat", 1, true, false)
CreateClientConVar("PC_xray_adaptive_opacity", 1, true, false)
CreateClientConVar("PC_xray_settings", 0, false, false)

CreateClientConVar("PC_propboxes", 0, true, false)
CreateClientConVar("PC_propboxes_col", "0,255,0", true, false)
CreateClientConVar("PC_propboxes_settings", 0, false, false)

CreateClientConVar("PC_playerboxes", 0, true, false)
CreateClientConVar("PC_playerboxes_col", "0,255,0", true, false)
CreateClientConVar("PC_playerboxes_settings", 0, false, false)

CreateClientConVar("PC_chams", 1, true, false)
CreateClientConVar("PC_chams_mat1", "models/debug/debugwhite", true, false)
CreateClientConVar("PC_chams_col_mat1", "0,255,0", true, false)
CreateClientConVar("PC_chams_opacity_mat1", 255, true, false)
CreateClientConVar("PC_chams_mat2", "models/wireframe", true, false)
CreateClientConVar("PC_chams_col_mat2", "0,0,255", true, false)
CreateClientConVar("PC_chams_opacity_mat2", 255, true, false)
CreateClientConVar("PC_chams_multimat", 1, true, false)
CreateClientConVar("PC_chams_wep", 0, true, false)
CreateClientConVar("PC_chams_wep_col", "0,255,255", true, false)
CreateClientConVar("PC_chams_wep_opacity", 255, true, false)
CreateClientConVar("PC_chams_settings", 0, false, false)

CreateClientConVar("PC_headbeams", 1, true, false)
CreateClientConVar("PC_headbeams_beam", 1, true, false)
CreateClientConVar("PC_headbeams_line", 0, true, false)
CreateClientConVar("PC_headbeams_type", "head", true, false)
CreateClientConVar("PC_headbeams_beam_mat", "trails/smoke", true, false)
CreateClientConVar("PC_headbeams_beam_col", "0,255,0", true, false)
CreateClientConVar("PC_headbeams_beam_opacity", 255, true, false)
CreateClientConVar("PC_headbeams_line_col", "0,255,125", true, false)
CreateClientConVar("PC_headbeams_line_opacity", 255, true, false)
CreateClientConVar("PC_headbeams_settings", 0, false, false)

CreateClientConVar("PC_pingpredictboxes", 1, true, false)

CreateClientConVar("PC_alert", 1, true, false)

CreateClientConVar("PC_physgun_wireframe", 0, true, false)
CreateClientConVar("PC_physgun_wireframe_col", "0,255,0", true, false)
CreateClientConVar("PC_physgun_wireframe_opacity", 255, true, false)

CreateClientConVar("PC_physline", 1, true, false)
CreateClientConVar("PC_physline_otherplayers", 1, true, false)

CreateClientConVar( "PC_crosshair", 1, true, false )
CreateClientConVar( "PC_crosshair_circles", 1, true, false )
CreateClientConVar( "PC_crosshair_cross", 0, true, false )
CreateClientConVar( "PC_crosshair_dot", 0, true, false )
CreateClientConVar( "PC_crosshair_circles_size", 1, true, false )
CreateClientConVar( "PC_crosshair_cross_size", 6, true, false )
CreateClientConVar( "PC_crosshair_dot_size", 1, true, false )
CreateClientConVar( "PC_crosshair_color", "255,255,255", true, false )
CreateClientConVar( "PC_crosshair_opacity", 255, true, false )
CreateClientConVar( "PC_crosshair_settings", 0, false, false )

CreateClientConVar( "PC_custom_skybox", 0, true, false )
CreateClientConVar( "PC_custom_skybox_col", "50,50,50", true, false )
CreateClientConVar( "PC_custom_skybox_settings", 0, false, false )

CreateClientConVar( "PC_eyetrace", 0, true, false )
CreateClientConVar( "PC_eyetrace_beam", 1, true, false )
CreateClientConVar( "PC_eyetrace_beam_col", "255,0,0", true, false )
CreateClientConVar( "PC_eyetrace_beam_opacity", 255, true, false )
CreateClientConVar( "PC_eyetrace_beam_mat", "sprites/tp_beam001", true, false )
CreateClientConVar( "PC_eyetrace_line", 0, true, false )
CreateClientConVar( "PC_eyetrace_line_col", "255,0,0", true, false )
CreateClientConVar( "PC_eyetrace_line_opacity", 255, true, false )
CreateClientConVar( "PC_eyetrace_origin", "eyepos", true, false )
CreateClientConVar( "PC_eyetrace_settings", 0, false, false )

CreateClientConVar( "PC_spectator_box", 0, true, false )

CreateClientConVar( "surfer_analyser_id", 0, true, false )



MsgC(Color(255,255,0), [[
> pKustom SCRIPT LOADED! THIS WAS MADE BY BRAINFUCK EXCLUSIVELY FOR PK SERVERS, ENJOY!
- The commands prefix is PC_, type PC_menu to open the menu :)
- You can also type !pc_menu in chat.
]])


local colors = {
	esp_color1 = Color(unpack(string.Explode(",", GetConVarString("PC_esp_col1")))),
	esp_color2 = Color(unpack(string.Explode(",", GetConVarString("PC_esp_col2")))),
	xray_color1 = Color(unpack(string.Explode(",", GetConVarString("PC_xray_col_mat1")))),
	xray_color2 = Color(unpack(string.Explode(",", GetConVarString("PC_xray_col_mat2")))),
	chams_color1 = Color(unpack(string.Explode(",", GetConVarString("PC_chams_col_mat1")))),
	chams_color2 = Color(unpack(string.Explode(",", GetConVarString("PC_chams_col_mat2")))),
	chams_wep_color = Color(unpack(string.Explode(",", GetConVarString("PC_chams_wep_col")))),
	skybox_custom_col = Color(unpack(string.Explode(",", GetConVarString("PC_custom_skybox_col")))),
	headbeams_beam_color = Color(unpack(string.Explode(",", GetConVarString("PC_headbeams_beam_col")))),
	headbeams_line_color = Color(unpack(string.Explode(",", GetConVarString("PC_headbeams_line_col")))),
	tracers_line_color = Color(unpack(string.Explode(",", GetConVarString("PC_tracers_line_col")))),
	tracers_beam_color = Color(unpack(string.Explode(",", GetConVarString("PC_tracers_beam_col")))),
	physgun_wireframe_color = Color(unpack(string.Explode(",", GetConVarString("PC_physgun_wireframe_col")))),
	propboxes_color = Color(unpack(string.Explode(",", GetConVarString("PC_propboxes_col")))),
	playerboxes_color = Color(unpack(string.Explode(",", GetConVarString("PC_playerboxes_col")))),
	trajectory_color = Color(unpack(string.Explode(",", GetConVarString("PC_trajectory_col")))),
	P2PColor = Color(unpack(string.Explode(",", GetConVarString("PC_p2p_col")))),
	esp_bones_color = Color(unpack(string.Explode(",", GetConVarString("PC_esp_bones_col")))),
	crosshair_color = Color(unpack(string.Explode(",", GetConVarString("PC_crosshair_color")))),
	eyetrace_beam_color = Color(unpack(string.Explode(",", GetConVarString("PC_eyetrace_beam_col")))),
	eyetrace_line_color = Color(unpack(string.Explode(",", GetConVarString("PC_eyetrace_line_col")))),
}


local function refresh()
	colors.esp_color1 = Color(unpack(string.Explode(",", GetConVarString("PC_esp_col1"))))
	colors.esp_color2 = Color(unpack(string.Explode(",", GetConVarString("PC_esp_col2"))))
	colors.xray_color1 = Color(unpack(string.Explode(",", GetConVarString("PC_xray_col_mat1"))))
	colors.xray_color2 = Color(unpack(string.Explode(",", GetConVarString("PC_xray_col_mat2"))))
	colors.chams_color1 = Color(unpack(string.Explode(",", GetConVarString("PC_chams_col_mat1"))))
	colors.chams_color2 = Color(unpack(string.Explode(",", GetConVarString("PC_chams_col_mat2"))))
	colors.chams_wep_color = Color(unpack(string.Explode(",", GetConVarString("PC_chams_wep_col"))))
	colors.skybox_custom_col = Color(unpack(string.Explode(",", GetConVarString("PC_custom_skybox_col"))))
	colors.headbeams_beam_color = Color(unpack(string.Explode(",", GetConVarString("PC_headbeams_beam_col"))))
	colors.headbeams_line_color = Color(unpack(string.Explode(",", GetConVarString("PC_headbeams_line_col"))))
	colors.tracers_line_color = Color(unpack(string.Explode(",", GetConVarString("PC_tracers_line_col"))))
	colors.tracers_beam_color = Color(unpack(string.Explode(",", GetConVarString("PC_tracers_beam_col"))))
	colors.physgun_wireframe_color = Color(unpack(string.Explode(",", GetConVarString("PC_physgun_wireframe_col"))))
	colors.propboxes_color = Color(unpack(string.Explode(",", GetConVarString("PC_propboxes_col"))))
	colors.playerboxes_color = Color(unpack(string.Explode(",", GetConVarString("PC_playerboxes_col"))))
	colors.trajectory_color = Color(unpack(string.Explode(",", GetConVarString("PC_trajectory_col"))))
	colors.P2PColor = Color(unpack(string.Explode(",", GetConVarString("PC_p2p_col"))))
	colors.esp_bones_color = Color(unpack(string.Explode(",", GetConVarString("PC_esp_bones_col"))))
	colors.crosshair_color = Color(unpack(string.Explode(",", GetConVarString("PC_crosshair_color"))))
end
hook.Add ("Think", "refresh", refresh )

local valid_fonts = {
["DebugFixed"] = true,
["DebugFixedSmall"] = true,
["Default"] = true,
["Marlett"] = true,
["Trebuchet18"] = true,
["Trebuchet24"] = true,
["HudHintTextLarge"] = true,
["HudHintTextSmall"] = true,
["CenterPrintText"] = true,
["HudSelectionText"] = true,
["CloseCaption_Normal"] = true,
["CloseCaption_Bold"] = true,
["CloseCaption_BoldItalic"] = true,
["ChatFont"] = true,
["TargetID"] = true,
["TargetIDSmall"] = true,
["HL2MPTypeDeath"] = true,
["BudgetLabel"] = true,
["HudNumbers"] = true,
["DermaDefault"] = true,
["DermaDefaultBold"] = true,
["DermaLarge"] = true,
["GModNotify"] = true,
["ScoreboardDefault"] = true,
["ScoreboardDefaultTitle"] = true,
["GModToolName"] = true,
["GModToolSubtitle"] = true,
["GModToolHelp"] = true,
["GModToolScreen"] = true,
["ContentHeader"] = true,
["GModWorldtip"] = true,
}


local function lavacolor(n, t)
	if n == 1 then
		return math.Round((255 - (math.floor(math.sin(RealTime() * 3.5 ) * 40 + 50 ) ) ) / t, 2), math.Round((math.floor(math.sin(RealTime() * 3.5 + 2 ) * 55 + 65 ) ) / t, 2), 0
	elseif n == 2 then
		return 255 / t , 0.6- math.Round((math.floor(math.sin(RealTime() * 3.5 + 2 ) * 55 + 65 ) ) / t, 2), 0
	end
end

local function spacecolor(n, t)
	if n == 1 then
		return math.Round( (math.floor(math.sin(RealTime() * 3.5 ) * 30 + 40 ) ) / t, 2), 0, math.Round((math.floor(math.sin(RealTime() * 3.5 ) * 55 + 65 ) ) / t, 2)
	elseif n == 2 then
		return 0.6- math.Round((math.floor(math.sin(RealTime() * 4 ) * 55 + 65 ) ) / t, 2), 0, 0.6- math.Round((math.floor(math.sin(RealTime() * 4) * 55 + 65 ) ) / t, 2)
	end
end


local function ErrorEvent( text )
	notification.AddLegacy( string.upper( text ), NOTIFY_ERROR, 3 )
	surface.PlaySound("buttons/button16.wav" )
end

// IsOutOfFOV (very usefull for optimization, thanks Grump)
local function IsOutOfFOV( ent )
	if GetConVarNumber("PC_SAVEFPS") == 1 and !PC.shotting then
		if LocalPlayer():GetObserverMode() == 0 then
			local Width = ent:BoundingRadius()
			local Disp = ent:GetPos() -LocalPlayer():GetShootPos()
			local Dist = Disp:Length()
			local MaxCos = math.abs( math.cos( math.acos( Dist /math.sqrt( Dist *Dist +Width *Width ) ) +56 *( math.pi /180 ) ) )
			Disp:Normalize()
			local dot = Disp:Dot( LocalPlayer():EyeAngles():Forward() )
			return dot <MaxCos
		end
	end
end

// lazyness
local function validation(x)
	return IsValid(x) && x:Alive() && x != LocalPlayer() && x:Team() != TEAM_SPECTATOR && team.GetName(x:Team()) != "Spectator" && x:GetObserverMode() == 0;
end

// ESP
local function ESP()
	if GetConVarNumber("PC_esp") == 1 then
		for k,v in next, player.GetAll() do -- Apparently, using "in next" is faster than "in pairs"
			if !IsOutOfFOV(v) then
				if validation(v) and LocalPlayer():GetObserverTarget() != v then
					local vpos = v:EyePos():ToScreen()
					if PC.friends[v] then
						draw.SimpleTextOutlined ( v:Name(), GetConVarString("PC_esp_font"), vpos.x, vpos.y -10, Color(0,255,0,255), 1, 1, 1, Color(50,50,50,255))
					elseif PC.enemies[v] then
						draw.SimpleTextOutlined ( v:Name(), GetConVarString("PC_esp_font"), vpos.x, vpos.y -10, Color(255,0,0,255), 1, 1, 1, Color(50,50,50,255))
					else
						draw.SimpleTextOutlined ( v:Name(), GetConVarString("PC_esp_font"), vpos.x, vpos.y -10, Color(colors.esp_color1.r, colors.esp_color1.g, colors.esp_color1.b, GetConVarNumber("PC_esp_opacity1")), 1, 1, 1, Color(colors.esp_color2.r, colors.esp_color2.g, colors.esp_color2.b, GetConVarNumber("PC_esp_opacity2")))
					end
				end
			end
		end
	end
end
hook.Add("HUDPaint", "names", ESP)

local LeftLeg = {
	"ValveBiped.Bip01_Spine",
	"ValveBiped.Bip01_L_Calf",
	"ValveBiped.Bip01_L_Foot",
}
local LeftArm = {
	"ValveBiped.Bip01_Head1",
	"ValveBiped.Bip01_L_Forearm",
	"ValveBiped.Bip01_L_Hand",
}
local RightLeg = {
	"ValveBiped.Bip01_Spine",
	"ValveBiped.Bip01_R_Calf",
	"ValveBiped.Bip01_R_Foot",
}
local RightArm = {
	"ValveBiped.Bip01_Head1",
	"ValveBiped.Bip01_R_Forearm",
	"ValveBiped.Bip01_R_Hand",
}

local invalidbone = {}
local function GetBonePos( ply, bone )
	local bone = ply:LookupBone(bone)
	if !bone then invalidbone[ply] = true return end
	local pos, ang = ply:GetBonePosition(bone)
	return pos
end

local function espbones()
	local actualcolor = Color(colors.esp_bones_color.r, colors.esp_bones_color.g, colors.esp_bones_color.b, GetConVarNumber("PC_esp_bones_opacity"))

	if GetConVarNumber("PC_esp_bones") == 1 then

	local Width

		for n,p in next, player.GetAll() do
			if( validation(p)) then
			GetBonePos(p, "ValveBiped.Bip01_Head1")
			if invalidbone[p] then return end
				if !IsOutOfFOV(p) then
				local Dist = math.Clamp( p:GetShootPos():Distance( LocalPlayer():GetShootPos() ), 100, 2500 )
				local StretchX = Dist/200
				local StretchY = Dist/200
					cam.Start3D()
						cam.IgnoreZ( true )
						render.SuppressEngineLighting(true)
						render.SetMaterial(Material(GetConVarString("PC_esp_bones_mat")))
						if GetConVarNumber("PC_esp_bones_width_dist_adaptive") == 1 then
							Width = Dist /30
						else
							Width = GetConVarNumber("PC_esp_bones_width")
						end
						render.DrawBeam( GetBonePos(p, "ValveBiped.Bip01_Head1"), GetBonePos(p, "ValveBiped.Bip01_Spine"), Width, 100, 100, actualcolor )
							for k, v in pairs( LeftLeg ) do
								if(k<3) then
									render.DrawBeam( GetBonePos(p, LeftLeg[k]), GetBonePos(p, LeftLeg[k+1]), Width, 100, 100, actualcolor )
									render.DrawBeam( GetBonePos(p, RightLeg[k]), GetBonePos(p, RightLeg[k+1]), Width, 100, 100, actualcolor )
									render.DrawBeam( GetBonePos(p, RightArm[k]), GetBonePos(p, RightArm[k+1]), Width, 100, 100, actualcolor )
									render.DrawBeam( GetBonePos(p, LeftArm[k]), GetBonePos(p, LeftArm[k+1]), Width, 100, 100, actualcolor )
								end
							end
						render.SuppressEngineLighting(false)
						cam.IgnoreZ( false )
					cam.End3D()
				end
			end
		end
	end
end
hook.Add( "PostDrawHUD", "espbones", espbones )


if not cvars.GetConVarCallbacks("PC_esp_font") then
	cvars.AddChangeCallback( "PC_esp_font", function( convar_name, value_old, value_new )
		if not valid_fonts[value_new] then print(value_new.. " is not a valid font. Please, enter a valid font.") return GetConVar(convar_name):SetString(value_old) end
	end, "esp_font_callback" )
end

-- // trajectory (draws a red line in the direction of a propsurfing target) // --
local function TRAJECTORY()
	if GetConVarNumber("PC_trajectory") == 1 then
		for k,v in pairs(player.GetAll()) do
			if validation(v) and !IsOutOfFOV(v) then
				if v:GetVelocity():Length() > 1200 then
					local Dist = math.Clamp( v:GetShootPos():Distance( LocalPlayer():GetShootPos() ), 100, 1000 )
					local StretchX = Dist/100
					local StretchY = Dist/200
					local TraceStart = v:LocalToWorld(v:OBBCenter())
					local linepos = util.QuickTrace(TraceStart, Vector(v:GetVelocity().x * 10, v:GetVelocity().y * 10, 0), v)
					if TraceStart:Distance(linepos.HitPos) > 400 then
					cam.Start3D()
						cam.IgnoreZ(true)
						render.SetMaterial( Material( "sprites/tp_beam001" ) )
						render.DrawBeam( TraceStart, linepos.HitPos , 50, StretchX, StretchY, Color(colors.trajectory_color.r, colors.trajectory_color.g, colors.trajectory_color.b, GetConVarNumber("PC_trajectory_opacity")))
					cam.End3D()
				end
			end
		end
	end
end
end
hook.Add("RenderScreenspaceEffects", "trajectory", TRAJECTORY)


// I took your physline concept and added a proplogger thing to know if its my prop or not, might be better idk
// I took it because im so used to it that I cant play without it anymore
local myprops = {}
local yourvictims = {}

local function prop_logger(ply,wep,enabled,targ,bone,pos)
	if (IsValid(ply)) and (ply == LocalPlayer()) and (enabled) and IsValid(targ) and targ:GetClass() == "prop_physics" then
		if (!myprops[targ]) then
			myprops[targ] = true
		end
	end
	if GetConVarNumber("PC_physline") != 1 and GetConVarNumber("PC_physline_otherplayers") != 1 then return true end
	if myprops[targ] then
		-- if ply == LocalPlayer() then
		PC.CPos = LocalPlayer():EyePos() + EyeAngles():Forward() * 50
		PC.prop = targ
		PC.propID = targ:GetModel()
		PC.entPOS = targ:LocalToWorld(targ:OBBCenter())
		PC.entPOSI = targ:GetPos()
		PC.propmod = PC.propID
		PC.physlineOn = true
		-- end
		return false
	else
		if ply == LocalPlayer() then
			PC.propID = ""
			PC.physlineOn = false
		else
			if IsValid(targ) and IsValid(ply) then
				PC.srcPos = wep:GetAttachment( 1 ).Pos
				if ( !ply:ShouldDrawLocalPlayer() and ply == LocalPlayer() ) then
					if ply:GetViewModel():GetAttachment( 1 ).Pos then
						PC.srcPos = ply:GetViewModel():GetAttachment( 1 ).Pos
					end
				end
				PC.entPOS2 = targ:LocalToWorld(targ:OBBCenter())
				PC.otherphysline = true
			else
				PC.otherphysline = false
			end
		end
		return false
	end
	return true
end
hook.Add("DrawPhysgunBeam", "heye", prop_logger)

local function physLine()
		if PC.physlineOn == true and GetConVarNumber("PC_physline") == 1 then
			cam.Start3D()
				render.SetMaterial(Material("cable/redlaser"))
				render.DrawBeam(PC.CPos, PC.entPOS, 5, 1, 1, Color(255, 0, 255, 255))
				render.DrawLine(PC.CPos, PC.entPOS, Color(lavacolor(2,1)))
			//prop:SetModel("models/props_junk/watermelon01.mdl")
			cam.End3D()
		end
		if PC.otherphysline == true and GetConVarNumber("PC_physline_otherplayers") == 1 then
			cam.Start3D()
				render.SetMaterial(Material("cable/redlaser"))
				render.DrawBeam(PC.srcPos, PC.entPOS2, 5, 1, 1, Color(255, 0, 255, 255))
				render.DrawLine(PC.srcPos, PC.entPOS2, Color(255,0,0,255))
			//prop:SetModel("models/props_junk/watermelon01.mdl")
			cam.End3D()
		end
end
hook.Add("HUDPaint", "kaosssuw3s", physLine)


local function crosshair()
	if ( GetConVarNumber ("PC_crosshair") == 1 and GetConVarNumber ("PC_crosshair_circles") == 1 ) then
		local x = ScrW() / 2
		local y = ScrH() / 2
		surface.DrawCircle(x, y, 5.5*GetConVarNumber("PC_crosshair_circles_size"), 0,200,255,50)
		surface.DrawCircle(x, y, 2*GetConVarNumber("PC_crosshair_circles_size"), 0,255,0,50)

	elseif

	( GetConVarNumber("PC_crosshair") == 1 and GetConVarNumber("PC_crosshair_dot") == 1 ) then
		local x = ScrW() / 2
		local y = ScrH() / 2
		surface.DrawCircle(x, y, GetConVarNumber("PC_crosshair_dot_size"), Color(colors.crosshair_color.r, colors.crosshair_color.g, colors.crosshair_color.b, GetConVarNumber("PC_crosshair_opacity")))

	elseif

	( GetConVarNumber ("PC_crosshair") == 1 and GetConVarNumber("PC_crosshair_cross") == 1 ) then
		surface.SetDrawColor(colors.crosshair_color.r, colors.crosshair_color.g, colors.crosshair_color.b, GetConVarNumber("PC_crosshair_opacity"))
		surface.DrawLine(ScrW() / 2, ScrH() / 2 - GetConVarNumber("PC_crosshair_cross_size"), ScrW() / 2, ScrH() / 2 + GetConVarNumber("PC_crosshair_cross_size"))
		surface.DrawLine(ScrW() / 2 - GetConVarNumber("PC_crosshair_cross_size"), ScrH() / 2, ScrW() / 2 + GetConVarNumber("PC_crosshair_cross_size"), ScrH() / 2)
	end
end
hook.Add("HUDPaint", "crosshair", crosshair)

 -- // PROPTOPLAYER TRACERS // --
local function proptoplayer()
	if GetConVarNumber("PC_p2p") == 1 then
		for k, v in pairs( ents.FindByClass( "prop_physics" ) ) do

			if (!myprops[v]) then continue end

				for c,b in pairs(player.GetAll()) do
					if v:GetPos():Distance(b:GetPos()) < 2000 then
						if validation(b) then
						local propPOS = v:LocalToWorld(v:OBBCenter())
							if LocalPlayer():KeyDown(IN_ATTACK) then
								if PC.physlineOn == true then
									if v:GetVelocity():Length() > 100 then
										if b:GetVelocity():Length() != 0 then
 
											cam.Start3D()
												render.SetMaterial(Material("trails/LOL"))
												render.DrawBeam(propPOS, b:EyePos(), 45, 0, 0, Color(0, 0, 0, 255))
												render.DrawLine(propPOS, b:EyePos(), Color(colors.P2PColor.r, colors.P2PColor.g, colors.P2PColor.b, colors.P2PColor.a))
											cam.End3D()
 
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
hook.Add ("HUDPaint", "proptoplayer", proptoplayer) // 35



local function ents_FindInSphereByClass(pos, dist, class)
  local out = {}

  for _, ent in pairs(ents.FindByClass(class)) do
    if ent:GetPos():Distance(pos) < dist then
		out[#out+1] = ent
    end
  end

  return out
end


-- // XRAY FUNCTION //
local function XRAY()

	
	if GetConVarNumber( "PC_xray" ) != 1 and PC.xray_invis then
		for k, v in pairs(ents_FindInSphereByClass(LocalPlayer():GetPos(), GetConVarNumber("PC_xray_distance_limit"), "prop_physics")) do
			render.MaterialOverride(nil)
			v:SetColor(PC.props_oldcolor[v])
		end
		PC.props_oldcolor = {}
		PC.xray_invis = false
		return 
	end

	for k, v in pairs(ents_FindInSphereByClass(LocalPlayer():GetPos(), GetConVarNumber("PC_xray_distance_limit"), "prop_physics")) do



	if GetConVarNumber( "PC_xray_propsound" ) == 1 then
		if v.PropSound then
			v.PropSound:ChangePitch(math.min(255,255*(v:GetVelocity():Length()/2500)), 0) -- credits to falco
		end
	end

	local DIS = v:GetPos():Distance(LocalPlayer():GetPos()) / 500

		if !IsOutOfFOV(v) then

			if GetConVarNumber( "PC_xray" ) == 1 then

				PC.props_oldcolor[v] = v:GetColor()
				v:SetColor(Color(0,0,0,0))
				PC.xray_invis = true

				cam.IgnoreZ( true )
				render.SuppressEngineLighting(true)
				render.MaterialOverride(Material(GetConVarString("PC_xray_mat1")))
				v:SetRenderMode( RENDERMODE_TRANSALPHA )
					render.SetColorModulation( colors.xray_color1.r / 255, colors.xray_color1.g / 255, colors.xray_color1.b / 255)
					if GetConVarNumber("PC_xray_adaptive_opacity") == 1 then
						render.SetBlend(0.08 + DIS)
					else
						render.SetBlend(GetConVarNumber("PC_xray_opacity_mat1") / 255 )
					end
				v:DrawModel()
				render.SuppressEngineLighting(false)
				render.MaterialOverride(nil)
				cam.IgnoreZ (false)

				if GetConVarNumber("PC_xray_multimat") == 1 then
					cam.IgnoreZ (true)
					render.SuppressEngineLighting(true)
					render.MaterialOverride(Material(GetConVarString("PC_xray_mat2")))
					v:SetRenderMode( RENDERMODE_TRANSALPHA )
					render.SetColorModulation( colors.xray_color2.r / 255, colors.xray_color2.g / 255, colors.xray_color2.b / 255)
					render.SetBlend( GetConVarNumber("PC_xray_opacity_mat2") / 255 )
					v:DrawModel()
					render.MaterialOverride(nil)
					render.SuppressEngineLighting(false)
					cam.IgnoreZ (false)
				end

			else

				render.MaterialOverride(nil)
				v:SetColor(Color(255,255,255,255))
				PC.xray_invis = false

			end

		if GetConVarNumber("PC_propboxes") == 1 then

			cam.IgnoreZ(true)
			render.SuppressEngineLighting(true)
			v:SetRenderMode(RENDERMODE_TRANSALPHA)
			render.DrawWireframeBox(v:GetPos(), v:GetAngles(), v:OBBMaxs() - Vector(-1.5 + DIS, -1.5 + DIS, -1.5 + DIS), v:OBBMins() + Vector(-1.5 + DIS, -1.5 + DIS, -1.5 + DIS), Color(colors.propboxes_color.r, colors.propboxes_color.g, colors.propboxes_color.b))
			render.DrawWireframeBox(v:GetPos(), v:GetAngles(), v:OBBMaxs() - Vector(-1.1 + DIS, -1.1 + DIS, -1.1 + DIS), v:OBBMins() + Vector(-1.1 + DIS, -1.1 + DIS, -1.1 + DIS), Color(colors.propboxes_color.r, colors.propboxes_color.g, colors.propboxes_color.b))
			render.DrawWireframeBox(v:GetPos(), v:GetAngles(), v:OBBMaxs() - Vector(-1, -1, -1), v:OBBMins() + Vector(-1, -1, -1), Color(0, 0,0))
			render.SuppressEngineLighting(false)
		end

		end

	end

end
hook.Add( "PreDrawEffects", "XRAY", XRAY )


local function XRAY2(ent)

	if not ent then return end

	local v = ent

	local DIS = Vector(0, 0, 0):Distance(Vector(0, 0, 0)) / 500

		-- if !IsOutOfFOV(v) then

			if GetConVarNumber( "PC_xray" ) == 1 then

				-- PC.props_oldcolor[v] = v:GetColor()
				v:SetColor(Color(0,0,0,0))
				-- PC.xray_invis = true

				cam.IgnoreZ( true )
				render.SuppressEngineLighting(true)
				render.MaterialOverride(Material(GetConVarString("PC_xray_mat1")))
				v:SetRenderMode( RENDERMODE_TRANSALPHA )
					render.SetColorModulation( colors.xray_color1.r / 255, colors.xray_color1.g / 255, colors.xray_color1.b / 255)
					if GetConVarNumber("PC_xray_adaptive_opacity") == 1 then
						render.SetBlend(0.5)
					else
						render.SetBlend(GetConVarNumber("PC_xray_opacity_mat1") / 255 )
					end
				v:DrawModel()
				render.SuppressEngineLighting(false)
				render.MaterialOverride(nil)
				cam.IgnoreZ (false)

				if GetConVarNumber("PC_xray_multimat") == 1 then
					cam.IgnoreZ (true)
					render.SuppressEngineLighting(true)
					render.MaterialOverride(Material(GetConVarString("PC_xray_mat2")))
					v:SetRenderMode( RENDERMODE_TRANSALPHA )
					render.SetColorModulation( colors.xray_color2.r / 255, colors.xray_color2.g / 255, colors.xray_color2.b / 255)
					render.SetBlend( (GetConVarNumber("PC_xray_opacity_mat2") / 255)/2 )
					v:DrawModel()
					render.MaterialOverride(nil)
					render.SuppressEngineLighting(false)
					cam.IgnoreZ (false)
				end


			end

		if GetConVarNumber("PC_propboxes") == 1 then

			cam.IgnoreZ(true)
			render.SuppressEngineLighting(true)
			v:SetRenderMode(RENDERMODE_TRANSALPHA)
			render.DrawWireframeBox(Vector(0, 0, 0), v:GetAngles(), Vector(16.745787, 25.287077, 76.050728)- Vector(-1.5 + DIS, -1.5 + DIS, -1.5 + DIS) , Vector(-13.919565, -25.283932, -0.261752)+ Vector(-1.5 + DIS, -1.5 + DIS, -1.5 + DIS), Color(colors.propboxes_color.r, colors.propboxes_color.g, colors.propboxes_color.b))
			render.DrawWireframeBox(Vector(0, 0, 0), v:GetAngles(), Vector(16.745787, 25.287077, 76.050728)- Vector(-1.1 + DIS, -1.1 + DIS, -1.1 + DIS) , Vector(-13.919565, -25.283932, -0.261752)+ Vector(-1.1 + DIS, -1.1 + DIS, -1.1 + DIS), Color(colors.propboxes_color.r, colors.propboxes_color.g, colors.propboxes_color.b))
			render.DrawWireframeBox(Vector(0, 0, 0), v:GetAngles(), Vector(16.745787, 25.287077, 76.050728) - Vector(-1, -1, -1) , Vector(-13.919565, -25.283932, -0.261752)+ Vector(-1, -1, -1), Color(0, 0,0))
			v:DrawModel()
			render.SuppressEngineLighting(false)
			cam.IgnoreZ (false)
		end

end

-- // CHAMS FUNCTION //
local function CHAMS()

	if GetConVarNumber("PC_chams") != 1 and GetConVarNumber("PC_playerboxes") != 1 then 
		if (PC.chams_invis) then
			for k,v in pairs(player.GetAll()) do
				v:SetColor(Color(255,255,255,255))
			end
			PC.chams_invis = false
		end
		return 
	end

	for k,v in pairs(player.GetAll()) do

	local DIS = v:GetPos():Distance(LocalPlayer():GetPos()) / 500

		if !IsOutOfFOV(v) then

			if validation(v) then

				if GetConVarNumber ("PC_chams") == 1 then
					v:SetColor(Color(0,0,0,0))
					PC.chams_invis = true
					cam.IgnoreZ (true)
					render.MaterialOverride(Material(GetConVarString("PC_chams_mat1")))
					v:SetRenderMode( RENDERMODE_TRANSALPHA )
					render.SetColorModulation( colors.chams_color1.r / 255, colors.chams_color1.g / 255, colors.chams_color1.b / 255)
					render.SetBlend( GetConVarNumber("PC_chams_opacity_mat1") / 255 )
					v:DrawModel()
					render.MaterialOverride(nil)
					cam.IgnoreZ (false)

					if GetConVarNumber("PC_chams_multimat") == 1 then
						cam.IgnoreZ (true)
						render.MaterialOverride(Material(GetConVarString("PC_chams_mat2")))
						v:SetRenderMode( RENDERMODE_TRANSALPHA )
						render.SetColorModulation( colors.chams_color2.r / 255, colors.chams_color2.g / 255, colors.chams_color2.b / 255)
						render.SetBlend( GetConVarNumber("PC_chams_opacity_mat2") / 255 )
						v:DrawModel()
						render.MaterialOverride(nil)
						cam.IgnoreZ (false)
					end

				end

				if GetConVarNumber("PC_playerboxes") == 1 then
					if LocalPlayer():GetObserverTarget() != v then
						cam.IgnoreZ(true)
						render.SuppressEngineLighting(true)
						v:SetRenderMode(RENDERMODE_TRANSALPHA)
						render.DrawWireframeBox(v:GetPos(), v:GetAngles(), v:OBBMaxs() - Vector(-1.5 + DIS, -1.5 + DIS, -1.5 + DIS), v:OBBMins() + Vector(-1.5 + DIS, -1.5 + DIS, -1.5 + DIS), Color(colors.playerboxes_color.r, colors.playerboxes_color.g, colors.playerboxes_color.b))
						render.DrawWireframeBox(v:GetPos(), v:GetAngles(), v:OBBMaxs() - Vector(-1.1 + DIS, -1.1 + DIS, -1.1 + DIS), v:OBBMins() + Vector(-1.1 + DIS, -1.1 + DIS, -1.1 + DIS), Color(colors.playerboxes_color.r, colors.playerboxes_color.g, colors.playerboxes_color.b))
						render.DrawWireframeBox(v:GetPos(), v:GetAngles(), v:OBBMaxs() - Vector(-1, -1, -1), v:OBBMins() + Vector(-1, -1, -1), Color(0, 0,0))
						render.SuppressEngineLighting(false)
					end
				end

				if GetConVarNumber("PC_chams_wep") == 1 then
					if(IsValid(v:GetActiveWeapon())) then
						cam.IgnoreZ(true)
						render.SuppressEngineLighting(true)
						render.MaterialOverride(Material("models/debug/debugwhite"))
						render.SetColorModulation(colors.chams_wep_color.r / 255, colors.chams_wep_color.g / 255, colors.chams_wep_color.b / 255)
						render.SetBlend( GetConVarNumber("PC_chams_wep_opacity") / 255 )
						v:GetActiveWeapon():DrawModel()
						render.SuppressEngineLighting(false)
						render.MaterialOverride(nil)
						cam.IgnoreZ(false)
					end
				end

			end

		end

	end

end
hook.Add ("PreDrawEffects", "CHAMS", CHAMS)

local function CHAMS2(ent, ent2)

	if GetConVarNumber("PC_chams") != 1 and GetConVarNumber("PC_playerboxes") != 1 then return end

	-- for k,v in pairs(player.GetAll()) do

	if not ent then return end

	local v = ent

	local DIS =  Vector(0, 0, 0):Distance(Vector(0, 0, 0)) / 500

		-- if !IsOutOfFOV(v) then

			-- if validation(v) then

				if GetConVarNumber ("PC_chams") == 1 then
					cam.IgnoreZ (true)
					render.MaterialOverride(Material(GetConVarString("PC_chams_mat1")))
					v:SetRenderMode( RENDERMODE_TRANSALPHA )
					render.SetColorModulation( colors.chams_color1.r / 255, colors.chams_color1.g / 255, colors.chams_color1.b / 255)
					render.SetBlend( GetConVarNumber("PC_chams_opacity_mat1") / 255 )
					v:DrawModel()
					render.MaterialOverride(nil)
					cam.IgnoreZ (false)

					if GetConVarNumber("PC_chams_multimat") == 1 then
						cam.IgnoreZ (true)
						render.MaterialOverride(Material(GetConVarString("PC_chams_mat2")))
						v:SetRenderMode( RENDERMODE_TRANSALPHA )
						render.SetColorModulation( colors.chams_color2.r / 255, colors.chams_color2.g / 255, colors.chams_color2.b / 255)
						render.SetBlend( (GetConVarNumber("PC_chams_opacity_mat2") / 255)/2 )
						v:DrawModel()
						render.MaterialOverride(nil)
						cam.IgnoreZ (false)
					end

				end

				if GetConVarNumber("PC_playerboxes") == 1 then
					if LocalPlayer():GetObserverTarget() != v then
						cam.IgnoreZ(true)
						render.SuppressEngineLighting(true)
						v:SetRenderMode(RENDERMODE_TRANSALPHA)
						render.DrawWireframeBox(Vector(0, 0, 0), v:GetAngles(), Vector(16.000000, 16.000000, 72.000000) - Vector(-1.5 + DIS, -1.5 + DIS, -1.5 + DIS), Vector(-16.000000, -16.000000, 0.000000) + Vector(-1.5 + DIS, -1.5 + DIS, -1.5 + DIS), Color(colors.playerboxes_color.r, colors.playerboxes_color.g, colors.playerboxes_color.b))
						render.DrawWireframeBox(Vector(0, 0, 0), v:GetAngles(), Vector(16.000000, 16.000000, 72.000000) - Vector(-0.5 + DIS, -0.5 + DIS, -0.5 + DIS), Vector(-16.000000, -16.000000, 0.000000) + Vector(-0.5 + DIS, -0.5 + DIS, -0.5 + DIS), Color(colors.playerboxes_color.r, colors.playerboxes_color.g, colors.playerboxes_color.b))
						render.DrawWireframeBox(Vector(0, 0, 0), v:GetAngles(), Vector(16.000000, 16.000000, 72.000000) - Vector(-1, -1, -1), Vector(-16.000000, -16.000000, 0.000000) + Vector(-1, -1, -1), Color(0, 0,0))
						render.SuppressEngineLighting(false)
					end
				end

				if GetConVarNumber("PC_chams_wep") == 1 then
					if(IsValid(ent2)) then
						cam.IgnoreZ(true)
						render.SuppressEngineLighting(true)
						render.MaterialOverride(Material("models/debug/debugwhite"))
						render.SetColorModulation(colors.chams_wep_color.r / 255, colors.chams_wep_color.g / 255, colors.chams_wep_color.b / 255)
						render.SetBlend( GetConVarNumber("PC_physgun_wireframe_opacity") / 255 )
						ent2:DrawModel()
						render.SuppressEngineLighting(false)
						render.MaterialOverride(nil)
						cam.IgnoreZ(false)
					end
				end

			end

		-- end

	-- end

-- end

hook.Add("Think", "dsgdfgxds", function()
    if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP then return end
	if GetConVarNumber("PC_bhop") == 1 then
		if (input.IsKeyDown(KEY_SPACE)) then
			if LocalPlayer():IsOnGround() then
				if LocalPlayer():IsTyping() then return end
					RunConsoleCommand("+jump")
					jumped = 1
				else
					RunConsoleCommand("-jump")
					jumped = 0
			end
			elseif LocalPlayer():IsOnGround() then
				if jumped == 1 then
					RunConsoleCommand("-jump")
					jumped = 0
			end
		end
	end
end)

 // FOV CHANGER
local function fov_changer(ply, pos, ang, fov)

	local view = {}

	if (!IsValid(ply)) then return end
	if GetConVarNumber("PC_FOVEnable") == 1 then
		view.fov = GetConVar("PC_FOVNumber"):GetInt()
		if GetConVarNumber("PC_FOV_VELOCITY") == 1 then
			view.fov =  math.Clamp(GetConVar("PC_FOVNumber"):GetInt() + LocalPlayer():GetVelocity():Length() / 60, GetConVar("PC_FOVNumber"):GetInt(), 140) -- trial's idea, feels good but unplayable in propkill :D
		end
	end

	return view 

end
hook.Add("CalcView", "fovchanger", fov_changer)

if not cvars.GetConVarCallbacks("PC_FOVEnable") then
	cvars.AddChangeCallback( "PC_FOVEnable", function( convar_name, value_old, value_new )
		if value_new == "0" then
			hook.Remove("CalcView", "fovchanger")
		else
			hook.Add("CalcView", "fovchanger", fov_changer)
		end
	end, "PC_FOVEnable_callback" )
end

-- // ROTATING FUNCTIONS // -- (from 3SP as all the rotates are the same thing)
local function ROTATE2()
	LocalPlayer():SetEyeAngles(Angle(-LocalPlayer():EyeAngles().x, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().z))
	RunConsoleCommand("+jump")
	timer.Simple(0.01, function()
		RunConsoleCommand("-jump")
	end)
end
concommand.Add("brain_ROTATE2", ROTATE2)

local function ROTATE()
	LocalPlayer():SetEyeAngles(Angle(-LocalPlayer():EyeAngles().x, LocalPlayer():EyeAngles().y - 180, LocalPlayer():EyeAngles().z))
end
concommand.Add("brain_ROTATE", ROTATE)

// credits to falco
local function Rotate180()
	FALCO_NOAUTOPICKUP = true
	timer.Simple(0.5, function() FALCO_NOAUTOPICKUP = false end)

	if hook.GetTable().CreateMove and hook.GetTable().CreateMove.PickupEnt then
		hook.Remove("CreateMove", "PickupEnt")
		hook.Remove("CalcView", "Ididntseeit")
		timer.Simple(0.05, function()
			local a = LocalPlayer():EyeAngles() LocalPlayer():SetEyeAngles(Angle(a.p, a.y-180, a.r))
		end)
		return
	end
	local a = LocalPlayer():EyeAngles() LocalPlayer():SetEyeAngles(Angle(a.p, a.y-180, a.r))
end

// credits to falco
concommand.Add("PC_180shot", function()
	local IsHook = hook.GetTable().CalcView and hook.GetTable().CalcView["180shot"]
	local IsHook2 = hook.GetTable().CalcView and hook.GetTable().CalcView["fovchanger"]

	PC.shotting = true
	
	if IsHook then
		Rotate180()
		hook.Remove("CalcView", "180shot")
		hook.Add("CalcView", "fovchanger", fov_changer)
		timer.Destroy("180shot")
		PC.shotting = false
		return
	end

	if IsHook2 then hook.Remove("CalcView", "fovchanger") end

	hook.Add("CalcView", "180shot", function(ply, origin, angle, fov)
		local view = {}
		view.origin = origin
		view.angles = angle - Angle(0,180,0)
		if GetConVarNumber("PC_FOVEnable") == 1 then
			view.fov = GetConVar("PC_FOVNumber"):GetInt()
			if GetConVarNumber("PC_FOV_VELOCITY") == 1 then
				view.fov =  math.Clamp(GetConVar("PC_FOVNumber"):GetInt() + LocalPlayer():GetVelocity():Length() / 60, GetConVar("PC_FOVNumber"):GetInt(), 140) -- trial's idea, feels good but unplayable in propkill :D
			end
		end

		if not LocalPlayer():KeyDown(IN_ATTACK) then
			hook.Remove("CalcView", "180shot")
			hook.Add("CalcView", "fovchanger", fov_changer)
			Rotate180()
			timer.Destroy("180shot")
			PC.shotting = false
		end

		return view
	end)
	Rotate180()
	timer.Create("180shot", 5, 1, function()
		hook.Remove("CalcView", "180shot")
		hook.Add("CalcView", "fovchanger", fov_changer)
		Rotate180()
		PC.shotting = false
	end)
end)

-- // tracers // -- 
local function TRACERS()
	if ( GetConVarNumber("PC_tracers") == 1 ) then
		for k,v in next, player.GetAll() do
		local Dist
		if GetConVarString("PC_tracers_beam_mat") == "sprites/lookingat" then
			Dist = math.Clamp( v:GetShootPos():Distance( LocalPlayer():GetShootPos() ), 700, 1500 )
		else
			Dist = math.Clamp( v:GetShootPos():Distance( LocalPlayer():GetShootPos() ), 100, 2500 )
		end
			if validation(v) and LocalPlayer():GetObserverMode() == 0 then
				cam.Start3D()
					cam.IgnoreZ(true)
					if ( GetConVarNumber("PC_tracers_beam") == 1 ) then 
						render.SetMaterial(Material(GetConVarString("PC_tracers_beam_mat")))
						if GetConVarString("PC_tracers_beam_mat") == "sprites/lookingat" then
							render.DrawBeam(v:GetPos(), LocalPlayer():GetPos() + EyeAngles():Forward() * 80, Dist /200, 0.8, Dist /60, Color(colors.tracers_beam_color.r, colors.tracers_beam_color.g, colors.tracers_beam_color.b, GetConVarNumber("PC_tracers_beam_opacity")))
						else
							render.DrawBeam(LocalPlayer():GetPos() + EyeAngles():Forward() * 80, v:GetPos(), Dist/125, 1, 1, Color(colors.tracers_beam_color.r, colors.tracers_beam_color.g, colors.tracers_beam_color.b, GetConVarNumber("PC_tracers_beam_opacity")))
						end
					end
					if ( GetConVarNumber("PC_tracers_line") == 1 ) then 
						render.DrawLine(LocalPlayer():GetPos() + EyeAngles():Forward() * 80, v:GetPos(), Color(colors.tracers_line_color.r, colors.tracers_line_color.g, colors.tracers_line_color.b, GetConVarNumber("PC_tracers_line_opacity")))
					end
				cam.End3D()
			end
		end
	end
end
hook.Add("RenderScreenspaceEffects", "tracerslel", TRACERS)

hook.Add("PostDraw2DSkyBox", "removeSkybox1", function()
	if GetConVarNumber("PC_custom_skybox") == 1 then
		render.Clear(colors.skybox_custom_col.r, colors.skybox_custom_col.g, colors.skybox_custom_col.b, 255)
	end
	return true	
end)

hook.Add("PostDrawSkyBox", "removeSkybox2", function()
	if GetConVarNumber("PC_custom_skybox") == 1 then
		render.Clear(colors.skybox_custom_col.r, colors.skybox_custom_col.g, colors.skybox_custom_col.b, 255)
	end
	return true	
end)

local function HEADBEAMS()

	local hbcolor_beam = Color(colors.headbeams_beam_color.r, colors.headbeams_beam_color.g, colors.headbeams_beam_color.b, GetConVarNumber("PC_headbeams_beam_opacity"))
	local hbcolor_line = Color(colors.headbeams_line_color.r, colors.headbeams_line_color.g, colors.headbeams_line_color.b, GetConVarNumber("PC_headbeams_line_opacity"))

	if (GetConVarNumber("PC_headbeams") == 1) and ( GetConVarNumber("PC_headbeams_beam") == 1 or GetConVarNumber("PC_headbeams_line") == 1 )then

		for k,v in pairs(player.GetAll()) do

			if validation(v) and !IsOutOfFOV(v) then

			local Origin = v:GetPos() + Vector( 0, 0, 40 ) 
			local Up = util.TraceLine( { start = Origin, endpos = Origin + Vector( 0, 0, 16384 ), filter = { v }, mask = MASK_SHOT } )
			local Down
			local Dist = math.Clamp( v:GetShootPos():Distance( LocalPlayer():GetShootPos() ), 100, 2500 )
			local CutoffPos
			local SpriteDist = v:EyePos():Distance(Up.HitPos)
			local V
			local StretchX = Dist/200
			local StretchY = Dist/400
			
			if GetConVarString("PC_headbeams_type") == "foot" or GetConVarString("PC_headbeams_type") == "both" then
				Down = util.TraceLine( { start = Origin, endpos = Origin - Vector( 0, 0, 16384 ), filter = { v }, mask = MASK_SHOT } )
				if GetConVarString("PC_headbeams_type") == "both" then
					V = { Start = Down.HitPos, End = Up.HitPos, Width = Dist /40  }
				end
				if GetConVarString("PC_headbeams_type") == "foot" then
					V = { Start = Down.HitPos, End = v:EyePos() - Vector(0,0,55), Width = Dist /40  }
				end
			end
			if GetConVarString("PC_headbeams_type") == "head" then
				V = { Start = v:EyePos(), End = Up.HitPos, Width = Dist /40  }
			end

				-- for u,f in pairs(ents.FindByClass("prop_physics")) do -- turning the color red when a prop is over players head
					if myprops[Up.Entity] then
						hbcolor_beam = Color(255,0,0,255)
						hbcolor_line = Color(255,0,0,255)
					else
						hbcolor_beam = Color(colors.headbeams_beam_color.r, colors.headbeams_beam_color.g, colors.headbeams_beam_color.b, GetConVarNumber("PC_headbeams_beam_opacity"))
						hbcolor_line = Color(colors.headbeams_line_color.r, colors.headbeams_line_color.g, colors.headbeams_line_color.b, GetConVarNumber("PC_headbeams_line_opacity"))
					end
				-- end

				cam.Start3D()
					cam.IgnoreZ(true)
					if GetConVarNumber("PC_headbeams_beam") == 1 then
						render.SetMaterial( Material( GetConVarString("PC_headbeams_beam_mat") ) )
						render.DrawBeam( V.Start , V.End, V.Width, StretchX, StretchY, hbcolor_beam )
					end
					if GetConVarNumber("PC_headbeams_line") == 1 then
						render.DrawLine(V.Start, V.End, hbcolor_line)
					end
				cam.End3D()
			end
		end
	end
end
hook.Add("RenderScreenspaceEffects", "HEADBEAMS", HEADBEAMS)


local function eyetrace()

	if GetConVarNumber("PC_eyetrace") == 1 and (GetConVarNumber("PC_eyetrace_beam") == 1 or GetConVarNumber("PC_eyetrace_line") == 1) then

		for k,v in pairs(player.GetAll()) do

			if validation(v) then

			local Origin
			if GetConVarString("PC_eyetrace_origin") == "eyepos" then
				Origin =  v:EyePos()
			else
				Origin =  v:GetBonePosition( v:LookupBone( "ValveBiped.Bip01_R_Hand" ) )
			end
			
			local Dist = math.Clamp( v:GetShootPos():Distance( LocalPlayer():GetShootPos() ), 100, 1000 )
			local StretchX = Dist/200
			local StretchY = Dist/400
			

				cam.Start3D()
					cam.IgnoreZ(true)
					if GetConVarNumber("PC_eyetrace_beam") == 1 then
						render.SetMaterial( Material( GetConVarString("PC_eyetrace_beam_mat") ) )
						render.DrawBeam( Origin ,v:GetEyeTrace().HitPos, Dist/50, StretchX, StretchY, Color(colors.eyetrace_beam_color.r, colors.eyetrace_beam_color.g, colors.eyetrace_beam_color.b, GetConVarNumber("PC_eyetrace_beam_opacity")) )
					end
					if GetConVarNumber("PC_eyetrace_line") == 1 then
						render.DrawLine(Origin, v:GetEyeTrace().HitPos, Color(colors.eyetrace_line_color.r, colors.eyetrace_line_color.g, colors.eyetrace_line_color.b, GetConVarNumber("PC_eyetrace_line_opacity")))
					end
				cam.End3D()
			end
		end
	end
end
hook.Add("RenderScreenspaceEffects", "eyetrace", eyetrace)


local MENU = {
	CheckBoxes = {},
	SettingsButtons = {},
	Functions_Registered = {},
	Things = {},
	SettingsFuncs = {},
	COLORSHIT = {},
	Labels = {},
	Sliders = {},
}

local function RegisterFunc(func, n)
	if not MENU.Functions_Registered[n] then
		MENU.Functions_Registered[n] = func
	end
	return MENU.Functions_Registered[n]
end

local function flipconvar(convar)
	if ( GetConVarNumber(convar)  == 1 ) then
		RunConsoleCommand(convar, "0")
	else
		RunConsoleCommand(convar, "1")
	end
end

local function AdjustMenuElement(var, posx, posy, sizex, sizey, title, SetDraggable, ShowCloseButton, MakePopup, paintfunc, center, setvisible, closefunc, convar)
	var:SetPos(posx, posy)
	if sizex and sizey then
		var:SetSize(sizex, sizey)
	end
	if title then
		var:SetTitle(title)
	end
	if SetDraggable then
		var:SetDraggable(true)
	end
	if ShowCloseButton then
		var:ShowCloseButton(true)
	end
	if MakePopup then
		var:MakePopup()
	end
	if paintfunc then
		if paintfunc == "settings" then
			var.Paint = RegisterFunc(function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
				local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
				surface.SetDrawColor( col )
				surface.DrawOutlinedRect(0,0,w,h)
			end,4)
		else
			var.Paint = paintfunc
		end
	end
	if center then
		var:Center(true)
	end
	if setvisible then
		var:SetVisible(true)
	end
	if closefunc then
		if closefunc == "settings" then
			var.OnClose = function()
				flipconvar(convar)
			end
		else
			var.OnClose = closefunc
		end
	end
end

local function AddMenuElementToTable(func, element, cvar)
	MENU.Things[func] = {element, cvar}
	MENU.SettingsFuncs[cvar] =  {func,element}
end

local function SettingsFunction(func, cvar)
	MENU.SettingsFuncs[cvar] =  {func,0}
end

local function AddCheckBox(text, convar, posx, posy, parent, tooltip, settingsbutton, func)
	MENU.CheckBoxes[text] = vgui.Create("DCheckBoxLabel", parent)
	MENU.CheckBoxes[text]:SetPos(posx, posy)
	MENU.CheckBoxes[text]:SetText(text)
	MENU.CheckBoxes[text]:SetConVar(convar)
	MENU.CheckBoxes[text]:SetFont("TargetIDSmall")
	if tooltip then
		MENU.CheckBoxes[text]:SetToolTip(tooltip)
	end
	if settingsbutton then
		MENU.SettingsButtons[text] = vgui.Create("DExpandButton", parent)
		MENU.SettingsButtons[text]:SetPos(posx-27, posy-3.5)
		MENU.SettingsButtons[text]:SetSize(23, 23)
		MENU.SettingsButtons[text]:SetTooltip(text.." settings window.")
		MENU.SettingsButtons[text].DoClick = func
	end
end

// huge fucking function which purpose is to create DRGBPickers and ColorCubes linked between eachothers to edit the visuals colors 
// (you dont have to fill all the arguments, just choose how many picker with cube you want from one to three maximum)
// note: WHY DID YOU CREATE THREE SET OF FUNCTIONS INSTEAD OF JUST ONE DOING THE SAME FOR ALL THE PICKERS AND CUBES? ---> vgui elements were in conflict and cubes were being controlled by the wrong picker as soon as you added more cubes.
// actually dont know if thats optimized, thats just meant to be a func creating elements and linking them when the menu is opened.. massive line economy tho
local function AdjustAndLinkPickersWithCubes(cube1, picker1, cubesizex1, cubesizey1, cubeposx1, cubeposy1, pickersizex1, pickersizey1, pickerposx1, pickerposy1, color1, convar1, cube2, picker2, cubesizex2, cubesizey2, cubeposx2, cubeposy2, pickersizex2, pickersizey2, pickerposx2, pickerposy2, color2, convar2, cube3, picker3, cubesizex3, cubesizey3, cubeposx3, cubeposy3, pickersizex3, pickersizey3, pickerposx3, pickerposy3, color3, convar3)

	cube1:SetPos(cubeposx1,cubeposy1)
	cube1:SetSize(cubesizex1,cubesizey1)
	cube1:SetColor( color1 )

	picker1:SetPos(pickerposx1, pickerposy1)
	picker1:SetSize(pickersizex1, pickersizey1)

		function picker1:SetColor( col )
			-- Get hue
			local h = ColorToHSV( col )
			-- Maximize saturation and vibrance
			col = HSVToColor( h, 1, 1 )
			-- Set color var
			self:SetRGB( col )
			-- Calculate position of color picker line
			local _, height = self:GetSize()
			self.LastY = height*( 1-( h/360 ) )
			-- Register that a change has occured
			self:OnChange( self:GetRGB() )
		end
		picker1:SetColor(color1)

		function picker1:OnChange( col )
			-- Get the hue of the RGB picker and the saturation and vibrance of the color cube
			local h = ColorToHSV( col )
			local _, s, v = ColorToHSV( cube1:GetRGB() )
			-- Mix them together and update the color cube
			local col = HSVToColor( h, s, v )
			cube1:SetColor( col )
			GetConVar(convar1):SetString( " "..col.r..", "..col.g..", "..col.b)
		end

		function cube1:OnUserChanged( col )
			GetConVar(convar1):SetString( " "..col.r..", "..col.g..", "..col.b)
		end


if cube2 then
	cube2:SetPos(cubeposx2,cubeposy2)
	cube2:SetSize(cubesizex2,cubesizey2)
	cube2:SetColor( color2 )

	picker2:SetPos(pickerposx2, pickerposy2)
	picker2:SetSize(pickersizex2, pickersizey2)

	function picker2:SetColor( col )
		-- Get hue
		local h = ColorToHSV( col )
		-- Maximize saturation and vibrance
		col = HSVToColor( h, 1, 1 )
		-- Set color var
		self:SetRGB( col )
		-- Calculate position of color picker line
		local _, height = self:GetSize()
		self.LastY = height*( 1-( h/360 ) )
		-- Register that a change has occured
		self:OnChange( self:GetRGB() )
	end
	picker2:SetColor(color2)

	function picker2:OnChange( col )
		-- Get the hue of the RGB picker and the saturation and vibrance of the color cube
		local h = ColorToHSV( col )
		local _, s, v = ColorToHSV( cube2:GetRGB() )
		-- Mix them together and update the color cube
		local col = HSVToColor( h, s, v )
		cube2:SetColor( col )
		GetConVar(convar2):SetString( " "..col.r..", "..col.g..", "..col.b)
	end

	function cube2:OnUserChanged( col )
		GetConVar(convar2):SetString( " "..col.r..", "..col.g..", "..col.b)
	end
end

if cube3 then
	cube3:SetPos(cubeposx3,cubeposy3)
	cube3:SetSize(cubesizex3,cubesizey3)
	cube3:SetColor( color3 )

	-- picker3 = vgui.Create("DRGBPicker", panel)
	picker3:SetPos(pickerposx3, pickerposy3)
	picker3:SetSize(pickersizex3, pickersizey3)

	function picker3:SetColor( col )
		-- Get hue
		local h = ColorToHSV( col )
		-- Maximize saturation and vibrance
		col = HSVToColor( h, 1, 1 )
		-- Set color var
		self:SetRGB( col )
		-- Calculate position of color picker line
		local _, height = self:GetSize()
		self.LastY = height*( 1-( h/360 ) )
		-- Register that a change has occured
		self:OnChange( self:GetRGB() )
	end
	picker3:SetColor(color3)

	function picker3:OnChange( col )
		-- Get the hue of the RGB picker and the saturation and vibrance of the color cube
		local h = ColorToHSV( col )
		local _, s, v = ColorToHSV( cube3:GetRGB() )
		-- Mix them together and update the color cube
		local col = HSVToColor( h, s, v )
		cube3:SetColor( col )
		GetConVar(convar3):SetString( " "..col.r..", "..col.g..", "..col.b)
	end

	function cube3:OnUserChanged( col )
		GetConVar(convar3):SetString( " "..col.r..", "..col.g..", "..col.b)
	end

end

end

local function AddLabel(var, panel, posx, posy, text, sizetocontent, font, sizex, sizey)
	MENU.Labels[var] = vgui.Create("DLabel", panel)
	MENU.Labels[var]:SetPos(posx+ (29.5454545455*posx)/100,posy)
	MENU.Labels[var]:SetText( text )
	if sizetocontent then
		MENU.Labels[var]:SizeToContents()
	end
	if font then
		MENU.Labels[var]:SetFont(font)
	end
	if sizex then
		MENU.Labels[var]:SetSize(sizex, sizey)
	end
end

function AddSlider(var, panel, posx, posy, sizex, sizey, text, min, max, value, decimals, color, cvar, default, cvar2)
	MENU.Sliders[var] = vgui.Create("DNumSlider", panel)
	MENU.Sliders[var]:SetMinMax( min, max )
	MENU.Sliders[var]:SetValue( value )
	if text then
		MENU.Sliders[var]:SetText( text )
	end
	MENU.Sliders[var]:SetDefaultValue( default )
	MENU.Sliders[var]:SetDecimals( 0 )
	MENU.Sliders[var]:SetPos(posx,posy)
	MENU.Sliders[var]:SetSize(sizex,sizey)
	if color then
		MENU.Sliders[var]:GetTextArea():SetTextColor(Color(255,255,255))
	end
	MENU.Sliders[var].OnValueChanged = function( panel, val )
		RunConsoleCommand(cvar, val)
	end
MENU.Sliders[var].Slider.Knob.Paint = function( self, w, h )
	surface.SetDrawColor( 80, 80, 80, 255 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall()-20 )
end
MENU.Sliders[var].Slider.Paint = function( self, w, h )
	surface.SetDrawColor( 255,255,255,100 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall()-20 )
end

end

local function ESP_SETTINGS()
	MENU.esp_settings_frame = vgui.Create( "DFrame" )
	AdjustMenuElement(MENU.esp_settings_frame, ScrW()/2 + 290, ScrH()/2 + 120, 250, 250, "ESP Settings", true, true, true, "settings", false, true, "settings", "PC_esp_settings")

		local EspSettingsPanel = vgui.Create( "DPanel", MENU.esp_settings_frame )
		EspSettingsPanel:Dock( FILL )
		EspSettingsPanel.Paint = RegisterFunc(function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			surface.SetDrawColor( col )
			surface.DrawOutlinedRect(0,0,w,h)
		end,28)

		AddLabel("espcol1", EspSettingsPanel, 13, 5, "ESP Color1")
		MENU.COLORSHIT.esp_color1_colorcube = vgui.Create("DColorCube", EspSettingsPanel)
		MENU.COLORSHIT.esp_color1_colorpicker = vgui.Create("DRGBPicker", EspSettingsPanel)
		AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.esp_color1_colorcube, MENU.COLORSHIT.esp_color1_colorpicker, 70, 70, 38, 30, 20, 70, 15, 30, colors.esp_color1, "PC_esp_col1")

		AddLabel("espcol2", EspSettingsPanel, 100, 5, "ESP Color2")
		MENU.COLORSHIT.esp_color2_colorcube = vgui.Create("DColorCube", EspSettingsPanel)
		MENU.COLORSHIT.esp_color2_colorpicker = vgui.Create("DRGBPicker", EspSettingsPanel)
		AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.esp_color2_colorcube, MENU.COLORSHIT.esp_color2_colorpicker, 70, 70, 152, 30, 20, 70, 129, 30, colors.esp_color2, "PC_esp_col2")

		AddLabel("boneslabel", EspSettingsPanel, 75, 115, "Bones Color")
		MENU.COLORSHIT.esp_bones_colorcube = vgui.Create("DColorCube", EspSettingsPanel)
		MENU.COLORSHIT.esp_bones_colorpicker = vgui.Create("DRGBPicker", EspSettingsPanel)
		AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.esp_bones_colorcube, MENU.COLORSHIT.esp_bones_colorpicker, 100, 70, 80, 138, 20, 70, 57, 138, colors.esp_bones_color, "PC_esp_bones_col")

AddMenuElementToTable(ESP_SETTINGS, MENU.esp_settings_frame, "PC_esp_settings")
end
SettingsFunction(ESP_SETTINGS, "PC_esp_settings")

local function XRAY_SETTINGS()

	MENU.xray_settings_frame = vgui.Create( "DFrame" )
	AdjustMenuElement(MENU.xray_settings_frame, ScrW()/2 + 290, ScrH()/2 - 420, 250, 250, "Xray Settings", true, true, true, "settings", false, true, "settings", "PC_xray_settings")

		local XraySettingsPanel = vgui.Create( "DPanel", MENU.xray_settings_frame )
		XraySettingsPanel:Dock( FILL )
		XraySettingsPanel.Paint = RegisterFunc(function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			surface.SetDrawColor( col )
			surface.DrawOutlinedRect(0,0,w,h)
		end,25)

		local MATERIALS = vgui.Create ("DLabel", XraySettingsPanel)
		MATERIALS:SetText("MATERIALS")
		MATERIALS:SetPos(10,5)

		local MAIN = vgui.Create ("DLabel", XraySettingsPanel)
		MAIN:SetText("Main:")
		MAIN:SetPos(25,20)

		local mat1 = vgui.Create ("DComboBox", XraySettingsPanel)
		mat1:SetValue(GetConVarString("PC_xray_mat1"))
		mat1:SetPos(30,40)
		mat1:SizeToContents()
		mat1:AddChoice("models/wireframe")
		mat1:AddChoice("models/debug/debugwhite")
		mat1:AddChoice("!White9")
		mat1.OnSelect = function( panel, index, value )
			GetConVar("PC_xray_mat1"):SetString( value )
		end


		local SECOND = vgui.Create ("DLabel", XraySettingsPanel)
		SECOND:SetText("Second:")
		SECOND:SetPos(25,60)

		local mat2 = vgui.Create ("DComboBox", XraySettingsPanel)
		mat2:SetValue(GetConVarString("PC_xray_mat2"))
		mat2:SetPos(30,80)
		mat2:SizeToContents()
		mat2:AddChoice("models/wireframe")
		mat2:AddChoice("models/debug/debugwhite")
		mat2:AddChoice("!White9")
		mat2:AddChoice("disable")
		mat2.OnSelect = function( panel, index, value )
				GetConVar("PC_xray_mat2"):SetString( value )
			if GetConVarString("PC_xray_mat2") == "disable" then
				RunConsoleCommand("PC_xray_multimat", 0)
			else
				RunConsoleCommand("PC_xray_multimat", 1)
			end
		end

		AddLabel("colorslabel", XraySettingsPanel, 10, 102, "COLORS")
		AddLabel("mainlabel", XraySettingsPanel, 25, 120, "Main:")
		AddLabel("secondlabel", XraySettingsPanel, 125, 120, "Second:")

		MENU.COLORSHIT.XRAY_maincolorcube = vgui.Create("DColorCube", XraySettingsPanel)
		MENU.COLORSHIT.XRAY_maincolorpicker = vgui.Create("DRGBPicker", XraySettingsPanel)

		MENU.COLORSHIT.XRAY_secondcolorcube = vgui.Create("DColorCube", XraySettingsPanel)
		MENU.COLORSHIT.XRAY_secondcolorpicker = vgui.Create("DRGBPicker", XraySettingsPanel)

		AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.XRAY_maincolorcube, MENU.COLORSHIT.XRAY_maincolorpicker, 65, 70, 30, 140, 20, 70, 8, 140, colors.xray_color1, "PC_xray_col_mat1", MENU.COLORSHIT.XRAY_secondcolorcube, MENU.COLORSHIT.XRAY_secondcolorpicker, 65, 70, 145, 140, 20, 70, 123, 140, colors.xray_color2, "PC_xray_col_mat2")
		
		local mainalpha = vgui.Create( "DAlphaBar", XraySettingsPanel )
		mainalpha:SetPos( 97, 140 )
		mainalpha:SetSize( 15, 70 )
		mainalpha:SetValue(GetConVarNumber("PC_xray_opacity_mat1"))
		mainalpha.OnChange = function( panel, alpha )
			GetConVar("PC_xray_opacity_mat1"):SetInt(alpha*255)
		end

		local secondalpha = vgui.Create( "DAlphaBar", XraySettingsPanel )
		secondalpha:SetPos( 212, 140 )
		secondalpha:SetSize( 15, 70 )
		secondalpha:SetValue(GetConVarNumber("PC_xray_opacity_mat2"))
		secondalpha.OnChange = function( panel, alpha )
			GetConVar("PC_xray_opacity_mat2"):SetInt(alpha*255)
		end


		AddMenuElementToTable(XRAY_SETTINGS, MENU.xray_settings_frame, "PC_xray_settings")

end
SettingsFunction(XRAY_SETTINGS, "PC_xray_settings")

local function HEADBEAMS_SETTINGS()
	MENU.headbeams_settings_frame = vgui.Create( "DFrame" )
	MENU.headbeams_settings_frame:SetPos( ScrW()/2 - 540 , ScrH()/2 - 420 )
	MENU.headbeams_settings_frame:SetSize( 250, 250 )
	MENU.headbeams_settings_frame:SetTitle( "Headbeams Settings" )
	MENU.headbeams_settings_frame:SetVisible( true )
	MENU.headbeams_settings_frame:SetDraggable( true )
	MENU.headbeams_settings_frame:ShowCloseButton( true )
	MENU.headbeams_settings_frame:MakePopup()
	MENU.headbeams_settings_frame.Paint = RegisterFunc(function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
		local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
		surface.SetDrawColor( col )
		surface.DrawOutlinedRect(0,0,w,h)
	end,31)


	MENU.headbeams_settings_frame.OnClose = function()
		flipconvar("PC_headbeams_settings")
	end

		local HBSettingsPanel = vgui.Create( "DPanel", MENU.headbeams_settings_frame )
		HBSettingsPanel:Dock( FILL )
		HBSettingsPanel.Paint = RegisterFunc(function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			surface.SetDrawColor( col )
			surface.DrawOutlinedRect(0,0,w,h)
		end,32)

			AddLabel("HEADBEAMS", HBSettingsPanel, 12, 10, "Headbeams:")

				local design1 = vgui.Create ("DButton", HBSettingsPanel)
				design1:SetText("Beam")
				design1:SetPos(12,35)
				design1:SetSize(100,30)
				design1.Paint = RegisterFunc(function( self, w, h )
					if GetConVarNumber("PC_headbeams_beam") == 1 then
						draw.RoundedBox(0, 0, 0, w, h, Color(5,255,145) )
					else
						draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255) )
					end
				end,40)

				design1.DoClick = function()
					flipconvar("PC_headbeams_beam")
				end

				local design2 = vgui.Create ("DButton", HBSettingsPanel)
				design2:SetText("Line")
				design2:SetPos(125,35)
				design2:SetSize(100,30)
				design2.Paint = RegisterFunc(function( self, w, h )
					if GetConVarNumber("PC_headbeams_line") == 1 then
						draw.RoundedBox(0, 0, 0, w, h, Color(5,255,145) )
					else
						draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255) )
					end
				end,41)
				design2.DoClick = function()
					flipconvar("PC_headbeams_line")
				end

			MENU.COLORSHIT.HEADBEAMS_maincolorcube = vgui.Create("DColorCube", HBSettingsPanel)
			MENU.COLORSHIT.HEADBEAMS_maincolorpicker = vgui.Create("DRGBPicker", HBSettingsPanel)

			MENU.COLORSHIT.HEADBEAMS_secondcolorcube = vgui.Create("DColorCube", HBSettingsPanel)
			MENU.COLORSHIT.HEADBEAMS_secondcolorpicker = vgui.Create("DRGBPicker", HBSettingsPanel)

			AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.HEADBEAMS_maincolorcube, MENU.COLORSHIT.HEADBEAMS_maincolorpicker, 70, 100, 33, 70, 20, 100, 11, 70, colors.headbeams_beam_color, "PC_headbeams_beam_col", MENU.COLORSHIT.HEADBEAMS_secondcolorcube, MENU.COLORSHIT.HEADBEAMS_secondcolorpicker, 70, 100, 147, 70, 20, 100, 125, 70, colors.headbeams_line_color, "PC_headbeams_line_col")

		local mainalpha = vgui.Create( "DAlphaBar", HBSettingsPanel )
		mainalpha:SetPos( 105, 70 )
		mainalpha:SetSize( 15, 100 )
		mainalpha:SetValue(GetConVarNumber("PC_headbeams_beam_opacity"))
		mainalpha.OnChange = function( panel, alpha )
			GetConVar("PC_headbeams_beam_opacity"):SetInt(alpha*255)
		end

		local secondalpha = vgui.Create( "DAlphaBar", HBSettingsPanel )
		secondalpha:SetPos( 219, 70 )
		secondalpha:SetSize( 15, 100 )
		secondalpha:SetValue( GetConVarNumber("PC_headbeams_line_opacity") )
		secondalpha.OnChange = function( panel, alpha )
			GetConVar("PC_headbeams_line_opacity"):SetInt(alpha*255)
		end
			
		local mat_label = vgui.Create ("DLabel", HBSettingsPanel)
		mat_label:SetText("Material:")
		mat_label:SetPos(12,170)

		local mat_combobox = vgui.Create ("DComboBox", HBSettingsPanel)
		mat_combobox:SetValue(GetConVarString("PC_headbeams_beam_mat"))
		mat_combobox:SetPos(12,190)
		mat_combobox:SizeToContents()
		mat_combobox:AddChoice("models/wireframe")
		mat_combobox:AddChoice("trails/smoke")
		mat_combobox:AddChoice("trails/laser")
		mat_combobox:AddChoice("sprites/tp_beam001")
		mat_combobox:AddChoice("gui/arrow")
		mat_combobox:AddChoice("sprites/lookingat")
		mat_combobox.OnSelect = function( panel, index, value )
			GetConVar("PC_headbeams_beam_mat"):SetString( value )
		end

		local type_label = vgui.Create ("DLabel", HBSettingsPanel)
		type_label:SetText("Type:")
		type_label:SetPos(145,170)

		local type_combobox = vgui.Create ("DComboBox", HBSettingsPanel)
		type_combobox:SetValue(GetConVarString("PC_headbeams_type"))
		type_combobox:SetPos(145,190)
		type_combobox:SizeToContents()
		type_combobox:AddChoice("head")
		type_combobox:AddChoice("foot")
		type_combobox:AddChoice("both")
		type_combobox.OnSelect = function( panel, index, value )
			GetConVar("PC_headbeams_type"):SetString( value )
		end

AddMenuElementToTable(HEADBEAMS_SETTINGS, MENU.headbeams_settings_frame, "PC_headbeams_settings")

end
SettingsFunction(HEADBEAMS_SETTINGS, "PC_headbeams_settings")

local function TRACERS_SETTINGS()

	MENU.tracers_settings_frame = vgui.Create( "DFrame" )
	AdjustMenuElement(MENU.tracers_settings_frame, ScrW()/2- 540, ScrH()/2 - 150, 250, 250, "Tracers Settings", true, true, true, "settings", false, true, "settings", "PC_tracers_settings")


		local TracersSettingsPanel = vgui.Create( "DPanel", MENU.tracers_settings_frame )
		TracersSettingsPanel:Dock( FILL )
		TracersSettingsPanel.Paint = RegisterFunc(function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			surface.SetDrawColor( col )
			surface.DrawOutlinedRect(0,0,w,h)
		end,39)

			AddLabel("TRACERS", TracersSettingsPanel, 12, 10, "Tracers:")

				local design1 = vgui.Create ("DButton", TracersSettingsPanel)
				design1:SetText("Beam")
				design1:SetPos(12,35)
				design1:SetSize(100,30)
				design1.Paint = RegisterFunc(function( self, w, h )
					if GetConVarNumber("PC_tracers_beam") == 1 then
						draw.RoundedBox(0, 0, 0, w, h, Color(5,255,145) )
					else
						draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255) )
					end
				end,4045687)

				design1.DoClick = function()
					flipconvar("PC_tracers_beam")
				end

				local design2 = vgui.Create ("DButton", TracersSettingsPanel)
				design2:SetText("Line")
				design2:SetPos(125,35)
				design2:SetSize(100,30)
				design2.Paint = RegisterFunc(function( self, w, h )
					if GetConVarNumber("PC_tracers_line") == 1 then
						draw.RoundedBox(0, 0, 0, w, h, Color(5,255,145) )
					else
						draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255) )
					end
				end,54198745)
				design2.DoClick = function()
					flipconvar("PC_tracers_line")
				end

			MENU.COLORSHIT.TRACERS_maincolorcube = vgui.Create("DColorCube", TracersSettingsPanel)
			MENU.COLORSHIT.TRACERS_maincolorpicker = vgui.Create("DRGBPicker", TracersSettingsPanel)

			MENU.COLORSHIT.TRACERS_secondcolorcube = vgui.Create("DColorCube", TracersSettingsPanel)
			MENU.COLORSHIT.TRACERS_secondcolorpicker = vgui.Create("DRGBPicker", TracersSettingsPanel)

			AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.TRACERS_maincolorcube, MENU.COLORSHIT.TRACERS_maincolorpicker, 70, 100, 33, 70, 20, 100, 11, 70, colors.tracers_beam_color, "PC_tracers_beam_col", MENU.COLORSHIT.TRACERS_secondcolorcube, MENU.COLORSHIT.TRACERS_secondcolorpicker, 70, 100, 147, 70, 20, 100, 125, 70, colors.tracers_line_color, "PC_tracers_line_col")

		local mainalpha = vgui.Create( "DAlphaBar", TracersSettingsPanel )
		mainalpha:SetPos( 105, 70 )
		mainalpha:SetSize( 15, 100 )
		mainalpha:SetValue(GetConVarNumber("PC_tracers_beam_opacity"))
		mainalpha.OnChange = function( panel, alpha )
			GetConVar("PC_tracers_beam_opacity"):SetInt(alpha*255)
		end

		local secondalpha = vgui.Create( "DAlphaBar", TracersSettingsPanel )
		secondalpha:SetPos( 219, 70 )
		secondalpha:SetSize( 15, 100 )
		secondalpha:SetValue( GetConVarNumber("PC_tracers_line_opacity") )
		secondalpha.OnChange = function( panel, alpha )
			GetConVar("PC_tracers_line_opacity"):SetInt(alpha*255)
		end

		local mat_label = vgui.Create ("DLabel", TracersSettingsPanel)
		mat_label:SetText("Material:")
		mat_label:SetPos(12,170)

		local mat_combobox = vgui.Create ("DComboBox", TracersSettingsPanel)
		mat_combobox:SetValue(GetConVarString("PC_tracers_beam_mat"))
		mat_combobox:SetPos(12,190)
		mat_combobox:SizeToContents()
		mat_combobox:AddChoice("models/wireframe")
		mat_combobox:AddChoice("trails/smoke")
		mat_combobox:AddChoice("trails/laser")
		mat_combobox:AddChoice("sprites/tp_beam001")
		mat_combobox:AddChoice("sprites/lookingat")
		mat_combobox.OnSelect = function( panel, index, value )
			GetConVar("PC_tracers_beam_mat"):SetString( value )
		end

AddMenuElementToTable(TRACERS_SETTINGS, MENU.tracers_settings_frame, "PC_tracers_settings")
end
SettingsFunction(TRACERS_SETTINGS, "PC_tracers_settings")



local function CROSSHAIR_SETTINGS()

	MENU.crosshair_settings_frame = vgui.Create( "DFrame" )
	AdjustMenuElement(MENU.crosshair_settings_frame, ScrW()/2 - 540 , ScrH()/2 + 120, 250, 250, "Crosshair Settings", true, true, true, "settings", false, true, "settings", "PC_crosshair_settings")

		local CrosshairSettingsPanel = vgui.Create( "DPanel", MENU.crosshair_settings_frame )
		CrosshairSettingsPanel:Dock( FILL )
		CrosshairSettingsPanel.Paint = RegisterFunc(function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			surface.SetDrawColor( col )
			surface.DrawOutlinedRect(0,0,w,h)
		end,35)

		AddLabel("CROSSHAIRS", CrosshairSettingsPanel, 10, 10, "Crosshairs:")
		
		AddCheckBox("Circles", "PC_crosshair_circles", 25, 35, CrosshairSettingsPanel)
		AddCheckBox("Dot", "PC_crosshair_dot", 25, 58, CrosshairSettingsPanel)
		AddCheckBox("Cross", "PC_crosshair_cross", 25, 81, CrosshairSettingsPanel)
		AddSlider("circles_size", CrosshairSettingsPanel, 110, 29.5, 150, 25, "-         SIZE", 1, 20, GetConVarNumber("PC_crosshair_circles_size"), 0, true, "PC_crosshair_circles_size", 1)
		AddSlider("dot_size", CrosshairSettingsPanel, 110, 52.5, 150, 25, "-         SIZE", 1, 20, GetConVarNumber("PC_crosshair_dot_size"), 0, true, "PC_crosshair_dot_size", 1)
		AddSlider("cross_size", CrosshairSettingsPanel, 110, 75.5, 150, 25, "-         SIZE", 6, 30, GetConVarNumber("PC_crosshair_cross_size"), 0, true, "PC_crosshair_cross_size", 6)

		AddLabel("xhaircolorlabel", CrosshairSettingsPanel, 55, 110, "Color:")
		MENU.COLORSHIT.CROSSHAIR_maincolorcube = vgui.Create("DColorCube", CrosshairSettingsPanel)
		MENU.COLORSHIT.CROSSHAIR_maincolorpicker = vgui.Create("DRGBPicker", CrosshairSettingsPanel)

		AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.CROSSHAIR_maincolorcube, MENU.COLORSHIT.CROSSHAIR_maincolorpicker, 70, 70, 90, 130, 20, 70, 68, 130, colors.crosshair_color, "PC_crosshair_color")


AddMenuElementToTable(CROSSHAIR_SETTINGS, MENU.crosshair_settings_frame, "PC_crosshair_settings")
end
SettingsFunction(CROSSHAIR_SETTINGS, "PC_crosshair_settings")

local function CUSTOM_SKYBOX_SETTINGS()
	MENU.custom_skybox_settings_frame = vgui.Create( "DFrame" )
	AdjustMenuElement(MENU.custom_skybox_settings_frame, ScrW()/2 + 10, ScrH()/2 - 450, 225, 225, "Custom Skybox Settings", true, true, true, "settings", false, true, "settings", "PC_custom_skybox_settings")

		local SkyboxSettingsPanel = vgui.Create( "DPanel", MENU.custom_skybox_settings_frame )
		SkyboxSettingsPanel:Dock( FILL )
		SkyboxSettingsPanel.Paint = RegisterFunc(function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			surface.SetDrawColor( col )
			surface.DrawOutlinedRect(0,0,w,h)
		end,43)

		AddLabel("colorlabel", SkyboxSettingsPanel, 20, 5, "Color")

			MENU.COLORSHIT.skybox_maincolorcube = vgui.Create("DColorCube", SkyboxSettingsPanel)
			MENU.COLORSHIT.skybox_maincolorpicker = vgui.Create("DRGBPicker", SkyboxSettingsPanel)

		AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.skybox_maincolorcube,MENU.COLORSHIT.skybox_maincolorpicker, 162, 162, 50, 25, 40, 162, 7, 25, colors.skybox_custom_col, "PC_custom_skybox_col")

AddMenuElementToTable(CUSTOM_SKYBOX_SETTINGS, MENU.custom_skybox_settings_frame, "PC_custom_skybox_settings")
end
SettingsFunction(CUSTOM_SKYBOX_SETTINGS, "PC_custom_skybox_settings")


local function PROPBOXES_SETTINGS()
	MENU.propboxes_settings_frame = vgui.Create( "DFrame" )
	AdjustMenuElement(MENU.propboxes_settings_frame, ScrW()/2 - 235, ScrH()/2 + 225, 225, 225, "Propboxes Settings", true, true, true, "settings", false, true, "settings", "PC_propboxes_settings")

		local PropBOXSettingsPanel = vgui.Create( "DPanel", MENU.propboxes_settings_frame )
		PropBOXSettingsPanel:Dock( FILL )
		PropBOXSettingsPanel.Paint = RegisterFunc(function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			surface.SetDrawColor( col )
			surface.DrawOutlinedRect(0,0,w,h)
		end,43)

		AddLabel("colorlabel", PropBOXSettingsPanel, 20, 5, "Color")

			MENU.COLORSHIT.PROPBOXES_maincolorcube = vgui.Create("DColorCube", PropBOXSettingsPanel)
			MENU.COLORSHIT.PROPBOXES_maincolorpicker = vgui.Create("DRGBPicker", PropBOXSettingsPanel)

		AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.PROPBOXES_maincolorcube,MENU.COLORSHIT.PROPBOXES_maincolorpicker, 162, 162, 50, 25, 40, 162, 7, 25, colors.propboxes_color, "PC_propboxes_col")

AddMenuElementToTable(PROPBOXES_SETTINGS, MENU.propboxes_settings_frame, "PC_propboxes_settings")

end
SettingsFunction(PROPBOXES_SETTINGS, "PC_propboxes_settings")

local function PLAYERBOXES_SETTINGS()

	MENU.playerboxes_settings_frame = vgui.Create( "DFrame" )
	AdjustMenuElement(MENU.playerboxes_settings_frame, ScrW()/2 + 10, ScrH()/2 + 225, 225, 225, "Playerboxes Settings", true, true, true, "settings", false, true, "settings", "PC_playerboxes_settings")

		local PlayerBOXSettingsPanel = vgui.Create( "DPanel", MENU.playerboxes_settings_frame )
		PlayerBOXSettingsPanel:Dock( FILL )
		PlayerBOXSettingsPanel.Paint = RegisterFunc(function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			surface.SetDrawColor( col )
			surface.DrawOutlinedRect(0,0,w,h)
		end,44)

		AddLabel("colorlabel", PlayerBOXSettingsPanel, 20, 5, "Color")

		MENU.COLORSHIT.PLAYERBOXES_maincolorcube = vgui.Create("DColorCube", PlayerBOXSettingsPanel)
		MENU.COLORSHIT.PLAYERBOXES_maincolorpicker = vgui.Create("DRGBPicker", PlayerBOXSettingsPanel)

		AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.PLAYERBOXES_maincolorcube, MENU.COLORSHIT.PLAYERBOXES_maincolorpicker, 162, 162, 50, 25, 40, 162, 7, 25, colors.playerboxes_color, "PC_playerboxes_col")

	AddMenuElementToTable(PLAYERBOXES_SETTINGS, MENU.playerboxes_settings_frame, "PC_playerboxes_settings")
end
SettingsFunction(PLAYERBOXES_SETTINGS, "PC_playerboxes_settings")


local function EYETRACE_SETTINGS()

	MENU.eyetrace_settings_frame = vgui.Create( "DFrame" )
	AdjustMenuElement(MENU.eyetrace_settings_frame, ScrW()/2 - 235, ScrH()/2 - 450, 225, 225, "EyeTrace Settings", true, true, true, "settings", false, true, "settings", "PC_eyetrace_settings")


		local EyetraceSettingsPanel = vgui.Create( "DPanel", MENU.eyetrace_settings_frame )
		EyetraceSettingsPanel:Dock( FILL )
		EyetraceSettingsPanel.Paint = RegisterFunc(function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			surface.SetDrawColor( col )
			surface.DrawOutlinedRect(0,0,w,h)
		end,39)

			AddLabel("TRACERS", EyetraceSettingsPanel, 12, 10, "EyeTrace:")

				local design1 = vgui.Create ("DButton", EyetraceSettingsPanel)
				design1:SetText("Beam")
				design1:SetPos(10,35)
				design1:SetSize(80,30)
				design1.Paint = RegisterFunc(function( self, w, h )
					if GetConVarNumber("PC_eyetrace_beam") == 1 then
						draw.RoundedBox(0, 0, 0, w, h, Color(5,255,145) )
					else
						draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255) )
					end
				end,4045687)

				design1.DoClick = function()
					flipconvar("PC_eyetrace_beam")
				end

				local design2 = vgui.Create ("DButton", EyetraceSettingsPanel)
				design2:SetText("Line")
				design2:SetPos(109,35)
				design2:SetSize(80,30)
				design2.Paint = RegisterFunc(function( self, w, h )
					if GetConVarNumber("PC_eyetrace_line") == 1 then
						draw.RoundedBox(0, 0, 0, w, h, Color(5,255,145) )
					else
						draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255) )
					end
				end,54198745)
				design2.DoClick = function()
					flipconvar("PC_eyetrace_line")
				end

			MENU.COLORSHIT.TRACERS_maincolorcube = vgui.Create("DColorCube", EyetraceSettingsPanel)
			MENU.COLORSHIT.TRACERS_maincolorpicker = vgui.Create("DRGBPicker", EyetraceSettingsPanel)

			MENU.COLORSHIT.TRACERS_secondcolorcube = vgui.Create("DColorCube", EyetraceSettingsPanel)
			MENU.COLORSHIT.TRACERS_secondcolorpicker = vgui.Create("DRGBPicker", EyetraceSettingsPanel)

			AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.TRACERS_maincolorcube, MENU.COLORSHIT.TRACERS_maincolorpicker, 50, 75, 28, 70, 20, 75, 6, 70, colors.tracers_beam_color, "PC_eyetrace_beam", MENU.COLORSHIT.TRACERS_secondcolorcube, MENU.COLORSHIT.TRACERS_secondcolorpicker, 50, 75, 127, 70, 20, 75, 105, 70, colors.tracers_line_color, "PC_eyetrace_line")

		local mainalpha = vgui.Create( "DAlphaBar", EyetraceSettingsPanel )
		mainalpha:SetPos( 80, 70 )
		mainalpha:SetSize( 15, 75 )
		mainalpha:SetValue(GetConVarNumber("PC_eyetrace_beam_opacity"))
		mainalpha.OnChange = function( panel, alpha )
			GetConVar("PC_eyetrace_beam_opacity"):SetInt(alpha*255)
		end

		local secondalpha = vgui.Create( "DAlphaBar", EyetraceSettingsPanel )
		secondalpha:SetPos( 180, 70 )
		secondalpha:SetSize( 15, 75 )
		secondalpha:SetValue( GetConVarNumber("PC_eyetrace_line_opacity") )
		secondalpha.OnChange = function( panel, alpha )
			GetConVar("PC_eyetrace_line_opacity"):SetInt(alpha*255)
		end

		local mat_label = vgui.Create ("DLabel", EyetraceSettingsPanel)
		mat_label:SetText("Material:")
		mat_label:SetPos(12,150)

		local mat_combobox = vgui.Create ("DComboBox", EyetraceSettingsPanel)
		mat_combobox:SetValue(GetConVarString("PC_eyetrace_beam_mat"))
		mat_combobox:SetPos(12,170)
		mat_combobox:SizeToContents()
		mat_combobox:AddChoice("models/wireframe")
		mat_combobox:AddChoice("trails/smoke")
		mat_combobox:AddChoice("trails/laser")
		mat_combobox:AddChoice("sprites/tp_beam001")
		mat_combobox:AddChoice("sprites/lookingat")
		mat_combobox.OnSelect = function( panel, index, value )
			GetConVar("PC_eyetrace_beam_mat"):SetString( value )
		end

		AddMenuElementToTable(EYETRACE_SETTINGS, MENU.eyetrace_settings_frame, "PC_eyetrace_settings")
end
SettingsFunction(EYETRACE_SETTINGS, "PC_eyetrace_settings")


local function CHAMS_SETTINGS()
	MENU.chams_settings_frame = vgui.Create( "DFrame" )
	AdjustMenuElement(MENU.chams_settings_frame, ScrW()/2 + 290, ScrH()/2 - 150, 250, 250, "Chams Settings", true, true, true, "settings", false, true, "settings", "PC_chams_settings")

		local ChamsSettingsPanel = vgui.Create( "DPanel", MENU.chams_settings_frame )
		ChamsSettingsPanel:Dock( FILL )
		ChamsSettingsPanel.Paint = RegisterFunc(function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
			local col = HSVToColor( CurTime() % 6 * 60, 1, 1 )
			surface.SetDrawColor( col )
			surface.DrawOutlinedRect(0,0,w,h)
		end,26)

		AddLabel("MATERIALS", ChamsSettingsPanel, 10, 5, "MATERIALS")

		AddLabel("MAIN", ChamsSettingsPanel, 25, 20, "Main:")

		local mat1 = vgui.Create ("DComboBox", ChamsSettingsPanel)
		mat1:SetValue(GetConVarString("PC_chams_mat1"))
		mat1:SetPos(30,40)
		mat1:SizeToContents()
		mat1:AddChoice("models/wireframe")
		mat1:AddChoice("models/debug/debugwhite")
		mat1:AddChoice("!White9")
		mat1.OnSelect = function( panel, index, value )
			GetConVar("PC_chams_mat1"):SetString( value )
		end

		AddLabel("SECOND", ChamsSettingsPanel, 25, 60, "Second:")

		local mat2 = vgui.Create ("DComboBox", ChamsSettingsPanel)
		mat2:SetValue(GetConVarString("PC_chams_mat2"))
		mat2:SetPos(30,80)
		mat2:SizeToContents()
		mat2:AddChoice("models/wireframe")
		mat2:AddChoice("models/debug/debugwhite")
		mat2:AddChoice("!White9")
		mat2:AddChoice("disable")
		mat2.OnSelect = function( panel, index, value )
				GetConVar("PC_chams_mat2"):SetString( value )
			if GetConVarString("PC_chams_mat2") == "disable" then
				RunConsoleCommand("PC_chams_multimat", 0)
			else
				RunConsoleCommand("PC_chams_multimat", 1)
			end
		end

		AddLabel("colorslabel", ChamsSettingsPanel, 10, 102, "COLORS")
		AddLabel("mainlabel", ChamsSettingsPanel, 25, 120, "Main:")
		AddLabel("secondlabel", ChamsSettingsPanel, 125, 120, "Second:")

		MENU.COLORSHIT.CHAMS_maincolorcube = vgui.Create("DColorCube", ChamsSettingsPanel)
		MENU.COLORSHIT.CHAMS_maincolorpicker = vgui.Create("DRGBPicker", ChamsSettingsPanel)

		MENU.COLORSHIT.CHAMS_secondcolorcube = vgui.Create("DColorCube", ChamsSettingsPanel)
		MENU.COLORSHIT.CHAMS_secondcolorpicker = vgui.Create("DRGBPicker", ChamsSettingsPanel)

		AdjustAndLinkPickersWithCubes(MENU.COLORSHIT.CHAMS_maincolorcube, MENU.COLORSHIT.CHAMS_maincolorpicker, 65, 70, 30, 140, 20, 70, 8, 140, colors.chams_color1, "PC_chams_col_mat1", MENU.COLORSHIT.CHAMS_secondcolorcube, MENU.COLORSHIT.CHAMS_secondcolorpicker, 65, 70, 145, 140, 20, 70, 123, 140, colors.chams_color2, "PC_chams_col_mat2")

		local mainalpha = vgui.Create( "DAlphaBar", ChamsSettingsPanel )
		mainalpha:SetPos( 97, 140 )
		mainalpha:SetSize( 15, 70 )
		mainalpha:SetValue(GetConVarNumber("PC_chams_opacity_mat1"))
		mainalpha.OnChange = function( panel, alpha )
			GetConVar("PC_chams_opacity_mat1"):SetInt(alpha*255)
		end

		local secondalpha = vgui.Create( "DAlphaBar", ChamsSettingsPanel )
		secondalpha:SetPos( 212, 140 )
		secondalpha:SetSize( 15, 70 )
		secondalpha:SetValue( GetConVarNumber("PC_chams_opacity_mat2"))
		secondalpha.OnChange = function( panel, alpha )
			GetConVar("PC_chams_opacity_mat2"):SetInt(alpha*255)
		end


		local wepchamsbutton = vgui.Create("DButton", MENU.chams_settings_frame)
		wepchamsbutton:SetPos(210,35)
		wepchamsbutton:SetText("WEP")
		wepchamsbutton:SizeToContents()
		wepchamsbutton:SetToolTip("Enables weapon chams")
		wepchamsbutton.Paint = RegisterFunc(function( self, w, h )
			if GetConVarNumber("PC_chams_wep") == 1 then
				draw.RoundedBox(0, 0, 0, w, h, Color(5,255,145) )
			else
				draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255) )
			end
		end,27)

		wepchamsbutton.DoClick = function()
			flipconvar("PC_chams_wep")
		end

AddMenuElementToTable(CHAMS_SETTINGS, MENU.chams_settings_frame, "PC_chams_settings")

end
SettingsFunction(CHAMS_SETTINGS, "PC_chams_settings")


local function VMENU()

	MENU.base = vgui.Create("DFrame")
		MENU.base:SetSize(245, 445)
		MENU.base:Center()
		MENU.base:MakePopup()
		MENU.base:SetTitle("pKustom SCRIPT    **HELL YEAH**")
		
		MENU.base.lblTitle.UpdateColours = function(label)
			label:SetTextStyleColor(Color(247, 252, 248))
		end
		
		MENU.base.btnMaxim:Hide()
		MENU.base.btnMinim:Hide()
		
		
		MENU.base.Paint = function(self, w, h)
			surface.SetDrawColor(25, 25, 25)
			surface.DrawRect(0, 0, w, h)
				
			surface.SetDrawColor(247, 252, 248)
			surface.DrawOutlinedRect(0, 0, w, h)
			
			
			surface.SetDrawColor(75, 75, 75)
			surface.DrawRect(2, 2, w - 4, h - 420)
			
			surface.DrawRect(10, 50, 40, 30)
			
			
			surface.SetDrawColor(25,25,25)
			surface.DrawOutlinedRect(1, 1, w - 2, h -421)	
			
		
			surface.DrawRect(2, 35, w - 4, h - 37)		
			surface.SetDrawColor(112, 117, 113)

			
		end

		MENU.base.OnClose = function()
			for k,v in pairs(MENU.Things) do
				if GetConVarNumber(v[2]) == 1 then
					v[1]:SetVisible(false)
					flipconvar(v[2])
				end
			end
		end

		local sheet = vgui.Create( "DPropertySheet", MENU.base )
		sheet:Dock( FILL )
		function sheet.GetTabHeight()
			if ( self:IsActive() ) then
				return 28
			else
				return 28
			end
		end
		sheet.Paint = RegisterFunc(function(self,w,h)
			surface.SetDrawColor( Color(25, 25, 25, 255) )
			surface.DrawRect(0, 0, w, h)
		end,48)

		local panel1 = vgui.Create( "DPanel", sheet )
		panel1.Paint = RegisterFunc(function(self,w,h)
			surface.SetDrawColor( Color(25, 25, 25, 255) )
			surface.DrawRect(0, 0, w, h)
		end,456)
		 sheet:AddSheet( "VISUALS", panel1, "icon16/eye.png" )

		
		AddCheckBox("ESP", "PC_esp", 25, 8, panel1, nil, true, function() 
				if( GetConVarNumber("PC_esp_settings") == 1) then
					ErrorEvent( "ESP SETTINGS WINDOW IS ALREADY OPENED" )
				else
					flipconvar("PC_esp_settings")
					ESP_SETTINGS()
				end
			end)

		AddCheckBox("ESP BONES", "PC_esp_bones", 25, 25, panel1)

		AddCheckBox("XRAY", "PC_xray", 25, 50, panel1, nil, true, function() 
				if( GetConVarNumber("PC_xray_settings") == 1) then
					ErrorEvent( "XRAY SETTINGS WINDOW IS ALREADY OPENED" )
				else
					flipconvar("PC_xray_settings")
					XRAY_SETTINGS()
				end
			end)

		-- AddCheckBox("XRAY SMART OPACITY", "PC_xray_adaptive_opacity", 25, 67, panel1)

		AddCheckBox("PROPBOXES", "PC_propboxes", 25, 67, panel1, nil, true, function() 
				if( GetConVarNumber("PC_propboxes_settings") == 1) then
					ErrorEvent( "PROPBOXES SETTINGS WINDOW IS ALREADY OPENED" )
				else
					flipconvar("PC_propboxes_settings")
					PROPBOXES_SETTINGS()
				end
			end)

		AddCheckBox("CHAMS", "PC_chams", 25, 92, panel1, nil, true, function() 
				if( GetConVarNumber("PC_chams_settings") == 1) then
					ErrorEvent( "CHAMS SETTINGS WINDOW IS ALREADY OPENED" )
				else
					flipconvar("PC_chams_settings")
					CHAMS_SETTINGS()
				end
			end)

		AddCheckBox("PLAYER BOXES", "PC_playerboxes", 25, 109, panel1, nil, true, function() 
				if( GetConVarNumber("PC_playerboxes_settings") == 1) then
					ErrorEvent( "PLAYERBOXES SETTINGS WINDOW IS ALREADY OPENED" )
				else
					flipconvar("PC_playerboxes_settings")
					PLAYERBOXES_SETTINGS()
				end
			end)

		AddCheckBox("EYETRACE", "PC_eyetrace", 25, 126, panel1, nil, true, function() 
				if( GetConVarNumber("PC_eyetrace_settings") == 1) then
					ErrorEvent( "EYETRACE SETTINGS WINDOW IS ALREADY OPENED" )
				else
					flipconvar("PC_eyetrace_settings")
					EYETRACE_SETTINGS()
				end
			end)

		AddCheckBox("TRACERS", "PC_tracers", 25, 151, panel1, nil, true, function() 
				if( GetConVarNumber("PC_tracers_settings") == 1) then
					ErrorEvent( "TRACERS SETTINGS WINDOW IS ALREADY OPENED" )
				else
					flipconvar("PC_tracers_settings")
					TRACERS_SETTINGS()
				end
			end)

		AddCheckBox("CROSSHAIR", "PC_crosshair", 25, 168, panel1, nil, true, function() 
				if( GetConVarNumber("PC_crosshair_settings") == 1) then
					ErrorEvent( "CROSSHAIR SETTINGS WINDOW IS ALREADY OPENED" )
				else
					flipconvar("PC_crosshair_settings")
					CROSSHAIR_SETTINGS()
				end
			end)

		AddCheckBox("CUSTOM SKYBOX", "PC_custom_skybox", 25, 185, panel1, nil, true, function() 
				if( GetConVarNumber("PC_custom_skybox_settings") == 1) then
					ErrorEvent( "CUSTOM SKYBOX SETTINGS WINDOW IS ALREADY OPENED" )
				else
					flipconvar("PC_custom_skybox_settings")
					CUSTOM_SKYBOX_SETTINGS()
				end
			end)

		AddCheckBox("HEADBEAMS", "PC_headbeams", 25, 202, panel1, nil, true, function() 
				if( GetConVarNumber("PC_headbeams_settings") == 1) then
					ErrorEvent( "HEADBEAMS SETTINGS WINDOW IS ALREADY OPENED" )
				else
					flipconvar("PC_headbeams_settings")
					HEADBEAMS_SETTINGS()
				end
			end)
			
PC.propmodel = vgui.Create("DModelPanel", panel1)
PC.propmodel:SetSize(110,160)
PC.propmodel:SetPos(0,220)
PC.propmodel:SetModel("models/props/cs_militia/refrigerator01.mdl")
PC.propmodel:SetAnimSpeed( 6 )


function PC.propmodel:LayoutEntity( ent )
	if ( self.bAnimated ) then
		self:RunAnimation()
	end
	ent:SetAngles( Angle( 0, RealTime() * (10*PC.propmodel:GetAnimSpeed()) % 360, 0 ) )
end

PC.propmodel.DrawModel = function(...) 
	XRAY2(PC.propmodel.Entity) 
	PC.propmodel.Entity:DrawModel() 
end

PC.playermodel = vgui.Create("DModelPanel", panel1)
PC.playermodel:SetSize(140,155)
PC.playermodel:SetPos(90,225)
PC.playermodel:SetModel("models/player/kleiner.mdl")
PC.playermodel:SetAnimSpeed( 6 )

function PC.playermodel:LayoutEntity( ent )
	if ( self.bAnimated ) then
		self:RunAnimation()
	end
	ent:SetAngles( Angle( 0, RealTime() * (10*PC.playermodel:GetAnimSpeed()) % 360, 0 ) )
end

local iconmodel=ents.CreateClientProp()
iconmodel:Spawn()
iconmodel:SetModel(LocalPlayer():GetActiveWeapon():GetWeaponWorldModel())
iconmodel:SetParent(PC.playermodel:GetEntity())
iconmodel:AddEffects( EF_BONEMERGE )


PC.playermodel.DrawModel = function(...) CHAMS2(PC.playermodel.Entity, iconmodel) PC.playermodel.Entity:DrawModel() end

	local panel2 = vgui.Create( "DPanel", sheet )
	panel2.Paint = RegisterFunc(function(self,w,h)
		surface.SetDrawColor( Color(25, 25, 25, 255) )
		surface.DrawRect(0, 0, w, h)
	end,456987)
	sheet:AddSheet( "MISC", panel2, "icon16/asterisk_orange.png" )
		AddCheckBox("FPS SAVER", "PC_SAVEFPS", 25, 8, panel2, "Disable visuals when they are out of your field of view")
		AddCheckBox("BACK-ATTACK ALERT", "PC_alert", 25, 25, panel2, "Draw an alert when a prop is about to kill you from behind")
		AddCheckBox("BHOP", "PC_bhop", 25, 42, panel2)
		AddCheckBox("FOV:", "PC_FOVEnable", 25, 59, panel2)
		local fovnumber = vgui.Create( "DNumberWang", panel2 )
			fovnumber:SetPos( 90, 59 )
			fovnumber:SetSize( 40, 15 )
			fovnumber:SetMin(0)
			fovnumber:SetMax(179)
			fovnumber:SetValue(GetConVarNumber("PC_FOVNumber"))
			function fovnumber:OnValueChanged(value)
				GetConVar("PC_FOVNumber"):SetInt(value)
			end
		AddCheckBox("VELOCITY FOV", "PC_FOV_VELOCITY", 25, 76, panel2)

			
		AddCheckBox("PROP-TO-PLAYER TRACERS", "PC_p2p", 25, 93, panel2)
		AddCheckBox("PLAYERS TRAJECTORY", "PC_trajectory", 25, 110, panel2)
		AddCheckBox("PHYSLINE", "PC_physline", 25, 127, panel2)
		AddCheckBox("PHYSLINE OTHERPLAYERS", "PC_physline_otherplayers", 25, 144, panel2)
		AddCheckBox("SPECTATOR BOX", "PC_spectator_box", 25, 161, panel2)
		AddCheckBox("PROPS SOUNDS", "PC_xray_propsound", 25, 178, panel2)
		AddLabel("wheelspeedlabel", panel2, 45, 212, "PHYSGUN_WHEELSPEED", true)
		AddSlider("wheelspeed", panel2, -40, 232, 250, 25, nil, 75, 300, GetConVarNumber("physgun_wheelspeed"), 0, true, "physgun_wheelspeed", GetConVarNumber("physgun_wheelspeed"))

	local panel3 = vgui.Create( "DPanel", sheet )
	panel3.Paint = RegisterFunc(function(self,w,h)
		surface.SetDrawColor( Color(25, 25, 25, 255) )
		surface.DrawRect(0, 0, w, h)
	end,45698457)
	sheet:AddSheet( "PLAYERS", panel3, "icon16/user.png" )
	local plytree = vgui.Create("DTree", panel3)
	plytree.Paint = RegisterFunc(function() end,445698755456217)
	plytree:Dock(FILL)

	local mainnode = plytree:AddNode("PLAYERS", "icon16/text_align_justify.png")
	mainnode:SetExpanded(true)

	for k,v in pairs(player.GetAll()) do
	local ply
	if v != LocalPlayer() then
		if v:GetFriendStatus() == "friend" then
			ply = mainnode:AddNode(v:Name(v).." (STEAM FRIEND)", "icon16/user_green.png")
		else
			ply = mainnode:AddNode(v:Name(v), "icon16/user_gray.png")
		end
	else
		ply = mainnode:AddNode(v:Name(v), "icon16/user_suit.png")
	end
		ply:SetExpanded(true)
			ply.DoRightClick = function()
			local option = DermaMenu()
			if v == LocalPlayer() then
				option:AddOption("THIS IS YOURSELF RETARD", function() ErrorEvent("OMG THIS GUY IS RETARDED") end):SetIcon("icon16/delete.png")
			else
				option:AddOption("COPY STEAMID", function() SetClipboardText(v:SteamID()) end):SetIcon("icon16/vcard.png")
				option:AddOption("COPY USERID", function() SetClipboardText(v:UserID()) end):SetIcon("icon16/vcard.png")
				option:AddOption("COPY NAME", function() SetClipboardText(v:Name()) end):SetIcon("icon16/vcard.png")

				if not PC.enemies[v] then
					option:AddOption("ADD ENEMY", function() PC.enemies[v] = true end):SetIcon("icon16/add.png")
				else
					option:AddOption("REMOVE ENEMY", function() PC.enemies[v] = nil end):SetIcon("icon16/exclamation.png")
				end

				if not PC.friends[v] then
					option:AddOption("ADD FRIEND", function() PC.friends[v] = true end):SetIcon("icon16/add.png")
				else
					option:AddOption("REMOVE FRIEND", function() PC.friends[v] = nil end):SetIcon("icon16/exclamation.png")
				end

			end
		option:Open()
		end
	end

	for k, v in pairs(sheet.Items) do

		if v.Tab then
		
			if v.Name == "VISUALS" then
				v.Tab.Paint = RegisterFunc(function(self,w,h)
					draw.RoundedBox(0, 0, 0, w, h-4, Color(75, 75, 75))
					surface.SetDrawColor( 25, 25, 25, 255 )
					surface.DrawLine(71,0,71,40)
				end,2)
			elseif v.Name == "MISC" then
				v.Tab.Paint = RegisterFunc(function(self,w,h)
					draw.RoundedBox(0, 0, 0, w, h-4, Color(75, 75, 75))
					surface.SetDrawColor( 25, 25, 25, 255 )
					surface.DrawLine(55,0,55,40)
				end,78998987)
			else
				v.Tab.Paint = RegisterFunc(function(self,w,h)
					draw.RoundedBox(0, 0, 0, w, h-4, Color(75, 75, 75))
				end,123654789)
			end
				
			function v.Tab:GetTabHeight()
				if ( self:IsActive() ) then
					return 28
				else
					return 28
				end
			end

		end
	end
	
	local allsettings = vgui.Create("DImageButton", MENU.base)
	allsettings:SetPos(220,33)
	allsettings:SetImage("icon16/cog.png")
	allsettings:SetToolTip("Show/Hide all the settings windows")
	allsettings:SizeToContents()
	allsettings.DoClick = function()
			for k,v in pairs(MENU.SettingsFuncs) do
				if GetConVarNumber(k) == 0 then
					v[1]()
					GetConVar(k):SetInt(1)
				else
					v[2]:SetVisible(false)
					flipconvar(k)
				end
			end
		end
	
end
concommand.Add("PC_menu", VMENU)

function draw.OutlinedBox( x, y, w, h, thickness, clr )
	surface.SetDrawColor( clr )
	for i=0, thickness - 1 do
		surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
	end
end

// this shit is unoptimized and a prototype
local function DANGEROUS()
	if GetConVarNumber("PC_alert") == 1 then
		for k,v in next, ents.FindByClass( "prop_physics" ) do
		if (myprops[v]) then continue end
		local entpos = v:LocalToWorld(v:OBBCenter())
		local endpos = util.QuickTrace (  entpos, Vector(v:GetVelocity().x / 5, v:GetVelocity().y / 5, 0), v )
		local entpos2 = v:LocalToWorld(v:OBBMins())
		local endpos2 = util.QuickTrace (  entpos2, Vector(v:GetVelocity().x / 5, v:GetVelocity().y / 5, 0), v )
		local entpos3 = v:LocalToWorld(v:OBBMaxs())
		local endpos3 = util.QuickTrace (  entpos3, Vector(v:GetVelocity().x / 5, v:GetVelocity().y / 5, 0), v )
		local entpos4 = v:LocalToWorld(v:OBBCenter() + Vector(0,0,40))
		local endpos4 = util.QuickTrace (  entpos4, Vector(v:GetVelocity().x / 5, v:GetVelocity().y / 5, 0), v )
		local entpos5 = v:LocalToWorld(v:OBBCenter() - Vector(0,0,40))
		local endpos5 = util.QuickTrace (  entpos5, Vector(v:GetVelocity().x / 5, v:GetVelocity().y / 5, 0), v )
		local entpos6 = v:LocalToWorld(v:OBBMins() + Vector(0,0,40))
		local endpos6 = util.QuickTrace (  entpos6, Vector(v:GetVelocity().x / 5, v:GetVelocity().y / 5, 0), v )
		local entpos7 = v:LocalToWorld(v:OBBMaxs() - Vector(0,0,40))
		local endpos7 = util.QuickTrace (  entpos7, Vector(v:GetVelocity().x / 5, v:GetVelocity().y / 5, 0), v )
		local entpos8 = v:LocalToWorld(v:OBBMaxs() - Vector(0,45,0))
		local endpos8 = util.QuickTrace (  entpos8, Vector(v:GetVelocity().x / 5, v:GetVelocity().y / 5, 0), v )
		local entpos9 = v:LocalToWorld(v:OBBMaxs() - Vector(0,0,76))
		local endpos9 = util.QuickTrace (  entpos9, Vector(v:GetVelocity().x / 5, v:GetVelocity().y / 5, 0), v )

			if endpos.Entity == LocalPlayer() or 
			endpos2.Entity == LocalPlayer() or 
			endpos3.Entity == LocalPlayer() or 
			endpos4.Entity == LocalPlayer() or 
			endpos5.Entity == LocalPlayer() or 
			endpos6.Entity == LocalPlayer() or 
			endpos7.Entity == LocalPlayer() then
				if IsOutOfFOV(v) then
					PC.dangerous = true
					hook.Add("HUDPaint", "dflksjhdf", function()
						draw.SimpleText("DANGER!", "DermaDefault", (ScrW() / 2)+11, 15 + (k * 10), Color(255,0,0,255) )
						draw.OutlinedBox(0, 0, ScrW(), ScrH(), 6, Color(255,0,0,255))
					end)
				end
			else
				if (PC.dangerous) then
					hook.Remove("HUDPaint", "dflksjhdf")
				end
				PC.dangerous = false
			end
		end
	end
end
hook.Add("RenderScreenspaceEffects", "itsdangerousdude", DANGEROUS)


hook.Add( "OnPlayerChat", "menucommand", function( ply, strText, bTeam, bDead )
	if ( ply != LocalPlayer() ) then return end

	strText = string.lower( strText )

	if ( strText == "!pc_menu" ) then
		VMENU()
		return true
	end

end )

hook.Add("Think", "specdetect", function()
    for k,v in pairs( player.GetAll() ) do
		if( v:GetObserverTarget() and v != LocalPlayer() and v:GetObserverTarget() == LocalPlayer() and !table.HasValue( PC.Spectators, v ) ) then
			RunConsoleCommand( "play", "vo/announcer_alert.wav" )
			chat.AddText( Color(0,255,0,255), v:Nick(), Color(255,0,0,255), " Started Spectating you!" )
			table.insert( PC.Spectators, v )
		end
	end
	for k,v in pairs( PC.Spectators ) do
		if( !IsValid( v ) ) then table.remove( PC.Spectators, k ) continue end
		if( !v:GetObserverTarget() or ( v:GetObserverTarget() and v:GetObserverTarget() != LocalPlayer() ) ) then
			chat.AddText( Color(0,255,0,255), v:Nick(), Color(255,0,0,255), " stopped spectating you." )
			RunConsoleCommand( "play", "bot/clear3.wav" )
			table.remove( PC.Spectators, k )
		end
	end
end)

hook.Add("HUDPaint", "specbox", function()
    if GetConVarNumber("PC_spectator_box") == 1 and #PC.Spectators > 0 then
        surface.SetDrawColor( Color(50, 50, 90, 255) )
        surface.DrawRect( (ScrW() / 2) - 150, 0, 300, (#PC.Spectators * 20) + 30)
        surface.SetDrawColor( Color(0, 0, 0, 250) )
        surface.DrawRect( (ScrW() / 2) - 145, 0 + 25, 290, (#PC.Spectators * 20) )
        draw.SimpleText("These people are spectating you", "DermaDefault", (ScrW() / 2) - 63, 0 + 10, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        for k, v in pairs( PC.Spectators ) do
            if !v:IsValid() then continue end -- let this pass silently, it only spams briefly when some faggot dcs anyway
            draw.SimpleText(v:Nick(), "DermaDefault", (ScrW() / 2) - 140, 0 + 8 + (k * 20), Color(255,255,255,255) )
        end
    end    
end)

hook.Add("OnEntityCreated", "SoundOnSpawn", function(ent) -- credits to falco for that
	if IsValid(ent) and ent:GetClass() == "prop_physics" then
	
		if GetConVarNumber( "PC_xray_propsound" ) == 1 then
			ent:EmitSound("eli_lab.al_buttonPunch", 100, 100)
			ent.PropSound = ent.PropSound or CreateSound(ent, "Canals.d1_canals_01_combine_shield_touch_loop1")
			ent.PropSound:PlayEx(100, 0)
			ent:CallOnRemove("RemovePropSound", function(ent) if ent.PropSound then ent.PropSound:Stop() end end)
		end
	end
end)
