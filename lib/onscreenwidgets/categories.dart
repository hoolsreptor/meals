import 'package:flutter/material.dart';
import 'package:meals/nonscreenwidgets/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/onscreenwidgets/meals.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
  });

//Navigatorü daha önce kullanmıştuk. .push ile ekran üzerinde ekran açaarak mealsa yönlendirmek için yaptık.
//Statelessta contexti global kullanamayacağımız için void fonksiyon parantezinde BuildContext contexti birkez daha kullandık.
  void _selectCategory(BuildContext context, Category category) {
final filteredmeals = dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();
//filteredmeals argümanı oluşturduk. Datamızdaki dummyMeals üzerinde iterable olan where aracını kullandık. meal indexi ile "contains" sayesinde
// dummyData içindeki idyi filtreledik. Sonra toList ile listeye çevirdik
//ardından aşada MealsScreen'e filtered mealsi ilettik. Seçilen kategoriye ait idye bağlı titleları görüntülemek için category.title kullandık

    //Navigator.push(context, route) alternatif yol, ama aşağıdaki daha fazla kullanılır.
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealsScreen(title: category.title, meals: filteredmeals),
    ));
  //push metoduyla ekran üzerinde ekran açarak MaterialPageRoute'u kullanmamız gerekiyor, builderimiz ise daha önce oluşturduğumuz MealsScreen Widgetı
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick your category"),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        //GridView bir adet scroolable ızgara görünümü elde edip editlememize olanak verir.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          //availableCategories.map((e) => CategoryGridItem(category: e)).toList()
          //yukarıdaki alternatif yöntem, ancak köşeli parantez kullanma. Daha önce kullanmıştık, biliyorsun.
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },//gridviewdaki positional fonksiyonu buraya bağladık
            )
          //category indexli ile availableCategories içerisinde loop çalıştırdık, bu loopu CategoryGridItem'a yönlendirdik ve böylece içerisinde ayarlamış
          //olduğumuz tüm kişiselliştirme ayarlarını da kullanabildik.
          ,
        ],
      ),
    );
  }
}
