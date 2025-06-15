SMODS.Joker {
	key = 'facsimile', --code formerly copied from old blueprint, now IMMENSELY optimized thanks to VanillaRemade
	loc_txt = {
		name = 'Facsimile',
		text = {
			'Copies ability of ',
			'{C:attention}Joker{} to the left',
		}
	},
	pos = { x = 0, y = 0 },
	rarity = 3,
	cost = 10,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = 'jokers',
	loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i - 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i - 1] end
        end
        return SMODS.blueprint_effect(card, other_joker, context)
    end,
	ast_credits = {
		art = {'MarioFan597'},
	},
}

-- SMODS.Joker{
--     key = 'stopwatch',
--     loc_txt = {
--         name = 'Stopwatch',
--         text = {
--             'Gives {C:chips}+#2# {C:black}chip for each ',
-- 			'{C:attention}second {C:black}game has been open',
-- 			'{C:inactive}(Currently {C:chips}#1# {C:inactive}chips)',
--         }
--     },
--     atlas = 'jokers',
--     pos = {x = 1, y = 0},
-- 	rarity = 3,
-- 	blueprint_compat = true,
-- 	ast_credits = {
--         art = {"Coo29"}
--     },
-- 	config = {
-- 		extra = {
-- 			chips = 0,
-- 			chip_mod = 1,
-- 			evil_chip_mod = 2,
-- 			anticheat = false,
-- 		}
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {card.ability.extra.chips, card.ability.extra.chip_mod}
-- 		}
-- 	end,
-- 	update = function(self, card, dt)
-- 		local time_elapsed = love.timer.getTime() - ast.start
-- 		local anticheat = love.timer.getTime() - ast.idle
-- 		card.ability.extra.chips = (math.floor(time_elapsed/1) * card.ability.extra.chip_mod) --/1 means per second, /60 would mean per minute
-- 		if anticheat >= 60 then
-- 			card.ability.extra.anticheat = true
-- 		end
-- 		if anticheat <= 60 then
-- 			card.ability.extra.anticheat = false
-- 		end
-- 		if card.ability.extra.anticheat == true then
-- 			card.ability.extra.chips = card.ability.extra.chips - (math.floor(anticheat-60) * card.ability.extra.evil_chip_mod) --STOP SETTING THE FUCKING CHIPS TO NEGATIVE DUMBASS
-- 		end
-- 		if card.ability.extra.chips < 0 then
-- 			card.ability.extra.chips = 0
			
-- 		end
-- 	end,
-- 	calculate = function(self, card, context)
-- 		if context.cry_press then
-- 			ast.idle = love.timer.getTime()
-- 		end	
-- 		if context.joker_main and card.ability.extra.chips > 0 then
-- 			return {
-- 				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
-- 				chip_mod = card.ability.extra.chips,
-- 				colour = G.C.CHIPS
-- 			}
-- 		end
-- 	end
-- }

SMODS.Joker{
    key = 'stopwatch',
    loc_txt = {
        name = 'Stopwatch',
        text = {
            'Gives {C:chips}+#2# {C:black}chip for each ',
			'{C:attention}second {C:black}game has been open',
			'{C:inactive}(Currently {C:chips}#1# {C:inactive}chips)',
        }
    },
    atlas = 'jokers',
    pos = {x = 1, y = 0},
	rarity = 3,
	blueprint_compat = true,
	config = {
		extra = {
			chips = 0,
			chip_mod = 1
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.chips, card.ability.extra.chip_mod}
		}
	end,
	update = function(self, card, dt)
		local time_elapsed = love.timer.getTime() - ast.start
		card.ability.extra.chips = (math.floor(time_elapsed/1) * card.ability.extra.chip_mod) --/1 means per second, /60 would mean per minute
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
				chip_mod = card.ability.extra.chips,
				colour = G.C.CHIPS
			}
		end
	end
}

