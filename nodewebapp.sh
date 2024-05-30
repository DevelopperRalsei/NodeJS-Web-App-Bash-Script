#!/bin/bash

#Dosya ve Dizinleri Oluşturma
touch index.js
npm init --yes
npm i express ejs bootstrap jquery morgan
npm i --save-dev nodemon
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
touch privacy.ejs
touch 404.ejs
mkdir partials
cd partials
touch _header.ejs _footer.ejs
cd ../
mkdir components
cd components/
touch navbar.ejs
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
echo 'const express = require("express")
const app = express()
const path = require("path")
const morgan = require("morgan")

const currentDir = __dirname
const currentFolderName = path.basename(currentDir)

app.set("view engine", "ejs")
app.use(express.static("public"))
app.use(morgan("common"))

app.get("/privacy", (req, res) => {
    res.render("privacy", {
        pageTitle: "Privacy | " + currentFolderName
    })
})

app.get("/", (req, res) => {
    res.render("index", {
        pageTitle: "Home Page | " + currentFolderName
    })
})

app.get("*", (req, res) => {
    res.status(404).render("404",{
        message:"This page does not exist.",
        pageTitle:"Error | " + currentFolderName
    })
})

var port = 3000 || process.env.PORT
app.listen(port, () => { console.log("Running at port "+port+" | Press Ctrl+C to stop") })
' >> index.js

cd views

echo '<%- include("partials/_header") %>

<%- include("components/navbar") %>

<div class="text-center mt-3">
    <h1 class="text-primary">This Your Project Page</h1>
    <p>Look at <strong>views/index.ejs </strong>to edit here.</p>
</div>

<%- include("partials/_footer") %>
' >> index.ejs

echo '<%- include("partials/_header") %>
<%- include("components/navbar") %>

<div class="container mt-3">
    <h1>This is a Privacy Page</h1>
    <p>Place your privacy content here.</p>
</div>
<%- include("partials/_footer") %>' >> privacy.ejs

echo '<%- include("partials/_header") %>
<%- include("components/navbar") %>

<div class="container mt-3">
    <h1>Error</h1>
    <hr>
    <p class="text-danger">
        <span class="text-dark">Error Message: </span><%= message %>    
    </p>
</div>

<%- include("partials/_footer") %>' >> 404.ejs

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

cd ../components

echo '<nav class="navbar navbar-expand-lg bg-body-tertiary shadow">
  <div class="container">
    <a class="navbar-brand" href="/">Node Web App</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" aria-current="page" href="/">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/privacy">Privacy</a>
        </li>
        <li class="nav-item">
          <a href="/error" class="nav-link">Error Page</a>
        </li>
    </div>
  </div>
</nav>' >> navbar.ejs

cd ../..

echo 'Project has created without any problems. Write "node index.js" to run or write "nodemon index.js" to run in development mode. | Proje hiç bir sıkıntı çıkmadan oluşturuldu. Çalıştırmak için "node index.js" ya da geliştirme modunda çalıştırmak için "nodemon index.js" yaz' 

