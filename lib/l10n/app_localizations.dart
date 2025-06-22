import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
  ];

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to {app_name}'**
  String signInTitle(Object app_name);

  /// No description provided for @signInEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signInEmail;

  /// No description provided for @signInPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signInPassword;

  /// No description provided for @signInInsertEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email'**
  String get signInInsertEmail;

  /// No description provided for @signInInsertPassword.
  ///
  /// In en, this message translates to:
  /// **'Insert your Password'**
  String get signInInsertPassword;

  /// No description provided for @signInRememberData.
  ///
  /// In en, this message translates to:
  /// **'Remember'**
  String get signInRememberData;

  /// No description provided for @signInForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get signInForgotPassword;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// No description provided for @signInNewUser.
  ///
  /// In en, this message translates to:
  /// **'New to {app_name}'**
  String signInNewUser(Object app_name);

  /// No description provided for @signInLongText.
  ///
  /// In en, this message translates to:
  /// **'Join us to access all the app\'s features and start now your trail!'**
  String get signInLongText;

  /// No description provided for @signInSignUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signInSignUpButton;

  /// No description provided for @signInInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get signInInvalidCredentials;

  /// No description provided for @signInDisabledAccount.
  ///
  /// In en, this message translates to:
  /// **'Your account has been disabled'**
  String get signInDisabledAccount;

  /// No description provided for @signInError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while signing in. Please try again later'**
  String get signInError;

  /// No description provided for @signInGenericError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get signInGenericError;

  /// No description provided for @signInEmailSent.
  ///
  /// In en, this message translates to:
  /// **'If your email is registered, we have sent you an email to reset your password'**
  String get signInEmailSent;

  /// No description provided for @signInEnterEmailToResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to reset your password'**
  String get signInEnterEmailToResetPassword;

  /// No description provided for @validationEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validationEmailRequired;

  /// No description provided for @validationPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validationPasswordRequired;

  /// No description provided for @validationConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm password is required'**
  String get validationConfirmPasswordRequired;

  /// No description provided for @validationPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordsDoNotMatch;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Email is invalid'**
  String get validationEmailInvalid;

  /// No description provided for @registrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up to {app_name}'**
  String registrationTitle(Object app_name);

  /// No description provided for @registrationEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registrationEmail;

  /// No description provided for @registrationInsertEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email'**
  String get registrationInsertEmail;

  /// No description provided for @registrationPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registrationPassword;

  /// No description provided for @registrationInsertPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your Password'**
  String get registrationInsertPassword;

  /// No description provided for @registrationConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get registrationConfirmPassword;

  /// No description provided for @registrationInsertConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your Password'**
  String get registrationInsertConfirmPassword;

  /// No description provided for @registrationButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get registrationButton;

  /// No description provided for @registrationAlreadyUser.
  ///
  /// In en, this message translates to:
  /// **'Already on {app_name}'**
  String registrationAlreadyUser(Object app_name);

  /// No description provided for @registrationLongText.
  ///
  /// In en, this message translates to:
  /// **'Sign in now to get back to exploring the best hiking trails!'**
  String get registrationLongText;

  /// No description provided for @registrationSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get registrationSignInButton;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful! Please sign in to continue'**
  String get registrationSuccess;

  /// No description provided for @registrationAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'You already have an account'**
  String get registrationAlreadyHaveAccount;

  /// No description provided for @registrationWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Your password is too weak. Passwords must be at least 8 characters long'**
  String get registrationWeakPassword;

  /// No description provided for @registrationError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while signing up. Please try again later'**
  String get registrationError;

  /// No description provided for @registrationGenericError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get registrationGenericError;

  /// No description provided for @homeNoTrails.
  ///
  /// In en, this message translates to:
  /// **'No trails found, please change the filters or try again later...'**
  String get homeNoTrails;

  /// No description provided for @homeNoLocation.
  ///
  /// In en, this message translates to:
  /// **'No location available, please enable location services in your device settings'**
  String get homeNoLocation;

  /// No description provided for @homeEasyTrail.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get homeEasyTrail;

  /// No description provided for @homeModerateTrail.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get homeModerateTrail;

  /// No description provided for @homeDemandingTrail.
  ///
  /// In en, this message translates to:
  /// **'Demanding'**
  String get homeDemandingTrail;

  /// No description provided for @homeHardTrail.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get homeHardTrail;

  /// No description provided for @homeExtremeTrail.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get homeExtremeTrail;

  /// No description provided for @homeSurfaceAsphalt.
  ///
  /// In en, this message translates to:
  /// **'Asphalt'**
  String get homeSurfaceAsphalt;

  /// No description provided for @homeSurfaceUnpaved.
  ///
  /// In en, this message translates to:
  /// **'Unpaved'**
  String get homeSurfaceUnpaved;

  /// No description provided for @homeSurfaceGravel.
  ///
  /// In en, this message translates to:
  /// **'Gravel'**
  String get homeSurfaceGravel;

  /// No description provided for @homeSurfaceGround.
  ///
  /// In en, this message translates to:
  /// **'Ground'**
  String get homeSurfaceGround;

  /// No description provided for @homeSurfaceCobblestone.
  ///
  /// In en, this message translates to:
  /// **'Cobblestone'**
  String get homeSurfaceCobblestone;

  /// No description provided for @homeSurfaceRock.
  ///
  /// In en, this message translates to:
  /// **'Rock'**
  String get homeSurfaceRock;

  /// No description provided for @homeSurfaceWood.
  ///
  /// In en, this message translates to:
  /// **'Wood'**
  String get homeSurfaceWood;

  /// No description provided for @homeSurfaceGrass.
  ///
  /// In en, this message translates to:
  /// **'Grass'**
  String get homeSurfaceGrass;

  /// No description provided for @homeSurfaceCompacted.
  ///
  /// In en, this message translates to:
  /// **'Compacted'**
  String get homeSurfaceCompacted;

  /// No description provided for @homeSurfaceSand.
  ///
  /// In en, this message translates to:
  /// **'Sand'**
  String get homeSurfaceSand;

  /// No description provided for @homeDefault.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get homeDefault;

  /// No description provided for @homeCharging.
  ///
  /// In en, this message translates to:
  /// **'Loading trails...'**
  String get homeCharging;

  /// No description provided for @homeFilterPosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get homeFilterPosition;

  /// No description provided for @homeFilterEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get homeFilterEasy;

  /// No description provided for @homeFilterModerate.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get homeFilterModerate;

  /// No description provided for @homeFilterHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get homeFilterHard;

  /// No description provided for @homeFilterExtreme.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get homeFilterExtreme;

  /// No description provided for @homeFilterRoad.
  ///
  /// In en, this message translates to:
  /// **'Road'**
  String get homeFilterRoad;

  /// No description provided for @homeFilterPedestrian.
  ///
  /// In en, this message translates to:
  /// **'Pedestrian'**
  String get homeFilterPedestrian;

  /// No description provided for @homeFilterCycleway.
  ///
  /// In en, this message translates to:
  /// **'Cycleway'**
  String get homeFilterCycleway;

  /// No description provided for @homeFilterTrail.
  ///
  /// In en, this message translates to:
  /// **'Trail'**
  String get homeFilterTrail;

  /// No description provided for @homeSearchBarHint.
  ///
  /// In en, this message translates to:
  /// **'Search for locations'**
  String get homeSearchBarHint;

  /// No description provided for @homeSearchError.
  ///
  /// In en, this message translates to:
  /// **'Place not found, please try another search'**
  String get homeSearchError;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'App settings'**
  String get settingsTitle;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferences;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark or Light Theme'**
  String get settingsTheme;

  /// No description provided for @settingsFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get settingsFavorites;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @settingsSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get settingsSignOut;

  /// No description provided for @settingData.
  ///
  /// In en, this message translates to:
  /// **'My Data'**
  String get settingData;

  /// No description provided for @settingsChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get settingsChangeEmail;

  /// No description provided for @settingsChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get settingsChangePassword;

  /// No description provided for @settingsSafety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get settingsSafety;

  /// No description provided for @settingsMountainSafety.
  ///
  /// In en, this message translates to:
  /// **'Mountain Safety'**
  String get settingsMountainSafety;

  /// No description provided for @settingsForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get settingsForgotPassword;

  /// No description provided for @settingsForgotPassworQuestion.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get settingsForgotPassworQuestion;

  /// No description provided for @settingsForgotPasswordText.
  ///
  /// In en, this message translates to:
  /// **'If you click continue, you will be redirected to the login page where you can press \"forgot password\"'**
  String get settingsForgotPasswordText;

  /// No description provided for @settingsForgotPasswordContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get settingsForgotPasswordContinue;

  /// No description provided for @settingsForgotPasswordCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsForgotPasswordCancel;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteAccountText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get settingsDeleteAccountText;

  /// No description provided for @settingsDeleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get settingsDeleteAccountConfirm;

  /// No description provided for @settingsDeleteAccountCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsDeleteAccountCancel;

  /// No description provided for @settingsNewEmail.
  ///
  /// In en, this message translates to:
  /// **'New Email'**
  String get settingsNewEmail;

  /// No description provided for @settingsCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get settingsCurrentPassword;

  /// No description provided for @settingsEmailUpdated.
  ///
  /// In en, this message translates to:
  /// **'Email updated successfully'**
  String get settingsEmailUpdated;

  /// No description provided for @settingsNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get settingsNewPassword;

  /// No description provided for @settingsChangeEmailCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsChangeEmailCancel;

  /// No description provided for @settingsChangeEmailConfirm.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsChangeEmailConfirm;

  /// No description provided for @settingsChangePasswordCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settingsChangePasswordCancel;

  /// No description provided for @settingsChangePasswordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsChangePasswordConfirm;

  /// No description provided for @settingsNoApp.
  ///
  /// In en, this message translates to:
  /// **'No app found to open the link.'**
  String get settingsNoApp;

  /// No description provided for @settingsDeleteAccountError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while deleting your account. Please try again later'**
  String get settingsDeleteAccountError;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get profileTitle;

  /// No description provided for @profileTrails.
  ///
  /// In en, this message translates to:
  /// **'Completed trails:'**
  String get profileTrails;

  /// No description provided for @profileFolders.
  ///
  /// In en, this message translates to:
  /// **'Your folders:'**
  String get profileFolders;

  /// No description provided for @trailDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trail details'**
  String get trailDetailsTitle;

  /// No description provided for @trailDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start exploring {trail_name}!'**
  String trailDetailsSubtitle(Object trail_name);

  /// No description provided for @trailDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'Description:'**
  String get trailDetailsDescription;

  /// No description provided for @trailDetailsLenght.
  ///
  /// In en, this message translates to:
  /// **'Length: {unit} m'**
  String trailDetailsLenght(Object unit);

  /// No description provided for @trailDetailsGrade.
  ///
  /// In en, this message translates to:
  /// **'Grade: {unit}'**
  String trailDetailsGrade(Object unit);

  /// No description provided for @trailDetailsSurface.
  ///
  /// In en, this message translates to:
  /// **'Surface: {unit}'**
  String trailDetailsSurface(Object unit);

  /// No description provided for @trailDetailsType.
  ///
  /// In en, this message translates to:
  /// **'Type: {unit}'**
  String trailDetailsType(Object unit);

  /// No description provided for @trailDetailsLoopYes.
  ///
  /// In en, this message translates to:
  /// **'This trail is a loop'**
  String get trailDetailsLoopYes;

  /// No description provided for @trailDetailsLoopNo.
  ///
  /// In en, this message translates to:
  /// **'This trail is not a loop'**
  String get trailDetailsLoopNo;

  /// No description provided for @trailDetailsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get trailDetailsSave;

  /// No description provided for @trailDetailsAlertText.
  ///
  /// In en, this message translates to:
  /// **'Select one or more folders:'**
  String get trailDetailsAlertText;

  /// No description provided for @trailDetailsAlertSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get trailDetailsAlertSave;

  /// No description provided for @trailDetailsAlertCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get trailDetailsAlertCancel;

  /// No description provided for @trailSelectFolder.
  ///
  /// In en, this message translates to:
  /// **'Select at least one folder to save the trail'**
  String get trailSelectFolder;

  /// No description provided for @trailStartTrail.
  ///
  /// In en, this message translates to:
  /// **'Directions to start'**
  String get trailStartTrail;

  /// No description provided for @trailCantOpenGoogleMaps.
  ///
  /// In en, this message translates to:
  /// **'Can\'t open Google Maps'**
  String get trailCantOpenGoogleMaps;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to {app_name}'**
  String welcomeTitle(Object app_name);

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore the Great Outdoors!'**
  String get welcomeSubtitle;

  /// No description provided for @welcomeText.
  ///
  /// In en, this message translates to:
  /// **'Discover the best hiking trails around you. Join our community of outdoor enthusiasts and start your adventure today!'**
  String get welcomeText;

  /// No description provided for @welcomeSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get welcomeSignInButton;

  /// No description provided for @welcomeSignUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get welcomeSignUpButton;

  /// No description provided for @editFolderTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Folder'**
  String get editFolderTitle;

  /// No description provided for @editFolderCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get editFolderCamera;

  /// No description provided for @editFolderGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get editFolderGallery;

  /// No description provided for @editFolderNameFolder.
  ///
  /// In en, this message translates to:
  /// **'Folder Name'**
  String get editFolderNameFolder;

  /// No description provided for @editFolderInsertName.
  ///
  /// In en, this message translates to:
  /// **'Enter folder name'**
  String get editFolderInsertName;

  /// No description provided for @editFolderSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get editFolderSave;

  /// No description provided for @editFolderName.
  ///
  /// In en, this message translates to:
  /// **'Edit {folder_name}'**
  String editFolderName(Object folder_name);

  /// No description provided for @editFolderEmptyName.
  ///
  /// In en, this message translates to:
  /// **'Folder name cannot be empty'**
  String get editFolderEmptyName;

  /// No description provided for @folderTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Folders'**
  String get folderTitle;

  /// No description provided for @folderDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm deletion?'**
  String get folderDelete;

  /// No description provided for @folderDeleteText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this folder? This action cannot be undone.'**
  String get folderDeleteText;

  /// No description provided for @folderDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get folderDeleteConfirm;

  /// No description provided for @folderDeleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get folderDeleteCancel;

  /// No description provided for @folderEmpty.
  ///
  /// In en, this message translates to:
  /// **'No folders available, create one to save your favorite trails!'**
  String get folderEmpty;

  /// No description provided for @folderDitails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get folderDitails;

  /// No description provided for @folderComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get folderComplete;

  /// No description provided for @folderDeleteTrail.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this trail from the folder? This action cannot be undone.'**
  String get folderDeleteTrail;

  /// No description provided for @folderRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get folderRemove;

  /// No description provided for @folderYourTrails.
  ///
  /// In en, this message translates to:
  /// **'Saved Trails:'**
  String get folderYourTrails;

  /// No description provided for @imagePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get imagePickerTitle;

  /// No description provided for @imagePickerNoCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera not available'**
  String get imagePickerNoCamera;

  /// No description provided for @profileCharge.
  ///
  /// In en, this message translates to:
  /// **'Loading profile...'**
  String get profileCharge;

  /// No description provided for @profileError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading your profile. Please try again later'**
  String get profileError;

  /// No description provided for @profileWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {user_name}!'**
  String profileWelcome(Object user_name);

  /// No description provided for @profileTrailError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading your trails. Please try again later'**
  String get profileTrailError;

  /// No description provided for @profileTrailEmpty.
  ///
  /// In en, this message translates to:
  /// **'No trails found, start exploring now!'**
  String get profileTrailEmpty;

  /// No description provided for @profileFolderError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading your folders. Please try again later'**
  String get profileFolderError;

  /// No description provided for @profileNewFolder.
  ///
  /// In en, this message translates to:
  /// **'Create a new folder'**
  String get profileNewFolder;

  /// No description provided for @profileFolderName.
  ///
  /// In en, this message translates to:
  /// **'Folder Name'**
  String get profileFolderName;

  /// No description provided for @profileCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileCancel;

  /// No description provided for @profileCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get profileCreate;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
