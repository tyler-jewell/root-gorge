// Copyright (c) 2022, Mezops
// https://mezops.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:marker_repository/marker_repository.dart';
import 'package:root_gorge/app/app.dart';
import 'package:root_gorge/bootstrap.dart';

void main() {
  bootstrap(() => App(markerRepository: MarkerRepository()));
}
