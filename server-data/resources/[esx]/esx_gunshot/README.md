# esx_gunshot
## Description
Makes you able to perform a GSR-test (gunshot residue) to check whether a citizen has fired a gun recently or not

## Implementation
Upon installation of the script everyone got the possibility to check for GSR with the command /guntest, see row 16-21 in client.lua. To implement this for police only in their menu (esx_policejob), please see below.

**1.** Delete the rows 16-21 in client.lua (esx_gunshot)

**2.** Go to the following row in esx_policejob client.lua
```LUA
title    = _U('citizen_interaction'),
```
**3.** Add a new menu button
```LUA
ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'citizen_interaction',
  {
    title    = _U('citizen_interaction'),
    align    = 'top-left',
    elements = {
      {label = _U('id_card'),       value = 'identity_card'},
      {label = _U('search'),        value = 'body_search'},
      -- New menu item added here
      {label = 'GSR-test',        value = 'gsr'}, 
    },
  },
  function(data2, menu2)
```

**4.** Define the value "gsr"
```LUA
if data2.current.value == 'identity_card' then
   OpenIdentityCardMenu(player)
end

if data2.current.value == 'body_search' then
   OpenBodySearchMenu(player)
end

-- GSR is defined here, and triggers the clientevent "esx_guntest:checkGun"
if data2.current.value == 'gsr' then
   TriggerEvent('esx_guntest:checkGun' source)
end
```

**5.** Done!
