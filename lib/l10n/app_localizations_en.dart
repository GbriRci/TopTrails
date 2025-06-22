// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String signInTitle(Object app_name) {
    return 'Sign in to $app_name';
  }

  @override
  String get signInEmail => 'Email';

  @override
  String get signInPassword => 'Password';

  @override
  String get signInInsertEmail => 'Enter your Email';

  @override
  String get signInInsertPassword => 'Insert your Password';

  @override
  String get signInRememberData => 'Remember';

  @override
  String get signInForgotPassword => 'Forgot password?';

  @override
  String get signInButton => 'Sign In';

  @override
  String signInNewUser(Object app_name) {
    return 'New to $app_name';
  }

  @override
  String get signInLongText =>
      'Join us to access all the app\'s features and start now your trail!';

  @override
  String get signInSignUpButton => 'Sign Up';

  @override
  String get signInInvalidCredentials => 'Invalid email or password';

  @override
  String get signInDisabledAccount => 'Your account has been disabled';

  @override
  String get signInError =>
      'An error occurred while signing in. Please try again later';

  @override
  String get signInGenericError => 'An error occurred';

  @override
  String get signInEmailSent =>
      'If your email is registered, we have sent you an email to reset your password';

  @override
  String get signInEnterEmailToResetPassword =>
      'Enter your email to reset your password';

  @override
  String get validationEmailRequired => 'Email is required';

  @override
  String get validationPasswordRequired => 'Password is required';

  @override
  String get validationConfirmPasswordRequired =>
      'Confirm password is required';

  @override
  String get validationPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get validationEmailInvalid => 'Email is invalid';

  @override
  String registrationTitle(Object app_name) {
    return 'Sign up to $app_name';
  }

  @override
  String get registrationEmail => 'Email';

  @override
  String get registrationInsertEmail => 'Enter your Email';

  @override
  String get registrationPassword => 'Password';

  @override
  String get registrationInsertPassword => 'Enter your Password';

  @override
  String get registrationConfirmPassword => 'Confirm Password';

  @override
  String get registrationInsertConfirmPassword => 'Confirm your Password';

  @override
  String get registrationButton => 'Sign Up';

  @override
  String registrationAlreadyUser(Object app_name) {
    return 'Already on $app_name';
  }

  @override
  String get registrationLongText =>
      'Sign in now to get back to exploring the best hiking trails!';

  @override
  String get registrationSignInButton => 'Sign In';

  @override
  String get registrationSuccess =>
      'Registration successful! Please sign in to continue';

  @override
  String get registrationAlreadyHaveAccount => 'You already have an account';

  @override
  String get registrationWeakPassword =>
      'Your password is too weak. Passwords must be at least 8 characters long';

  @override
  String get registrationError =>
      'An error occurred while signing up. Please try again later';

  @override
  String get registrationGenericError => 'An error occurred';

  @override
  String get homeNoTrails =>
      'No trails found, please change the filters or try again later...';

  @override
  String get homeNoLocation =>
      'No location available, please enable location services in your device settings';

  @override
  String get homeEasyTrail => 'Easy';

  @override
  String get homeModerateTrail => 'Medium';

  @override
  String get homeDemandingTrail => 'Demanding';

  @override
  String get homeHardTrail => 'Hard';

  @override
  String get homeExtremeTrail => 'Extreme';

  @override
  String get homeSurfaceAsphalt => 'Asphalt';

  @override
  String get homeSurfaceUnpaved => 'Unpaved';

  @override
  String get homeSurfaceGravel => 'Gravel';

  @override
  String get homeSurfaceGround => 'Ground';

  @override
  String get homeSurfaceCobblestone => 'Cobblestone';

  @override
  String get homeSurfaceRock => 'Rock';

  @override
  String get homeSurfaceWood => 'Wood';

  @override
  String get homeSurfaceGrass => 'Grass';

  @override
  String get homeSurfaceCompacted => 'Compacted';

  @override
  String get homeSurfaceSand => 'Sand';

  @override
  String get homeDefault => 'Not specified';

  @override
  String get homeCharging => 'Loading trails...';

  @override
  String get homeFilterPosition => 'Position';

  @override
  String get homeFilterEasy => 'Easy';

  @override
  String get homeFilterModerate => 'Medium';

  @override
  String get homeFilterHard => 'Hard';

  @override
  String get homeFilterExtreme => 'Extreme';

  @override
  String get homeFilterRoad => 'Road';

  @override
  String get homeFilterPedestrian => 'Pedestrian';

  @override
  String get homeFilterCycleway => 'Cycleway';

  @override
  String get homeFilterTrail => 'Trail';

  @override
  String get homeSearchBarHint => 'Search for locations';

  @override
  String get homeSearchError => 'Place not found, please try another search';

  @override
  String get settingsTitle => 'App settings';

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get settingsTheme => 'Dark or Light Theme';

  @override
  String get settingsFavorites => 'Favorites';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsSignOut => 'Sign Out';

  @override
  String get settingData => 'My Data';

  @override
  String get settingsChangeEmail => 'Change Email';

  @override
  String get settingsChangePassword => 'Change Password';

  @override
  String get settingsSafety => 'Safety';

  @override
  String get settingsMountainSafety => 'Mountain Safety';

  @override
  String get settingsForgotPassword => 'Forgot Password';

  @override
  String get settingsForgotPassworQuestion => 'Forgot your password?';

  @override
  String get settingsForgotPasswordText =>
      'If you click continue, you will be redirected to the login page where you can press \"forgot password\"';

  @override
  String get settingsForgotPasswordContinue => 'Continue';

  @override
  String get settingsForgotPasswordCancel => 'Cancel';

  @override
  String get settingsDeleteAccount => 'Delete Account';

  @override
  String get settingsDeleteAccountText =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get settingsDeleteAccountConfirm => 'Confirm';

  @override
  String get settingsDeleteAccountCancel => 'Cancel';

  @override
  String get settingsNewEmail => 'New Email';

  @override
  String get settingsCurrentPassword => 'Current Password';

  @override
  String get settingsEmailUpdated => 'Email updated successfully';

  @override
  String get settingsNewPassword => 'New Password';

  @override
  String get settingsChangeEmailCancel => 'Cancel';

  @override
  String get settingsChangeEmailConfirm => 'Save';

  @override
  String get settingsChangePasswordCancel => 'Cancel';

  @override
  String get settingsChangePasswordConfirm => 'Save';

  @override
  String get settingsNoApp => 'No app found to open the link.';

  @override
  String get settingsDeleteAccountError =>
      'An error occurred while deleting your account. Please try again later';

  @override
  String get profileTitle => 'Your profile';

  @override
  String get profileTrails => 'Completed trails:';

  @override
  String get profileFolders => 'Your folders:';

  @override
  String get trailDetailsTitle => 'Trail details';

  @override
  String trailDetailsSubtitle(Object trail_name) {
    return 'Start exploring $trail_name!';
  }

  @override
  String get trailDetailsDescription => 'Description:';

  @override
  String trailDetailsLenght(Object unit) {
    return 'Length: $unit m';
  }

  @override
  String trailDetailsGrade(Object unit) {
    return 'Grade: $unit';
  }

  @override
  String trailDetailsSurface(Object unit) {
    return 'Surface: $unit';
  }

  @override
  String trailDetailsType(Object unit) {
    return 'Type: $unit';
  }

  @override
  String get trailDetailsLoopYes => 'This trail is a loop';

  @override
  String get trailDetailsLoopNo => 'This trail is not a loop';

  @override
  String get trailDetailsSave => 'Save';

  @override
  String get trailDetailsAlertText => 'Select one or more folders:';

  @override
  String get trailDetailsAlertSave => 'Save';

  @override
  String get trailDetailsAlertCancel => 'Cancel';

  @override
  String get trailSelectFolder =>
      'Select at least one folder to save the trail';

  @override
  String get trailStartTrail => 'Directions to start';

  @override
  String get trailCantOpenGoogleMaps => 'Can\'t open Google Maps';

  @override
  String welcomeTitle(Object app_name) {
    return 'Welcome to $app_name';
  }

  @override
  String get welcomeSubtitle => 'Explore the Great Outdoors!';

  @override
  String get welcomeText =>
      'Discover the best hiking trails around you. Join our community of outdoor enthusiasts and start your adventure today!';

  @override
  String get welcomeSignInButton => 'Sign In';

  @override
  String get welcomeSignUpButton => 'Sign Up';

  @override
  String get editFolderTitle => 'Edit Folder';

  @override
  String get editFolderCamera => 'Camera';

  @override
  String get editFolderGallery => 'Gallery';

  @override
  String get editFolderNameFolder => 'Folder Name';

  @override
  String get editFolderInsertName => 'Enter folder name';

  @override
  String get editFolderSave => 'Save';

  @override
  String editFolderName(Object folder_name) {
    return 'Edit $folder_name';
  }

  @override
  String get editFolderEmptyName => 'Folder name cannot be empty';

  @override
  String get folderTitle => 'Your Folders';

  @override
  String get folderDelete => 'Confirm deletion?';

  @override
  String get folderDeleteText =>
      'Are you sure you want to delete this folder? This action cannot be undone.';

  @override
  String get folderDeleteConfirm => 'Confirm';

  @override
  String get folderDeleteCancel => 'Cancel';

  @override
  String get folderEmpty =>
      'No folders available, create one to save your favorite trails!';

  @override
  String get folderDitails => 'Details';

  @override
  String get folderComplete => 'Complete';

  @override
  String get folderDeleteTrail =>
      'Are you sure you want to remove this trail from the folder? This action cannot be undone.';

  @override
  String get folderRemove => 'Remove';

  @override
  String get folderYourTrails => 'Saved Trails:';

  @override
  String get imagePickerTitle => 'Take a photo';

  @override
  String get imagePickerNoCamera => 'Camera not available';

  @override
  String get profileCharge => 'Loading profile...';

  @override
  String get profileError =>
      'An error occurred while loading your profile. Please try again later';

  @override
  String profileWelcome(Object user_name) {
    return 'Welcome, $user_name!';
  }

  @override
  String get profileTrailError =>
      'An error occurred while loading your trails. Please try again later';

  @override
  String get profileTrailEmpty => 'No trails found, start exploring now!';

  @override
  String get profileFolderError =>
      'An error occurred while loading your folders. Please try again later';

  @override
  String get profileNewFolder => 'Create a new folder';

  @override
  String get profileFolderName => 'Folder Name';

  @override
  String get profileCancel => 'Cancel';

  @override
  String get profileCreate => 'Create';
}
