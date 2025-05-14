--god help me

--formula for amount:

--(base chips + bonus chips) * (base mult + bonus mult)

SMODS.Joker{
	key = "bashful",
    loc_txt = {
        name = 'Bashful Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 400,
			type = "High Card",
            active = false,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.score),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "jokers",
    pos = { x = 1, y = 1 },
	rarity = 1,
    order = 2,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["High Card"])) or context.forcetrigger then
            card.ability.extra.active = true
            end
            if context.after and card.ability.extra.active == true then  
                G.E_MANAGER:add_event(Event({
                func = function() 
                    G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.score))
                    G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
                    play_sound('gong')
                    card.ability.extra.active = false
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

SMODS.Joker{
	key = "nonchalant",
    loc_txt = {
        name = 'Nonchalant Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 600,
			type = "Pair",
            active = false,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.score),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "jokers",
    pos = { x = 2, y = 1 },
	rarity = 1,
    order = 3,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Pair"])) or context.forcetrigger then
            card.ability.extra.active = true
            end
            if context.after and card.ability.extra.active == true then  
                G.E_MANAGER:add_event(Event({
                func = function() 
                    G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.score))
                    G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
                    play_sound('gong')
                    card.ability.extra.active = false
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

SMODS.Joker{
	key = "mendacious",
    loc_txt = {
        name = 'Mendacious Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 1950,
			type = "Three of a Kind",
            active = false,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.score),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "jokers",
    pos = { x = 3, y = 1 },
	rarity = 1,
    order = 4,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Three of a Kind"])) or context.forcetrigger then
            card.ability.extra.active = true
            end
            if context.after and card.ability.extra.active == true then  
                G.E_MANAGER:add_event(Event({
                func = function() 
                    G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.score))
                    G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
                    play_sound('gong')
                    card.ability.extra.active = false
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

SMODS.Joker{
	key = "misanthropic",
    loc_txt = {
        name = 'Misanthropic Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 1200,
			type = "Two Pair",
            active = false,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.score),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "jokers",
    pos = { x = 4, y = 1 },
	rarity = 1,
    order = 5,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Two Pair"])) or context.forcetrigger then
            card.ability.extra.active = true
            end
            if context.after and card.ability.extra.active == true then  
                G.E_MANAGER:add_event(Event({
                func = function() 
                    G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.score))
                    G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
                    play_sound('gong')
                    card.ability.extra.active = false
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

SMODS.Joker{
	key = "conniving",
    loc_txt = {
        name = 'Conniving Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 2080,
			type = "Straight",
            active = false,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.score),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "jokers",
    pos = { x = 5, y = 1 },
	rarity = 1,
    order = 6,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Straight"])) or context.forcetrigger then
            card.ability.extra.active = true
            end
            if context.after and card.ability.extra.active == true then  
                G.E_MANAGER:add_event(Event({
                func = function() 
                    G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.score))
                    G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
                    play_sound('gong')
                    card.ability.extra.active = false
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

SMODS.Joker{
	key = "eccentric",
    loc_txt = {
        name = 'Eccentric Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 1610,
			type = "Flush",
            active = false,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				number_format(card.ability.extra.score),
				localize(card.ability.extra.type, "poker_hands"),
			},
		}
	end,
	atlas = "jokers",
    pos = { x = 6, y = 1 },
	rarity = 1,
    order = 7,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Flush"])) or context.forcetrigger then
            card.ability.extra.active = true
            end
            if context.after and card.ability.extra.active == true then  
                G.E_MANAGER:add_event(Event({
                func = function() 
                    G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.score))
                    G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
                    play_sound('gong')
                    card.ability.extra.active = false
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