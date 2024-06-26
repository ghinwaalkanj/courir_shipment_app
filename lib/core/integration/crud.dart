import 'dart:convert';
import 'dart:io';
import 'package:courir_shipment_app/core/integration/statusrequest.dart';
import 'package:path/path.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../services/checkinternet.dart';

class Crud {
  final InternetService _internetService = InternetService();  // Instantiate InternetService

  Future<Either<StatusRequest, Map>> postData(
      String linkurl, Map data, Map<String, String> headers) async {
    if (await _internetService.isConnected()) {
      var response =
      await http.post(Uri.parse(linkurl), body: data, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);

        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverfailure);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map>> getData(
      String linkurl, Map<String, String> headers) async {
    // if (await checkInternet()) {
    var response = await http.get(Uri.parse(linkurl), headers: headers);
//asdfghjkl;'asdfghjkl;'
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);

      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
    // } else {
    //   return const Left(StatusRequest.offlinefailure);
    // }
  }

  postFileAndData(
      String linkUrl, Map data, Map<String, String> headers, File file) async {
    var request = http.MultipartRequest('Post', Uri.parse(linkUrl));
    int fileLength = await file.length();
    var streamData = http.ByteStream(file.openRead());
    var multiFile = http.MultipartFile('files', streamData, fileLength,
        filename: basename(file.path));
    request.files.add(multiFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    request.headers.addAll(headers);

    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);

      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  }

  postFileAndTwoData(String linkUrl, Map data, Map<String, String> headers,
      File id_front_image, File id_back_image) async {
    var request = http.MultipartRequest('Post', Uri.parse(linkUrl));
    int fileLength = await id_front_image.length();
    int idFileLength = await id_back_image.length();
    var streamData = http.ByteStream(id_front_image.openRead());
    var idStreamData = http.ByteStream(id_back_image.openRead());
    var multiFile = http.MultipartFile('id_front_image', streamData, fileLength,
        filename: basename(id_front_image.path));
    var idMultiFile = http.MultipartFile(
        'id_back_image', idStreamData, idFileLength,
        filename: basename(id_back_image.path));
    request.files.add(multiFile);
    request.files.add(idMultiFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    request.headers.addAll(headers);

    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);

      //print("postMultiData1============ $responsebody");

      return Right(responsebody);
    } else {
      if (response.statusCode == 405) {
        Map responsebody = jsonDecode(response.body);
        //print("postMultiData1============ $responsebody");

        return Left(responsebody);
      }
    }
  }
}
