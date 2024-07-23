# NutriMate

NutriMate is a comprehensive application designed to streamline grocery shopping. This software offers a suite of tools to enhance the user's shopping experience and optimize product selection.

## Key Features

1. **Shopping Checklist**: efficiently create and manage your shopping lists.

2. **Barcode Scanner**: rapidly add products to your list by scanning their barcodes.

3. **Nearby Supermarkets**: identify and navigate to nearby supermarkets.

4. **Product Catalogue**: access an extensive database of products, searchable for easy addition to your list.

## Installation

The NutriMate repository is created and curated by following GitHub best practices. Since a Google Maps API (comprehensive of Places API) is required to make the Nearby Supermarkets feature functional, the following rules must be followed: 
- A .env file must be added to the root folder of the project. This file must contain the variable MAPS_API_KEY. In this section, please provide your API key
- A reference to the .env file must be added (or uncommented, if found) in the asset section of the pubspec.yaml file
- Commented code in the lib/widgets/supermarkets.dart file must be uncommented
- Commented code in the main.dart needed for the .env loading must be uncommented

Project-needed dependencies must be downloaded by running `flutter pub get` (mandatory).

Further actions based on running environment: 

- **Web version:** include your Google Maps API key in the web/index.html file

- **Android version:** include your Google Maps API key in the android/app/scr/main/AndroidManifest.xml file. Run in debug mode by connecting your phone via adb or get the apk by running `flutter build apk`. Finally, install the apk on your chosen Android device.

## Execution

On your machine, for the web version, run `flutter run -d yourbrowser --web-browser-flag "--disable-web-security"`. 

The `--disable-web-security` flag is needed to avoid CORS related errors.

On Android, simply run the installed app.

## Copyright
Copyright © 2024 NutriMate. All rights reserved.

This software and its documentation are protected by copyright law. Unauthorized reproduction or distribution of this software, or any portion of it, may infringe upon these rights.  
