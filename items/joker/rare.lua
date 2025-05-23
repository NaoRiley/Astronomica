SMODS.Joker {
	key = 'facsimile', --code mostly copied from old blueprint in cryptid with the banana code removed i dont know how 95% of this works
	loc_txt = {
		name = 'Facsimile',
		text = {
			'Copies ability of ',
			'{C:attention}Joker{} to the left',
		}
	},
	pos = { x = 0, y = 0 },
	config = { extra = { odds = 0 } }, --note to self DONT delete this i have NO idea why but deleting this crashes the fucking game
	rarity = 3,
	cost = 10,
	update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i - 1]
				end
			end
			if other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat then
				card.ability.blueprint_compat = "compatible"
			else
				card.ability.blueprint_compat = "incompatible"
			end
		end
	end,
	loc_vars = function(self, info_queue, card)
		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ""
		card.ability.blueprint_compat_check = nil
		return {
			vars = {
				cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged),
				card.ability.extra.odds,
			},
			main_end = (card.area and card.area == G.jokers) and {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = {
								ref_table = card,
								align = "m",
								colour = G.C.JOKER_GREY,
								r = 0.05,
								padding = 0.06,
								func = "blueprint_compat",
							},
							nodes = {
								{
									n = G.UIT.T,
									config = {
										ref_table = card.ability,
										ref_value = "blueprint_compat_ui",
										colour = G.C.UI.TEXT_LIGHT,
										scale = 0.32 * 0.8,
									},
								},
							},
						},
					},
				},
			} or nil,
		}
	end,
	blueprint_compat = true,
	eternal_compat = true,
	atlas = 'jokers',
	calculate = function(self, card, context)
	if not context.blueprint or (context.blueprint and context.fromRight) then --prevents the crash
			local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i - 1]
				end
			end
			if other_joker and other_joker ~= card then
				context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
				context.blueprint_card = context.blueprint_card or card
				context.fromRight = true

				if context.blueprint > #G.jokers.cards + 1 then
					return
				end

				local other_joker_ret, trig = other_joker:calculate_joker(context)
				local eff_card = context.blueprint_card or card

				context.blueprint = nil
				context.blueprint_card = nil
				context.fromRight = nil

				if other_joker_ret == true then
					return other_joker_ret
				end
				if other_joker_ret or trig then
					if not other_joker_ret then
						other_joker_ret = {}
					end
					other_joker_ret.card = eff_card
					other_joker_ret.colour = darken(G.C.BLUE, 0.3)
					other_joker_ret.no_callback = true
					return other_joker_ret
				end
			end
		end
	end,
	ast_credits = {
		code = {"MathIsFun"},
		art = {'MarioFan597'},
	},
}

SMODS.Joker{
    key = 'stopwatch',
    loc_txt = {
        name = 'Stopwatch',
        text = {
            'Gives {C:chips}+#2# {C:black}chip for each ',
			'{C:attention}second {C:black}game has been open',
			'{C:inactive}(Currently {C:chips}#1# {C:inactive}chips)',
        }
    },
    atlas = 'jokers',
    pos = {x = 1, y = 0},
	rarity = 3,
	blueprint_compat = true,
	ast_credits = {
        art = {"Coo29"}
    },
	config = {
		extra = {
			chips = 0,
			chip_mod = 1,
			evil_chip_mod = 2,
			anticheat = false,
		}
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {card.ability.extra.chips, card.ability.extra.chip_mod}
		}
	end,
	update = function(self, card, dt)
		local time_elapsed = love.timer.getTime() - ast.start
		local anticheat = love.timer.getTime() - ast.idle
		card.ability.extra.chips = (math.floor(time_elapsed/1) * card.ability.extra.chip_mod) --/1 means per second, /60 would mean per minute
		if anticheat >= 60 then
			card.ability.extra.anticheat = true
		end
		if anticheat <= 60 then
			card.ability.extra.anticheat = false
		end
		if card.ability.extra.anticheat == true then
			card.ability.extra.chips = card.ability.extra.chips - (math.floor(anticheat-60) * card.ability.extra.evil_chip_mod) --STOP SETTING THE FUCKING CHIPS TO NEGATIVE DUMBASS
		end
		if card.ability.extra.chips < 0 then
			card.ability.extra.chips = 0
			
		end
	end,
	calculate = function(self, card, context)
		if context.cry_press then
			ast.idle = love.timer.getTime()
		end	
		if context.joker_main and card.ability.extra.chips > 0 then
			return {
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
				chip_mod = card.ability.extra.chips,
				colour = G.C.CHIPS
			}
		end
	end
}