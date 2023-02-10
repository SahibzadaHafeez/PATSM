# Personality Assessment Through Social Media (Twitter)
PATSM is a machine learning application for determining a person's Big 5 or O.C.E.A.N personality type based on their twitter profile.

## [Online Demo](https://patsm-76602.web.app)
You can try the live demo of the application on your browser from the above link. Go [here](#how-to-use) for details on how to use the app. Alternatively you can download the project and run it on your own machine.

## How to run
To run the application you'll need the following programs.
 - python 3.8
 - NodeJS
 - android studio
 - flutter

### Python Libraries
 - twint [Install instructions](https://github.com/twintproject/twint)
 - tensorflow
 - sklearn
 - autokeras
 - langid
 - requests_html
 - pandas
 - re

To install all required packages just run the following commands after following the install instructions for twint first.
```bash
git clone --depth=1 https://github.com/SahibzadaHafeez/PATSM
cd PATSM
pip3 install . -r requirements.txt
```

### NodeJS Modules
Navigate to the API folder and run the fllowing commands to install all required node modules.
```bash
npm cache clean --force
npm install
```

### Android Studio & Flutter
To run the project you will need to download and install [Android Studio](https://developer.android.com/studio/install) and [Flutter](https://docs.flutter.dev/get-started/install). Once downloaded and configured according navigate to the folder *\PATSM\FLUTTER\patsm and open it in android studio.

### Run application
To run the application first navigate to *\PATSM\API and run the command `npm .` to start the api server.
Then run the application in flutter to get started.

## How to use
After creating and logging into an account you wil be prompted to enter a twitter username.
![find-twitter-user](https://user-images.githubusercontent.com/42448306/211232088-eba955c4-06ad-4746-a763-d739fe9b82fa.png)

Here you will enter the twitter handle of the profile you want to evaluate.


The application will then begin to go through the user's publically available tweets and determine if the profile is eligible for evaluation. If the profile is eligible then you will be promted to proceed after which the program will begin to evaluate a users personality.

All results are stored in the history tab and can be viewed at any time.

Results can also be updated with manually recorded data that is more accurate, this data is then used to further train the model on newer and more accurate data thus imporoving future results.
