--Where the HELL is THE BOSS!!

SMODS.Blind{
    key = 'shard', --so apparently i do this really unusually, youre not supposed to put calculate in a blind, but IDC!!! if it works it works so whatever
    loc_txt = {
        name = 'The Shard',
        text = {
            'Divides Score by',
			'1.5 per hand played',
        }
    },
    atlas = 'blinds',
    pos = {x = 0, y = 0},
	dollars = 5,
	mult = 2,
	boss = {min = 1},
	boss_colour = HEX('FFA500'),
	calculate = function(self, card, context)
		if context.after and not G.GAME.blind.disabled then
			G.E_MANAGER:add_event(Event({
				func = function() 
					G.GAME.chips = (to_big(G.GAME.chips))/(to_big(1.5))
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('slice1')
					return true
				end,
			}))
		end
	end
}