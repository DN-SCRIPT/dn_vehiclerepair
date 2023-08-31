Config = {}
Config.Locale = 'en' --en, tw

Config.Stations = {                                 
    --------------------------------------
	{x = -216.8, y = 6200.39, z = 31.06},      -- THIS SHOWS WHERE THE VEHICLE REPAIRING SYSTEM SHOULD COME , YOU CAN ADD OR REMOVE AS PER YOUR INTEREST [x = , y = , z = ]
	{x = 1532.37, y = 782.2, z = 77.44},
	{x = 481.31, y = -1279.83, z = 28.96},
	{x = 1362.93, y = 3592.48, z = 34.33},
	{x = -214.71, y = -1392.66, z = 30.68},
	{x = -1657.64, y = -245.83, z = 54.37},
	{x = 539.24, y = -177.01, z = 54.48},
	{x = 1151.11, y = -775.85, z = 57.03},
	{x = -2185.34, y = -410.91, z = 12.5},
	{x = 1024.9, y = 2656.52, z = 38.96},
	{x = 387.64,  y = 3590.0,  z = 33.2},
	{x = 2005.89, y = 3798.56, z = 31.59},
	{x = -2195.78, y = 4246.5, z = 47.25},

}

Config.RepairTime = 10000 -- Repairing Time
Config.EnableSoundEffect = true -- Sound Effect Which Means Weather You Need Sound Effect While Repair
Config.Blips = true -- Blips in map
Config.cost = 15000 -- Repairing Cost

function sendNotification(message, messageType, messageTimeout)
	exports["dn_notify"]:notify('Vehicle Repair Station', 'VEHICLE REPAIRING ONGOING', 'info', 10000) -- you can change this notify if you need
end