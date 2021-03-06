sprunktable={}

function startTrinkCreate()

    local query="SELECT * FROM sprunk"
    local result=mysql_query(handler,query)

    local zahler=0
    if(not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
    else
        zahler=0
        while (mysql_num_rows(result)>zahler) do
            local dasatz = mysql_fetch_assoc(result)

            local colShape=createColSphere(dasatz["X"],dasatz["Y"],dasatz["Z"],0.5)
            table.insert(sprunktable,{colShape,dasatz["X"],dasatz["Y"],dasatz["Z"],dasatz["Rot"]})

            zahler=zahler+1
        end
        outputDebugString("# "..zahler.." Sprunkautomaten loaded!")
        mysql_free_result(result)
    end


end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),startTrinkCreate)

function addSprunk_func(thePlayer,cmd,...)
    if(isAdminLevel(thePlayer,4))then
        local x,y,z=getElementPosition(thePlayer)
        local rx,ry,rz=getElementRotation ( thePlayer )
        local kom=""..table.concat({...}," ")
        local query="INSERT INTO sprunk (X,Y,Z,Rot,Kommentar) Values ('%s','%s','%s','%s','%s')"
        mysql_query(handler,string.format(query,x,y,z,rz,kom))

        local colShape=createColSphere(x,y,z,0.5)
        table.insert(sprunktable,{colShape,x,y,z,rz})
    end
end
addCommandHandler("addSprunk",addSprunk_func,false,false)


function bind_trink_key()
	bindKey(source,"enter","down",enter_trink_key,source)
end
addEventHandler("onPlayerJoin",getRootElement(),bind_trink_key)

function enter_trink_key(thePlayer)
	if(vioGetElementData(thePlayer,"cuffed")==0)then
		for theKey,theShape in ipairs(sprunktable) do
			if(isElementWithinColShape(thePlayer,theShape[1]))then
				if(getPlayerMoney(thePlayer)>0.99)then
					setElementPosition(thePlayer,theShape[2],theShape[3],theShape[4])
                    setElementRotation(thePlayer,0,0,theShape[5])
					setPedAnimation ( thePlayer ,"VENDING","VEND_Use", -1, false, true, false,false)
					triggerClientEvent(thePlayer,"playSound",thePlayer,"FILES/SOUNDS/sprunk.ogg")
					setTimer(trink_ani_sprunk,3000,1,thePlayer)
					triggerClientEvent(thePlayer,"addFood",thePlayer,35)
                    changePlayerMoney(thePlayer,-1,"sonstige","Sprunkautomat")
                    changeBizKasse(4, 2, "Dosenkauf")
				end
			
			end	
		end
	end
end

function trink_ani_sprunk(source)
	setPedAnimation ( source ,"VENDING","VEND_Drink_P", -1, false, true, false,false)
	setTimer(trink_unfreeze,1000,1,source)
end

function trink_unfreeze(source)
setPedAnimation(source)

end








