import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app_clean_arch_bloc/core/network/network_checker.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/data/repo/post_repo_impl.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/repo/post_repository.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/use_cases/add_post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/use_cases/delete_post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/use_cases/get_all_posts.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/domain/use_cases/update_post.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/bloc/add_update_delete_posts/add_update_delete_bloc.dart';
import 'package:posts_app_clean_arch_bloc/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance ;

Future<void> initInject() async{


  //! Featuer => Posts

  // Bloc
   sl.registerFactory(()=> PostsBloc(getAllPostsUseCase: sl()));
   sl.registerFactory(()=> AddUpdateDeleteBloc(addPostUseCase: sl(),
   deletePostUseCase: sl(),
   updatePostUseCase: sl()));

  // Use Case
   sl.registerLazySingleton(()=>AddPostUseCase(sl()));
   sl.registerLazySingleton(()=>UpdatePostUseCase(sl()));
   sl.registerLazySingleton(()=>DeletePostUseCase(sl()));
   sl.registerLazySingleton(()=>GetAllPostsUseCase(sl()));
   
  // Repo
  sl.registerLazySingleton<PostRepository>(()=>PostRepoImpl(
      networkChecker: sl(),
      postRemoteDataSource: sl(),
      postLocalDataSource: sl()));
  
  // Data Source
  sl.registerLazySingleton<PostRemoteDataSource>(()=>PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(()=>PostLocalDataSourceImpl(sharedPreferences: sl()));

  //core
   sl.registerLazySingleton<NetworkChecker>(()=>NetworkCheckerImpl(internetConnectionChecker: sl()));

   // External
   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
  sl.registerLazySingleton(()=>sharedPreferences);
  sl.registerLazySingleton(()=>http.Client());
   sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker.createInstance());

}