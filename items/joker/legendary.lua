SMODS.Joker{
    key = 'foole',
    loc_txt = {
        name = 'Foole',
        text = {
            'Bring extra {C:attention}Score {C:black}you win to the next blind',
			'{C:inactive}(Currently {C:purple}+#1# {C:inactive}Score)',
        }
    },
    atlas = 'j_placeholder',
    pos = {x = 0, y = 0},
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
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.score)),
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('gong')
					card.ability.extra.score = (to_big(0))
					return true
				end,
			}))
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