import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanpackage/controller/customerqna_controller.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/data/question_model.dart';
import 'package:scanpackage/widget/custom_progressbar.dart';

class CustomerQnA extends StatefulWidget {
  final int itemID;
  final String shopUrl;

  const CustomerQnA({super.key, required this.itemID, required this.shopUrl});

  @override
  CustomerQnAState createState() => CustomerQnAState();
}

class CustomerQnAState extends State<CustomerQnA> {
  late final CustomerQnAController _controller;
  final Map<int, TextEditingController> _textControllers = {};
  @override
  void initState() {
    super.initState();
    _controller = Get.put(CustomerQnAController());
    _controller.fetchQuestions(widget.itemID, widget.shopUrl);
  }
@override
  void dispose() {
    // Dispose of all controllers when the widget is disposed
    _textControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.isLoading.value) {
        return const Center(
          child: CustomProgressIndicator(
            backgroundColor: primaryRedColor,
            color: Colors.orange,
            strokeWidth: 2.0,
            strokeCap: StrokeCap.round, // Optional
          ),
        );
      }

      if (_controller.questions.isEmpty) {
        return const Center(child: Text('No questions available'));
      }

      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 4.0, vertical: 4.0), // Padding around the entire column
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Padding inside the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._controller.questions.map((question) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0), // Spacing between questions
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black, // Use primary red color
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildAnswerOptions(question),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _controller.submitQuestions(
                    widget.itemID, widget.shopUrl),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: primaryRedColor,
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text('Submit Answers'),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAnswerOptions(QuestionModel question) {
    switch (question.type) {
      case 'input':
        return _buildTextInput(question.id);
      case 'select':
        return _buildChoiceChip(question.id, question);
      case 'radio':
        return _buildRadioOptions(question.id, question);
      case 'checkbox':
        return _buildCheckboxOptions(question.id, question);
      default:
        return const SizedBox.shrink();
    }
  }

 Widget _buildTextInput(int questionId) {
    // Check if there's already a controller for this question, otherwise create a new one
    if (!_textControllers.containsKey(questionId)) {
      final selectedValues = _controller.selectedValues[questionId];
      _textControllers[questionId] = TextEditingController(
        text: selectedValues is List<String>
            ? selectedValues[0]
            : selectedValues?.toString() ?? '',
      );
    }

    final textController = _textControllers[questionId]!;

    return TextField(
      controller: textController,
      onChanged: (value) {
        _controller.selectedValues[questionId] = value; // Update selected value on change
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your answer',
        hintStyle: TextStyle(color: lightGrey), // Hint text style
      ),
    );
  }

  Widget _buildChoiceChip(int questionId, QuestionModel question) {
    return Wrap(
      spacing: 8.0,
      children: question.options?.map((option) {
            final isSelected =
                _controller.selectedValues[questionId] is List<String>
                    ? _controller.selectedValues[questionId][0] == option.value
                    : _controller.selectedValues[questionId] == option.value;

            return ChoiceChip(
              showCheckmark: false,
              label: Text(option.text),
              selected: isSelected,
              onSelected: (selected) {
                _controller.selectedValues[questionId] =
                    selected ? option.value : null;
              },
              backgroundColor: Colors.grey[300], // Default background color
              selectedColor: primaryRedColor, // Selected color
              labelStyle: TextStyle(
                  color: isSelected ? Colors.white : null), // Label color
            );
          }).toList() ??
          [],
    );
  }

  Widget _buildRadioOptions(int questionId, QuestionModel question) {
    return Column(
      children: question.options?.map((option) {
            return RadioListTile<String>(
              activeColor: primaryRedColor,
              title: Text(option.text),
              value: option.value,
              groupValue: _controller.selectedValues[questionId] is List<String>
                  ? _controller.selectedValues[questionId][0]
                  : _controller.selectedValues[questionId],
              onChanged: (value) {
                _controller.selectedValues[questionId] = value;
              },
            );
          }).toList() ??
          [],
    );
  }

  Widget _buildCheckboxOptions(int questionId, QuestionModel question) {
    List<String> selectedOptions =
        _controller.selectedValues[questionId] as List<String>? ?? [];

    return Column(
      children: question.options?.map((option) {
            return CheckboxListTile(
              activeColor: primaryRedColor,
              title: Text(option.text),
              value: selectedOptions.contains(option.value),
              onChanged: (checked) {
                if (checked == true) {
                  selectedOptions.add(option.value);
                } else {
                  selectedOptions.remove(option.value);
                }
                _controller.selectedValues[questionId] = selectedOptions;
              },
            );
          }).toList() ??
          [],
    );
  }
}
