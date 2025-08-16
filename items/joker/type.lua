local jokers = {
    { name = "Bashful",      hand = "High Card",       pos = { x = 1, y = 1 } },
    { name = "Nonchalant",   hand = "Pair",            pos = { x = 2, y = 1 } },
    { name = "Misanthropic", hand = "Two Pair",        pos = { x = 4, y = 1 } },
    { name = "Mendacious",   hand = "Three of a Kind", pos = { x = 3, y = 1 } },
    { name = "Conniving",    hand = "Straight",        pos = { x = 5, y = 1 } },
    { name = "Eccentric",    hand = "Flush",           pos = { x = 6, y = 1 } },
    { name = "Ludicrous",    hand = "Full House",      pos = { x = 9, y = 1 } },
    { name = "Snobby",       hand = "Four of a Kind",  pos = { x = 7, y = 1 } },
    { name = "Berserk",      hand = "Straight Flush",  pos = { x = 8, y = 1 } },
    { name = "Wistful",      hand = "Five of a Kind",  pos = { x = 0, y = 2 } },
    { name = "Envious",      hand = "Flush House",     pos = { x = 1, y = 2 } },
    { name = "Ardent",       hand = "Flush Five",      pos = { x = 2, y = 2 } },
    { name = "Deviant",      hand = "cry_Clusterfuck", pos = { x = 3, y = 2 } },
    { name = "Avaricious",   hand = "cry_UltPair",     pos = { x = 4, y = 2 } },
    { name = "Lamentable",   hand = "cry_Bulwark",     pos = { x = 5, y = 2 } },
    { name = "Hypothetical", hand = "cry_None",        pos = { x = 6, y = 2 } },
}

local hands = Game.init_game_object().hands

for i, data in ipairs(jokers) do
    SMODS.Joker {
        key = data.name,
        loc_txt = {
            name = data.name .. " Joker",
            text = {
                "{C:purple}+#1#{} Score if played",
                "hand contains a",
                "{C:attention}#2#{}"
            }
        },
        config = { extra = {
            type = data.hand,
            active = false,
            score = (hands[data.hand].chips + hands[data.hand].l_chips * 2) * (hands[data.hand].mult + hands[data.hand].l_mult * 2) * 5
        } },
        rarity = 1,
        atlas = "jokers",
        pos = data.pos,
        order = i + 1,
        demicoloncompat = true,
        blueprint_compat = true,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    number_format(card.ability.extra.score),
                    localize(card.ability.extra.type, "poker_hands"),
                },
            }
        end,
        in_pool = function(self, args)
            return (G.GAME.hands[self.config.extra.type].played or 0) > 0
        end,
        calculate = function(self, card, context)
            if (context.before and context.poker_hands and next(context.poker_hands[card.ability.extra.type])) or context.forcetrigger then
                card.ability.extra.active = true
            end
            if context.after and card.ability.extra.active == true then
                return {
                    func = function()
                        score = card.ability.extra.score
                        card.ability.extra.active = false
                    end
                }
            end
        end,
    }
end