import 'dart:math';

import 'package:rider/models/distance_time_model.dart';

class Distance {
  DistanceTime calculateDistanceTimePrice(double lat1, double lon1, double lat2,
      double lon2, double speedKmPerHr) {
    // Covert Lattituds & longitueds from degres to radian

    var rLat1 = _toRadians(lat1);
    var rLon1 = _toRadians(lon1);
    var rLat2 = _toRadians(lat2);
    var rLon2 = _toRadians(lon2);

    //Haversine Formula
    var dLat = rLat1 - rLat2;
    var dLon = rLon1 - rLon2;

    var a =
        pow(sin(dLat / 2), 2) + cos(rLat1) * cos(rLat2) * pow(sin(dLon / 2), 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));

    //raduis of the eart in kilometers
    const double earthRaduisInKm = 6371.0;
    var distance = (earthRaduisInKm * 2) * c;

    //calculate time(distance / speed)
    var time = distance / speedKmPerHr;
    time = time * 60;

    return DistanceTime(distance: distance, time: time);
  }

  //  helper function to convert degress to radians
  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
