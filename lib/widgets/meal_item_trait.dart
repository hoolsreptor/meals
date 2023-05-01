import "package:flutter/material.dart";

//bu widgetın amacı meals_itemda sürekli aynı komutları kullanacağımız için, içeriğini değiştirebileceğimiz bir widget oluşturmaktan ibaret.

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
