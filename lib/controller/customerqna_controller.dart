import 'package:get/get.dart';
import 'package:scanpackage/data/question_model.dart';
import 'package:scanpackage/network/api_service.dart';
import 'package:scanpackage/screen/home/bottom_navigation_screen.dart';

class CustomerQnAController extends GetxController {
  CustomerQnAController();
  final ApiService _apiService = ApiService();

  // Observable properties
  var isLoading = true.obs;
  var questions = <QuestionModel>[].obs;
  var answers = <LogisticAnswer>[].obs;
  var selectedValues = <int, dynamic>{}.obs;

  // Fetch questions from the API
  Future<void> fetchQuestions(int itemID, String shopUrl) async {
    isLoading.value = true; // Set loading state
    try {
      // Call the instance method
      QNAModel? fetchedQuestions =
          await _apiService.fetchRmaQuestions(itemID, shopUrl);

      if (fetchedQuestions != null) {
        questions.value = fetchedQuestions.questions;
        answers.value = fetchedQuestions.logisticAnswers;

        for (var answer in answers) {
          selectedValues[answer.returnLogisticsQuestionId] = answer.answer;
        }
      }
    } catch (e) {
      print("Error fetching questions: $e");
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }

  // Submit questions to the API
  Future<void> submitQuestions(int itemID, String shopUrl) async {
    List<Map<String, dynamic>> answers = questions.map((question) {
      return {
        "id": question.id,
        "title": question.title,
        "answer": selectedValues[question.id] is List<String>
            ? selectedValues[question.id]
            : [selectedValues[question.id]?.toString() ?? '']
      };
    }).toList();

    Map<String, dynamic> payload = {"answers": answers};

    final response =
        await _apiService.submitQuestions(itemID, shopUrl, payload);

    if (response != null) {
      Get.snackbar('Success', 'Questions submitted successfully');
       Get.off(() =>  BottomNavScreen()); // Ensure HomeScreen is a widget
    } else {
      Get.snackbar('Error', 'Failed to submit questions');
    }
  }
}
