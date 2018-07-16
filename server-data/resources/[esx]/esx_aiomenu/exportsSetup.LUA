You need to add the following lines to BOTTOM your files.
You need to add the following lines to BOTTOM your files.
You need to add the following lines to BOTTOM your files.
You need to add the following lines to BOTTOM your files.
You need to add the following lines to BOTTOM your files.
You need to add the following lines to BOTTOM your files.

============================================
==    es_extended/client/functions.lua    == 
==				    ADD                   ==
============================================

function openInventory()
    if not ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
      ESX.ShowInventory()
    end
end

============================================
==      es_extended/__resource.lua        ==
==				  REPLACE                 == 
============================================

exports {
  'getSharedObject',
  'openInventory'
}



============================================
==        es_phone/client/main.lua        ==
==				    ADD                   == 
============================================

function openPhone()
      if (GetGameTimer() - GUI.Time) > 150 then

        if not ESX.UI.Menu.IsOpen('phone', GetCurrentResourceName(), 'main') then
          ESX.UI.Menu.CloseAll()
          ESX.UI.Menu.Open('phone', GetCurrentResourceName(), 'main')
        end

        GUI.Time = GetGameTimer()

      end
end



============================================
==         es_phone/__resource.lua        ==
==				    ADD                   == 
============================================

exports {
  'openPhone'
}



============================================
==       es_billing/client/main.lua       ==
==				    ADD                   == 
============================================

function openInvoices()
  	if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'billing') and (GetGameTimer() - GUI.Time) > 150 then
  		ShowBillsMenu()
	  	GUI.Time  = GetGameTimer()
    end
end



============================================
==        es_billing/__resource.lua       ==
==				    ADD                   == 
============================================

exports {
  'openInvoices'
}



============================================
==    esx_ambulancejob/client/main.lua    ==  
==				    ADD                   == 
============================================

function openAmbulance()
	if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and (GetGameTimer() - GUI.Time) > 150 then
		OpenMobileAmbulanceActionsMenu()
		GUI.Time = GetGameTimer()
	end
end



============================================
==    esx_ambulancejob/__resource.lua     ==  
==				    ADD                   == 
============================================

exports {
  'openAmbulance'
}



============================================
==     esx_policejob/client/main.lua      ==  
==				    ADD                   == 
============================================

function openPolice()
  if PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') and (GetGameTimer() - GUI.Time) > 150 then
    OpenPoliceActionsMenu()
    GUI.Time = GetGameTimer()
  end
end

function getJob()
  if PlayerData.job ~= nil then
	return PlayerData.job.name
  end
end



============================================
==      esx_policejob/__resource.lua      ==  
==				    ADD                   == 
============================================

exports {
  'openPolice',
  'getJob',
}


============================================
==     esx_mecanojob/client/main.lua      ==  
==				    ADD                   == 
============================================

function openMechanic()
  if PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then
    OpenMobileMecanoActionsMenu()
  end
end



============================================
==      esx_mecanojob/__resource.lua      ==  
==				    ADD                   == 
============================================

exports {
  'openMechanic'
}



============================================
==      esx_taxijob/client/main.lua       ==  
==				    ADD                   == 
============================================

function openTaxi()
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'taxi' and (GetGameTimer() - GUI.Time) > 150 then
    OpenMobileTaxiActionsMenu()
    GUI.Time = GetGameTimer()
  end
end



============================================
==       esx_taxijob/__resource.lua       ==  
==				    ADD                   == 
============================================

exports {
  'openTaxi'
}

============================================
==      esx_animations/client/main.lua    ==  
==				    ADD                   == 
============================================

function openAnimations()
  OpenAnimationsMenu()
end



============================================
==       esx_animations/__resource.lua    ==  
==				    ADD                   == 
============================================

exports {
  'openAnimations'
}


============================================
==       esx_voice/__resource.lua         ==  
==				    ADD                   == 
============================================

exports {
  'setVoice'
}



============================================
==      esx_voice/client/main.lua         ==  
==				    ADD                   == 
============================================

function setVoice()
      voice.current = (voice.current + 1) % 3
      if voice.current == 0 then
        NetworkSetTalkerProximity(voice.default)
        voice.level = "Normal"
      elseif voice.current == 1 then
        NetworkSetTalkerProximity(voice.shout)
        voice.level = "Shout"
      elseif voice.current == 2 then
        NetworkSetTalkerProximity(voice.whisper)
        voice.level = "Whisper"
      end
end

============================================
==       esx_identity/__resource.lua      ==  
==				    ADD                   == 
============================================

exports {
  'openRegistry'
}



============================================
==      esx_identity/client.lua           ==  
==				    ADD                   == 
============================================

function openRegistry()
  TriggerEvent('esx_identity:showRegisterIdentity')
end
