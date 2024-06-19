import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sushi_app/utils/constants.dart';
import 'package:sushi_app/utils/secure_storage_util.dart';

import '../cubit/auth/auth_cubit.dart';
import '../pages/login_page.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;
  const AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return FutureBuilder<String?>(
      future: _getAccessTokenFromSecureStorage(),
      builder: (context, snapshot) {
        final storedAccessToken = snapshot.data;

        if (snapshot.connectionState == ConnectionState.done) {
          if (storedAccessToken != null &&
              storedAccessToken == authCubit.state.accessToken) {
            return child; // Display the child screen if tokens match
          } else {
            return const LoginPage(); // Redirect if no token or mismatch
          }
        } else {
          // Show a loading indicator while fetching the token
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<String?> _getAccessTokenFromSecureStorage() async {
    try {
      final accessToken =
          await SecureStorageUtil.storage.read(key: tokenStoreName);
      return accessToken;
    } catch (e) {
      // Handle potential errors (e.g., storage unavailable, decryption issues)
      debugPrint('Error while retrieving access token: $e');
      return null;
    }
  }
}
