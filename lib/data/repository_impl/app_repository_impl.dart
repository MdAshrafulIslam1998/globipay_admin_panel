import '../remote/app_remote_data_source.dart';
import '../repository/app_repository.dart';

/**
 * Created by Abdullah on 13/10/24.
 */


class AppRepositoryImpl extends AppRepository{
  AppRemoteDataSource remoteDataSource;
  AppRepositoryImpl(this.remoteDataSource);



}