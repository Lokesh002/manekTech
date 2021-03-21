import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

class Networking {
  Future postData(int page) async {
    print('API called');
    http.Response getResponse = await http.post(
      "http://205.134.254.135/~mobile/MtProject/api/v1/product_list",
      body: convert.jsonEncode({"page": page, "perPage": 5}),
      headers: {
        "Content-Type": "application/json",
        "token":
            "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz"
      },
    );

    if (getResponse.statusCode == 200) {
      print(getResponse);
      return convert.jsonDecode(getResponse.body);
    } else {
      print(getResponse.statusCode);
    }
    return null;
  }
}
