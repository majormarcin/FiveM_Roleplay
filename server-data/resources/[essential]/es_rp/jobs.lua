JOB_CIVILIAN = {
	name = "Civilian",
	plural = "Civilians",
	spawns = {
		{ ['x'] = 221.52095031738, ['y'] = -903.49005126953, ['z'] = 30.692230224609, ['heading'] = 10.0 },
		{ ['x'] = 235.01333618164, ['y'] = -880.53637695313, ['z'] = 30.49201965332, ['heading'] = 10.0 },
		{ ['x'] = 205.37657165527, ['y'] = -930.04858398438, ['z'] = 30.69202041626, ['heading'] = 10.0 },
		{ ['x'] = 214.60696411133, ['y'] = -945.7802734375, ['z'] = 30.686811447144, ['heading'] = 10.0 },
		{ ['x'] = 173.83438110352, ['y'] = -989.86187744141, ['z'] = 30.091932296753, ['heading'] = 10.0 },
		{ ['x'] = 157.37118530273, ['y'] = -986.79077148438, ['z'] = 30.091903686523, ['heading'] = 10.0 }
	},
	skins = "DEFAULT",
	weapons = {
		"WEAPON_KNIFE"
	},
	armour = 0,
	health = 200,
	permission_level = 0,
	salary = 10
}

JOB_TAXI = {
	name = "Taxi Driver",
	plural = "Taxi Drivers",
	spawns = {
		{ ['x'] = 221.52095031738, ['y'] = -903.49005126953, ['z'] = 30.692230224609, ['heading'] = 10.0 },
		{ ['x'] = 235.01333618164, ['y'] = -880.53637695313, ['z'] = 30.49201965332, ['heading'] = 10.0 },
		{ ['x'] = 205.37657165527, ['y'] = -930.04858398438, ['z'] = 30.69202041626, ['heading'] = 10.0 },
		{ ['x'] = 214.60696411133, ['y'] = -945.7802734375, ['z'] = 30.686811447144, ['heading'] = 10.0 },
		{ ['x'] = 173.83438110352, ['y'] = -989.86187744141, ['z'] = 30.091932296753, ['heading'] = 10.0 },
		{ ['x'] = 157.37118530273, ['y'] = -986.79077148438, ['z'] = 30.091903686523, ['heading'] = 10.0 }
	},
	skins = "DEFAULT",
	weapons = {
		"WEAPON_KNIFE"
	},
	armour = 0,
	health = 200,
	permission_level = 0,
	salary = 10
}

JOB_TRUCKER = {
	name = "Truck Driver",
	plural = "Truck Drivers",
	spawns = {
		{ ['x'] = 221.52095031738, ['y'] = -903.49005126953, ['z'] = 30.692230224609, ['heading'] = 10.0 },
		{ ['x'] = 235.01333618164, ['y'] = -880.53637695313, ['z'] = 30.49201965332, ['heading'] = 10.0 },
		{ ['x'] = 205.37657165527, ['y'] = -930.04858398438, ['z'] = 30.69202041626, ['heading'] = 10.0 },
		{ ['x'] = 214.60696411133, ['y'] = -945.7802734375, ['z'] = 30.686811447144, ['heading'] = 10.0 },
		{ ['x'] = 173.83438110352, ['y'] = -989.86187744141, ['z'] = 30.091932296753, ['heading'] = 10.0 },
		{ ['x'] = 157.37118530273, ['y'] = -986.79077148438, ['z'] = 30.091903686523, ['heading'] = 10.0 }
	},
	skins = "DEFAULT",
	weapons = {
		"WEAPON_KNIFE"
	},
	armour = 0,
	health = 200,
	permission_level = 0,
	salary = 10
}

JOB_DELIVERY = {
	name = "Delivery Driver",
	plural = "Delivery Drivers",
	spawns = {
		{ ['x'] = 221.52095031738, ['y'] = -903.49005126953, ['z'] = 30.692230224609, ['heading'] = 10.0 },
		{ ['x'] = 235.01333618164, ['y'] = -880.53637695313, ['z'] = 30.49201965332, ['heading'] = 10.0 },
		{ ['x'] = 205.37657165527, ['y'] = -930.04858398438, ['z'] = 30.69202041626, ['heading'] = 10.0 },
		{ ['x'] = 214.60696411133, ['y'] = -945.7802734375, ['z'] = 30.686811447144, ['heading'] = 10.0 },
		{ ['x'] = 173.83438110352, ['y'] = -989.86187744141, ['z'] = 30.091932296753, ['heading'] = 10.0 },
		{ ['x'] = 157.37118530273, ['y'] = -986.79077148438, ['z'] = 30.091903686523, ['heading'] = 10.0 }
	},
	skins = "DEFAULT",
	weapons = {
		"WEAPON_KNIFE"
	},
	armour = 0,
	health = 200,
	permission_level = 0,
	salary = 10
}

JOB_EMS = {
	name = "EMS",
	plural = "EMS",
	spawns = {
		{ ['x'] = 376.62930297852, ['y'] = -591.61248779297, ['z'] = 28.770683288574 }
	},
	skins = {
		"s_m_m_paramedic_01"
	},
	weapons = {
	},
	armour = 100,
	health = 200,
	permission_level = 10,
	salary = 50,
	customPermissionLevelCheck = function(source)
		TriggerClientEvent('es_rp:notify', source, "Aplikuj na ~b~https://deathcommando.pl")
	end
}

JOB_POLICE = {
	name = "Police Officer",
	plural = "Police Officers",
	spawns = {
		{ ['x'] = 457.956, ['y'] = -992.723, ['z'] = 30.689, ['heading'] = 10.0 }
	},
	skins = {
		"s_f_y_cop_01"
	},
	weapons = {
		"WEAPON_PISTOL50",
		"WEAPON_STUNGUN",
		"WEAPON_NIGHTSTICK",
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_CARBINERIFLE"
	},
	armour = 100,
	health = 200,
	permission_level = 11,
	salary = 50,
	customPermissionLevelCheck = function(source)
		TriggerClientEvent('es_rp:notify', source, "Aplikacja na stanowisko dostępna ~b~https://deathcommando.pl")
	end
}

JOB_MECHANIC = {
    name = "Mechanic",
    plural = "Mechanics",
    spawns = {
        { ['x'] = 221.52095031738, ['y'] = -903.49005126953, ['z'] = 30.692230224609, ['heading'] = 10.0 },
        { ['x'] = 235.01333618164, ['y'] = -880.53637695313, ['z'] = 30.49201965332, ['heading'] = 10.0 },
        { ['x'] = 205.37657165527, ['y'] = -930.04858398438, ['z'] = 30.69202041626, ['heading'] = 10.0 },
        { ['x'] = 214.60696411133, ['y'] = -945.7802734375, ['z'] = 30.686811447144, ['heading'] = 10.0 },
        { ['x'] = 173.83438110352, ['y'] = -989.86187744141, ['z'] = 30.091932296753, ['heading'] = 10.0 },
        { ['x'] = 157.37118530273, ['y'] = -986.79077148438, ['z'] = 30.091903686523, ['heading'] = 10.0 }
    },
    skins = "DEFAULT",
    weapons = {},
    armour = 0,
    health = 200,
    permission_level = 0,
    salary = 10
}

POLICE = {
	["Police Officer"] = true
}

JOBS = {
	["Police Officer"] = JOB_POLICE,
	["Civilian"] = JOB_CIVILIAN,
	["EMS"] = JOB_EMS,
	["Mechanic"] = JOB_MECHANIC,
	["Taxi"]=JOB_TAXI,
	["Kurier"]=JOB_DELIVERY,
	["Kierowca TIRa"]=JOB_TRUCKER
}

JOB_VEHICLES = {
	["Police Officer"] = {
		"police",
		"police2",
		"police3",
		"police4",
		"policeb",
		"policet",
		"maverick",
	},
	["EMS"] = {
		"ambulance"
	},
	["Mechanic"] = {
		"towtruck",
		"towtruck2",
	}
}