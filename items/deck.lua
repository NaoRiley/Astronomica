SMODS.Back{
	key = "runic",
	config = { cry_negative_rate = 40, joker_slot = -3 },
	pos = { x = 0, y = 0 },
	atlas = "deck",
    loc_txt = {
        name = "Runic Deck",
        text ={
            "Start with an {C:chips}Empyrean{C:attention} Joker",
            "Jokers are {C:attention}40X{} more",
            "likely to be {C:dark_edition}Negative",
            "{C:attention}-3{} Joker slots",
        },
    },
	apply = function(self)
		G.GAME.modifiers.cry_negative_rate = self.config.cry_negative_rate
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					local card = create_card("Joker", G.jokers, nil, "ast_empyrean", nil, nil, nil, "cry_wormhole")
					card:add_to_deck()
					card:start_materialize()
					G.jokers:emplace(card)
					return true
				end
			end,
		}))
	end,
	init = function(self)
		SMODS.Edition:take_ownership("negative", {
			get_weight = function(self)
				return self.weight * (G.GAME.modifiers.cry_negative_rate or 1)
			end,
		}, true)
	end,
}