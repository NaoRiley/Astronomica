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
			G.E_MANAGER:add_event(Event({
				func = function() 
					G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.score))
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
					play_sound('gong')
					return true
				end,
			}))
			return {
				message = "+" .. tostring(card.ability.extra.score),
				colour = G.C.PURPLE
			}
		end
	end
}

-- SMODS.Joker{
--     key = 'genie',
--     loc_txt = {
--         name = 'Genie Joker',
--         text = {
--             "Increase values of {C:attention}Joker{} to the right",
-- 			"by {C:attention}+#1#{} at end of round",
--         }
--     },
-- 	blueprint_compat = true,
--     atlas = 'j_placeholder',
--     pos = {x = 0, y = 0},
-- 	rarity = 1,
-- 	order = 1,
-- 	config = {
-- 		extra = {
-- 			increase = 4
-- 		}
-- 	},
-- 	loc_vars = function(self, info_queue, card)
-- 		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
-- 		card.ability.blueprint_compat_check = nil
-- 		return {
-- 			vars = { number_format(card.ability.extra.increase) },
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
-- 					other_joker = G.jokers.cards[i + 1]
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
-- 						if not Card.no(G.jokers.cards[i + 1], "immutable", true) then
-- 							check = true
-- 							Cryptid.with_deck_effects(G.jokers.cards[i + 1], function(cards)
-- 								Cryptid.misprintize(
-- 									cards,
-- 									{ min = card.ability.extra.increase, max = card.ability.extra.increase },
-- 									nil,
-- 									true,
-- 									'+'
-- 								)
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
-- }

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
			return {
				Emult_mod = (to_big(card.ability.extra.Emult_mod)),
				message = "^" .. tostring(card.ability.extra.Emult_mod),
				colour = G.C.DARK_EDITION
			}
		end
	end
}