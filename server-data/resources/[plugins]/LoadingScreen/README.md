# [LoqScript] FiveM Loading Screen - Material_Load
Material_Load is a loading screen developed by github.com/Loqrin. The loading screen comes with a configurable JSON file, to configure the loading screen to the user's liking. The JSON has configs such as:
+ Enable a solid, colour background and set the colour with RGB.
+ Enable a background image, ability to insert a path to the image.
+ Use a different colour for the text and set the colour with RGB.
+ Use bold for the text.
+ Set the server title.
+ Enable audio to be played in the background as well as supply a path to the audio and adjust the volume of it.
+ Ability to set what rules to display on the loading screen.
+ Ability to set what servers / other community things the user has on the loading screen.
+ Ability to set the content of what the server has, on the loading screen.

The loading screen is designed to have a material design feel. It is responsive on different resolutions. If you wish to view an example, you can visit the following YouTube link:
https://youtu.be/B32-xvPCdP8

---

# How to install
The installation is rather quite simple. If you have any loading screens installed, do uninstall them and remove them from your citmp-server.yml.

1. Download the .zip or clone the repository to your desktop.
2. Extract the .zip to your desktop.
3. Make sure the folder is named "loqscript-material_load-loadingscreen".
4. Copy the folder to your server resources folder.
5. Open up your citmp-server.yml and under "AutoStartResources:" add the following:
```lua
- loqscript-material_load-loadingscreen
```
That's it. It's all installed and now it's time to configure it.

---

# How to configure
The configuration is, again, rather quite simple. Open the folder "loqscript-material_load-loadingscreen". Then head into the folder "LoadingScreen". Within there, you'll see a file called "config.json". **REMEMBER THAT AUDIO FILES MUST BE IN .ogg FORMAT TO FUNCTION! THIS IS NOT DUE TO MATERIAL_LOAD!**

1. Open the config.json file.
2. Once opened, you'll be presented with options such as:
![alt text](http://i.imgur.com/KAA7fxy.png "config.json Settings")
3. The following are the settings and their explanation:
  * **"useBackgroundColour"** : set this value to true or false if you want to use a solid, background colour.
  * **"backgroundColour"** : set this value to the format of "0,0,0" where the numbers are the RGB values for the colour of the background.
  * **"useBackgroundImage"** : set this value to true or false if you want to use a background image instead of a colour.
  * **"backgroundImagePath"** : set this value to the path of your image. It can be anywhere but preferbly put it in the images folder.
  * **"useTextColour"** : set this value to true or false if you want to use a custom colour for the text.
  * **"textColour"** : set this value to the format of "0,0,0" where the numbers are the RGB values for the colour of the text.
  * **"useBoldText"** : set this value to true or false if you want to use bold text.
  * **"serverTitle"** : set this value to the name of your server.
  * **"playAudioInBackground"** : set this value to true or false if you want to play audio in the background when someone is joining.
  * **"audioPath"** : set this value to the path of your audio file. It can be anywhere but preferbly put it in the audio folder.
  * **"audioVolume"** : set this value between 0 and 1 to change the volume of the audio that is playing.
  * **"rule1"** : set this value to whatever you want the rules to be. Same applies to **rule2** to **rule7**.
  * **"servers1"** : set this value to whatever you want the rules to be. Same applies to **servers2** to **servers7**.
  * **"content1"** : set this value to whatever you want the rules to be. Same applies to **content2** to **content7**.
  
  **ALL YOU HAVE TO DO IS INSERT THE CONTENT INBETWEEN THE QUOTATION ("") MARKS! DO NOT CHANGE ANYTHING ELSE SUCH AS COMMAS OR TRY TO ADD MORE RULES, SERVERS OR CONTENT SETTINGS! IT WILL BREAK AND NOT WORK! WORK WITH WHAT IS SUPPLIED!**
  
4. If you do use a background image or audio file, do not forget to include it in the "[resource.lua](../master/__resource.lua)" file. 
  * If it's a background: insert it under the heading "--Loading Image Files--" inside ''. Inside the '' is the path to your background.
  * If it's an audio: insert it under the heading "--Loading Audio Files--" inside ''. Inside the '' is the path to your audio file.
  
---

That's it. Not much to it. Thank you for using my loading screen.

---

If you appreciate any of my work and wish to purchase me a coffe, or something else, you can always send a donation to my PayPal by clicking the button below.

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=L5WM8JJY3KXEU)

