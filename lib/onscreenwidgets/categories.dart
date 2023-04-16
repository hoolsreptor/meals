import 'package:flutter/material.dart';
import 'package:meals/nonscreenwidgets/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,});

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
            CategoryGridItem(category: category)
            //category indexli ile availableCategories içerisinde loop çalıştırdık, bu loopu CategoryGridItem'a yönlendirdik ve böylece içerisinde ayarlamış
            //olduğumuz tüm kişiselliştirme ayarlarını da kullanabildik.
            , 
        ],
      ),
    );
  }
}
