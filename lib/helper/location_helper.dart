const GOOGLE_API_KEY = 'AIzaSyCCT6MWoYFOymnKTRMBmkl6QIzRdWkEPKI';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longtiude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longtiude&zoom=16&size=300x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longtiude&key=$GOOGLE_API_KEY';
  }
}
