#!/bin/bash

touch app.js
npm init --yes
npm i express ejs
mkdir public
cd public
mkdir css
mkdir js
mkdir lib
cd ..
mkdir views
cd views
touch index.ejs
cd ..

echo 'var express = require("express")
var app = express()

app.set("view engine","ejs")
app.use(express.static("public"))

app.get("/",(req,res)=>{res.render("index",{pageTitle:"Ana Sayfa"})})


var port = 3000
app.listen(port,()=>{console.log(`Proje ${port} portu altında çalışıyor | http://127.0.0.1:${port}`)})' >> app.js

cd views
echo '<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %></title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <h1>
        NodeJS Web Projesi Oluşturma Scripti Başarıyla Çalıştı
    </h1>
    <script src="/js/script.js"></script>
</body>
</html>' >> index.ejs
cd ..
cd public/css/
touch style.css
cd ..
cd js/
touch script.js
cd ..
