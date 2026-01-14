class AppStrings {
  // ========================= App Info =========================
  static const String appName = 'Quranity';

  // ========================= Onboarding Strings =========================
  static const String skip = 'Skip';
  static const String continueText = 'Continue';
  static const String next = 'Next';
  static const String getStarted = 'Get Started';

  // Onboarding 1
  static const String onboarding1Title = "Connect with the Qur'an,Daily";
  static const String onboarding1Description =
      "Read the Qur'an with authentic Arabic text and trusted English translation, designed for focus and peace.";

  // Onboarding 2
  static const String onboarding2Title = "Ask. Learn. Reflect.";
  static const String onboarding2Description =
      "Get answers powered only by the Qur’an and authentic Hadith — no opinions, only truth.";

  // Onboarding 3
  static const String onboarding3Title = "Stay Connected to Your Salah.";
  static const String onboarding3Description =
      "Accurate prayer times, live countdowns, and reminders — wherever you are..";

  // Onboarding 4
  static const String onboarding4Title = "Learn & Grow";
  static const String onboarding4Description =
      "Access authentic Islamic knowledge and grow spiritually with daily reminders and lessons.";

  // ========================= Auth Strings =========================
  static const String login = 'Login';
  static const String register = 'Register';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = "Don't have an account?";
  static const String alreadyHaveAccount = "Already have an account?";
  static const String signUp = 'Sign Up';
  static const String signIn = 'Sign In';

// ============================================================
  // VERIFY EMAIL SCREEN
  // ============================================================

  // Title & Headings
  static const String verifyEmailTitle = 'Verify Email';

  // Subtitles & Instructions
  static const String verifyEmailSubtitle1 = "We've sent a 4-digit code to ";
  static const String verifyEmailSubtitle2 = ".";
  static const String verifyEmailInstruction = "Please enter it below.";

  // Buttons
  static const String verifyButton = 'Verify & Create Account';
  static const String verifyingButton = 'Verifying...';
  static const String resendButton = 'Resend';
  static const String resendTimerButton = 'Resend ({}s)'; // {} will be replaced with seconds
  static const String backToSignUpButton = 'Back to Sign Up';

  // Labels & Hints
  static const String didntReceiveCode = "Didn't receive the code? ";

  // Success Messages
  static const String verifyEmailSuccess = 'Email verified successfully!';
  static const String resendCodeSuccess = 'A new verification code has been sent to ';

  // Error Messages
  static const String invalidCodeError = 'Please enter a 4-digit code';
  static const String verificationFailedError = 'Invalid verification code. Please try again.';
  static const String resendFailedError = 'Failed to resend code. Please try again.';
  static const String invalidCodeTitle = 'Invalid Code';
  static const String verificationFailedTitle = 'Verification Failed';
  static const String resendFailedTitle = 'Resend Failed';
  static const String codeSentTitle = 'Code Sent';
  static const String successTitle = 'Success';

  // Warnings
  static const String noEmailWarning = '⚠️ Warning: No email passed to VerifyEmailScreen';

  // Placeholders
  static const String defaultEmail = 'user@example.com';

  // OTP Settings
  static const int otpLength = 4;
  static const int resendTimerSeconds = 60;







  // Signup Screen
  static const String createAccountTitle = 'Create Account';
  static const String joinCommunitySubtitle = 'Join our community and start your spiritual journey.';
  static const String fullNameHint = 'Full Name';
  static const String emailAddressHint = 'Email Address';
  static const String newPasswordHint = 'New Password';
  static const String confirmPasswordHint = 'Confirm New Password';
  static const String agreeWithTerms = 'Agree with ';
  static const String termsAndConditions = 'Terms and Conditions';
  static const String signInLink = 'Sign in';

  // Common
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String cancel = 'Cancel';
  static const String ok = 'OK';


  // ============================ login screen ====================================

  // ============================================================
  // LOGIN SCREEN
  // ============================================================

  // Title & Subtitles
  static const String loginTitle = 'Welcome Back';
  static const String loginSubtitle = 'Sign in to access your saved verses and continue\nyour journey.';

  // Input Fields
  static const String passwordHint = 'Password';

  // Buttons & Links
  static const String signInButton = 'Sign In';
  static const String forgotPasswordLink = 'Forgot Password?';
  static const String rememberMeLabel = 'Remember Me';
  static const String dontHaveAccountText = "Don't have an account? ";
  static const String signUpLink = 'Sign Up';

  // Validation Messages
  static const String emailRequired = 'Please enter your email';
  static const String emailInvalid = 'Please enter a valid email';
  static const String passwordRequired = 'Please enter your password';
  static const String passwordMinLength = 'Password must be at least 8 characters';

  // Success Messages
  static const String loginSuccess = 'Login successful!';

  // Error Messages
  static const String loginFailed = 'Login failed. Please check your credentials.';
  static const String invalidCredentials = 'Invalid email or password';

  // Loading
  static const String signingIn = 'Signing In...';






  // ============================================================
  // FORGOT PASSWORD SCREEN
  // ============================================================

  // Title & Subtitles
  static const String forgotPasswordTitle = 'Forget Your Password?';
  static const String forgotPasswordSubtitle = "Enter your email address and we'll send you a link\nto reset your password.";

  // Input Fields
  static const String emailAddressPlaceholder = 'Email Address';

  // Buttons
  static const String sendResetLinkButton = 'Send Reset Link →';
  static const String sendingLinkButton = 'Sending...';
  static const String backToSignInLink = 'Back to Sign In';

  // Success Messages
  static const String resetLinkSentSuccess = 'Reset link sent successfully!';

  // Error Messages
  static const String resetLinkSendFailed = 'Failed to send reset link. Please try again.';






  // ============================================================
  // RESET PASSWORD SCREEN
  // ============================================================

  // Title & Subtitles
  static const String resetPasswordTitle = 'Reset Password';
  static const String resetPasswordSubtitle = 'Password must have minimum 8 characters.';

  // Input Fields
  static const String confirmNewPasswordHint = 'Confirm New Password';

  // Buttons
  static const String saveAndSignInButton = 'Save & Sign In';
  static const String savingButton = 'Saving...';

  // Validation Messages
  static const String passwordMismatch = 'Passwords do not match';
  static const String passwordTooShort = 'Password must be at least 8 characters';

  // Success Messages
  static const String passwordResetSuccess = 'Password reset successfully!';

  // Error Messages
  static const String passwordResetFailed = 'Failed to reset password. Please try again.';








}