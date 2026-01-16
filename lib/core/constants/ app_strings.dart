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




  // ============================================================================
  // APP GENERAL
  // ============================================================================
  static const String appTagline = 'Your spiritual companion';

  // ============================================================================
  // AUTHENTICATION
  // ============================================================================

  static const String logout = 'Logout';
  static const String createAccount = 'Create Account';
  static const String resetPassword = 'Reset Password';
  static const String emailHint = 'Email';

  // ============================================================================
  // NAVIGATION
  // ============================================================================
  static const String navHome = 'Home';
  static const String navAsk = 'Ask';
  static const String navShorts = 'Shorts';
  static const String navStories = 'Stories';
  static const String navQuran = 'Qur\'an';

  // ============================================================================
  // MUSLIM AI SCREEN
  // ============================================================================
  static const String muslimAI = 'Muslim AI';
  static const String freePlan = 'Free Plan';
  static const String questionsLeft = 'left';
  static const String askToMuslimAI = 'Ask to Muslim AI';

  // Category titles
  static const String categoryWisdom = 'Wisdom';
  static const String categoryChallenges = 'Challenges in\nDaily Life';
  static const String categorySpirituality = 'Spirituality Guidance';
  static const String categoryCharacter = 'Character & Peace';
  static const String categoryKnowledge = 'Knowledge and\nLearning';
  static const String categoryRelationship = 'Relationship &\nCommunity';

  // Category subtitles
  static const String categoryWisdomSubtitle = 'Divine insights';
  static const String categoryChallengesSubtitle = 'Amal/practice';
  static const String categorySpiritualitySubtitle = 'Inner Peace';
  static const String categoryCharacterSubtitle = 'Akhlaq & Adab';
  static const String categoryKnowledgeSubtitle = 'Ilm & Education';
  static const String categoryRelationshipSubtitle = 'Family & Society';

  // ============================================================================
  // COMMON ACTIONS
  // ============================================================================
  static const String submit = 'Submit';
  static const String confirm = 'Confirm';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String done = 'Done';
  static const String back = 'Back';
  static const String continue_ = 'Continue';
  static const String yes = 'Yes';
  static const String no = 'No';

  // ============================================================================
  // GREETINGS
  // ============================================================================
  static const String assalamuAlaikum = 'As-salamu alaykum';
  static const String goodMorning = 'Good Morning';
  static const String goodAfternoon = 'Good Afternoon';
  static const String goodEvening = 'Good Evening';
  static const String goodNight = 'Good Night';

  // ============================================================================
  // PRAYER TIMES
  // ============================================================================
  static const String fajr = 'Fajr';
  static const String dhuhr = 'Dhuhr';
  static const String asr = 'Asr';
  static const String maghrib = 'Maghrib';
  static const String isha = 'Isha';
  static const String nextPrayer = 'Next Prayer';
  static const String prayerTimes = 'Prayer Times';

  // ============================================================================
  // ERRORS & MESSAGES
  // ============================================================================
  static const String errorGeneral = 'Something went wrong';
  static const String errorNetwork = 'No internet connection';
  static const String errorInvalidEmail = 'Invalid email address';
  static const String errorInvalidPassword = 'Password must be at least 6 characters';
  static const String errorPasswordMismatch = 'Passwords do not match';
  static const String errorEmptyField = 'This field cannot be empty';
  static const String successSaved = 'Successfully saved';
  static const String successDeleted = 'Successfully deleted';
  static const String processing = 'Processing...';
  static const String noDataFound = 'No data found';

  // ============================================================================
  // PLACEHOLDER TEXT
  // ============================================================================
  static const String searchPlaceholder = 'Search...';
  static const String typeMessagePlaceholder = 'Type a message...';
  static const String noResultsFound = 'No results found';




  // ============================================================================
  // CHAT SCREEN
  // ============================================================================
  static const String sendMessage = 'Send Message...';
  static const String typeMessage = 'Type a message...';
  static const String messageCopied = 'Message copied to clipboard';
  static const String copied = 'Copied';
  static const String regeneratingResponse = 'Regenerating response...';
  static const String sendingMessage = 'Sending...';
  static const String chatHistory = 'Chat History';
  static const String newChat = 'New Chat';
  static const String clearChat = 'Clear Chat';
  static const String deleteChat = 'Delete Chat';

  // Chat actions
  static const String copyMessage = 'Copy';
  static const String likeMessage = 'Like';
  static const String dislikeMessage = 'Dislike';
  static const String regenerateMessage = 'Regenerate';
  static const String shareMessage = 'Share';
  static const String reportMessage = 'Report';
  static const String premiumPlan = 'Premium Plan';

  // Daily Limit Dialog
  static const String dailyLimitReached = 'Daily Limit Reached';
  static const String dailyLimitMessage = "You've used your 10 free messages for today.\nUpgrade to Premium for unlimited access.";
  static const String upgradeToPremium = 'Upgrade to Premium';

  // ============================================================================
  // COMMON ACTIONS
  // ============================================================================
  static const String close = 'Close';
  static const String retry = 'Retry';
  static const String refresh = 'Refresh';
  static const String viewAll = 'View All';
  static const String seeMore = 'See More';
  static const String seeLess = 'See Less';

  // ============================================================================
  // GREETINGS
  // ============================================================================

  static const String welcome = 'Welcome';
  static const String welcomeBack = 'Welcome Back';

  // ============================================================================
  // PRAYER TIMES
  // ============================================================================
  static const String timeRemaining = 'Time Remaining';
  static const String prayerNotification = 'Prayer Notification';

  // ============================================================================
  // QURAN
  // ============================================================================
  static const String quran = 'Qur\'an';
  static const String surah = 'Surah';
  static const String juz = 'Juz';
  static const String page = 'Page';
  static const String verse = 'Verse';
  static const String ayah = 'Ayah';
  static const String translation = 'Translation';
  static const String transliteration = 'Transliteration';
  static const String tafsir = 'Tafsir';
  static const String recitation = 'Recitation';
  static const String bookmark = 'Bookmark';
  static const String bookmarks = 'Bookmarks';
  static const String lastRead = 'Last Read';
  static const String continueReading = 'Continue Reading';

  // ============================================================================
  // ERRORS & MESSAGES
  // ============================================================================
  static const String errorRequired = 'This field is required';
  static const String errorInvalidInput = 'Invalid input';

  // Success messages
  static const String successUpdated = 'Successfully updated';
  static const String successSent = 'Successfully sent';
  static const String successCopied = 'Successfully copied';

  // Loading messages
  static const String pleaseWait = 'Please wait...';
  static const String fetching = 'Fetching data...';

  // Empty states
  static const String noChatHistory = 'No chat history';
  static const String noBookmarks = 'No bookmarks yet';
  static const String noNotifications = 'No notifications';
  static const String emptyChat = 'Start a conversation';

  // ============================================================================
  // PLACEHOLDER TEXT
  // ============================================================================
  static const String enterEmail = 'Enter your email';
  static const String enterPassword = 'Enter your password';
  static const String enterName = 'Enter your name';
  static const String writeHere = 'Write here...';

  // ============================================================================
  // SETTINGS
  // ============================================================================
  static const String settings = 'Settings';
  static const String account = 'Account';
  static const String profile = 'Profile';
  static const String preferences = 'Preferences';
  static const String notifications = 'Notifications';
  static const String language = 'Language';
  static const String theme = 'Theme';
  static const String darkMode = 'Dark Mode';
  static const String lightMode = 'Light Mode';
  static const String fontSize = 'Font Size';
  static const String aboutUs = 'About Us';
  static const String privacyPolicy = 'Privacy Policy';
  static const String contactUs = 'Contact Us';
  static const String rateApp = 'Rate App';
  static const String shareApp = 'Share App';
  static const String version = 'Version';

  // ============================================================================
  // SUBSCRIPTION
  // ============================================================================
  static const String upgrade = 'Upgrade';
  static const String upgradeToPro = 'Upgrade to Pro';
  static const String premiumFeatures = 'Premium Features';
  static const String unlimitedAccess = 'Unlimited Access';
  static const String monthly = 'Monthly';
  static const String yearly = 'Yearly';
  static const String lifetime = 'Lifetime';
  static const String subscribe = 'Subscribe';
  static const String restorePurchase = 'Restore Purchase';
  static const String manageSubscription = 'Manage Subscription';

  // ============================================================================
  // DAYS & MONTHS
  // ============================================================================
  static const String monday = 'Monday';
  static const String tuesday = 'Tuesday';
  static const String wednesday = 'Wednesday';
  static const String thursday = 'Thursday';
  static const String friday = 'Friday';
  static const String saturday = 'Saturday';
  static const String sunday = 'Sunday';

  static const String january = 'January';
  static const String february = 'February';
  static const String march = 'March';
  static const String april = 'April';
  static const String may = 'May';
  static const String june = 'June';
  static const String july = 'July';
  static const String august = 'August';
  static const String september = 'September';
  static const String october = 'October';
  static const String november = 'November';
  static const String december = 'December';

  // ============================================================================
  // TIME
  // ============================================================================
  static const String now = 'Now';
  static const String today = 'Today';
  static const String yesterday = 'Yesterday';
  static const String tomorrow = 'Tomorrow';
  static const String thisWeek = 'This Week';
  static const String lastWeek = 'Last Week';
  static const String thisMonth = 'This Month';
  static const String lastMonth = 'Last Month';
  static const String hour = 'hour';
  static const String hours = 'hours';
  static const String minute = 'minute';
  static const String minutes = 'minutes';
  static const String second = 'second';
  static const String seconds = 'seconds';
  static const String ago = 'ago';

  // ============================================================================
  // CONFIRMATION DIALOGS
  // ============================================================================
  static const String areYouSure = 'Are you sure?';
  static const String deleteConfirmation = 'Are you sure you want to delete this?';
  static const String logoutConfirmation = 'Are you sure you want to logout?';
  static const String clearChatConfirmation = 'Are you sure you want to clear this chat?';
  static const String cantBeUndone = 'This action cannot be undone';
  static const String permanentAction = 'This is a permanent action';







  /// videos

  // ============================================================================
  // SHORTS SCREEN
  // ============================================================================
  static const String forYou = 'For You';
  static const String saved = 'Saved';
  static const String removed = 'Removed';
  static const String videoSaved = 'Video saved successfully';
  static const String videoRemoved = 'Video removed from saved';
  static const String upgradeSuccess = 'Success';
  static const String upgradeMessage = 'Upgraded to Premium! Enjoy unlimited shorts.';





  // Stories Screen
  static const String searchQuranHadith = 'Search Qur\'an, Hadith...';
  static const String discover = 'Discover';
  static const String quranStory = 'Quran Story';
  static const String categories = 'Categories';
  static const String understandingSalah = 'Understanding Salah: Step by Step';
  static const String newLabel = 'New';
  static const String watchNow = 'Watch Now';

  // ============================================================================
  // LIMIT DIALOG
  // ============================================================================
  static const String limitReached = 'Limit Reached';
  static const String freeUsersLimit = 'Free users can watch up to';
  static const String shortsDaily = 'shorts daily.';
  static const String upgradePremiumAccess = 'Upgrade to Premium for unlimited access.';

  // ============================================================================
  // ERROR MESSAGES
  // ============================================================================
  static const String videoLoadError = 'Failed to load video';

  // ============================================================================
  // COMMON
  // ============================================================================
  static const String unlimited = 'Unlimited';


}