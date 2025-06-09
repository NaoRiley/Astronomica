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

SMODS.Joker{
    key = 'black_joker',
    loc_txt = {
        name = ':black_joker:',
        text = {
            'One random value increased by',
            '{C:attention}+#1#{} every round',
        }
    },
	blueprint_compat = true,
    atlas = 'jokers',
    pos = {x = 9, y = 0},
	rarity = 'cry_epic',
	config = {
		extra = {
			mod = 4,
			random = nil,
			chips = 0,
			xchips = 1,
			echips = 1,
			mult = 0,
			xmult = 1,
			emult = 1,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.mod, card.ability.extra.random}
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(1)) then --mod
			card.ability.extra.mod = card.ability.extra.mod + card.ability.extra.mod
			SMODS.calculate_effect({
				message = 'Values!',
				colour = G.C.ATTENTION,
				card = card
			}, card)
			-- print("1: mod")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(2)) then --hands
			G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.mod
			print("2: hands")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(3)) then --discards
			G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.mod
			print("3: discards")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(4)) then --money
			ease_dollars(card.ability.extra.mod)
			print("4: money")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(5)) then --hand size
			G.hand:change_size(card.ability.extra.mod)
			print("5: hand size")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(6)) then --reroll cost
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.ability.extra.mod
					G.GAME.current_round.reroll_cost = math.max(0,
						G.GAME.current_round.reroll_cost + card.ability.extra.mod)
					return true
				end
			}))
			print("6: reroll cost")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(7)) then --shop prices
			G.GAME.inflation = G.GAME.inflation + card.ability.extra.mod
			print("7: shop prices")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(8)) then --shop slots
			G.E_MANAGER:add_event(Event({
				func = function()
					change_shop_size(card.ability.extra.mod)
					return true
				end
			}))
			print("8: shop slots")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(9)) then --antes
			ease_ante(card.ability.extra.mod)
			print("9: antes")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(10)) then --joker slots
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.jokers then
						G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.mod
					end
					return true
				end,
			}))
			print("10: joker slots")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(11)) then --consumable slots
			G.E_MANAGER:add_event(Event({
				func = function()
					G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.mod
					return true
				end
			}))
			print("11: consumable slots")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(12)) then --jokers
            local jokers_to_create = card.ability.extra.mod
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            key_append = 'ast_black_joker'
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
			print("12: jokers")
		end
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(13)) then --interest cap
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.interest_cap = G.GAME.interest_cap + card.ability.extra.mod
					return true
				end
			}))
			print("13: interest cap")
		end
		if context.first_hand_drawn then
			card.ability.extra.random = pseudorandom("black_joker_main", 1, 13)
		end
	end
}