--this is some BULLSHIT WHY IS IT SO COMPLICATED TO ADD A NEW COLOR

multi_gradient = SMODS.Gradient{
	key = 'multicolor',
	colours = {
		HEX('FF0000'), --red
		HEX('FFA500'), --orange
		HEX('FFFF00'), --yellow
		HEX('00FF00'), --lime
		HEX('00FFFF'), --aqua
		HEX('FF00FF'), --purple
	},
	cycle = 10,
	interpolation = 'trig',
}

SMODS.Rarity{
	key = 'worldbending',
	loc_txt = {name = 'Worldbending'},
	badge_colour = multi_gradient, --calls the variable
}