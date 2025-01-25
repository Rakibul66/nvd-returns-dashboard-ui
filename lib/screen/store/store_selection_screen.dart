import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scanpackage/contstants/colors.dart';
import 'package:scanpackage/contstants/image_path.dart';
import 'package:scanpackage/contstants/shared_pref_manager.dart';

import 'package:scanpackage/data/merchants.dart';
import 'package:scanpackage/network/api_service.dart';
import 'package:scanpackage/screen/home/bottom_navigation_screen.dart';


class StoreSelectionScreen extends StatefulWidget {
  @override
  _StoreSelectionScreenState createState() => _StoreSelectionScreenState();
}

class _StoreSelectionScreenState extends State<StoreSelectionScreen> {
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  List<MerchantData> merchants = [];

  @override
  void initState() {
    super.initState();
    loadMerchants();
  }

  Future<void> loadMerchants() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    final response = await ApiService().fetchMerchants(page: currentPage);
    if (response != null) {
      setState(() {
        merchants.addAll(response.merchants.data);
        currentPage++;
        hasMore = response.merchants.data.isNotEmpty;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void _selectStore(String storeName) async {
    await SharedPrefManager.saveSelectedStore(storeName);
    // Navigate to the BottomNavigationScreen
    Get.off(() =>  BottomNavScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: Text(
          'Choose a Store',
          style: TextStyle(
            fontSize: 18.sp, 
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagePaths.statusBarGradient),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16)
            ),
          ),
        ),
    
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: merchants.length + 1,
        itemBuilder: (context, index) {
          if (index < merchants.length) {
            final merchant = merchants[index];
            return Card(
              color: Colors.white,
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(merchant.shopUrl ?? 'N/A'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Service: ${merchant.serviceName}"),
                    Text("Role: ${merchant.role}"),
                    Text("Claims Permission: ${merchant.permissions?.claims ?? 0}"),
                  ],
                ),
                onTap: () => _selectStore(merchant.shopUrl ?? 'N/A'),
              ),
            );
          } else {
            return Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : hasMore
                      ? ElevatedButton(
                          onPressed: loadMerchants,
                          child: Text('Load More'),
                        )
                      : Text('No more stores'),
            );
          }
        },
      ),
    );
  }
}
