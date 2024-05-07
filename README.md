# Flappy 
Un clon de flappy bird que guarda la puntuacion en una tabla dynamodb.

![Gif del juego](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExOWZjamUyMzhjMDF1a2tpZzg4cmtoZHBwYWUydXh4YXU1MzV4M2wxayZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/pIGh4maJKDHArDQTwx/giphy.gif)

En esta version las variables como el usuario y el endpoint de AWS estan hard-coded en res://global/global.gd

La estructura de la tabla esta descrita en LeaderboardTableTemplate.json, que es un template de cloudformation para una tabla en DynamoDB.
