class ChangePasswordStrings {
  // ============================================================================
  // SCREEN TITLE
  // ============================================================================
  static const String screenTitle = 'Change Password';

  // ============================================================================
  // FORM LABELS
  // ============================================================================
  static const String currentPasswordLabel = 'Current Password';
  static const String newPasswordLabel = 'New Password';
  static const String confirmNewPasswordLabel = 'Confirm New Password';

  // ============================================================================
  // BUTTONS
  // ============================================================================
  static const String changeAndSaveButton = 'Change & Save';
  static const String forgotPasswordButton = 'Forgot Password?';

  // ============================================================================
  // VALIDATION MESSAGES
  // ============================================================================
  static const String currentPasswordRequired = 'Please enter current password';
  static const String newPasswordRequired = 'Please enter new password';
  static const String confirmPasswordRequired = 'Please confirm new password';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String passwordsDoNotMatch = 'Passwords do not match';

  // ============================================================================
  // SUCCESS MESSAGES
  // ============================================================================
  static const String passwordChangedTitle = 'Success';
  static const String passwordChangedMessage = 'Password changed successfully';

  // ============================================================================
  // ERROR MESSAGES
  // ============================================================================
  static const String wrongCurrentPassword = 'Current password is incorrect';
  static const String changePasswordFailed = 'Failed to change password. Please try again.';
  static const String networkError = 'Network error. Please check your connection.';
}