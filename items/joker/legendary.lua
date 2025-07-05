SMODS.Joker{
    key = 'foole',
    loc_txt = {
        name = 'Foole',
        text = {
            'Bring extra {C:attention}Score {C:black}you win to the next blind',
			'{C:inactive}(Currently {C:purple}+#1# {C:inactive}Score)',
        }
    },
    atlas = 'jokers',
    pos = {x = 2, y = 3},
    soul_pos = { x = 3, y = 3 },
	ast_credits = {
		art = {"LFMoth"},
	},
	blueprint_compat = false,
	rarity = 4,
	config = {
		extra = {
			score = 0,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.score}
		}
	end,
	calculate = function(self, card, context)
		if context.after and not context.repetiiton or context.blueprint then
			return {
				func = function ()
					ast.mod_score({add = card.ability.extra.score})
				end,
				message = ("+")..card.ability.extra.score..(" Score"),
				colour = G.C.PURPLE,
			}
		end
		if context.blind_defeated and not context.repetition or context.blueprint then
			card.ability.extra.score = (to_big(G.GAME.chips))-(to_big(G.GAME.blind.chips))
		end
		if context.after then
			return {
				message = "+" .. tostring(card.ability.extra.score),
				colour = G.C.PURPLE
			}
		end
	end
}

-- SMODS.Joker{
--     key = 'ena',
--     loc_txt = {
--         name = '{f:ast_m6x11mod}ƎNA',
--         text = {
--         }
--     },
-- 	blueprint_compat = true,
-- 	demicoloncompat = true,
--     atlas = 'jokers',
--     pos = {x = 0, y = 3},
-- 	rarity = 4,
-- 	config = {
-- 		extra = {
-- 		}
-- 	},
-- 	blueprint_compat = true,
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {}
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 	end,
-- 	ast_credits = {
-- 		art = {'gudusername_53951'},
-- 	},
-- }

-- SMODS.Joker{
--     key = 'lovelace',
--     loc_txt = {
--         name = 'Lovelace',
--         text = {

--         }
--     },
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
--     -- soul_pos = { x = 0, y = 0 },
-- 	blueprint_compat = false,
-- 	rarity = 4,
-- 	config = {
-- 		extra = {
-- 			score = 0,
-- 		}
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {}
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 	end
-- }
