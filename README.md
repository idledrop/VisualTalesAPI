# Visual Tales
A web platform to build your stories in a visual novel style manner.

## Contributors
Jon Craig - [jonnydevlive](https://github.com/jonnydevlive)  
Joshua Livesay - [joshualivesay](https://github.com/joshualivesay)  
David Fuka - [graveto](https://github.com/graveto)  
Vinicio Del Toro - [viniciodeltoro](https://github.com/viniciodeltoro)  
Ted Martinez - [tedma4](https://github.com/tedma4)  
Polo Santiago - [polosantiago](https://github.com/polosantiago)  
Rene Martinez - [rnemtz](https://github.com/rnemtz)  
Mark Davis - [mdavisJr](https://github.com/mdavisJr)  

## Inspiration
Japanese developers have been creating vivid experiences using visual novels for what seems like forever now. It's a powerful way to tell stories that uses the readers imagination with visual effects that allows you to say more with less.j

## Environment Setup
bundle install

Install ImageMagick
$ brew install imagemagick

### Install MYSQL
$ brew install mysql
$ mysql.server restart
$ mysql_secure_installation
 - Set the root password to 1234
$ rake db:setup

## Application Setup
npm install
npm install gulp

## Starting the application
rails server  
gulp

## Page and NPM errors
If you run into problems with the views or npm install do this
$ rm -fr node_modules
$ npm cache clear
$ npm install
