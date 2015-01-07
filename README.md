About
=====

This plugin makes it easy to track app events from a Cordova or Phonegap app.

Installing
==========

The plugin can be installed using the following command:

```sh
$ cordova plugin add https://github.com/brightin/cordova-fb-conversion-plugin.git
```


Facebook API
============

When the plugin is installed, it requires the facebook library to be linked with the application.
Use relevant platform guides to add the android / iOS Facebook SDK to the respective platforms.

iOS
---

For iOS, this involves downloading the Facebook SDK and adding the installed FacebookSDK.framework
folder to the list of frameworks in the auto-generated cordova XCode project.

Android
-------

For Android, download the Facebook SDK and add an extra library reference for the Cordova generated Android project
(either using Eclipse, or by manually adding a line to project.properties - e.g. 'android.library.reference.2=/your/path/to/the/facebook/SDK')
