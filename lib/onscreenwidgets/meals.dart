import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  //aşağıdaki yiyeceklerin liste idsini alabildmek için List<Meal> meals argümanını kullandık. Bu sayede ListView ile meals.lenght uzunluğunda
  //bir liste oluştururken itemBuilder ile meals.[index].title ile models titleı indexledik. Bu sayede Meals(title)'a bağlı dummydatadan veri çektik

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    //if döngüsünde daha etkin kullanmak için content diye widget oluşturarak bodye aktarmış olduk.
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Uh... nothing here",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Try selecting a different category!",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItam(meal: meals[index]));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: content);
  }
}
