import 'package:amond/presentation/controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [

];

List<SingleChildWidget> dependentModels = [

];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider(create: (_) => AuthController()),
];