import 'package:autoshine/services/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  AuthBloc({required this.authService}) : super(AuthInitial()) {
    //Sign up
    on<AuthSignUpRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final userId = await authService.signUp(
          email: event.email,
          password: event.password,
          name: event.name,
        );

        emit(AuthSuccess(userId: userId));
      } catch (e) {
        emit(
          AuthFailed(
            error: 'Verification email sent. Please verify before logging in.',
          ),
        );
      }
    });

    //Login
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authService.logIn(
          email: event.email,
          password: event.password,
        );

        if (user != null && !user.emailVerified) {
          emit(AuthFailed(error: 'Email not verified. Check your inbox.'));
        } else {
          emit(AuthSuccess(userId: user!.uid));
        }
      } catch (e) {
        emit(AuthFailed(error: e.toString()));
      }
    });

    //Resend Verification
    on<AuthResendVerificationEmail>((event, emit) async {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          emit(AuthVerificationEmailSent('Verification email sent again.'));
        } else {
          emit(AuthFailed(error: 'Email already verified or user not found.'));
        }
      } catch (e) {
        emit(AuthFailed(error: 'Could not send verification email.'));
      }
    });

    // // Google Login
    // on<AuthGoogleLoginRequested>((event, emit) async {
    //   emit(AuthLoading());
    //   try {
    //     final user = await authService.signInWithGoogle();
    //     if (user != null) {
    //       emit(AuthSuccess(userId: user.uid));
    //     } else {
    //       emit(AuthFailed(error: 'Google sign in failed!!!!!!!!'));
    //     }
    //   } catch (e) {
    //     log('Google Sign in Failed : $e');
    //     emit(AuthFailed(error: 'Google sign in failed'));
    //   }
    // });

    // // Facebook Login
    // on<AuthFacebookLoginRequested>((event, emit) async {
    //   emit(AuthLoading());
    //   try {
    //     final user = await authService.signInWithFacebook();
    //     if (user != null) {
    //       emit(AuthSuccess(userId: user.uid));
    //     } else {
    //       emit(AuthFailed(error: 'Facebook sign in failed'));
    //     }
    //   } catch (e) {
    //     emit(AuthFailed(error: 'Facebook sign in failed'));
    //   }
    // });

    // // Twitter Login
    // on<AuthTwitterLoginRequested>((event, emit) async {
    //   emit(AuthLoading());
    //   try {
    //     final user = await authService.signInWithTwitter();
    //     if (user != null) {
    //       emit(AuthSuccess(userId: user.uid));
    //     } else {
    //       emit(AuthFailed(error: 'Twitter sign in failed'));
    //     }
    //   } catch (e) {
    //     emit(AuthFailed(error: 'Twitter sign in failed'));
    //   }
    // });

    //Logout
    on<AuthLogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService.logOut();
        emit(AuthInitial());
      } catch (e) {
        emit(AuthFailed(error: 'Logout failed. Please try again.'));
      }
    });
  }
}
