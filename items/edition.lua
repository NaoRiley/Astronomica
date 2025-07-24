SMODS.Shader {
	key = "ultraviolet",
	path = "ultraviolet.fs",
}

SMODS.Shader {
	key = "irradiated",
	path = "irradiated.fs",
}

SMODS.Edition{
    key = 'ultraviolet',
    loc_txt = {
        name = 'Ultraviolet',
        text = {
            '{C:purple}+#1#{} Score',
        },
        label = 'Ultraviolet',
    },
    shader = 'ultraviolet',
    weight = 20,
    in_shop = true,
    extra_cost = 1,
	config = {
		score = 800,
        active = false,
    },
    loc_vars = function(self, info_queue, center)
		return {
			vars = {self.config.score, self.config.active}
		}
	end,
    calculate = function(self, card, context)
        if context.post_joker and not context.repetition then
            self.config.active = true
        end
        if context.after and self.config.active == true then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4,
				func = function() 
					G.GAME.chips = (to_big(G.GAME.chips))+(to_big(self.config.score))
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('gong')
                    self.config.active = false
					return true
				end,
			}))
            return {
				message = "X" .. tostring(self.config.score),
				colour = G.C.PURPLE
			}
        end
	end
}



SMODS.Edition{
    key = 'irradiated', --the haunted fucking edition
    loc_txt = {
        name = 'Irradiated',
        text = {
            '{X:purple,C:white}X#1#{} Score',
        },
        label = 'Irradiated',
    },
    shader = 'irradiated',
    weight = 3,
    in_shop = true,
    extra_cost = 1,
	config = {
		score = 3.5,
        active = false,
    },
    loc_vars = function(self, info_queue, center)
		return {
			vars = {self.config.score, self.config.active}
		}
	end,
    calculate = function(self, card, context)
        if context.post_joker and not context.repetition then
            self.config.active = true
        end
        if context.after and self.config.active == true then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4,
				func = function() 
					G.GAME.chips = (to_big(G.GAME.chips))*(to_big(self.config.score))
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('gong')
                    self.config.active = false
					return true
				end,
			}))
            return {
				message = "X" .. tostring(self.config.score),
				colour = G.C.PURPLE
			}
        end
	end
}

SMODS.Edition{
    key = 'nil',
    loc_txt = {
        name = 'Anomalous',
        text = {
            '???',
        },
    },
    shader = false,
    weight = 1,
    in_shop = true,
    extra_cost = 90,
    -- no_collection = true,
}

-- SMODS.Enhancement {
--     key = 'obsidian',
--     loc_txt = {
--         name = 'Obsidian',
--         text = {
--             '{C:purple}+#1#{} Score',
--             "no rank or suit",
--         },
--         label = 'Obsidian',
--     },
-- 	atlas = 'jokers',
-- 	pos = { x = 4, y = 0 },
--     config = {
--         active = false,
--     },
--     replace_base_card = true,
--     no_rank = true,
--     no_suit = true,
--     always_scores = true,
-- 	loc_vars = function(self, info_queue, card)
--         if card.area.config.collection then
--             return {
--                 vars = {
--                     '((Ante*2)^10)'
--                 }
--             }
--         else
--             return {
--                 vars = {
--                     (G.GAME.round_resets.ante*2)^10
--                 }
--             }
--         end 
-- 	end,
--     calculate = function(self, card, context)
--         if context.main_scoring and context.cardarea == G.play then
--             card.ability.active = true
--         end
-- 		if context.after and card.ability.active == true then
-- 			return {
--                 func = function ()
-- 				    score_mod = (G.GAME.round_resets.ante*2)^10
--                     card.ability.active = false
--                 end
-- 			}
--         end        
--     end
-- }