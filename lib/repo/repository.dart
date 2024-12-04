import '../modal/modal.dart';
import 'package:http/http.dart' as http;

class Repository{
  final String apiKey = "0Glnko2HRNTHKquVdmR9zTnFoq9RwlnjXqiEE1obSdBTVgc73CSZiMCT";
  final String baseURL = "https://api.pexels.com/v1/";

  Future<List<Images>> getImagesList({required int? pageNumber}) async {
    String url = '';

    if (pageNumber == null) {
      url = "$baseURL?per_page=80";
    }
    else {
      url = "$baseURL?per_page=80&page=$pageNumber";
    }

    List<Images> imageList = [];

    try {
      final response = await http.get(
          Uri.parse(url),
          headers: {
            'Authorization': apiKey,
          },
      );

      if(response.statusCode >= 200 && response.statusCode <= 299){
        final jsonData = json.decode(response.body);

        for(final json in jsonData["photos"] as Iterable) {
          final image = Images.fromJson(json);
          imageList.add(image);
        }
      }
    } catch (_) {}

    return imageList;
  }

  Future<Images> getImageById({required int id}) async{
    final url = "${baseURL}photos/$id";

    Images image = Images.emptyConstructor();
    
    try{
      final response = await http.get(
          Uri.parse(url),
          headers: {
          'Authorization': apiKey,
          },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final jsonData = json.decode(response.body);

        image = Images.fromJson(jsonData);

      } catch (_) {}
      return image;
    }

    Future<List<Images>> getImagesBySearch
  }
}