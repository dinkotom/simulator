-- require "bit"

print("---------------------------------------")
print("Initial setup for Airfoiabs KA350 -----")
print("=======================================")

-- GEARS
create_switch(169, "sim/cockpit2/controls/gear_handle_down", 0, 1, 0)

-- AUTOPILOT ALTITUDE
create_positive_edge_increment(163,"sim/cockpit/autopilot/altitude",0,1000,49000,0)
create_positive_edge_decrement(162,"sim/cockpit/autopilot/altitude",0,1000,1000,0)
create_positive_edge_increment(160,"sim/cockpit/autopilot/altitude",0,100,49000,0)
create_positive_edge_decrement(161,"sim/cockpit/autopilot/altitude",0,100,1000,0)

-- AUTOPILOT HEADING
create_positive_edge_increment(179,"sim/cockpit/autopilot/heading_mag",0,10,400,0)
create_positive_edge_decrement(178,"sim/cockpit/autopilot/heading_mag",0,10,-100,0)
create_positive_edge_increment(177,"sim/cockpit/autopilot/heading_mag",0,1,400,0)
create_positive_edge_decrement(176,"sim/cockpit/autopilot/heading_mag",0,1,-100,0)

set("sim/cockpit/autopilot/heading_mag", -100)

-- MCP
set_button_assignment(186, "KA350/cmd/cPanel/efisSCP/courseDec")
set_button_assignment(187, "KA350/cmd/cPanel/efisSCP/courseInc")
set_button_assignment(184, "sim/autopilot/heading_sync")
set_button_assignment(181, "KA350/cmd/cPanel/flightCP/nav")
set_button_assignment(182, "KA350/cmd/cPanel/flightCP/appr")
set_button_assignment(185, "KA350/cmd/cPanel/flightCP/bc")
set_button_assignment(190, "KA350/cmd/cPanel/pilotDisplayCP/crsAct")
set_button_assignment(189, "KA350/cmd/cPanel/flightCP/hdg")
set_button_assignment(171, "KA350/cmd/cPanel/flightCP/climb")
set_button_assignment(188, "KA350/cmd/cPanel/flightCP/altSel")
set_button_assignment(172, "KA350/cmd/cPanel/flightCP/dsc")
set_button_assignment(170, "KA350/cmd/cPanel/flightCP/alt")
set_button_assignment(168, "KA350/cmd/cPanel/flightCP/vs")
set_button_assignment(173, "KA350/cmd/cPanel/autopilotCP/apEng")
set_button_assignment(167, "KA350/cmd/cPanel/autopilotCP/yawEng")

-- YOKE
set_button_assignment(325, "KA350/cmd/cPanel/autopilotCP/pitchSwitchDec")
set_button_assignment(324, "KA350/cmd/cPanel/autopilotCP/pitchSwitchInc")
set_button_assignment(323, "sim/flight_controls/pitch_trim_down")
set_button_assignment(322, "sim/flight_controls/pitch_trim_up")
set_button_assignment(326, "KA350/cmd/cPanel/autopilotCP/turnDec")
set_button_assignment(327, "KA350/cmd/cPanel/autopilotCP/turnInc")
set_button_assignment(321, "KA350/cmd/Yoke/AP_YD_ElecTrim_disc")





do_every_frame([[

-- PARKING BRAKE
	local parking_brake = get("sim/cockpit2/controls/parking_brake_ratio")
	if (parking_brake == 1 and button(166) == false) then	
			command_once("KA350/cmd/pSubpanel/parkBrake")
	end
	if (parking_brake == 0 and button(166) == true) then	
			command_once("KA350/cmd/pSubpanel/parkBrake")
	end 

-- FLAPS
	if button(328) == true 
		then set("sim/cockpit2/controls/flap_ratio",0)
	elseif button(329) == true
		then set("sim/cockpit2/controls/flap_ratio",0.5)
	elseif button(330) == true
		then set("sim/cockpit2/controls/flap_ratio",1)
	end
	
-- LANDING LIGHTS
	if (button(183) == true) then
		set_array("sim/cockpit2/switches/landing_lights_switch",0,1)
		set_array("sim/cockpit2/switches/landing_lights_switch",1,1)
	else
		set_array("sim/cockpit2/switches/landing_lights_switch",0,0)
		set_array("sim/cockpit2/switches/landing_lights_switch",1,0)			
	end

-- TAXI LIGHTS
	if (button(180) == true) then
		set("sim/cockpit2/switches/taxi_light_on",1)		
	else
		set("sim/cockpit2/switches/taxi_light_on",0)			
	end

]])