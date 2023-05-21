import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meals_item.dart';
import 'package:meals/onscreenwidgets/meal_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  //aşağıdaki yiyeceklerin liste idsini alabildmek için List<Meal> meals argümanını kullandık. Bu sayede ListView ile meals.lenght uzunluğunda
  //bir liste oluştururken itemBuilder ile meals.[index].title ile models titleı indexledik. Bu sayede Meals(title)'a bağlı dummydatadan veri çektik

  final String? title;
  final List<Meal> meals;

  void selectmeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealDetailsScreen(meal: meal),
    ));
    //Void fonksiyonun amacı MealDetailsScreen'i MealsItam'a iletebileceğimiz  ve ListView builderda kullanabilmek için. Bu fonksiyonu
    //meals_item'da kullanıyoruz. Sebebi InkWell'de herbir meal için onTap'ın ne yapacağını belirlemek için
    //Navigator.of().push metoduyla geri de gelebileceğimiz bir ekran oluşturmuş oluyoruz.
  }

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
          itemBuilder: (ctx, index) => MealItam(
                meal: meals[index],
                onSelectmeal: (context, meal) {
                  selectmeal(context, meal);
                },
              ));
    }

//Karışılıklık olmaması açısından meals.dartta yaptığımız değişikliği burada anlatacağım. İki adet appbar title olmaması için meals.darttaki string title'ı string? title
//yaptık. Böylece title hem null hem de dolu olabilir hale getirdik. Ardından required yazısını kaldırdık çünkü artık null da olabildiği için ve yerine favorites tabındaki
//dataları kullanacağımız için sildik. Ardından if döngüsü ile eğer title = null ise contente geri döndürdük. Ancak hiçbir zaman null olmayacağınız biliyoruz.
//Sadece favorilerde null olacak. Ancak onu da burada ayarladığımız için null safetye ihtiyacımız kalmadı.

    if (title == null) {
      return content;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
