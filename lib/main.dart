import 'package:app_clean_arch/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:app_clean_arch/core/theme/theme.dart';
import 'package:app_clean_arch/feature/presentation/bloc/auth_bloc.dart';
import 'package:app_clean_arch/feature/presentation/pages/login_page.dart';
import 'package:app_clean_arch/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (context) => serviceLocator<AppUserCubit>()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      //El bloc selector se encarga de seleccionar el widget que se va a mostrar en la pantalla
      //dependiendo de si el usuario esta logueado o no
      //Si el usuario esta logueado, no se muestra la pagina de login
      //Si el usuario no esta logueado, se muestra la pagina de login
      //El bloc selector solo se enfoca en un estado en especifico
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const Scaffold(body: Center(child: Text('Home Logged In')));
          }
          return const LoginPage();
        },
      ),
    );
  }
}
