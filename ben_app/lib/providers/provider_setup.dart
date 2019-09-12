import 'package:provider/provider.dart';

import 'view_models/login_model.dart';

final List<SingleChildCloneableWidget> providers = [
  // _independentServices,
  // _dependentServices,
  // _states
  ChangeNotifierProvider(builder: (context) => LoginViewModel()),
];
