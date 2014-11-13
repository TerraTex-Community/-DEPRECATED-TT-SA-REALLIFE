--
--	Dieses Script gehört Colin Weber.
--	Dieses Script ist geistiges Eigentum, d.h. es darf weder kopiert, bearbeitet oder verfälscht werden.
--	Es darf nur auf TT-rl.de (TerraTex Reallife) genutzt werden.
--	
--	(c) 2011-2012 by [TTeam]Geramy92 / Colin Weber
--
addEvent("bindclicksys_event",true)

function rebind_func()
		bindKey ("ralt", "down",  clicksysbind  )
		bindKey ("i","down",openInventar )
end
addEventHandler("bindclicksys_event",getRootElement(),rebind_func)
addCommandHandler("rebind",rebind_func,false,false)

function clicksysbind()
    showCursor( not isCursorShowing() )
end
		
		
function click_func()
	clicksysbind()	
end
addCommandHandler("click",click_func,false,false)









