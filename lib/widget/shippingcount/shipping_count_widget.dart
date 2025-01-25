import 'package:flutter/material.dart';
import 'package:scanpackage/contstants/colors.dart';

class ShippingCountWidget extends StatelessWidget {
  ShippingCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/cardbg.png'), // Replace with your image path
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Queue Summary",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildGrid(),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    List<Widget> rows = [];

    // First Row with two items
    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildItem("Pending Shipment", "25", 0)),
        const SizedBox(width: 8),
        Expanded(child: _buildItem("In Transit", "15", 1)),
      ],
    ));

    rows.add(const SizedBox(height: 8));

    // Second Row with three items
    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildItem("Delivered", "40", 2)),
        const SizedBox(width: 8),
        Expanded(child: _buildItem("Returned", "5", 3)),
        const SizedBox(width: 8),
        Expanded(child: _buildItem("Canceled", "3", 4)),
      ],
    ));

    return Column(children: rows);
  }

  Widget _buildItem(String status, String count, int index) {
    double cardHeight = 58;

    // Format the status text
    String formattedStatus = status
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/item_background_$index.png'), // Image path for each item
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formattedStatus,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: blackLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: blackLight,
            ),
          ),
        ],
      ),
    );
  }
}
