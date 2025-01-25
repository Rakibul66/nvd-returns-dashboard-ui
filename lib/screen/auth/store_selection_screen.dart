import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scanpackage/contstants/colors.dart';

class StoreSelectionModal extends StatefulWidget {
  final List<String> stores;
  
  const StoreSelectionModal({super.key, required this.stores});

  @override
  State<StoreSelectionModal> createState() => _StoreSelectionModalState();
}

class _StoreSelectionModalState extends State<StoreSelectionModal> {
  String? _selectedStore;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please select a store:',
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.stores.length,
                itemBuilder: (context, index) {
                  final store = widget.stores[index];
                  final isSelected = _selectedStore == store;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedStore = store;
                      });
                    },
                    child: Card(
                      elevation: isSelected ? 2 : 0,
                      color: isSelected ? lightGrey : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected ? primaryRedColor : lightGrey,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            store,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.green : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 45,
              width: 180.w,
              child: ElevatedButton(
                onPressed: _selectedStore == null
                    ? null
                    : () {
                        Navigator.pop(context, _selectedStore);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRedColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Select',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
