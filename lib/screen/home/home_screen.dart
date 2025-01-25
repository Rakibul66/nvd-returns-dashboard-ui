import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanpackage/controller/barcode_controller.dart';
import 'package:scanpackage/controller/user_controller.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/widget/appbar/custom_appbar.dart';
import 'package:scanpackage/widget/banner/banner_card.dart';
import 'package:scanpackage/widget/category/category_widget.dart';
import 'package:scanpackage/widget/shippingcount/shipping_count_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BarcodeController barcodeController = Get.put(BarcodeController());
  final TextEditingController _textController = TextEditingController();
  final UserController userController = Get.find<UserController>();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShippingCountWidget(),
              const SizedBox(height: 8),
              const BannerCard(),
              const SizedBox(height: 8),
              const CategoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
