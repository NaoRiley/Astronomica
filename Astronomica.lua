--- STEAMODDED HEADER
--- MOD_NAME: Astronomica
--- MOD_ID: ASTRONOMICA
--- MOD_AUTHOR: [naoriley]
--- MOD_DESCRIPTION: Extremely unbalanced Cryptid add-on which has no direct aim in mind, just trying to make silly stuff!
--- PREFIX: ast

--Welcome to the source code for this mod! A few things:
--Firstly, I do not know what i am doing. Modding is hard.
--Secondly, this is all in a single lua file, sorry about that! i've made sure to make things as organized as possible.
--UPDATE TO ABOVE: so its all in different files now, youre welcome! will i ever do localization? maybe... idk..... (if the mod gets popular enough yes)
--If you have any suggestions, complaints, fixes, etc. PLEASE come to me! i promise i'm approachable! 
--(just keep in mind that it might be hard for me to fix any bugs on my own, i do NOT KNOW HOW TO CODE!!! (YET.))

--4/15/2025: half my code is commented out this shit is HARD

--4/25/2025: lmao im trying to organize shit (THANK YOU RUBY UR THE GOAT)

local files = {
"items/lib",
"items/atlas",
"items/rarity",
"items/tag",
"items/joker",
"items/blind"
}
for i, v in ipairs(files) do
  local result, err = SMODS.load_file(v..".lua")
  if result then result() else error("error in file: "..v..": "..err) end
end

