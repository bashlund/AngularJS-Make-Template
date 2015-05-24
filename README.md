#AngularJS-Make-Template
This is a AngularJS stub project using `Make` and `Bash` as building tools (instead of `Grunt` or `Gulp`) and `Bower` as browser package manager.

##Dependencies
###Bash
Comes with your GNU/Linux or OSX distribution.
###GNU Make
Usually preinstalled, install with:
```
sudo apt-get install make
```
###NodeJS
`npm` is needed to install Bower and the optional dependencies, install with:
```
sudo apt-get install nodejs
```
###Bower
```
sudo npm install -g bower
```

##Optional Dependencies
The optional dependencies are in the form of NodeJS packages.
First install NodeJS with:
```
sudo apt-get install nodejs
```

1.  Less Compiler (lessc).

    If you have `.less` files present in your project then `lessc` must be available on your path.
    Install globally using `npm` as:
    ```
    sudo npm install -g less
    ```
2.  JSHint as JavaScript linter.

    If it is available on your path then all JS code will be *linted* when building.
    Install globally using `npm` as:
    ```
    sudo npm install -g jshint
    ```
3.  TmuxNotify

    Install [github.com/thomasbacklund/TmuxNotify](https://github.com/thomasbacklund/TmuxNotify) to have the build status displayed in
    your Tmux status row.
    Tmux-Notify could be used for any other project.

##Install
Clone the AngularJS-Make Git repo:
```
git clone git@github.com/thomasbacklund/AngularJS-Make YourRepoName
```

###Making it into your own Git repo
```
cd YourRepoName
rm -rf .git
```

Replace this `REAMDE.md` file with your own content. Feel free to leave a link to
this original repo.

Edit `bower.json` to reflect your project.

Replace the `LICENSE` file as you feel appropiate.

Then, recreate the git repo and optionally connect it to your github repo.

```
git init
git add .
git add remote origin git@github.com/yourname/YourRepoName
git commit -m 'Initial commit'
git push origin master
```

###Bower packages
Add and modify the package list in the bower.json file as you want.
Some default packages are present. Then install packages:
```
bower install
```
When you add or remove packages with Bower ake sure you then include or remove the javasript and possible CSS references in the `index.html` file.

##How to use
First time make sure you have got all bower packages, as described above.

###Build

To build:
```
make
```

###Serve files
To serve files from the default web server:
```
make serve
```
`make serve` runs the `serve.sh` script to start the default web server serving from the build/ directory. The web server
run is the python `SimpleHTTPServer` on port 8080.
If you want to run another web server, just point it to
the build/ directory.

###Watch for changes
If you want automatic builds when files change in the source directories, run in another terminal window:
```
make watch
```

##Project structure
###ng/
All AngularJS files are to be placed here.
When creating new controllers, directives or factories, consider using the `make` targets for that. Using the make targets are not required in any way and you may create and place files under ng/ as you wish.
All HTML files under ng/ are considered templates and will be put into AngularJS's $templateCache.
All JS files ar concatenated, all Less files are compiled and concateneated with the CSS files.

###common/
Everything under common/ will be grouped (less compiled) and concatenated into the app.js and app.css files.

###static/
Everything under static/ is reachable from the browser as static/

###tools/
In the tools directory the bash scripts called from make are located.
Also the template files for controllers, directives and factories are located here.
You do not need to bother about these files.

###build/
The build goes here. The static/ and bower/ directories are linked into here.

###dist/
A minified distributale version of build/ goes here for `make dist`.

###Add Controller
To add a new NgJS controller run:
`make new-controller module=ModuleName dir=directory name=Name`
```
make new-controller module=NgApp dir=/controllers/main name=MyController
```
Note that /controllers/main directory is relative to ./ng.

###Add Directive
To add a new NgJS directive run:
```
make new-directive module=NgApp dir=/directives name=MyDirective
```
Note that /directives directory is relative to ./ng.

###Add Factory
To add a new NgJS factory run:
```
make new-factory module=NgApp dir=/factories name=MyFactory
```
Note that /factories directory is relative to ./ng.

###Other Providers
You can manually add any kind if NgJS specific file into the ./ng/ directory. The structure
and placement of files is not important. Directive files should be placed together dough.

##Routing and config
See app-config.js for routing and Ng configuration. The contents of app-config.js file is the last to be
concatenated and also the entry into the app when everything else has been loaded.

##Modules
See app-modules.js for adding your modules to the AngularJS runtime.

##Contribute
Feel free to make pull-requests on bug fixes, cross OS fixes or further AngularJS support development.
