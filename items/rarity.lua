--this is some BULLSHIT WHY IS IT SO COMPLICATED TO ADD A NEW COLOR

--edit from me like a month or two later: you are STUPID

multi_gradient = SMODS.Gradient{
	key = 'multicolor',
	colours = {
		-- HEX('FF0000'), --red
		-- HEX('FFA500'), --orange
		-- HEX('FFFF00'), --yellow
		-- HEX('00FF00'), --lime
		HEX('00FFFF'), --aqua
		HEX('FF00FF'), --purple
	},
	cycle = 10,
	interpolation = 'trig',
}

SMODS.Rarity{
	key = 'empyrean',
	loc_txt = {name = 'Empyrean'},
	badge_colour = multi_gradient, --calls the variable
}