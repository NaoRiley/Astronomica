SMODS.Joker{
    key = 'trickster',
    loc_txt = {
        name = 'Trickster',
        text = {
            '{C:purple}+#1# {C:black}Score',
        }
    },
	blueprint_compat = true,
    atlas = 'jokers',
    pos = {x = 0, y = 1},
	rarity = 1,
	order = 1,
	config = {
		extra = {
			score = 400
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.score}
		}
	end,
	calculate = function(self, card, context)
		if context.after then
			ast.mod_score({add = card.ability.extra.score})
			SMODS.calculate_effect({
				message = ("+")..card.ability.extra.score..(" Score"),
				colour = G.C.PURPLE,
				card = card
			}, card)
		end
	end
}

SMODS.Joker {
	key = 'exoticjoker',
	loc_txt = {
		name = 'Exotic Joker',
		text = {
			'{X:dark_edition,C:white}^#1# {} Mult',
		}
	},
	pos = { x = 4, y = 0 },
	soul_pos = { x = 6, y = 0, extra = { x = 5, y = 0 } },
	config = {
		extra = {
			Emult_mod = 1.04
		} 
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Emult_mod } }
	end,
	cost = 1, 
	rarity = 1,
	unlocked = true,
	discovered = true,
	no_doe = false,
	immutable = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = 'jokers',
	calculate = function(self, card, context)
		if context.joker_main then
			SMODS.calculate_effect ({
				Emult_mod = (to_big(card.ability.extra.Emult_mod)),
				message = "^" .. tostring(card.ability.extra.Emult_mod),
				colour = G.C.DARK_EDITION
			}, card)
		end
	end
}