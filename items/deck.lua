SMODS.Back{
	key = "puritan",
	config = {},
	pos = { x = 4, y = 0 },
	atlas = "jokers",
    loc_txt = {
        name = "Puritan Deck",
        text ={
            "Modded Jokers no longer",
			"appear in the shop",
			"{C:inactive}(Unstable)"
        },
    },
	apply = function(self)
		G.GAME.modifiers.no_modded_jokers = true
	end
}

SMODS.Back{
	key = "elementary",
	config = {},
	pos = { x = 1, y = 0 },
	atlas = "deck",
    loc_txt = {
        name = "Elementary Deck",
        text ={
			"Ante scaling is {C:attention}quadratic{}",
			"{C:attention}Chips/Mult{} operator becomes {C:chips,s:1.5}+",
        },
    },
	apply = function(self)
		G.GAME.quadratic_ante_scaling = true
		G.E_MANAGER:add_event(Event({
			func = function()
				set_operator(-1)
				return true
			end,
		}))
	end,
}

SMODS.Back{
	key = "runic",
	config = { cry_negative_rate = 40, joker_slot = -3 },
	pos = { x = 0, y = 0 },
	atlas = "deck",
    loc_txt = {
        name = "Runic Deck",
        text ={
            "Start with an {C:ast_multicolor}Empyrean{C:attention} Joker",
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

if CardSleeves then
    CardSleeves.Sleeve {
		key = "puritan",
		loc_txt = {
			name = "Puritan Sleeve",
			text ={
				"Modded Jokers no longer",
				"appear in the shop.",
			},
    	},
		atlas = "sleeve",
		pos = { x = 1, y = 0 },
		apply = function()
			G.GAME.modifiers.no_modded_jokers = true
		end
    }
	CardSleeves.Sleeve {
		key = "runic",
		config = { cry_negative_rate = 40, joker_slot = -3 },
		pos = { x = 0, y = 0 },
		atlas = "sleeve",
		loc_txt = {
			name = "Runic Sleeve",
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
end

-- SMODS.Challenge {
	
-- }

-- "j_joker",
-- "j_greedy_joker",
-- "j_lusty_joker",
-- "j_wrathful_joker",
-- "j_gluttenous_joker",
-- "j_jolly",
-- "j_zany",
-- "j_mad",
-- "j_crazy",
-- "j_droll",
-- "j_sly",
-- "j_wily",
-- "j_clever",
-- "j_devious",
-- "j_crafty",
-- "j_half",
-- "j_stencil",
-- "j_four_fingers",
-- "j_mime",
-- "j_credit_card",
-- "j_ceremonial",
-- "j_banner",
-- "j_mystic_summit",
-- "j_marble",
-- "j_loyalty_card",
-- "j_8_ball",
-- "j_misprint",
-- "j_dusk",
-- "j_raised_fist",
-- "j_chaos",
-- "j_fibonacci",
-- "j_steel_joker",
-- "j_scary_face",
-- "j_abstract",
-- "j_delayed_grat",
-- "j_hack",
-- "j_pareidolia",
-- "j_gros_michel",
-- "j_even_steven",
-- "j_odd_todd",
-- "j_scholar",
-- "j_business",
-- "j_supernova",
-- "j_ride_the_bus",
-- "j_space",
-- "j_egg",
-- "j_burglar",
-- "j_blackboard",
-- "j_runner",
-- "j_ice_cream",
-- "j_dna",
-- "j_splash",
-- "j_blue_joker",
-- "j_sixth_sense",
-- "j_constellation",
-- "j_hiker",
-- "j_faceless",
-- "j_green_joker",
-- "j_superposition",
-- "j_todo_list",
-- "j_cavendish",
-- "j_card_sharp",
-- "j_red_card",
-- "j_madness",
-- "j_square",
-- "j_seance",
-- "j_riff_raff",
-- "j_vampire",
-- "j_shortcut",
-- "j_hologram",
-- "j_vagabond",
-- "j_baron",
-- "j_cloud_9",
-- "j_rocket",
-- "j_obelisk",
-- "j_midas_mask",
-- "j_luchador",
-- "j_photograph",
-- "j_gift",
-- "j_turtle_bean",
-- "j_erosion",
-- "j_reserved_parking",
-- "j_mail",
-- "j_to_the_moon", 
-- "j_hallucination",
-- "j_fortune_teller",
-- "j_juggler",
-- "j_drunkard",
-- "j_stone",
-- "j_golden",
-- "j_lucky_cat",
-- "j_baseball",
-- "j_bull",
-- "j_diet_cola",
-- "j_trading",
-- "j_flash",
-- "j_popcorn",
-- "j_trousers",
-- "j_ancient",
-- "j_ramen",
-- "j_walkie_talkie",
-- "j_selzer",
-- "j_castle",
-- "j_smiley",
-- "j_campfire",
-- "j_ticket",
-- "j_mr_bones",
-- "j_acrobat",
-- "j_sock_and_buskin",
-- "j_swashbuckler",
-- "j_troubadour",
-- "j_certificate",
-- "j_smeared",
-- "j_throwback",
-- "j_hanging_chad",
-- "j_rough_gem",
-- "j_bloodstone",
-- "j_arrowhead",
-- "j_onyx_agate",
-- "j_glass",
-- "j_ring_master",
-- "j_flower_pot",
-- "j_blueprint",
-- "j_wee",
-- "j_merry_andy",
-- "j_oops",
-- "j_idol",
-- "j_seeing_double",
-- "j_matador",
-- "j_hit_the_road",
-- "j_duo",
-- "j_trio",
-- "j_family",
-- "j_order",
-- "j_tribe",
-- "j_stuntman",
-- "j_invisible",
-- "j_brainstorm",
-- "j_satellite",
-- "j_shoot_the_moon",
-- "j_drivers_license",
-- "j_cartomancer",
-- "j_astronomer",
-- "j_burnt",
-- "j_bootstraps",
-- "j_caino",
-- "j_triboulet",
-- "j_yorick",
-- "j_chicot",
-- "j_perkeo"