// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:root_gorge/app/app.dart';
import 'package:root_gorge/bootstrap.dart';
import 'package:root_gorge/local_map_api.dart';
import 'package:root_gorge/map_repository.dart';

void main() {
  final localMapApi = LocalMapApi();
  final mapRepository = MapRepository(localMapApi: localMapApi);

  bootstrap(() => App(mapRepository: mapRepository));
}
