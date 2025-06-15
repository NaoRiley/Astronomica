--Where the HELL is THE BOSS!!

SMODS.Blind{
    key = 'shard', 
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
	calculate = function(self, blind, context)
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

SMODS.Blind{
    key = 'torrent',
    loc_txt = {
        name = 'Tempestuous Torrent',
        text = {
			'Disables all Mult effects',
        }
    },
    atlas = 'blinds',
    pos = {x = 0, y = 3},
	dollars = 5,
	showdown = true,
	mult = 0.1,
	boss = {min = 16},
	boss_colour = G.C.CHIPS,
    defeat = function(self, silent)
		enable_mult()
	end,
    disable = function(self, silent)
		enable_mult()
	end,
    set_blind = function(self)
		if not next(SMODS.find_card('j_ast_congruentia')) then
			disable_mult()
		end
    end,
}

SMODS.Blind{
    key = 'inferno',
    loc_txt = {
        name = 'Impetuous Inferno',
        text = {
			'Disables all Chips effects',
        }
    },
    atlas = 'blinds',
    pos = {x = 0, y = 4},
	dollars = 5,
	showdown = true,
	mult = 0.1,
	boss = {min = 16},
	boss_colour = G.C.MULT,
    defeat = function(self, silent)
		enable_chips()
	end,
    disable = function(self, silent)
		enable_chips()
	end,
    set_blind = function(self)
		if not next(SMODS.find_card('j_ast_congruentia')) then
			disable_chips()
		end
    end,
}

-- SMODS.Blind{
--     key = 'iris_candle', 
--     loc_txt = {
--         name = 'Iris Candle',
--         text = {
--             'Divides Score by',
-- 			'#1# per hand played',
--         }
--     },
--     atlas = 'blinds',
--     pos = {x = 0, y = 1},
-- 	dollars = 5,
-- 	mult = 2,
-- 	boss = {min = 1},
-- 	boss_colour = HEX('6479bd'),
-- 	config = {
-- 		extra = {
-- 			amount = nil
-- 		}
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {card.ability.extra.amount}
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 		if context.after and not G.GAME.blind.disabled then
-- 			G.E_MANAGER:add_event(Event({
-- 				func = function() 
-- 					G.GAME.chips = (to_big(G.GAME.chips))/(to_big(card.ability.extra.amount))
-- 					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
-- 					play_sound('slice1')
-- 					return true
-- 				end,
-- 			}))
-- 		end
-- 	end,
-- 	set_blind = function(self, reset, silent)
-- 		if not reset then
-- 			card.ability.extra.amount = (to_big(G.GAME.round_resets.ante))/(to_big(4))
-- 		end
-- 	end
-- }