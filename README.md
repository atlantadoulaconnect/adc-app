# Atlanta Doula Connect App

A Flutter application that provides a platform for assigning low-resource pregnant women to volunteer doulas based on the client’s needs and allows for direct, in-app communication between the doulas, clients, and program staff.

## VERSION 1.0 

## Release Notes 

### New Features
_List of features that were implemented since Sprint 3_
- Client/Doula matching interface for admin users
- Local storage persistence
- Settings page where you can edit your application information
- Profile pages for each user type 
- Distinct home pages for user type
- User type-specific menus so that each user will only see relevant functionality 

### Improvements
_List of improvements that were made since Sprint 3_
- Improved doula sign-up applications for selecting availability
- Cancel buttons are now included in both the client and doula applications
- Server side security was improved to only give access to authorized users

### Bug Fixes
_List of bugs that have been fixed since Sprint 3_
- Fixed layout and scrolling problems on messages screen
- Fixed pending applications and unmatched clients from admin view so that they show only relevant applications  
- Fixed the notifications on the admin homepage to show the correct numbers of pending applications of each user type 

### Known Bugs
_List of all known defects that currently exist in the app_
- Not currently storing doulas’ availability in the database 
- Need to fix the recent messages screen to pull from Firebase chats
- In-App Notifications do not fully work yet 

&nbsp;

## Installation Guide

### Pre-Requisites 
_Minimum requirements that are needed to be able to run this application_
1. An Android phone with operating system 5.1 Lollipop (API 22) or later  
      OR an iPhone with operating system iOS 12 or later
2. 100 MB of free storage on your device 

### Dependencies
_List of all the flutter libraries that are used in this app and their download locations_
  #### General Dependencies: 
    flutter:
      sdk: flutter
    firebase_core: 0.4.0+9
    firebase_analytics: ^5.0.2
    firebase_messaging: ^6.0.13

  #### Frontend Specific Dependencies:
    calendarro: ^1.1.2
    url_launcher: ^5.4.2
    intl: ^0.16.1

  #### iOS Style Icons Dependency:
    cupertino_icons: ^0.1.2

  #### Backend Specific Dependencies:
    firebase_auth: 0.15.4
    firebase_database: ^3.1.1
    cloud_firestore: ^0.12.9+5
    cloud_functions: ^0.4.1+1
    async_redux: ^2.5.2
    path_provider: ^1.6.5
    json_annotation: ^3.0.0

  #### Dev Dependencies:
    build_runner: ^1.0.0
    json_serializable: ^3.2.0
    flutter_test:
      sdk: flutter

All of these dependencies can be accessed and downloaded directly through flutter using the `flutter pub get` command 

### Download and Installation Instructions
_Detailed instructions on how to access, download, and install the app for each platform_ 
  #### Android: 
    1. Search “ADC app” on Google Playstore
    2. Click Install
  #### iOS: 
    1. Search “ADC app” on the Apple Store
    2. Click Get

### Running the App
_Instructions on how to run and use the app after downloading and installing_  
  
Just open the app after you install it

### Build Instructions
Not applicable since the app is being delivered through the app store

### Troubleshooting  
_Here are some common errors that you might experience and how you can fix them_
1. If you get an error stating that you do not have enough space on your phone, you need to delete other apps on your device and make space. You could also consider deleting photos or other documents that you have saved elsewhere. 
2. If you get an error stating that your operating system does not meet the minimum requirements for the app, then you will need to update the operating system on your phone. If you are on an iPhone, you will need iOS 12 or later to install this app. On an Android phone, you will need Lollipop (API 22) or later to install this app. 
3. If you run into any bugs or other issues while using this app, there is an option in the app for you to report these bugs using the “Feedback” button. This is available even without having to create an account or log-in to the app. 
