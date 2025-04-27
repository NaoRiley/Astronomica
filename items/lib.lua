AST = {} --global variables

AST.euler = 2.718281828459045 --this is for the factorial function

AST.pi = 3.14159265358979 --this is also for the factorial functuion

--print('before')
AST.start = love.timer.getTime() --gives some time
--print('after', start)

AST.context_counts={}

-- UTIL_TABLE = {} 
-- function UTIL_TABLE.factorial(n) --for factorial bullshit
-- 	print(type(n), n, to_number(n))
--     local res = to_big(1)
-- 	print(type(n), n)
--     for i = 2, to_number(n) do --try approximation
--         res = res * to_big(i)
-- 		print(n, i, res)
--     end
--     return res
-- end

UTIL_TABLE = {} 
function UTIL_TABLE.small_factorial(n) --exact computation factorial (for smaller numbers)
	--print(type(n), n, to_number(n))
    local res = to_big(1)
	local i = to_big(1)
	while i:lt(to_big(n)) or i:eq(to_big(n)) do
		res = res * to_big(i)
		i = to_big(i) + to_big(1)
		--print(n, i, res)
	end
    return res
end
 
function UTIL_TABLE.additive_factorial(n) --additive factorial
	return (to_big(n)*(to_big(n)+1)/2)
end

function UTIL_TABLE.factorial(n) --multiplicative factorial
    return (to_big(AST.pi * 2)*to_big(n)):pow(0.5)*(to_big(n)/to_big(AST.euler))^to_big(n)
end

function UTIL_TABLE.efactorial(n) --exponential factorial (that's infaccurate!)
    return (to_big(AST.pi * 2)*to_big(n^(n-1))):pow(0.5)*(to_big(n^(n-1))/to_big(AST.euler))^to_big(n^(n-1))
end

-- if (key == 'p_score' or key == 'pscore' or key == 'pscore_mod') and amount ~= 1 then --i dont fucking know how to do this
-- 	G.E_MANAGER:add_event(Event({
-- 		func = function() 
-- 			G.GAME.chips = (to_big(G.GAME.chips))+(to_big(card.ability.extra.pscore))
-- 			G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)
-- 			play_sound('multhit1')
-- 			play_sound('chips1')
-- 			return true
-- 		end,
-- 	}))
-- end