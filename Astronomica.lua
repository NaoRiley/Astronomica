--- STEAMODDED HEADER
--- MOD_NAME: Astronomica
--- MOD_ID: Astronomica
--- MOD_AUTHOR: [naoriley]
--- MOD_DESCRIPTION: Extremely unbalanced Cryptid add-on which aims to add a large variety of content!
--- PREFIX: ast
--- PRIORITY: 2500
--- BADGE_COLOUR: c96da8
--- BADGE_TEXT_COLOUR: FFFFFF

--Welcome to the source code for this mod! A few things:
--Firstly, I do not know what i am doing. Modding is hard.
--Secondly, this is all in a single lua file, sorry about that! i've made sure to make things as organized as possible.
--UPDATE TO ABOVE: so its all in different files now, youre welcome! will i ever do localization? maybe... idk..... (if the mod gets popular enough yes)
--If you have any suggestions, complaints, fixes, etc. PLEASE come to me! i promise i'm approachable! 
--(just keep in mind that it might be hard for me to fix any bugs on my own, i do NOT KNOW HOW TO CODE!!! (YET.))

--4/15/2025: half my code is commented out this shit is HARD

--4/25/2025: lmao im trying to organize shit (THANK YOU RUBY UR THE GOAT)

--5/22/2025: hi chat, doing a lot today and its quite difficult, just letting yall know that you are awesome and i am so incredibly thankful for all the support, love yall <3

local files = {
"items/lib",
"Cryptid",
"items/atlas",
"items/sound",
"items/rarity",
"items/edition",
"items/tag",
"items/deck",
"items/voucher",
"items/joker/common",
"items/joker/type",
"items/joker/uncommon",
"items/joker/rare",
"items/joker/epic",
"items/joker/legendary",
"items/joker/exotic",
"items/joker/exadversum",
"items/joker/empyrean",
"items/spectral",
"items/tarot",
"items/blind",
"items/joker/tests",
}
for i, v in ipairs(files) do
  local result, err = SMODS.load_file(v..".lua")
  if result then result() else error("error in file: "..v..": "..err) end
end

SMODS.current_mod.optional_features = {
  retrigger_joker = true,
}

Cryptid.pointerblistifytype("rarity", "ast_empyrean", nil)

--stolen fron entropy

local smcmb = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	smcmb(obj, badges)
	if not SMODS.config.no_mod_badges and obj and obj.ast_credits then
		local function calc_scale_fac(text)
			local size = 0.9
			local font = G.LANG.font
			local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
			local calced_text_width = 0
			-- Math reproduced from DynaText:update_text
			for _, c in utf8.chars(text) do
				local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
					+ 2.7 * 1 * G.TILESCALE * font.FONTSCALE
				calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
			end
			local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
			return scale_fac
		end
		if obj.ast_credits.art or obj.ast_credits.code or obj.ast_credits.idea or obj.ast_credits.custom then
			local scale_fac = {}
			local min_scale_fac = 1
			local strings = { "Astronomica" }
			for _, v in ipairs({ "idea", "art", "code" }) do
				if obj.ast_credits[v] then
					for i = 1, #obj.ast_credits[v] do
						strings[#strings + 1] =
							localize({ type = "variable", key = "cry_" .. v, vars = { obj.ast_credits[v][i] } })[1]
					end
				end
			end
            if obj.ast_credits.custom then
                strings[#strings + 1] = localize({ type="variable", key = obj.ast_credits.custom.key, vars = { obj.ast_credits.custom.text } })
            end
			for i = 1, #strings do
				scale_fac[i] = calc_scale_fac(strings[i])
				min_scale_fac = math.min(min_scale_fac, scale_fac[i])
			end
			local ct = {}
			for i = 1, #strings do
				ct[i] = {
					string = strings[i],
				}
			end
			local cry_badge = {
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							colour = HEX("c96da8"),
							r = 0.1,
							minw = 2 / min_scale_fac,
							minh = 0.36,
							emboss = 0.05,
							padding = 0.03 * 0.9,
						},
						nodes = {
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = ct or "ERROR",
										colours = { obj.ast_credits and obj.ast_credits.text_colour or G.C.WHITE },
										silent = true,
										float = true,
										shadow = true,
										offset_y = -0.03,
										spacing = 1,
										scale = 0.33 * 0.9,
									}),
								},
							},
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						},
					},
				},
			}
			local function eq_col(x, y)
				for i = 1, 4 do
					if x[i] ~= y[i] then
						return false
					end
				end
				return true
			end
			for i = 1, #badges do
				if eq_col(badges[i].nodes[1].config.colour, HEX("c96da8")) then
					badges[i].nodes[1].nodes[2].config.object:remove()
					badges[i] = cry_badge
					break
				end
			end
		end
	end
end