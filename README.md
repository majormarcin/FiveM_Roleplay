# PL ESX FiveM RolePlay
LINK DO ESX-ORG:
[ESX-ORG](https://github.com/ESX-Org)

# INFORMACJE

| Plugin | Wersja |
| --- | --- |
| EssentialMode | 6.2.2 |
| ES-Extended | 1.1.0 |
| mysql-async | 3.2.0 |
| skrypty z dnia| 30.07.2019 |


### Paczka Pluginów RolePlay do ESX, gotowych żeby wystarować serwer w pare sekund.

Pluginy ESX są często update'owane, wiec po pobraniu mojej paczki upewnij sie że wszystkie pluginy są nadal aktualne. Link do GitHub'a ESX'a dostępny powyżej.

# JAK ZAINSTALOWAĆ

1. Pobierz pliki serwerowe [stąd](https://docs.fivem.net/server-manual/setting-up-a-server/)

2. Wklej pliki z server-data (nie musisz pobierac "cfx-server-data" jest to już dodane do paczki)
3. Zimportuj wybrane pliki sql do swojej bazy danych znajdziesz je w folderach ze skryptami
4. Eytuj server.cfg do twoich ustawien serwera dopisz skrypty i wymkagane parametry (więcej o pliku konfiguracyjnym [tutaj](https://docs.fivem.net/server-manual/setting-up-a-server/) )
```
add_ace resource.essentialmode command.sets allow
add_ace resource.essentialmode command.add_principal allow
add_ace resource.essentialmode command.add_ace allow

set es_permissionDenied "Pesky rat! You don't have permission for this!!"
set es_startingCash 10000
set es_startingBank 10000
set es_enableRankDecorators 1
set es_moneyIcon "-"
set es_nativeMoneySystem 1
set es_commandDelimeter "/"
set es_enableLogging 1
set es_enableCustomData 1
set mysql_connection_string "server=127.0.0.1;database=database_name;userid=user_name;password=password"

ensure mapmanager
ensure chat
ensure spawnmanager
ensure sessionmanager
ensure fivem
ensure hardcap
ensure rconlog
ensure scoreboard

ensure mysql-async
ensure essentialmode
ensure esplugin_mysql
ensure es_extended

ensure esx_menu_default
ensure esx_menu_list
ensure esx_menu_dialog

ensure esx_accessories
ensure esx_addonaccount
ensure esx_addoninventory
ensure esx_ambulancejob
ensure esx_animations
ensure esx_atm
ensure esx_bankerjob
ensure esx_barbershop
ensure esx_basicneeds
ensure esx_billing
ensure esx_boat
ensure esx_clotheshop
ensure esx_datastore
ensure esx_dmvschool
ensure esx_drugs
ensure esx_holdup
ensure esx_identity
ensure esx_joblisting
ensure esx_jobs
ensure esx_license
ensure esx_lscustom
ensure esx_mechanicjob
ensure esx_menu_default
ensure esx_menu_dialog
ensure esx_menu_list
ensure esx_policejob
ensure esx_property
ensure esx_realestateagentjob
ensure esx_rpchat
ensure esx_service
ensure esx_shops
ensure esx_sit
ensure esx_skin
ensure esx_society
ensure esx_status
ensure esx_taxijob
ensure esx_vehicleshop
ensure esx_voice
ensure esx_weaponshop
ensure instance
```
5. Odpal Serwer!!

Jeżeli masz pytania, problemy lub potrzebujesz pomocy, napisz na odpowiednim kanale na moim serwerze [discord](https://discord.gg/cyJtwG6)

### Paczka nie posiada plików serwerowych gdyż te zależne są od wybranego systemu operacyjnego serwera

### Przetestowane i sprawne na artifacts build server 1445

# PRZYDATNE LINKI
- [ESX Documentation](https://esx-org.github.io/) 
- [ES Documentation](https://docs.essentialmode.com/)
- [FiveM Native Reference](https://runtime.fivem.net/doc/reference.html)

