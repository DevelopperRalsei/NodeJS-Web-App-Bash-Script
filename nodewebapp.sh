#!/bin/bash

#Dosya ve Dizinleri Oluşturma
touch app.js
npm init --yes
npm i express ejs bootstrap jquery
mkdir public
mkdir views
cd public
mkdir lib js css
cd css
touch style.css
cd ../js
touch script.js
cd ../../views
touch index.ejs
mkdir partials
cd partials
touch _header.ejs _footer.ejs
cd ../..

#Paketleri Projeye Yerleştirme
cd public/lib
mkdir bootstrap jquery
cd bootstrap
mkdir css js
cd ../../..
cp node_modules/bootstrap/dist/css/bootstrap.min.css public/lib/bootstrap/css/
cp node_modules/bootstrap/dist/js/bootstrap.bundle.min.js public/lib/bootstrap/js/
cp node_modules/jquery/dist/jquery.min.js public/lib/jquery/

#Dosyaları Düzenleme
echo 'var express = require("express")
var app = express()

app.set("view engine","ejs")
app.use(express.static("public"))

app.get("/",(req,res)=>{res.render("index",{pageTitle:"Ana Sayfa"})})

var port = 3000
app.listen(port,()=>{console.log("Proje "+port+" portu altında çalışıyor | http://127.0.0.1:"+port+" <- Buna Tıklayarak projene bakabilirsin. <3")})' >> app.js

cd views

echo '<%- include("partials/_header") %>
    

<%- include("partials/_footer") %>' >> index.ejs

cd partials

echo '    <script src="/lib/jquery/jquery.min.js"></script>
    <script src="/lib/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/js/script.js"></script>
</body>
</html>' >> _footer.ejs

echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %></title>
    <link rel="stylesheet" href="/lib/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>' >> _header.ejs

cd ../..



