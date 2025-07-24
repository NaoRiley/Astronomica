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
    in_pool = function(self, args)
        return (G.GAME.hands["High Card"].played or 0) > 0
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
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
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
    in_pool = function(self, args)
        return (G.GAME.hands["Pair"].played or 0) > 0
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
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
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
    in_pool = function(self, args)
        return (G.GAME.hands["Three of a Kind"].played or 0) > 0
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
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
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
    in_pool = function(self, args)
        return (G.GAME.hands["Two Pair"].played or 0) > 0
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
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
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
    in_pool = function(self, args)
        return (G.GAME.hands["Straight"].played or 0) > 0
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
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
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
    in_pool = function(self, args)
        return (G.GAME.hands["Flush"].played or 0) > 0
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
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "snobby",
    loc_txt = {
        name = 'Snobby Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 5250,
			type = "Four of a Kind",
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
    in_pool = function(self, args)
        return (G.GAME.hands["Four of a Kind"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 7, y = 1 },
	rarity = 1,
    order = 8,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Four of a Kind"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "berserk",
    loc_txt = {
        name = 'Berserk Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 8100,
			type = "Straight Flush",
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
    in_pool = function(self, args)
        return (G.GAME.hands["Straight Flush"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 8, y = 1 },
	rarity = 1,
    order = 9,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Straight Flush"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "ludicrous",
    loc_txt = {
        name = 'Ludicrous Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 3400,
			type = "Full House",
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
    in_pool = function(self, args)
        return (G.GAME.hands["Full House"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 9, y = 1 },
	rarity = 1,
    order = 10,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Full House"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "wistful",
    loc_txt = {
        name = 'Wistful Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 9860,
			type = "Five of a Kind",
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
    in_pool = function(self, args)
        return (G.GAME.hands["Five of a Kind"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 0, y = 2 },
	rarity = 1,
    order = 11,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Five of a Kind"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "envious",
    loc_txt = {
        name = 'Envious Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 16720,
			type = "Flush House",
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
    in_pool = function(self, args)
        return (G.GAME.hands["Flush House"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 1, y = 2 },
	rarity = 1,
    order = 12,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Flush House"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "ardent",
    loc_txt = {
        name = 'Ardent Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 18400,
			type = "Flush Five",
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
    in_pool = function(self, args)
        return (G.GAME.hands["Flush Five"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 2, y = 2 },
	rarity = 1,
    order = 13,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["Flush Five"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "deviant",
    loc_txt = {
        name = 'Deviant Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 26320,
			type = "cry_Clusterfuck",
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
    in_pool = function(self, args)
        return (G.GAME.hands["cry_Clusterfuck"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 3, y = 2 },
	rarity = 1,
    order = 14,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["cry_Clusterfuck"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "avaricious",
    loc_txt = {
        name = 'Avaricious Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 33280,
			type = "cry_UltPair",
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
    in_pool = function(self, args)
        return (G.GAME.hands["cry_UltPair"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 4, y = 2 },
	rarity = 1,
    order = 15,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["cry_UltPair"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "lamentable",
    loc_txt = {
        name = 'Lamentable Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 8100,
			type = "cry_Bulwark",
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
    in_pool = function(self, args)
        return (G.GAME.hands["cry_Bulwark"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 5, y = 2 },
	rarity = 1,
    order = 16,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["cry_Bulwark"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "hypothetical",
    loc_txt = {
        name = 'Hypothetical Joker',
        text = {
            '{C:purple}+#1# {}Score if played',
            'hand is {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 150,
			type = "cry_None",
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
    in_pool = function(self, args)
        return (G.GAME.hands["cry_None"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 6, y = 2 },
	rarity = 1,
    order = 2,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["cry_None"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end
}

SMODS.Joker{
	key = "tefd",
    loc_txt = {
        name = 'A Tremendous Amount Of Effort Is Required To Even Begin To Simply Comprehend The Concept Behind This Joker',
        text = {
            '{X:purple,C:white}X#1#{} Score if played',
            'hand contains',
            'a {C:attention}#2#'
        }
    },
	config = {
		extra = {
			score = 52525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252,
			type = "cry_WholeDeck",
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
    in_pool = function(self, args)
        return (G.GAME.hands["cry_WholeDeck"].played or 0) > 0
    end,
	atlas = "jokers",
    pos = { x = 7, y = 2 },
	rarity = 1,
    order = 2,
	cost = 4,
    effect = "Cry Type Score",
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context)
		if (context.before and context.poker_hands and next(context.poker_hands["cry_WholeDeck"])) or context.forcetrigger then
            card.ability.extra.active = true
        end
        if context.after and card.ability.extra.active == true then  
            return {
                func = function ()
                    score = card.ability.extra.score
                    card.ability.extra.active = false
                end
            }
        end
	end,
	ast_credits = {
		art = {'luigicat11'},
	},
}