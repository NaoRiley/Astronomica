SMODS.Joker{
    key = 'warlock',
    loc_txt = {
        name = 'Warlock',
        text = {
            'This joker gains {X:purple,C:white}X#2#{C:black} Score',
			'per {C:attention}hand {C:black}played.',
			'Loses {X:purple,C:white}X#2#{C:black} Score per {C:attention}card {C:black}discarded',
			'{C:inactive}(Currently {X:purple,C:white}X#1#{C:inactive} Score)',
        }
    },
	blueprint_compat = true,
	demicoloncompat = true,
    atlas = 'jokers',
    pos = {x = 3, y = 0},
	rarity = 'cry_epic',
	config = {
		extra = {
			score = 1,
			score_mod = 0.5
		}
	},
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.score, card.ability.extra.score_mod}
		}
	end,
	calculate = function(self, card, context)
		if context.before or context.forcetrigger then
			card.ability.extra.score = (to_big(card.ability.extra.score))+(to_big(card.ability.extra.score_mod))
		end
		if context.discard then
			card.ability.extra.score = math.max(1, (to_big(card.ability.extra.score))-(to_big(card.ability.extra.score_mod)))
		end
		if context.after then
			G.E_MANAGER:add_event(Event({
				func = function() 
					G.GAME.chips = (to_big(G.GAME.chips))*(to_big(card.ability.extra.score))
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('gong')
					return true
				end,
			}))
		end
		if context.after then
			return {
				message = "X" .. tostring(card.ability.extra.score),
				colour = G.C.PURPLE
			}
		end
	end
}

-- SMODS.Joker{
--     key = 'trueinvisiblejoker',
--     loc_txt = {
--         name = 'True Invisible Joker',
--         text = {
--         }
--     },
-- 	demicoloncompat = true,
--     atlas = 'jokers',
--     pos = {x = 2000, y = 2000},
-- 	rarity = 'cry_epic',
-- 	blueprint_compat = true,
-- 	calculate = function(self, card, context)
-- }

