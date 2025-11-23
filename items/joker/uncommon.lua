SMODS.Joker {
	key = 'genie',
	loc_txt = {
		name = 'Genie Joker',
		text = {
			"Increase values of {C:attention}Joker{} to the right",
			"by {C:attention}+#1#{} at end of round",
		}
	},
	blueprint_compat = true,
	atlas = 'jokers',
	pos = { x = 1, y = 3 },
	ast_credits = {
		art = { "LFMoth" },
	},
	rarity = 2,
	order = 1,
	config = {
		extra = {
			increase = 4
		}
	},
	loc_vars = function(self, info_queue, card)
		local other_joker = nil
		if card.area and card.area == G.jokers then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
			end
		end
		local compatible = other_joker and other_joker ~= card and not other_joker.config.center.immutable
		return {
			vars = { number_format(card.ability.extra.increase) },
			main_end = (card.area and card.area == G.jokers) and {
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
			},
		}
	end,
	calculate = function(self, card, context)
		if (context.end_of_round and not context.repetition and not context.individual and not context.blueprint) or context.forcetrigger then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					---@type Card
					local c = G.jokers.cards[i + 1]
					if c and not c:no("immutable", true) then
						Cryptid.with_deck_effects(c, function(cards)
							Cryptid.manipulate(cards, { value = card.ability.extra.increase, type = "+" })
						end)
						card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_upgrade_ex"), colour = G.C.GREEN } )
					end
				end
			end
		end
	end,
}
