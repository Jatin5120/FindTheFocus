import 'package:find_the_focus/screens/screens.dart';
import 'package:get/get.dart';

import '../bindings/bindings.dart';
import '../widgets/widgets.dart';
import 'constants.dart';

class AppPages {
  AppPages._();

  static const initialRoute = Routes.login;

  static final List<GetPage> pages = [
    GetPage(
      name: Routes.authWrapper,
      page: () => const AuthenticationWrapper(),
      //  binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.screenWrapper,
      page: () => const ScreenWrapper(),
      //  binding: ScreenWrapperBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      //  binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.loading,
      page: () => const LoadingScreen(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardScreen(),
      //  binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.projects,
      page: () => const ProjectScreen(),
      //  binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.analytics,
      page: () => const AnalyticsScreen(),
      //  binding: AnalyticsBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
      //  binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.questions,
      page: () => const QuestionsWrapper(),
    ),
  ];
}
