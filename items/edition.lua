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

-- SMODS.Edition{
    -- key = 'ultraviolet', --the haunted fucking edition
--     loc_txt = {
--         name = 'Ultraviolet',
--         text = {
--             '{X:purple,C:white}X#1#{} Score',
--         },
--         label = 'Ultraviolet',
--     },
--     shader = false,
--     weight = 3,
--     in_shop = true,
--     extra_cost = 1,
-- 	config = {
-- 		extra = {
-- 			score = 3.5,
-- 		}
--     },
--     loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {card.ability.extra.score}
-- 		}
-- 	end,
--     calculate = function(self, card, context)
--         if context.post_joker then
-- 			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4,
-- 				func = function() 
-- 					G.GAME.chips = (to_big(G.GAME.chips))*(to_big(card.ability.extra.score))
-- 					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
-- 					play_sound('gong')
-- 					return true
-- 				end,
-- 			}))
--             return {
-- 				message = "X" .. tostring(card.ability.extra.score),
-- 				colour = G.C.PURPLE
-- 			}
--         end
-- 	end
-- }

