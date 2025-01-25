import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanpackage/contstants/shared_pref_manager.dart';
import 'package:scanpackage/data/auth_token.dart';
import 'package:scanpackage/data/question_model.dart';
import 'package:scanpackage/data/return_history.dart';
import 'package:scanpackage/data/return_queue_model.dart';
import 'package:scanpackage/data/rma_data.dart';
import 'package:scanpackage/data/shipping_status.dart';
import 'package:scanpackage/data/merchants.dart';

class ApiService extends GetxService {
  final dio.Dio dioInstance = dio.Dio(BaseOptions(
    baseUrl: "https://returns-api.navidiumapp.com/api",
    connectTimeout: Duration(seconds: 5), // Updated to use Duration
    receiveTimeout: Duration(seconds: 3), // Updated to use Duration
  ));



  ApiService() {
    // Setup interceptors for request batching and optimization
    dioInstance.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add caching mechanism using Cache-Control headers
        options.headers['Cache-Control'] = 'public, max-age=300'; // 5 minutes
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle response
        return handler.next(response);
      },
      onError: (error, handler) {
        // Check for DioError type and handle connectivity error
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.unknown ||
            error.type == DioExceptionType.receiveTimeout) {
          _showNoInternetDialog();
        }
        return handler.next(error);
      },
    ));
  }
 // Method to show the "No Internet Connection" dialog
  void _showNoInternetDialog() {
    Get.defaultDialog(
      title: "No Internet Connection",
      content: Text("Please connect to \n the internet and try again."),
      textConfirm: "OK",
      onConfirm: () {
        Get.back(); // Close the dialog
      },
    );
  }

  // Method to sign message with HMAC-SHA256
  String signMessage(String message, String secret) {
    final hmac = Hmac(sha256, utf8.encode(secret));
    final digest = hmac.convert(utf8.encode(message));
    return digest.toString();
  }

// Fetch Return Histories with batching capability
Future<HistoryResponse?> fetchReturnHistories({
  String? searchQuery,
  String? fromDate,
  String? toDate,
}) async {
  try {
    // Build the query parameters
    final queryParameters = {
      if (searchQuery != null && searchQuery.isNotEmpty) 'search_query': searchQuery,
      if (fromDate != null) 'from_date': fromDate,
      if (toDate != null) 'to_date': toDate,
    };

    final response = await dioInstance.get(
      '/return/histories',
      queryParameters: queryParameters, // Add query parameters here
      options: dio.Options(headers: {
        "authorization": '',
        "shop": ''
      }),
    );

    if (response.statusCode == 200) {
      return HistoryResponse.fromJson(response.data);
    }
    return null;
  } catch (e) {
    print('Error fetching return histories: $e');
    return null;
  }
}


// Return Queue
Future<List<ReturnQueueModel>> fetchReturnQueueLists() async {
  try {
    // Get the auth token and selected store from SharedPrefManager
    final authToken = SharedPrefManager.getAuthToken();
    final selectedStore = await SharedPrefManager.getSelectedStore();

    // Log the token and selected store
    print("Auth Token: ${authToken?.accessToken}");
    print("Selected Store: $selectedStore");

    // Check if the token and store are available
    if (authToken == null || selectedStore == null) {
      throw Exception('Authorization token or selected store is not available');
    }

    // Set the headers using the token and store
    final response = await dioInstance.get(
      '/return/inspects',
      options: dio.Options(headers: {
        "authorization": authToken.accessToken,
        "shop": selectedStore,
        
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['returns']['data'];
      return data.map((item) => ReturnQueueModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load return data');
    }
  } catch (e) {
    // Handle DioException and other exceptions separately
    if (e is DioException) {
      String errorMessage = _getErrorMessage(e);
      print("DioException caught: $errorMessage"); // Log DioException details
      _showErrorDialog(errorMessage);
    } else {
      print("Unexpected error: $e"); // Log other types of errors
      _showErrorDialog("An unexpected error occurred. Please try again.");
    }
    return [];
  }
}



// Method to show error dialog
void _showErrorDialog(String message) {
  Get.defaultDialog(
    title: "Error",
    content: Text(message),
    textConfirm: "OK",
    onConfirm: () {
      Get.back(); // Close the dialog
    },
  );
}

// Method to get error message based on DioException type
String _getErrorMessage(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return "Connection timed out. Please check your internet connection.";
    case DioExceptionType.sendTimeout:
      return "Request timed out. Please try again.";
    case DioExceptionType.receiveTimeout:
      return "Server took too long to respond.";
    case DioExceptionType.badResponse:
      return "Received invalid status code: ${e.response?.statusCode}";
    case DioExceptionType.cancel:
      return "Request was cancelled.";
    default:
      return "An unexpected error occurred.";
  }
}

  // Method to submit question answers with optimized API call
  Future<dynamic> submitQuestions(
      int itemID, String shopUrl, Map<String, dynamic> payload) async {
    try {
      dio.Response response = await dioInstance.post(
        '/return/app/show/$itemID',
        data: payload,
        options: dio.Options(headers: {
          "authorization": '',
          "Content-Type": 'application/json',
          "shop": shopUrl,
        }),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      print("Error submitting questions: $e");
      return null;
    }
  }

  // Fetch RMA Questions with URLCache support for iOS
  Future<QNAModel?> fetchRmaQuestions(int itemID, String shopUrl) async {
    try {
      dio.Response response = await dioInstance.get(
        '/return/app/show/$itemID',
        options: dio.Options(headers: {
          "authorization": '',
          "shop": shopUrl,
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> questionsData = response.data['data']['questions'];
        List<QuestionModel> questions =
            questionsData.map((q) => QuestionModel.fromJson(q)).toList();

        List<dynamic> logisticAnswersData =
            response.data['data']['logistic_answers'];
        List<LogisticAnswer> logisticAnswers = logisticAnswersData
            .map((answer) => LogisticAnswer.fromJson(answer))
            .toList();

        return QNAModel(questions: questions, logisticAnswers: logisticAnswers);
      }
      return null;
    } catch (e) {
      print("Error fetching RMA questions: $e");
      return null;
    }
  }


// Method to fetch RMA data with HMAC-SHA256 signature
Future<RmaData?> fetchRmaData(String rmaNumber, String secret) async {
  try {
    String hmacSignature = signMessage(rmaNumber, secret);

    dio.Response response = await dioInstance.get(
      '/return/app/show',
      queryParameters: {"rma_number": rmaNumber},
      options: dio.Options(headers: {
        "app-hmac": hmacSignature,
        "authorization": '',
        "shop": '',
      }),
    );

    if (response.statusCode == 200) {
      return RmaData.fromJson(response.data['data']);
    }
    return null;
  } catch (e) {
    if (e is DioException && e.response?.statusCode == 404) {
      // Show Snackbar for invalid RMA request
      Get.snackbar(
        'Invalid RMA Request',
        'The RMA number you entered is incorrect. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } else {
      // Show generic error message for other errors
      Get.snackbar(
        'Error',
        'An error occurred while fetching RMA data. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
    print("Error fetching RMA data: $e");
    return null;
  }
}


   Future<AuthToken?> login(String email, String password) async {
    try {
      // Prepare form data for the OAuth token request
      final formData = dio.FormData.fromMap({
        'grant_type': 'password',
        'client_id': '9d4dbfc8-a13f-45d5-9263-f94ace096958',
        'client_secret': '1RjSpKSIIILx4v6MrnUHapCAORaYN8k1YbsfhfjP',
        'username': email,
        'password': password,
        'scope': ''
      });

      // Request the OAuth token
      final tokenResponse = await dioInstance.post(
        'https://auth.nvdmini.com/oauth/token',
        data: formData,
      );

      // Check if the response is successful
      if (tokenResponse.statusCode == 200) {
        return AuthToken.fromJson(tokenResponse.data);
      } else {
        print("Login failed with status code: ${tokenResponse.statusCode}");
        print("Response data: ${tokenResponse.data}");
      }
    } catch (e) {
      print("Login Error: $e");
    }
    return null;
  }


//marchant store list 

Future<MerchantResponse?> fetchMerchants({int page = 1}) async {
  try {
    // Retrieve auth token from SharedPrefManager
    AuthToken? authToken = SharedPrefManager.getAuthToken();

    // Check if token is available
    if (authToken == null) {
      print("No access token available.");
      return null;
    }

    // Fetch merchants data with pagination
    dio.Response merchantsResponse = await dioInstance.get(
      'https://auth.nvdmini.com/api/merchants',
      queryParameters: {'page': page},
      options: dio.Options(
      headers: {
          'Authorization': 'Bearer ${authToken.accessToken}',
          'Service': 'shipping_protection', // Added Service header
        },
      ),
    );


    // Check if merchants data request is successful
    if (merchantsResponse.statusCode == 200) {
      return MerchantResponse.fromJson(merchantsResponse.data);
    } else {
      print("Failed to fetch merchants data: ${merchantsResponse.statusCode}");
    }
  } catch (e) {
    print("Fetch Merchants Error: $e");
  }
  return null;
}


  // Forgot Password
  Future<dynamic> forgotPassword(String email) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({'email': email});

      dio.Response resetResponse =
          await dioInstance.post('/forgot-password', data: formData);

      if (resetResponse.statusCode == 200) {
        return resetResponse.data;
      } else {
        return {
          'status': resetResponse.statusCode,
          'message': 'Failed to send reset link',
        };
      }
    } catch (e) {
      return {
        'status': 500,
        'message': 'An error occurred. Please try again.',
      };
    }
  }

// Method to fetch shipping count data
Future<List<ShippingStatus>> fetchShippingCount() async {
  try {
    dio.Response response = await dioInstance.get(
      '/return/return/shipping-count',
      options: dio.Options(headers: {
        "authorization": '',
        "shop": ''
      }),
    );
    
    if (response.statusCode == 200) {
      List<dynamic> data = response.data['total_shipping_status'];
      return data.map((item) => ShippingStatus.fromJson(item)).toList();
    } else {
      Get.snackbar("Error", "Failed to fetch shipping count data");
      return [];
    }
  } catch (e) {
    print("Error fetching shipping count data: $e");
    Get.snackbar("Error", "Error fetching shipping count data: $e");
    return [];
  }
}



}