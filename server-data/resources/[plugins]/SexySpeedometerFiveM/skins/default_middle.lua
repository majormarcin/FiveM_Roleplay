

local skinData = {
	-- names
	skinName = "default_middle",
	ytdName = "default",
	-- texture dictionary informations:
	-- night textures are supposed to look like this:
	-- "needle", "tachometer", "speedometer", "fuelgauge"
	-- daytime textures this:
	-- "needle_day", "tachometer_day", "speedometer_day", "fuelgauge_day"
	-- these names are hardcoded
centerCoords = {0.45,0.85},
	-- icon locations
											-- these are xy,width,height
	lightsLoc = {0.010,0.092,0.018,0.02},
	blinkerLoc = {0.105,0.034,0.022,0.03},
	fuelLoc = {0.105,0.090,0.012,0.025},
	oilLoc = {0.100,0.062,0.020,0.025},
	engineLoc = {0.130,0.092,0.020,0.025},

	-- gauge locations
	SpeedoBGLoc = {0.000,0.060,0.12,0.185},
	SpeedoNeedleLoc = {0.000,0.062,0.076,0.15},

	TachoBGloc = {0.120,0.060,0.12,0.185},
	TachoNeedleLoc = {0.120,0.062,0.076,0.15},

	FuelBGLoc = {0.060, -0.020,0.04, 0.04},
	FuelGaugeLoc = {0.060,0.000,0.040,0.08},

	RotMult = 2.036936,
	RotStep = 2.32833,

	-- rpm scale, defines how "far" the rpm gauge goes before hitting redline
	rpmScale = 250,
	rpmScaleDecrease = 30, -- how much we want to decrease the rpm end result, this gives lower idle

}

addSkin(skinData)