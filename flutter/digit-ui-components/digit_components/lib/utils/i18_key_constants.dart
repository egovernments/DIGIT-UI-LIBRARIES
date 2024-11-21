const common = Common();

class Common {
  const Common();
  String get camera => 'CAMERA';
  String get chooseOptionToUpload => 'CHOOSE_OPTION_TO_UPLOAD';
  String get clickToAddPicture => 'CLICK_TO_ADD_PICTURE';
  String get viewLessFuture => 'VIEW_LESS_FUTURE';
  String get viewMoreFuture => 'VIEW_MORE_FUTURE';
  String get viewLessPast => 'VIEW_LESS_PAST';
  String get viewMorePast => 'VIEW_MORE_PAST';
  String get viewDetails => 'VIEW_DETAILS';
  String get hideDetails => 'HIDE_DETAILS';
  String get download => 'DOWNLOAD';
  String get reUpload => 'RE_UPLOAD';
  String get dragDropFile => 'DRAG_DROP_FILE';
  String get browseFile => 'BROWSE_FILE';
  String get acceptText {
    return 'PRIVACY_POLICY_ACCEPT_TEXT';
  }

  String get declineText {
    return 'PRIVACY_POLICY_DECLINE_TEXT';
  }

  String get privacyNoticeText => 'PRIVACY_POLICY_TEXT';
  String get privacyPolicyLinkText => 'PRIVACY_POLICY_LINK_TEXT';
  String get privacyPolicyValidationText => 'PRIVACY_POLICY_VALIDATION_TEXT';
}