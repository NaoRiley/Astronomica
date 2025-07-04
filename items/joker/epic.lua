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
			return {
				func = function ()
					ast.mod_score({mult = card.ability.extra.score})
				end,
				message = ("X")..card.ability.extra.score..(" Score"),
				colour = G.C.PURPLE,
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
			print("1: mod")
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
		if context.end_of_round and context.main_eval and (to_big(card.ability.extra.random)) == (to_big(14)) then --win ante
			G.GAME.win_ante = G.GAME.win_ante + card.ability.extra.mod
			print("14: win ante")
		end
		if context.first_hand_drawn then
			card.ability.extra.random = pseudorandom("black_joker_main", 1, 14)
		end
	end
}

-- SMODS.Joker{
--     key = 'turron',
--     loc_txt = {
--         name = 'Turrón',
--         text = {
--             "Increase values of {C:attention}Joker{} to the left",
-- 			"by {C:attention}+#1#{} at end of round",
-- 			'Amount decreases by {C:attention}#2#{} at end of round',
--         }
--     },
-- 	blueprint_compat = true,
--     atlas = 'jokers',
--     pos = {x = 8, y = 0},
-- 	rarity = 2,
-- 	order = 1,
-- 	pools = { ["Food"] = true },
-- 	config = {
-- 		extra = {
-- 			increase = 100,
-- 			decrease = 10
-- 		}
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
-- 		card.ability.blueprint_compat_check = nil
-- 		return {
-- 			vars = { number_format(card.ability.extra.increase), card.ability.extra.decrease },
-- 			main_end = (card.area and card.area == G.jokers) and {
-- 				{
-- 					n = G.UIT.C,
-- 					config = { align = "bm", minh = 0.4 },
-- 					nodes = {
-- 						{
-- 							n = G.UIT.C,
-- 							config = {
-- 								ref_table = card,
-- 								align = "m",
-- 								colour = G.C.JOKER_GREY,
-- 								r = 0.05,
-- 								padding = 0.06,
-- 								func = "blueprint_compat",
-- 							},
-- 							nodes = {
-- 								{
-- 									n = G.UIT.T,
-- 									config = {
-- 										ref_table = card.ability,
-- 										ref_value = "blueprint_compat_ui",
-- 										colour = G.C.UI.TEXT_LIGHT,
-- 										scale = 0.32 * 0.8,
-- 									},
-- 								},
-- 							},
-- 						},
-- 					},
-- 				},
-- 			} or nil,
-- 		}
-- 	end,
-- 	update = function(self, card, front)
-- 		if G.STAGE == G.STAGES.RUN then
-- 			for i = 1, #G.jokers.cards do
-- 				if G.jokers.cards[i] == card then
-- 					other_joker = G.jokers.cards[i - 1]
-- 				end
-- 			end
-- 			if other_joker and other_joker ~= card and not (Card.no(other_joker, "immutable", true)) then
-- 				card.ability.blueprint_compat = "compatible"
-- 			else
-- 				card.ability.blueprint_compat = "incompatible"
-- 			end
-- 		end
-- 	end,
-- 	calculate = function(self, card, context)
-- 		if
-- 			(context.end_of_round and not context.repetition and not context.individual and not context.blueprint)
-- 			or context.forcetrigger
-- 		then
-- 			local check = false
-- 			for i = 1, #G.jokers.cards do
-- 				if G.jokers.cards[i] == card then
-- 					if i < #G.jokers.cards then
-- 						if not Card.no(G.jokers.cards[i - 1], "immutable", true) then
-- 							check = true
-- 							Cryptid.with_deck_effects(G.jokers.cards[i - 1], function(cards)
-- 								Cryptid.manipulate(cards, { value = card.ability.extra.increase, type = "+" })
-- 							end)
-- 						end
-- 					end
-- 				end
-- 			end
-- 			if check then
-- 				card_eval_status_text(
-- 					card,
-- 					"extra",
-- 					nil,
-- 					nil,
-- 					nil,
-- 					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
-- 				)
-- 			end
-- 		end
-- 	end,
	-- 	if card.ability.extra.increase <= 0 then
	-- 		G.E_MANAGER:add_event(Event({
	-- 			func = function()
	-- 				play_sound('tarot1')
	-- 				card.T.r = -0.2
	-- 				card:juice_up(0.3, 0.4)
	-- 				card.states.drag.is = true
	-- 				card.children.center.pinch.x = true
	-- 				G.E_MANAGER:add_event(Event({
	-- 					trigger = 'after',
	-- 					delay = 0.3,
	-- 					blockable = false,
	-- 					func = function()
	-- 						card:remove()
	-- 						return true
	-- 					end
	-- 				}))
	-- 				return true
	-- 			end
	-- 		}))
	-- 		return {
	-- 			message = localize('k_eaten_ex'),
	-- 			colour = G.C.RED
	-- 		}
	-- 	end
	-- end
-- }
-- card.ability.extra.increase = card.ability.extra.increase - card.ability.extra.decrease

-- SMODS.Joker{
--     key = 'punchcard',
--     loc_txt = {
--         name = 'Punch Card',
--         text = {
--         }
--     },
-- 	blueprint_compat = true,
-- 	demicoloncompat = true,
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	rarity = 'cry_epic',
-- 	config = {
-- 		extra = {
-- 		}
-- 	},
-- 	blueprint_compat = true,
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {card.ability.extra.score, card.ability.extra.score_mod}
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 	end
-- }

