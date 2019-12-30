-- require "bit"

print("---------------------------------------")
print("Initial setup for Airfoiabs KA350 -----")
print("=======================================")

-- GEARS
create_switch(169, "sim/cockpit2/controls/gear_handle_down", 0, 1, 0)

-- AUTOPILOT ALTITUDE
create_positive_edge_increment(163,"sim/cockpit/autopilot/altitude",0,1000,49000,0)
create_positive_edge_decrement(162,"sim/cockpit/autopilot/altitude",0,1000,1000,0)

-- AUTOPILOT HEADING
create_positive_edge_increment(177,"sim/cockpit/autopilot/heading_mag",0,10,400,0)
create_positive_edge_decrement(176,"sim/cockpit/autopilot/heading_mag",0,10,-100,0)

set("sim/cockpit/autopilot/heading_mag", -100)

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