import "package:flutter/material.dart";
import 'package:meals/onscreenwidgets/categories.dart';
import 'package:meals/onscreenwidgets/meals.dart';
import 'package:meals/models/meal.dart';
//burayı navigasyon barını yönetmek için oluşturduk

//Karışılıklık olmaması açısından meals.dartta yaptığımız değişikliği burada anlatacağım. İki adet appbar title olmaması için meals.darttaki string title'ı string? title
//yaptık. Böylece title hem null hem de dolu olabilir hale getirdik. Ardından required yazısını kaldırdık çünkü artık null da olabildiği için ve yerine favorites tabındaki
//dataları kullanacağımız için sildik. Ardından if döngüsü ile eğer title = null ise contente geri döndürdük. Ancak hiçbir zaman null olmayacağınız biliyoruz.
//Sadece favorilerde null olacak. Ancak onu da burada ayarladığımız için null safetye ihtiyacımız kalmadı.

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {

//Snackbarı daha önce de kullandık burada snackbarı kullanmak üzere bir fonksiyon oluşturarak snackbarın silinmesini ve içerik göstermesini ve bu içeriğin text içermesini belirtiyoruz.
void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }



  //Models meal üzerinde boş bir liste oluşturduk. Arından bir fonksiyon yaptık. Daha sonra if döngüsünde kullanmak üzere isExisting değişkeni oluşturduk. Bunu da listede meal
  //içeren _favoriteMeals. ile eşitledik.
  //If döngüsünde ise eğer isExisting true ise yani bir şey içerisinde varsa seçili hale gelince içindeki kaldırılır. Eğer değilse içerisine ekleme yapılır
  //Aşağıda favori ekleyip kaldırdığımızda kullanacağımız snackbara bağlı void fonksiyonumuzun nasıl çalışacağını ayarlıyoruz.
  final List<Meal> _favoriteMeals = [];
  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage("Meal is no longer a favorite");
      });
    } else {
      _favoriteMeals.add(meal);
      _showInfoMessage('Marked as favorite');
    }
  }

  //2 tane öğemiz var BottomNavigationda, bu yüzden _selectedPageIndex kurduk, bunu da index ile eşitleyen fonsiyon haline getirerek
  //onTap'ta kullanmak için oluşturduk
  int _selectedPageIndex = 0;
  void selectedPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Burada aktifsayfamızı kategori widgetıyla eşitliyoruz. AppBar titleında kullanmak için activePageTitle oluşturduk, bu sayede bottomnavigationbarda yapacağımız değişikliklerde
    //başlığın değişmesini sağlayabileceğiz.
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = "Categories";

//_selectedpageindexte 1 numarada Favorites var. Bu yüzden mantık kuruyoruz. Eğer 1'e eşitse aşağıdaki favorites alanını istediğimize göre şekillendiriyoruz.
//index 0'dan bire geçerse AppBar başlığını da favorimize göre değiştirmiş oluyoruz.
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = "Your favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: selectedPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
        ],
      ),
    );
  }
}
