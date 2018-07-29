# esx_hide_hud
Allow to hide and show the esx HUD by pressing a button.

The assigned button is F10 and can be modified on line 78:

```lua
if IsControlJustPressed(0,  Keys['F10']) and (GetGameTimer() - GUI.Time) > 300 then
```


The radar can be hidden too by uncommenting these functions:

```lua
-- DisplayRadar(false)
-- DisplayRadar(true)
```


The status bars can be hidden too by uncommenting these functions:

```lua
-- TriggerEvent('esx_status:setDisplay', 0.0)
-- TriggerEvent('esx_status:setDisplay', 1.0)
```


## Installation

1) Add folder esx_hide_hud to your [esx] dir
2) Add this in your server.cfg :

```
start esx_hide_hud
```

## In es_extended script

Comment the following lines in es_extended/client/main.lua

```
Pause menu disable HUD display
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if IsPauseMenuActive() and not IsPaused then
      IsPaused = true
      TriggerEvent('es:setMoneyDisplay', 0.0)
      ESX.UI.HUD.SetDisplay(0.0)
    elseif not IsPauseMenuActive() and IsPaused then
      IsPaused = false
      TriggerEvent('es:setMoneyDisplay', 1.0)
      ESX.UI.HUD.SetDisplay(1.0)
    end
  end
end)
```
