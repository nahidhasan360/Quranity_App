import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quranity/app/theme/app_colors.dart';
import 'package:quranity/core/constants/app_assets.dart';
import 'package:quranity/widgets/custom_otp/generic_otp_controller.dart';
import '../../core/constants/ app_strings.dart';
import '../customPrimaryButton.dart';
import '../reusable_gradient.dart';

class GenericOTPScreen extends StatefulWidget {
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String instruction;
  final String buttonText;
  final String backButtonText;

  const GenericOTPScreen({
    super.key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.instruction,
    required this.buttonText,
    required this.backButtonText,
  });

  @override
  State<GenericOTPScreen> createState() => _GenericOTPScreenState();
}

class _GenericOTPScreenState extends State<GenericOTPScreen> {
  GenericOTPController? _controller;

  @override
  void initState() {
    super.initState();
    // ✅ Wait for controller to be ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _controller = Get.find<GenericOTPController>();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Show loading until controller is ready
    if (_controller == null) {
      return Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryGold,
          ),
        ),
      );
    }

    return PopScope(
      canPop: true,
      child: Scaffold(
        body: GradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),

                      // Back Button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: _controller!.backToPrevious,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.textWhite,
                            size: 20.sp,
                            weight: 600,
                          ),
                        ),
                      ),

                      SizedBox(height: 60.h),

                      // Icon
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.verifyIcon,
                          )
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Title
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w700,
                          height: 1.54,
                          letterSpacing: -0.90,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Subtitle
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Obx(() => RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w400,
                              color: AppColors.subtitle,
                              height: 1.43,
                            ),
                            children: [
                              TextSpan(text: widget.subtitle1),
                              TextSpan(
                                text: _controller!.maskedIdentifier.value,
                                style: TextStyle(
                                  color: AppColors.textWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(text: widget.subtitle2),
                            ],
                          ),
                        )),
                      ),

                      SizedBox(height: 8.h),

                      // Instruction
                      Text(
                        widget.instruction,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          color: AppColors.subtitle,
                          height: 1.43,
                        ),
                      ),

                      SizedBox(height: 26.h),

                      // OTP Input
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: PinCodeTextField(
                          appContext: context,
                          length: AppStrings.otpLength,
                          controller: _controller!.otpController,
                          animationType: AnimationType.fade,
                          animationDuration: const Duration(milliseconds: 300),
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(12.r),
                            fieldHeight: 80.h,
                            fieldWidth: 76.w,
                            activeFillColor: AppColors.cardDark,
                            activeColor: AppColors.primaryGold,
                            selectedFillColor: AppColors.cardDark,
                            selectedColor: AppColors.primaryGold,
                            inactiveFillColor: AppColors.cardDark,
                            inactiveColor: AppColors.iconBackground,
                            errorBorderColor: Colors.red,
                          ),
                          cursorColor: AppColors.primaryGold,
                          enableActiveFill: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textStyle: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textWhite,
                            fontFamily: 'SF Pro',
                          ),
                          onCompleted: (code) => _controller!.verifyOTP(code),
                          onChanged: (value) => _controller!.otpCode.value = value,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Resend Code
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.didntReceiveCode,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.subtitle,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                          GestureDetector(
                            onTap: _controller!.canResend.value
                                ? _controller!.resendOTP
                                : null,
                            child: Text(
                              _controller!.canResend.value
                                  ? AppStrings.resendButton
                                  : AppStrings.resendTimerButton
                                  .replaceAll('{}', '${_controller!.resendTimer.value}'),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: _controller!.canResend.value
                                    ? AppColors.primaryGold
                                    : AppColors.hintText,
                                fontFamily: 'SF Pro',
                              ),
                            ),
                          ),
                        ],
                      )),

                      SizedBox(height: 250.h),

                      // Verify Button
                      Obx(() => CustomPrimaryButton(
                        text: _controller!.isLoading.value
                            ? AppStrings.verifyingButton
                            : widget.buttonText,
                        isFilled: true,
                        fontWeight: FontWeight.w700,
                        height: 56.h,
                        onPressed: _controller!.otpCode.value.length == AppStrings.otpLength &&
                            !_controller!.isLoading.value
                            ? () => _controller!.verifyOTP(_controller!.otpCode.value)
                            : () {},
                        filledBackgroundColor: _controller!.otpCode.value.length == AppStrings.otpLength
                            ? AppColors.primaryGold
                            : AppColors.iconBackground,
                        filledTextColor: _controller!.otpCode.value.length == AppStrings.otpLength
                            ? AppColors.black
                            : AppColors.hintText,
                      )),

                      SizedBox(height: 16.h),

                      // Back Button
                      GestureDetector(
                        onTap: _controller!.backToPrevious,
                        child: Text(
                          widget.backButtonText,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subtitle,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                      ),

                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}