Config = {}

Config.Locations = {
    ["sanchez"] = {
        coords = vector3(-1412.3755, 253.5816, 60.2584),
        text = "Zmackni [E] pro prodani heroinu",
        drug = "heroin"
    },
    ["rodriguez"] = {
        coords = vector3(-1408.6132, 251.5348, 60.2776),
        text = "Zmackni [E] pro prodani weedu",
        drug = "weed"
    },
    ["garcia"] = {
        coords = vector3(-1404.9662, 249.0758, 60.2510),
        text = "Zmackni [E] pro prodani pervitinu",
        drug = "meth"
    } 
}

Config.Items = {
    ["heroin"] = {
        type = "heroin",
        description = "Bílý prášek na dobrou noc"
    },
    ["weed"] = {
        type = "weed",
        description = "Travička zelená ta je fajn"
    },
    ["meth"] = {
        type = "meth",
        description = "Heroin na steroidech"
    }
}

Config.Peds = {
    { type=4, model="cs_stevehains", coordsPos=vector4(-1412.3861, 253.5681, 60.2563, 119.1273), id=1 },
    { type=4, model="cs_stretch", coordsPos=vector4(-1408.5526, 251.5394, 60.2792, 120.5190), id=2 },
    { type=4, model="cs_old_man2", coordsPos=vector4(-1404.9413, 249.1254, 60.2548, 104.5964), id=3 }
}
