#!/bin/bash

#Dosya ve Dizinleri Oluşturma | Creating files and directories
touch index.js
npm init --yes
npm i express ejs ejs-locals bootstrap jquery morgan cors dotenv helmet
npm i --save-dev nodemon
mkdir public
mkdir views
mkdir controllers && cd controllers && touch homeController.js && cd ..
mkdir routes && cd routes && touch homeRoute.js && cd ..
touch .env
cd public
mkdir lib js css
cd css
touch style.css
cd ../js
touch script.js
cd ../../views
touch layout.ejs
touch index.ejs
touch privacy.ejs
touch 404.ejs
mkdir components
cd components/
touch navbar.ejs
cd ../..

#Paketleri Projeye Yerleştirme | Inserting packages to project
cd public/lib
mkdir bootstrap jquery
cd bootstrap
mkdir css js
cd ../../..
cp node_modules/bootstrap/dist/css/bootstrap.min.css public/lib/bootstrap/css/
cp node_modules/bootstrap/dist/js/bootstrap.bundle.min.js public/lib/bootstrap/js/
cp node_modules/jquery/dist/jquery.min.js public/lib/jquery/

#Dosyaları Düzenleme | Editing created files

echo 'PORT = 8080' > .env

echo 'const express = require("express")
const app = express()
const morgan = require("morgan")
const helmet = require("helmet")
const cors = require("cors")
const engine = require("ejs-locals")
require("dotenv").config()

app.engine("ejs",engine)
app.set("view engine", "ejs")
app.use(express.static("public"))
app.use(morgan("common"))
app.use(helmet())
app.use(cors())

const homeRoute = require("./routes/homeRoute")
app.use("/",homeRoute)

var port = process.env.PORT || 8080
app.listen(port, () => { console.log("Running at port "+port+" | http://localhost:"+port+" | Press Ctrl+C to stop") })' > index.js

cd routes

echo 'const express = require("express")
const router = express.Router()

const homeContollrer = require("../controllers/homeController")
router.get("/privacy", homeContollrer.Privacy)
router.get("/", homeContollrer.Index)
router.get("*", homeContollrer.err404)

module.exports = router' > homeRoute.js

cd ../controllers

echo 'const path = require("path")

const projectDirectory = path.join(__dirname,"../..")
const currentFolderName = path.basename(projectDirectory)

module.exports = {
    Index: (req, res) => {
        res.render("index", {
            pageTitle: "Home Page | " + currentFolderName
        })
    },

    Privacy: (req, res) => {
        res.render("privacy", {
            pageTitle: "Privacy | " + currentFolderName
        })
    },

    err404: (req, res) => {
        res.status(404).render("404",{
            message:"This page does not exist.",
            pageTitle:"Error | " + currentFolderName
        })
    }
}' > homeController.js

cd ../views

echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %></title>
    <link rel="stylesheet" href="/lib/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <%- include components/navbar %>

    <div class="container mt-3">
        <%- body %>
    </div>

</body>
</html>' > layout.ejs

echo '<%- layout("layout") -%>

<div class="text-center mt-3">
    <h1 class="text-primary">This Your Project Page</h1>
    <p>Look at <strong>views/index.ejs </strong>to edit here.</p>
</div>' > index.ejs

echo '<%- layout("layout") -%>

<div class="container mt-3">
    <h1>This is a Privacy Page</h1>
    <p>Place your privacy content here.</p>
</div>' > privacy.ejs

echo '<%- layout("layout") -%>

<div class="container mt-3">
    <h1>Error</h1>
    <hr>
    <p class="text-danger">
        <span class="text-dark">Error Message: </span><%= message %>    
    </p>
</div>' > 404.ejs

cd components/

echo '<nav class="navbar navbar-expand-lg bg-body-tertiary shadow">
  <div class="container">
    <a class="navbar-brand" href="/"><%= pageTitle %></a>
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
</nav>' > navbar.ejs

cd ../..

# Son | Finish

echo 'Project has created without any problems. Write "node index.js" to run or write "nodemon index.js" to run in development mode. | Proje hiç bir sıkıntı çıkmadan oluşturuldu. Çalıştırmak için "node index.js" yaz' 
