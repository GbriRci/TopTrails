// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String signInTitle(Object app_name) {
    return 'Accedi a $app_name';
  }

  @override
  String get signInEmail => 'Email';

  @override
  String get signInPassword => 'Password';

  @override
  String get signInInsertEmail => 'Inserisci la tua email';

  @override
  String get signInInsertPassword => 'Inserisci la tua password';

  @override
  String get signInRememberData => 'Ricorda';

  @override
  String get signInForgotPassword => 'Password dimenticata?';

  @override
  String get signInButton => 'Accedi';

  @override
  String signInNewUser(Object app_name) {
    return 'Nuovo su $app_name';
  }

  @override
  String get signInLongText =>
      'Registrati e inizia ora la tua escursione nel mondo naturale!';

  @override
  String get signInSignUpButton => 'Registrati';

  @override
  String get signInInvalidCredentials => 'Email o password non validi';

  @override
  String get signInDisabledAccount => 'Il tuo account è stato disabilitato';

  @override
  String get signInError =>
      'Si è verificato un errore durante l\'accesso. Riprova più tardi.';

  @override
  String get signInGenericError => 'Si è verificato un errore';

  @override
  String get signInEmailSent =>
      'Se la tua email è registrata, ti abbiamo inviato un\'email per reimpostare la password.';

  @override
  String get signInEnterEmailToResetPassword =>
      'Inserisci l\'email per reimpostare la password';

  @override
  String get validationEmailRequired => 'Email è richiesta';

  @override
  String get validationPasswordRequired => 'Password è richiesta';

  @override
  String get validationConfirmPasswordRequired =>
      'La conferma della password è richiesta';

  @override
  String get validationPasswordsDoNotMatch => 'Le password non corrispondono';

  @override
  String get validationEmailInvalid => 'L\'email non è valida';

  @override
  String registrationTitle(Object app_name) {
    return 'Registrati a $app_name';
  }

  @override
  String get registrationEmail => 'Email';

  @override
  String get registrationInsertEmail => 'Inserisci la tua Email';

  @override
  String get registrationPassword => 'Password';

  @override
  String get registrationInsertPassword => 'Inserisci la tua Password';

  @override
  String get registrationConfirmPassword => 'Conferma Password';

  @override
  String get registrationInsertConfirmPassword => 'Conferma la tua Password';

  @override
  String get registrationButton => 'Registrati';

  @override
  String registrationAlreadyUser(Object app_name) {
    return 'Sei già su $app_name';
  }

  @override
  String get registrationLongText =>
      'Accedi ora per tornare a esplorare i migliori sentieri di escursionismo!';

  @override
  String get registrationSignInButton => 'Accedi';

  @override
  String get registrationSuccess =>
      'Registrazione riuscita! Accedi per continuare';

  @override
  String get registrationAlreadyHaveAccount => 'Hai già un account';

  @override
  String get registrationWeakPassword =>
      'La tua password è troppo debole. Le password devono essere lunghe almeno 8 caratteri';

  @override
  String get registrationError =>
      'Si è verificato un errore durante la registrazione. Riprova più tardi';

  @override
  String get registrationGenericError => 'Si è verificato un errore';

  @override
  String get homeNoTrails =>
      'Nessun sentiero trovato, modifica i filtri o riprova più tardi...';

  @override
  String get homeNoLocation =>
      'Nessuna posizione disponibile, abilita i servizi di localizzazione nelle impostazioni del dispositivo';

  @override
  String get homeEasyTrail => 'Facile';

  @override
  String get homeModerateTrail => 'Medio';

  @override
  String get homeDemandingTrail => 'Impegnativo';

  @override
  String get homeHardTrail => 'Difficile';

  @override
  String get homeExtremeTrail => 'Estremo';

  @override
  String get homeSurfaceAsphalt => 'Asfalto';

  @override
  String get homeSurfaceUnpaved => 'Non asfaltato';

  @override
  String get homeSurfaceGravel => 'Ghiaia';

  @override
  String get homeSurfaceGround => 'Terra';

  @override
  String get homeSurfaceCobblestone => 'Ciottolato';

  @override
  String get homeSurfaceRock => 'Roccia';

  @override
  String get homeSurfaceWood => 'Legno';

  @override
  String get homeSurfaceGrass => 'Erba';

  @override
  String get homeSurfaceCompacted => 'Compattato';

  @override
  String get homeSurfaceSand => 'Sabbia';

  @override
  String get homeDefault => 'Not specified';

  @override
  String get homeCharging => 'Caricamento sentieri...';

  @override
  String get homeFilterPosition => 'Posizione';

  @override
  String get homeFilterEasy => 'Facile';

  @override
  String get homeFilterModerate => 'Medio';

  @override
  String get homeFilterHard => 'Difficile';

  @override
  String get homeFilterExtreme => 'Estremo';

  @override
  String get homeFilterRoad => 'Strada';

  @override
  String get homeFilterPedestrian => 'Pedonale';

  @override
  String get homeFilterCycleway => 'Ciclabile';

  @override
  String get homeFilterTrail => 'Sentiero';

  @override
  String get homeSearchBarHint => 'Cerca luoghi';

  @override
  String get homeSearchError => 'Luogo non trovato, prova a cercarne un altro';

  @override
  String get settingsTitle => 'Impostazioni app';

  @override
  String get settingsPreferences => 'Preferenze';

  @override
  String get settingsTheme => 'Tema chiaro o scuro';

  @override
  String get settingsFavorites => 'Preferiti';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsSignOut => 'Disconnetti';

  @override
  String get settingData => 'I miei Dati';

  @override
  String get settingsChangeEmail => 'Cambia Email';

  @override
  String get settingsChangePassword => 'Cambia Password';

  @override
  String get settingsSafety => 'Sicurezza';

  @override
  String get settingsMountainSafety => 'Sicurezza in Montagna';

  @override
  String get settingsForgotPassword => 'Password Dimenticata';

  @override
  String get settingsForgotPassworQuestion => 'Hai dimenticato la password?';

  @override
  String get settingsForgotPasswordText =>
      'Se premi continua, verrai reindirizzato alla pagina di accesso dove potrai premere \"password dimenticata\"';

  @override
  String get settingsForgotPasswordContinue => 'Continua';

  @override
  String get settingsForgotPasswordCancel => 'Annulla';

  @override
  String get settingsDeleteAccount => 'Elimina Account';

  @override
  String get settingsDeleteAccountText =>
      'Sei sicuro di voler eliminare il tuo account? Questa azione non può essere annullata.';

  @override
  String get settingsDeleteAccountConfirm => 'Conferma';

  @override
  String get settingsDeleteAccountCancel => 'Annulla';

  @override
  String get settingsNewEmail => 'Nuova Email';

  @override
  String get settingsCurrentPassword => 'Password Attuale';

  @override
  String get settingsEmailUpdated => 'Email aggiornata con successo';

  @override
  String get settingsNewPassword => 'Nuova Password';

  @override
  String get settingsChangeEmailCancel => 'Annulla';

  @override
  String get settingsChangeEmailConfirm => 'Salva';

  @override
  String get settingsChangePasswordCancel => 'Annulla';

  @override
  String get settingsChangePasswordConfirm => 'Salva';

  @override
  String get settingsNoApp => 'Nessuna app trovata per aprire il link.';

  @override
  String get settingsDeleteAccountError =>
      'Si è verificato un errore durante l\'eliminazione del tuo account. Riprova più tardi.';

  @override
  String get profileTitle => 'Il tuo profilo';

  @override
  String get profileTrails => 'Sentieri completati:';

  @override
  String get profileFolders => 'Le tue cartelle:';

  @override
  String get trailDetailsTitle => 'Dettagli del sentiero';

  @override
  String trailDetailsSubtitle(Object trail_name) {
    return 'Inizia ad esplorare $trail_name!';
  }

  @override
  String get trailDetailsDescription => 'Descrizionen:';

  @override
  String trailDetailsLenght(Object unit) {
    return 'Lunghezza: $unit m';
  }

  @override
  String trailDetailsGrade(Object unit) {
    return 'Difficoltà: $unit';
  }

  @override
  String trailDetailsSurface(Object unit) {
    return 'Terreno: $unit';
  }

  @override
  String trailDetailsType(Object unit) {
    return 'Tipologia: $unit';
  }

  @override
  String get trailDetailsLoopYes => 'Questo sentiero è un anello';

  @override
  String get trailDetailsLoopNo => 'Questo sentiero non è un anello';

  @override
  String get trailDetailsSave => 'Salva';

  @override
  String get trailDetailsAlertText => 'Seleziona una o più cartelle:';

  @override
  String get trailDetailsAlertSave => 'Salva';

  @override
  String get trailDetailsAlertCancel => 'Annulla';

  @override
  String get trailSelectFolder =>
      'Seleziona almeno una cartella per salvare il sentiero';

  @override
  String get trailStartTrail => 'Indicazioni partenza';

  @override
  String get trailCantOpenGoogleMaps => 'Impossibile aprire Google Maps';

  @override
  String welcomeTitle(Object app_name) {
    return 'Benvenuto su $app_name';
  }

  @override
  String get welcomeSubtitle => 'Esplora il mondo attorno a te!';

  @override
  String get welcomeText =>
      'Scopri i migliori sentieri di escursionismo e inizia la tua avventura registrandoti o accedendo!';

  @override
  String get welcomeSignInButton => 'Accedi';

  @override
  String get welcomeSignUpButton => 'Registrati';

  @override
  String get editFolderTitle => 'Modifica Cartella';

  @override
  String get editFolderCamera => 'Fotocamera';

  @override
  String get editFolderGallery => 'Galleria';

  @override
  String get editFolderNameFolder => 'Nome Cartella';

  @override
  String get editFolderInsertName => 'Inserisci il nome della cartella';

  @override
  String get editFolderSave => 'Salva';

  @override
  String editFolderName(Object folder_name) {
    return 'Modifica $folder_name';
  }

  @override
  String get editFolderEmptyName =>
      'Il nome della cartella non può essere vuoto';

  @override
  String get folderTitle => 'Le tue Cartelle';

  @override
  String get folderDelete => 'Conferma eliminazione?';

  @override
  String get folderDeleteText =>
      'Sei sicuro di voler eliminare questa cartella? Questa azione non può essere annullata.';

  @override
  String get folderDeleteConfirm => 'Conferma';

  @override
  String get folderDeleteCancel => 'Annulla';

  @override
  String get folderEmpty =>
      'Nessuna cartella disponibile, creane una per salvare i tuoi sentieri preferiti!';

  @override
  String get folderDitails => 'Dettagli';

  @override
  String get folderComplete => 'Completa';

  @override
  String get folderDeleteTrail =>
      'Sei sicuro di voler rimuovere questo sentiero dalla cartella? Questa azione non può essere annullata.';

  @override
  String get folderRemove => 'Rimuovi';

  @override
  String get folderYourTrails => 'Sentieri Salvati:';

  @override
  String get imagePickerTitle => 'Scatta una foto';

  @override
  String get imagePickerNoCamera => 'Fotocamera non disponibile';

  @override
  String get profileCharge => 'Caricamento profilo...';

  @override
  String get profileError =>
      'Si è verificato un errore durante il caricamento del tuo profilo. Riprova più tardi';

  @override
  String profileWelcome(Object user_name) {
    return 'Benvenuto, $user_name!';
  }

  @override
  String get profileTrailError =>
      'Si è verificato un errore durante il caricamento dei tuoi sentieri. Riprova più tardi';

  @override
  String get profileTrailEmpty =>
      'Nessun sentiero trovato, inizia a esplorare ora!';

  @override
  String get profileFolderError =>
      'Si è verificato un errore durante il caricamento delle tue cartelle. Riprova più tardi';

  @override
  String get profileNewFolder => 'Crea una nuova cartella';

  @override
  String get profileFolderName => 'Nome Cartella';

  @override
  String get profileCancel => 'Annulla';

  @override
  String get profileCreate => 'Crea';
}
