import 'dart:async';
import 'package:get/get.dart';
import 'package:autoshine/blocs/auth/auth_bloc.dart';

class SignupController extends GetxController {
  final AuthBloc authBloc;

  SignupController({required this.authBloc});

  final showResendButton = false.obs;
  Timer? _resendTimer;
  Timer? _emailVerificationTimer;

  RxBool showPassword = false.obs;

  void startResendTimer() {
    showResendButton.value = false;
    _resendTimer?.cancel();
    _resendTimer = Timer(const Duration(seconds: 20), () {
      showResendButton.value = true;
    });
  }

  void startEmailVerificationCheck() {
    _emailVerificationTimer?.cancel();
    _emailVerificationTimer = Timer.periodic(const Duration(seconds: 3), (
      timer,
    ) async {
      final user = authBloc.authService.getCurrentUser();
      await user?.reload();
      final refreshedUser = authBloc.authService.getCurrentUser();

      if (refreshedUser?.emailVerified ?? false) {
        timer.cancel();
        Get.offAllNamed('/home');
      }
    });
  }

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    _emailVerificationTimer?.cancel();
    super.onClose();
  }
}
