#!/bin/bash
#this script is going to start a react application from scratch
mkdir my-app
cd my-app
#
echo "starting npm in our current folder"
#
npm init -y
npm i webpack babel-loader @babel/preset-react @babel/core babel-preset-react html-webpack-plugin webpack-dev-server css-loader style-loader @babel/plugin-proposal-class-properties webpack-cli -D && npm i react react-dom -S
#
echo "making a source folder and change directory to that folder"
#
mkdir src && cd  src
#
echo "creating a html file inside /src"
#
echo '<!doctype html>
<html lang="en">
<head>
 <meta charset="utf-8">
 <title>My React App from Scratch</title>
</head>
<body>
 <div id="app"></div>
</body>
</html>' >>  index.html
#
echo "creating a js file inside of /src"
#
echo 'import ReactDOM from "react-dom";
import React from "react";
const App = () => {
 return <h1>This is my React app!</h1>;
 }
ReactDOM.render(<App />, document.getElementById("app"));' >> index.js
#
echo "configuring webpack and babel"
#
cd ..
echo 'const HtmlWebPackPlugin = require("html-webpack-plugin");
const htmlPlugin = new HtmlWebPackPlugin({
 template: "./src/index.html",
 filename: "./index.html"
});
module.exports = {
mode: "development",
  module: {
    rules: [{
   test: /\.js$/,
   exclude: /node_modules/,
   use: {
     loader: "babel-loader"
   }
 },
  {
   test: /\.css$/,
   use: ["style-loader", "css-loader"]
  }
]},
 plugins: [htmlPlugin]
};' >> webpack.config.js
####
echo '{
    "presets": ["@babel/preset-react"],
    "plugins": ["@babel/plugin-proposal-class-properties"]
}' >> .babelrc
#
echo "Adding some script to package.json"
#
line=8
text=',"start": "webpack serve --config webpack.config.js"'
sed -i "$line i \ $text" package.json

echo "All done!"
echo "you can use npm run start"
echo "your local host should be at http://localhost:8080/"
echo "Happy Coding!"

