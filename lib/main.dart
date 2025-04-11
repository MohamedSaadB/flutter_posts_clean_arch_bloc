import 'package:flutter/material.dart';
import 'package:posts_app_clean_arch_bloc/core/app_theme.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/bloc/add_update_delete_posts/add_update_delete_bloc.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/pages/posts_screen.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await di.initInject();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:themeData,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(providers: [
      BlocProvider(create:(_)=> di.sl<PostsBloc>()..add(GetAllPostsEvent())),
      BlocProvider(create:(_)=> di.sl<AddUpdateDeleteBloc>()),

    ],
        child:MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Posts App',
            home: PostsScreen()));
  }
}
