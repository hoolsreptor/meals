import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});

  //models/category de id title ve renk için oluşturduğumuz sınıfı aşağıda kullandık. Böylece özelleştirmelerimize sahip olabilecek.
  

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //inkwell ve gesturedetection aynı işlevi görür, ancak inkwell daha userfriendly
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        //padding ve yukarıdaki borderradius aynı olmalı,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          //Listedeki renkleri dummy_datada bulunan renk ayarlarımızdan çektik
          //gradient kutunun değişim ölçüsüdür
            gradient: LinearGradient(colors: [
          //yukarıdaki Category category indexiyle oluşturduğumuz girdiyle aşağıda categoriye color ayarlamalarını iletiyoruz.    
          category.color.withOpacity(0.55),
          category.color.withOpacity(0.9)
        ],)),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
