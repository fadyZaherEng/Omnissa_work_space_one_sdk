// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Mofa`
  String get mova {
    return Intl.message(
      'Mofa',
      name: 'mova',
      desc: '',
      args: [],
    );
  }

  /// `Upload Media`
  String get uploadMedia {
    return Intl.message(
      'Upload Media',
      name: 'uploadMedia',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `The server responded with an unexpected error. Please try again later.`
  String get badResponse {
    return Intl.message(
      'The server responded with an unexpected error. Please try again later.',
      name: 'badResponse',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Risks`
  String get risks {
    return Intl.message(
      'Risks',
      name: 'risks',
      desc: '',
      args: [],
    );
  }

  /// `Project`
  String get project {
    return Intl.message(
      'Project',
      name: 'project',
      desc: '',
      args: [],
    );
  }

  /// `Password can't be empty`
  String get passwordCantBeEmpty {
    return Intl.message(
      'Password can\'t be empty',
      name: 'passwordCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalidEmail {
    return Intl.message(
      'Invalid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email can't be empty`
  String get emailCantBeEmpty {
    return Intl.message(
      'Email can\'t be empty',
      name: 'emailCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Email must be between 6-30 characters before @, and between 3-10 characters after @ and before dot. Example: 4U6b2@example.com`
  String get emailLengthRequirement {
    return Intl.message(
      'Email must be between 6-30 characters before @, and between 3-10 characters after @ and before dot. Example: 4U6b2@example.com',
      name: 'emailLengthRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address for example: 4U6b2@example.com`
  String get pleaseEnterAValidEmailAddressForExample {
    return Intl.message(
      'Please enter a valid email address for example: 4U6b2@example.com',
      name: 'pleaseEnterAValidEmailAddressForExample',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Forget password for sign in?`
  String get forgetPasswordForSignIn {
    return Intl.message(
      'Forget password for sign in?',
      name: 'forgetPasswordForSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit Mova app? `
  String get areYouSureYouWantExitMovaApp {
    return Intl.message(
      'Are you sure you want to exit Mova app? ',
      name: 'areYouSureYouWantExitMovaApp',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks {
    return Intl.message(
      'Tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get projects {
    return Intl.message(
      'Projects',
      name: 'projects',
      desc: '',
      args: [],
    );
  }

  /// `Pointers`
  String get pointers {
    return Intl.message(
      'Pointers',
      name: 'pointers',
      desc: '',
      args: [],
    );
  }

  /// `Pointers Tools`
  String get pointersTool {
    return Intl.message(
      'Pointers Tools',
      name: 'pointersTool',
      desc: '',
      args: [],
    );
  }

  /// `Strategies`
  String get strategies {
    return Intl.message(
      'Strategies',
      name: 'strategies',
      desc: '',
      args: [],
    );
  }

  /// `Initiatives`
  String get initiatives {
    return Intl.message(
      'Initiatives',
      name: 'initiatives',
      desc: '',
      args: [],
    );
  }

  /// `Accreditations`
  String get accreditations {
    return Intl.message(
      'Accreditations',
      name: 'accreditations',
      desc: '',
      args: [],
    );
  }

  /// `Challenges`
  String get challenges {
    return Intl.message(
      'Challenges',
      name: 'challenges',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sort {
    return Intl.message(
      'Sort',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Ascending (From A to Z)`
  String get ascending {
    return Intl.message(
      'Ascending (From A to Z)',
      name: 'ascending',
      desc: '',
      args: [],
    );
  }

  /// `Descending (From Z to A)`
  String get descending {
    return Intl.message(
      'Descending (From Z to A)',
      name: 'descending',
      desc: '',
      args: [],
    );
  }

  /// `Recently Added`
  String get recentlyAdded {
    return Intl.message(
      'Recently Added',
      name: 'recentlyAdded',
      desc: '',
      args: [],
    );
  }

  /// `Oldest`
  String get oldest {
    return Intl.message(
      'Oldest',
      name: 'oldest',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get approved {
    return Intl.message(
      'Approved',
      name: 'approved',
      desc: '',
      args: [],
    );
  }

  /// `Under Review`
  String get under_review {
    return Intl.message(
      'Under Review',
      name: 'under_review',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get department {
    return Intl.message(
      'Department',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Choose Department`
  String get chooseDepartment {
    return Intl.message(
      'Choose Department',
      name: 'chooseDepartment',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection found, check your connection`
  String get noInternetConnectionFoundCheckYourConnection {
    return Intl.message(
      'No internet connection found, check your connection',
      name: 'noInternetConnectionFoundCheckYourConnection',
      desc: '',
      args: [],
    );
  }

  /// `Oops!!`
  String get oops {
    return Intl.message(
      'Oops!!',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// `Welcome,`
  String get greeting {
    return Intl.message(
      'Welcome,',
      name: 'greeting',
      desc: '',
      args: [],
    );
  }

  /// `Summaries`
  String get summaries {
    return Intl.message(
      'Summaries',
      name: 'summaries',
      desc: '',
      args: [],
    );
  }

  /// `Landmarks`
  String get landmarks {
    return Intl.message(
      'Landmarks',
      name: 'landmarks',
      desc: '',
      args: [],
    );
  }

  /// `Quick access`
  String get details {
    return Intl.message(
      'Quick access',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `No Record Found`
  String get noRecordFound {
    return Intl.message(
      'No Record Found',
      name: 'noRecordFound',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progressPercentage {
    return Intl.message(
      'Progress',
      name: 'progressPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message(
      'Start Date',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get endDate {
    return Intl.message(
      'End Date',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Output`
  String get output {
    return Intl.message(
      'Output',
      name: 'output',
      desc: '',
      args: [],
    );
  }

  /// `Planned`
  String get planned {
    return Intl.message(
      'Planned',
      name: 'planned',
      desc: '',
      args: [],
    );
  }

  /// `Achievements`
  String get achievements {
    return Intl.message(
      'Achievements',
      name: 'achievements',
      desc: '',
      args: [],
    );
  }

  /// `Completion Percentage`
  String get completionPercentage {
    return Intl.message(
      'Completion Percentage',
      name: 'completionPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Attachments`
  String get attachments {
    return Intl.message(
      'Attachments',
      name: 'attachments',
      desc: '',
      args: [],
    );
  }

  /// `End Date Expected`
  String get endDateExpected {
    return Intl.message(
      'End Date Expected',
      name: 'endDateExpected',
      desc: '',
      args: [],
    );
  }

  /// `End Date Real`
  String get endDateReal {
    return Intl.message(
      'End Date Real',
      name: 'endDateReal',
      desc: '',
      args: [],
    );
  }

  /// `Implementation State`
  String get implementationState {
    return Intl.message(
      'Implementation State',
      name: 'implementationState',
      desc: '',
      args: [],
    );
  }

  /// `Number Of Days`
  String get numberOfDays {
    return Intl.message(
      'Number Of Days',
      name: 'numberOfDays',
      desc: '',
      args: [],
    );
  }

  /// `Progress Implementation`
  String get progressImplementation {
    return Intl.message(
      'Progress Implementation',
      name: 'progressImplementation',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Start Date Basics Line`
  String get startDateBasicsLine {
    return Intl.message(
      'Start Date Basics Line',
      name: 'startDateBasicsLine',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Specific Date`
  String get specificDate {
    return Intl.message(
      'Specific Date',
      name: 'specificDate',
      desc: '',
      args: [],
    );
  }

  /// `Risk Status`
  String get riskStatus {
    return Intl.message(
      'Risk Status',
      name: 'riskStatus',
      desc: '',
      args: [],
    );
  }

  /// `Risk Effect`
  String get riskEffect {
    return Intl.message(
      'Risk Effect',
      name: 'riskEffect',
      desc: '',
      args: [],
    );
  }

  /// `Risk Strong`
  String get riskStrong {
    return Intl.message(
      'Risk Strong',
      name: 'riskStrong',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Challenge Risk`
  String get challengeRisk {
    return Intl.message(
      'Challenge Risk',
      name: 'challengeRisk',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Solve Date`
  String get solveDate {
    return Intl.message(
      'Solve Date',
      name: 'solveDate',
      desc: '',
      args: [],
    );
  }

  /// `Suggest Solution`
  String get suggestSolution {
    return Intl.message(
      'Suggest Solution',
      name: 'suggestSolution',
      desc: '',
      args: [],
    );
  }

  /// `Problem Reasons`
  String get problemReasons {
    return Intl.message(
      'Problem Reasons',
      name: 'problemReasons',
      desc: '',
      args: [],
    );
  }

  /// `Close Date`
  String get closeDate {
    return Intl.message(
      'Close Date',
      name: 'closeDate',
      desc: '',
      args: [],
    );
  }

  /// `Creation Date`
  String get creationDate {
    return Intl.message(
      'Creation Date',
      name: 'creationDate',
      desc: '',
      args: [],
    );
  }

  /// `Target`
  String get target {
    return Intl.message(
      'Target',
      name: 'target',
      desc: '',
      args: [],
    );
  }

  /// `My Pointers`
  String get myPointers {
    return Intl.message(
      'My Pointers',
      name: 'myPointers',
      desc: '',
      args: [],
    );
  }

  /// `Project Name`
  String get projectName {
    return Intl.message(
      'Project Name',
      name: 'projectName',
      desc: '',
      args: [],
    );
  }

  /// `Project Status`
  String get projectStatus {
    return Intl.message(
      'Project Status',
      name: 'projectStatus',
      desc: '',
      args: [],
    );
  }

  /// `Task Start Date`
  String get taskStartDate {
    return Intl.message(
      'Task Start Date',
      name: 'taskStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Task End Date`
  String get taskEndDate {
    return Intl.message(
      'Task End Date',
      name: 'taskEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Achievement`
  String get achievement {
    return Intl.message(
      'Achievement',
      name: 'achievement',
      desc: '',
      args: [],
    );
  }

  /// `End Date Basics Line`
  String get endDateBasicsLine {
    return Intl.message(
      'End Date Basics Line',
      name: 'endDateBasicsLine',
      desc: '',
      args: [],
    );
  }

  /// `Severity Of The Challenge`
  String get severityOfTheChallenge {
    return Intl.message(
      'Severity Of The Challenge',
      name: 'severityOfTheChallenge',
      desc: '',
      args: [],
    );
  }

  /// `Workflow Cases`
  String get workflowCases {
    return Intl.message(
      'Workflow Cases',
      name: 'workflowCases',
      desc: '',
      args: [],
    );
  }

  /// `Number Of Goals`
  String get numberOfGoals {
    return Intl.message(
      'Number Of Goals',
      name: 'numberOfGoals',
      desc: '',
      args: [],
    );
  }

  /// `Number Of Initiatives`
  String get numberOfInitiatives {
    return Intl.message(
      'Number Of Initiatives',
      name: 'numberOfInitiatives',
      desc: '',
      args: [],
    );
  }

  /// `Goals`
  String get goals {
    return Intl.message(
      'Goals',
      name: 'goals',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summary {
    return Intl.message(
      'Summary',
      name: 'summary',
      desc: '',
      args: [],
    );
  }

  /// `Problem Challenge`
  String get problemChallenge {
    return Intl.message(
      'Problem Challenge',
      name: 'problemChallenge',
      desc: '',
      args: [],
    );
  }

  /// `Agreements`
  String get agreements {
    return Intl.message(
      'Agreements',
      name: 'agreements',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Decline`
  String get decline {
    return Intl.message(
      'Decline',
      name: 'decline',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Notifications and Alerts`
  String get notificationsAndAlerts {
    return Intl.message(
      'Notifications and Alerts',
      name: 'notificationsAndAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Powered By`
  String get poweredBy {
    return Intl.message(
      'Powered By',
      name: 'poweredBy',
      desc: '',
      args: [],
    );
  }

  /// `Password length must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number and one special character.`
  String get passwordLengthRequirement {
    return Intl.message(
      'Password length must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number and one special character.',
      name: 'passwordLengthRequirement',
      desc: '',
      args: [],
    );
  }

  /// `At least one lowercase letter`
  String get lowercaseRequirement {
    return Intl.message(
      'At least one lowercase letter',
      name: 'lowercaseRequirement',
      desc: '',
      args: [],
    );
  }

  /// `At least one uppercase letter`
  String get uppercaseRequirement {
    return Intl.message(
      'At least one uppercase letter',
      name: 'uppercaseRequirement',
      desc: '',
      args: [],
    );
  }

  /// `At least one digit`
  String get digitRequirement {
    return Intl.message(
      'At least one digit',
      name: 'digitRequirement',
      desc: '',
      args: [],
    );
  }

  /// `At least one special character (!@#$%^&*_=+-)`
  String get specialCharacterRequirement {
    return Intl.message(
      'At least one special character (!@#\$%^&*_=+-)',
      name: 'specialCharacterRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, the new password and confirm password do not match.`
  String get sorryTheNewPasswordAndConfirmPasswordDoNotMatch {
    return Intl.message(
      'Sorry, the new password and confirm password do not match.',
      name: 'sorryTheNewPasswordAndConfirmPasswordDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `The new password must be different from the previous password`
  String get theNewPasswordMustBeDifferentFromThePreviousPassword {
    return Intl.message(
      'The new password must be different from the previous password',
      name: 'theNewPasswordMustBeDifferentFromThePreviousPassword',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Choose your preferred language`
  String get ChooseYourPreferredLanguage {
    return Intl.message(
      'Choose your preferred language',
      name: 'ChooseYourPreferredLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continues {
    return Intl.message(
      'Continue',
      name: 'continues',
      desc: '',
      args: [],
    );
  }

  /// `Change Language Successfully`
  String get changeLanguageSuccessfully {
    return Intl.message(
      'Change Language Successfully',
      name: 'changeLanguageSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get taskDetails {
    return Intl.message(
      'Task Details',
      name: 'taskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Assignments`
  String get assignments {
    return Intl.message(
      'Assignments',
      name: 'assignments',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Task Information`
  String get taskInfo {
    return Intl.message(
      'Task Information',
      name: 'taskInfo',
      desc: '',
      args: [],
    );
  }

  /// `Assignment Information`
  String get assignmentInfo {
    return Intl.message(
      'Assignment Information',
      name: 'assignmentInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get taskName {
    return Intl.message(
      'Name',
      name: 'taskName',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Percent Done`
  String get percentDone {
    return Intl.message(
      'Percent Done',
      name: 'percentDone',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Enter your comments here...`
  String get enterYourComments {
    return Intl.message(
      'Enter your comments here...',
      name: 'enterYourComments',
      desc: '',
      args: [],
    );
  }

  /// `Created By`
  String get createdBy {
    return Intl.message(
      'Created By',
      name: 'createdBy',
      desc: '',
      args: [],
    );
  }

  /// `Not Started`
  String get notStarted {
    return Intl.message(
      'Not Started',
      name: 'notStarted',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message(
      'In Progress',
      name: 'inProgress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Submitting...`
  String get submitting {
    return Intl.message(
      'Submitting...',
      name: 'submitting',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Resubmission`
  String get confirmResubmission {
    return Intl.message(
      'Confirm Resubmission',
      name: 'confirmResubmission',
      desc: '',
      args: [],
    );
  }

  /// `This task has already been submitted. Are you sure you want to resubmit with the updated information?`
  String get resubmitTaskWarning {
    return Intl.message(
      'This task has already been submitted. Are you sure you want to resubmit with the updated information?',
      name: 'resubmitTaskWarning',
      desc: '',
      args: [],
    );
  }

  /// `Deliverables`
  String get deliverables {
    return Intl.message(
      'Deliverables',
      name: 'deliverables',
      desc: '',
      args: [],
    );
  }

  /// `Milestones`
  String get milestones {
    return Intl.message(
      'Milestones',
      name: 'milestones',
      desc: '',
      args: [],
    );
  }

  /// `Current`
  String get currents {
    return Intl.message(
      'Current',
      name: 'currents',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Write Comment`
  String get writeComment {
    return Intl.message(
      'Write Comment',
      name: 'writeComment',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Task Updates`
  String get taskUpdates {
    return Intl.message(
      'Task Updates',
      name: 'taskUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Select Task Status`
  String get selectTaskStatus {
    return Intl.message(
      'Select Task Status',
      name: 'selectTaskStatus',
      desc: '',
      args: [],
    );
  }

  /// `Select Task Priority`
  String get selectTaskPriority {
    return Intl.message(
      'Select Task Priority',
      name: 'selectTaskPriority',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout Mova app? `
  String get areYouSureYouWantLogoutMovaApp {
    return Intl.message(
      'Are you sure you want to logout Mova app? ',
      name: 'areYouSureYouWantLogoutMovaApp',
      desc: '',
      args: [],
    );
  }

  /// `Objectives Count`
  String get objectivesCount {
    return Intl.message(
      'Objectives Count',
      name: 'objectivesCount',
      desc: '',
      args: [],
    );
  }

  /// `Initiatives Count`
  String get initiativesCount {
    return Intl.message(
      'Initiatives Count',
      name: 'initiativesCount',
      desc: '',
      args: [],
    );
  }

  /// `Challenge Owner`
  String get challengeOwner {
    return Intl.message(
      'Challenge Owner',
      name: 'challengeOwner',
      desc: '',
      args: [],
    );
  }

  /// `Old Status`
  String get oldStatus {
    return Intl.message(
      'Old Status',
      name: 'oldStatus',
      desc: '',
      args: [],
    );
  }

  /// `New Status`
  String get newStatus {
    return Intl.message(
      'New Status',
      name: 'newStatus',
      desc: '',
      args: [],
    );
  }

  /// `Work Flow History`
  String get workFlowHistory {
    return Intl.message(
      'Work Flow History',
      name: 'workFlowHistory',
      desc: '',
      args: [],
    );
  }

  /// `Project Owner`
  String get projectOwner {
    return Intl.message(
      'Project Owner',
      name: 'projectOwner',
      desc: '',
      args: [],
    );
  }

  /// `Project Sponsor`
  String get projectSponsor {
    return Intl.message(
      'Project Sponsor',
      name: 'projectSponsor',
      desc: '',
      args: [],
    );
  }

  /// `Project Priority`
  String get projectPriority {
    return Intl.message(
      'Project Priority',
      name: 'projectPriority',
      desc: '',
      args: [],
    );
  }

  /// `Project Classification`
  String get projectClassification {
    return Intl.message(
      'Project Classification',
      name: 'projectClassification',
      desc: '',
      args: [],
    );
  }

  /// `Project Manager`
  String get projectManager {
    return Intl.message(
      'Project Manager',
      name: 'projectManager',
      desc: '',
      args: [],
    );
  }

  /// `Show More`
  String get showMore {
    return Intl.message(
      'Show More',
      name: 'showMore',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Task Description`
  String get taskDescription {
    return Intl.message(
      'Task Description',
      name: 'taskDescription',
      desc: '',
      args: [],
    );
  }

  /// `Duration (Days)`
  String get durationDays {
    return Intl.message(
      'Duration (Days)',
      name: 'durationDays',
      desc: '',
      args: [],
    );
  }

  /// `Task Update`
  String get taskUpdate {
    return Intl.message(
      'Task Update',
      name: 'taskUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get destails {
    return Intl.message(
      'Details',
      name: 'destails',
      desc: '',
      args: [],
    );
  }

  /// `View More`
  String get viewMore {
    return Intl.message(
      'View More',
      name: 'viewMore',
      desc: '',
      args: [],
    );
  }

  /// `Executing Department`
  String get executingDepartment {
    return Intl.message(
      'Executing Department',
      name: 'executingDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Stage`
  String get stage {
    return Intl.message(
      'Stage',
      name: 'stage',
      desc: '',
      args: [],
    );
  }

  /// `Not Sent`
  String get notSent {
    return Intl.message(
      'Not Sent',
      name: 'notSent',
      desc: '',
      args: [],
    );
  }

  /// `Current Project Phase`
  String get currentProjectPhase {
    return Intl.message(
      'Current Project Phase',
      name: 'currentProjectPhase',
      desc: '',
      args: [],
    );
  }

  /// `Current Project Stage`
  String get currentProjectStage {
    return Intl.message(
      'Current Project Stage',
      name: 'currentProjectStage',
      desc: '',
      args: [],
    );
  }

  /// `Actual`
  String get actual {
    return Intl.message(
      'Actual',
      name: 'actual',
      desc: '',
      args: [],
    );
  }

  /// `Planned`
  String get plan {
    return Intl.message(
      'Planned',
      name: 'plan',
      desc: '',
      args: [],
    );
  }

  /// `Choose Owner`
  String get chooseOwner {
    return Intl.message(
      'Choose Owner',
      name: 'chooseOwner',
      desc: '',
      args: [],
    );
  }

  /// `Assumptions`
  String get assumptions {
    return Intl.message(
      'Assumptions',
      name: 'assumptions',
      desc: '',
      args: [],
    );
  }

  /// `Project Description`
  String get projectDescription {
    return Intl.message(
      'Project Description',
      name: 'projectDescription',
      desc: '',
      args: [],
    );
  }

  /// `Project Description Within Scope`
  String get projectDescriptionWithinScope {
    return Intl.message(
      'Project Description Within Scope',
      name: 'projectDescriptionWithinScope',
      desc: '',
      args: [],
    );
  }

  /// `Project Description Outside Scope`
  String get projectDescriptionOutsideScope {
    return Intl.message(
      'Project Description Outside Scope',
      name: 'projectDescriptionOutsideScope',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message(
      'Owner',
      name: 'owner',
      desc: '',
      args: [],
    );
  }

  /// `Assign To`
  String get assignTo {
    return Intl.message(
      'Assign To',
      name: 'assignTo',
      desc: '',
      args: [],
    );
  }

  /// `Problem From Client`
  String get problemFromClient {
    return Intl.message(
      'Problem From Client',
      name: 'problemFromClient',
      desc: '',
      args: [],
    );
  }

  /// `Mitigation Plan`
  String get mitigationPlan {
    return Intl.message(
      'Mitigation Plan',
      name: 'mitigationPlan',
      desc: '',
      args: [],
    );
  }

  /// `Contingency Plan`
  String get contingencyPlan {
    return Intl.message(
      'Contingency Plan',
      name: 'contingencyPlan',
      desc: '',
      args: [],
    );
  }

  /// `Resolved Date`
  String get resolvedDate {
    return Intl.message(
      'Resolved Date',
      name: 'resolvedDate',
      desc: '',
      args: [],
    );
  }

  /// `Due Date`
  String get dueDate {
    return Intl.message(
      'Due Date',
      name: 'dueDate',
      desc: '',
      args: [],
    );
  }

  /// `Severity`
  String get severity {
    return Intl.message(
      'Severity',
      name: 'severity',
      desc: '',
      args: [],
    );
  }

  /// `Risk Details`
  String get riskDetails {
    return Intl.message(
      'Risk Details',
      name: 'riskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Impact`
  String get impact {
    return Intl.message(
      'Impact',
      name: 'impact',
      desc: '',
      args: [],
    );
  }

  /// `Risk Probability`
  String get riskProbability {
    return Intl.message(
      'Risk Probability',
      name: 'riskProbability',
      desc: '',
      args: [],
    );
  }

  /// `Risk Title`
  String get riskTitle {
    return Intl.message(
      'Risk Title',
      name: 'riskTitle',
      desc: '',
      args: [],
    );
  }

  /// `Challenge Details`
  String get challengeDetails {
    return Intl.message(
      'Challenge Details',
      name: 'challengeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Discussions`
  String get discussions {
    return Intl.message(
      'Discussions',
      name: 'discussions',
      desc: '',
      args: [],
    );
  }

  /// `Resolution`
  String get resolution {
    return Intl.message(
      'Resolution',
      name: 'resolution',
      desc: '',
      args: [],
    );
  }

  /// `Show Less`
  String get showLess {
    return Intl.message(
      'Show Less',
      name: 'showLess',
      desc: '',
      args: [],
    );
  }

  /// `Issue Priority`
  String get issuePriority {
    return Intl.message(
      'Issue Priority',
      name: 'issuePriority',
      desc: '',
      args: [],
    );
  }

  /// `Latest Update Date`
  String get latestUpdateDate {
    return Intl.message(
      'Latest Update Date',
      name: 'latestUpdateDate',
      desc: '',
      args: [],
    );
  }

  /// `Latest Update Brief`
  String get latestUpdateBrief {
    return Intl.message(
      'Latest Update Brief',
      name: 'latestUpdateBrief',
      desc: '',
      args: [],
    );
  }

  /// `Validity`
  String get validity {
    return Intl.message(
      'Validity',
      name: 'validity',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Details`
  String get deliveryDetails {
    return Intl.message(
      'Delivery Details',
      name: 'deliveryDetails',
      desc: '',
      args: [],
    );
  }

  /// `Milestone`
  String get milestone {
    return Intl.message(
      'Milestone',
      name: 'milestone',
      desc: '',
      args: [],
    );
  }

  /// `Current Stage`
  String get currentStage {
    return Intl.message(
      'Current Stage',
      name: 'currentStage',
      desc: '',
      args: [],
    );
  }

  /// `This request requires attachments.`
  String get thisRequestRequiresAttachments {
    return Intl.message(
      'This request requires attachments.',
      name: 'thisRequestRequiresAttachments',
      desc: '',
      args: [],
    );
  }

  /// `It is preferable to take action from the web.`
  String get preferableToTakeActionFromWeb {
    return Intl.message(
      'It is preferable to take action from the web.',
      name: 'preferableToTakeActionFromWeb',
      desc: '',
      args: [],
    );
  }

  /// `Task Percent Done`
  String get taskPercentDone {
    return Intl.message(
      'Task Percent Done',
      name: 'taskPercentDone',
      desc: '',
      args: [],
    );
  }

  /// `Assignment Percent Done`
  String get assignmentPercentDone {
    return Intl.message(
      'Assignment Percent Done',
      name: 'assignmentPercentDone',
      desc: '',
      args: [],
    );
  }

  /// `Milestones`
  String get milstones {
    return Intl.message(
      'Milestones',
      name: 'milstones',
      desc: '',
      args: [],
    );
  }

  /// `Milestone Details`
  String get milstoneDetails {
    return Intl.message(
      'Milestone Details',
      name: 'milstoneDetails',
      desc: '',
      args: [],
    );
  }

  /// `Update Milestone Successfully`
  String get updateMilstoneSuccessfully {
    return Intl.message(
      'Update Milestone Successfully',
      name: 'updateMilstoneSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Save Project Latest Successfully`
  String get SaveProjectLatestSuccessfully {
    return Intl.message(
      'Save Project Latest Successfully',
      name: 'SaveProjectLatestSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Start Date`
  String get deliveryStartDate {
    return Intl.message(
      'Delivery Start Date',
      name: 'deliveryStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Delivery End Date`
  String get deliveryEndDate {
    return Intl.message(
      'Delivery End Date',
      name: 'deliveryEndDate',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get userProfile {
    return Intl.message(
      'User Profile',
      name: 'userProfile',
      desc: '',
      args: [],
    );
  }

  /// `User Information`
  String get userInformation {
    return Intl.message(
      'User Information',
      name: 'userInformation',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Roles`
  String get roles {
    return Intl.message(
      'Roles',
      name: 'roles',
      desc: '',
      args: [],
    );
  }

  /// `Allow Full Path Visibility`
  String get allowFullPathVisibility {
    return Intl.message(
      'Allow Full Path Visibility',
      name: 'allowFullPathVisibility',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Value cannot exceed 100`
  String get valueCannotExceed100 {
    return Intl.message(
      'Value cannot exceed 100',
      name: 'valueCannotExceed100',
      desc: '',
      args: [],
    );
  }

  /// `Issues`
  String get issues {
    return Intl.message(
      'Issues',
      name: 'issues',
      desc: '',
      args: [],
    );
  }

  /// `Compliance Indicator`
  String get complianceIndicators {
    return Intl.message(
      'Compliance Indicator',
      name: 'complianceIndicators',
      desc: '',
      args: [],
    );
  }

  /// `Compliance`
  String get compliance {
    return Intl.message(
      'Compliance',
      name: 'compliance',
      desc: '',
      args: [],
    );
  }

  /// `On Track`
  String get onTrack {
    return Intl.message(
      'On Track',
      name: 'onTrack',
      desc: '',
      args: [],
    );
  }

  /// `Late`
  String get late {
    return Intl.message(
      'Late',
      name: 'late',
      desc: '',
      args: [],
    );
  }

  /// `Very Late`
  String get veryLate {
    return Intl.message(
      'Very Late',
      name: 'veryLate',
      desc: '',
      args: [],
    );
  }

  /// `Activity Name`
  String get activityName {
    return Intl.message(
      'Activity Name',
      name: 'activityName',
      desc: '',
      args: [],
    );
  }

  /// `Process Name`
  String get processName {
    return Intl.message(
      'Process Name',
      name: 'processName',
      desc: '',
      args: [],
    );
  }

  /// `Phase Name`
  String get phaseName {
    return Intl.message(
      'Phase Name',
      name: 'phaseName',
      desc: '',
      args: [],
    );
  }

  /// `Stage Name`
  String get stageName {
    return Intl.message(
      'Stage Name',
      name: 'stageName',
      desc: '',
      args: [],
    );
  }

  /// `Mark`
  String get mark {
    return Intl.message(
      'Mark',
      name: 'mark',
      desc: '',
      args: [],
    );
  }

  /// `Compliance Rate`
  String get complianceRate {
    return Intl.message(
      'Compliance Rate',
      name: 'complianceRate',
      desc: '',
      args: [],
    );
  }

  /// `Discovery Date`
  String get discoveryDate {
    return Intl.message(
      'Discovery Date',
      name: 'discoveryDate',
      desc: '',
      args: [],
    );
  }

  /// `Resolution Date`
  String get resolutionDate {
    return Intl.message(
      'Resolution Date',
      name: 'resolutionDate',
      desc: '',
      args: [],
    );
  }

  /// `Recommendations`
  String get recommendations {
    return Intl.message(
      'Recommendations',
      name: 'recommendations',
      desc: '',
      args: [],
    );
  }

  /// `Observation`
  String get observation {
    return Intl.message(
      'Observation',
      name: 'observation',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get noData {
    return Intl.message(
      'No data',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `No recommendations`
  String get noRecommendations {
    return Intl.message(
      'No recommendations',
      name: 'noRecommendations',
      desc: '',
      args: [],
    );
  }

  /// `No observation`
  String get noObservation {
    return Intl.message(
      'No observation',
      name: 'noObservation',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
