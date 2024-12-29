# ✍️ Notes - A simple note-taking Android app

Welcome! _Notes_ is a simple but effective app for taking plain text notes and making check lists, developed and currently maintained by [Rova](https://github.com/rovati).</br>
It started as a little playground to learn a new dev framework but quickly evolved into the desire to create a meaningful product. <br>
Apps these days tend to offer an elaborate set of features, at the cost of asking the user for many permissions. _Notes_ takes the opposite approach: it carefully picks a small set of essential features so that the user does not have to worry about security and privacy related issues. Your data is yours to keep.

## 📲 How to install it
[<img src="resources/readme_imgs/IzzyOnDroid.png" width="170">](https://apt.izzysoft.de/fdroid/index/apk/dev.rova.notes/)

Due to costs, the app is not available on any of the mainstream app platforms (namely Apple AppStore and Google Play). It is only possible to obtain the app for Android through this GitHub repository or [IzzyOnDroid's F-Droid repo](https://apt.izzysoft.de/fdroid/index/apk/dev.rova.notes/).<br>
To install it, head over to the [Releases](https://github.com/rovati/noteapp/releases) section and download the most recent version. Each release offers an apk for the three main mobile architectures (and a fat apk compatible with any of those three architectures, if you are unsure which one your phone is built on). Download the right one for your phone and simply tap on the file to install the app. Voilà, everything is ready to go!

> [!IMPORTANT]
> For security reasons, Android phones do not allow the installation of apk files from untrusted sources, i.e. the internet. If the installation of the apk is blocked, please look up a guide for your operative system on how to disable this rule.

> [!NOTE]
> IzzyOnDroid's repo only offers the arm6-v8a build.

## 📖 What it can do
Ok, the app is installed. But actually... what can it do?<br>

The app is equipped with a toolbar on the bottom right of the screen, use it to create new notes or to head over to the settings page (a reminder text is shown when no notes exist). On the main page you can access the full list of your notes. You can open them by tapping their tile or delete them by swiping left on them. Moreover, you can pin them at the top of the list by long pressing on them.<br>

<p align="center">
  <img src="https://github.com/rovati/noteapp/blob/main/resources/readme_imgs/v3-1-0/homescreen_empty.png" width="200" title="Empty Home Page">
  <img src="https://github.com/rovati/noteapp/blob/main/resources/readme_imgs/v3-1-0/homescreen.png" width="200" title="Home Page">
<p>

There currently are two types of notes: plaintext notes and checklists. Plaintext notes are simple notes with a title and body you can write on. Checklists are notes with a title and groups of elements. Each element can contain a short text and can be marked as completed.<br>

> [!NOTE]
>  Please refer to [this section](#a-complete-guide-to-checklists) for a full description of how to use checklists at their best.

<p align="center">
  <img src="https://github.com/rovati/noteapp/blob/main/resources/readme_imgs/v3-1-0/plaintext.png" width="200" title="Plaintext Note">
  <img src="https://github.com/rovati/noteapp/blob/main/resources/readme_imgs/v3-1-0/checklist.png" width="200" title="Checklist Note">
<p>

Through the settings page it is possible to select the theme of the app. The app currently offers a short selection of predefined themes, including a couple dark ones for the lovers of low brightness and high contrast. In this page it is also possible to find useful links and info.<br>

<p align="center">
  <img src="https://github.com/rovati/noteapp/blob/main/resources/readme_imgs/v3-1-0/settings.png" width="200" title="Settings Page">
</p>


Lastly, the toolbar is equipped with a button for saving locally a zipped version of the notes, so that they can be exported in text format. This functionality is under revision since it is not consistent with its desired behaviour.

## ⚙️ How it is implemented
The project is fully implemented in [Dart](https://dart.dev/) using the [Flutter](https://flutter.dev/) framework. This choice was based solely on personal interest, but it empowers the project with the possibility of easily extending the ecosystem with clients for various platforms.

> [!NOTE]
> Want to contribute? Feel free to contact [Rova](https://github.com/rovati) to introduce yourself and get more info about the project!

## 🚀 Roadmap

⚪ ✅ Version 1\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Plaintext notes\
⬇️ \
⚪ ✅ Version 2\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Checklist notes\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Pin/unpin system \
⬇️\
⚪ ✅ Recovery update\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Recovery from failure on notes loading\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Export notes in text format\
⬇️\
⚪ ✅ Colorful update\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Color themes\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ New toolbar\
⬇️\
⚪ ✅ Checklist overhaul\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Groups in checklists\
⬇️\
⚪ 🔜 Zippy update\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Improve notes export system\
⬇️\
⚪ ⏸️ Beauty update\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ UI improvements\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Animations\
⬇️\
⚪ ⏸️ Tidy update\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Rework of part of the codebase\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Extend checklist keyboard functionalities\
⬇️\
⚪ ⏸️ Sync update\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Accounts\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Cloud save of notes\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ Multi-device sync\
⬇️\
⚪ ⏸️ Web client\
⬇️ &nbsp;&nbsp;&nbsp;&nbsp;↘️ _Notes_ web-app\
⬇️\
⚪ ❓\
⬇️\
⚪ 🏁


## ©️ Licensing and forking
[![GPL Licence](https://badges.frapsoft.com/os/gpl/gpl.png?v=103)](https://opensource.org/licenses/GPL-3.0/)

This project is and always will be open-source and non-profit. The project is released under [GNU General Public License v3.0](LICENSE). Feel free to fork it or download it for personal use. If you modify it we would really appreciate you mentioning all the current contributors on this project.

## 🗺️ Navigating the repo
Starting from version 3 of the Android app it has been decided to revisit the organization of the repo. It is possible to access old code of the Android app through an "archive" branch [android-prev-versions](https://github.com/rovati/noteapp/tree/android-prev-versions). The currrent development of the Android app is found in the branch [android-app](https://github.com/rovati/noteapp/tree/android_app) while the _main_ branch contains code for the latest stable version released.

## ✏️ Final comments

#### Bugs and new features
You can report bugs or request features [here](https://github.com/rovati/notesapp/issues).

#### A complete guide to checklists
- New checklists are created containing an empty group.
- You can change the checklist title the same way as plaintext notes.
- You can change a group name by tapping on its name.
- To add a new unchecked element tap on "add element" of the corresponding group.
- To add a new empty group tap on "add group".
- To change the content of an element, tap on its content **when unchecked**. It is not possible to change the content of a checked element (it is necessary to uncheck it and then modify it).
- To delete a group slide left over its name or its unchecked items.
- To mark an element as completed tap on its empty checkbox.
- To mark an element as not completed tap on its checked box.
- To delete an element slide left on it **if it is already checked**. Unchecked elements cannot be deleted.
- To collapse/uncollapse the list of checked elements of a group, tap on the separator line.
