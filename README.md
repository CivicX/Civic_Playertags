# CIvic_Playertags
Hello this is a script where you can display Player names as tags by using a key bind and disable the tags with a command.

##DEPENDICES##

ESX_LEGACY


##INSTALLATION##

[1] Your gonna need to tweak your es_extended, go into es_extended/server/main.lua, find the loadesxplayer function 

[2] Find mysql.prepare should be line 121 if im correct

[3] Under the ```local result``` paste this there ```local Player = Player(playerId).state```

[4] then scroll down til you see the CreateExtendedPlayer call, right above it paste this code there 

```
Player.firstName = userData.firstname
Player.lastName = userData.lastname
Player.name = ('%s %s'):format(userData.firstname, userData.lastname)
Player.job = jobObject.name
Player.grade = gradeObject.name
```

[5] Now all you need to do is insall the script so just drag and drop Civic_Playertags into your resources folder and start it in your server.cfg . 
