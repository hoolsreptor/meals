import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart'; //bunu import etme sebebimiz, yavaşça gösterilecek görsel gelirken arka plana
// tranparan bir görüntüyü place holder olarak kullanabilmek.
import 'package:meals/widgets/meal_item_trait.dart';

class MealItam extends StatelessWidget {
  const MealItam({super.key, required this.meal, required this.onSelectmeal});

  final Meal meal;

  final void Function (BuildContext context, Meal meal) onSelectmeal;
  //bu fonsiyonu Meals'ta oluşturduğumuz void fonksiyonla birleştiriyoruz. Amaç, InkWell onTap'a işlevsellik vermek.

  //Aşağıdaki gettersı daha önce kullanmıştık. Affordable ve complexity datalarda enum olarak kayıtlı. Bu yüzden bu sıralamayı 0,1,2 şeklinde olan sıralamayı
  //Stringe çevirmeliyiz. Bir numerik değeri olan bir listeyi yada widgetı Stringe çevirmek için String geti kullandık.
  //Enum olarak isimlere girildiği için namei kullandık ve kelimenin ilk değeri 0 olduğu için liste metoduyla 0'ı seçtik ve bu değeri .toUppercase ile büyük harfe çevirdik
  //Enumun devamını da stringe çevirmek için + .substring metodunu kullandık. .substring ile 0,1,2,3 sıralamasından 1 den başlayarak returnledik. 0 'ı zaten seçmiştik
  //substring basitçe bir index ve rakamla atanmış bir stringin bir kısmını Stringe çevirirken kullandığımız bir buildin method.
  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip
          .hardEdge, //Stacki forcelayarak yuvarlak kenar elde etmemizi sağlar
      elevation: 2,
      child: InkWell(
        onTap: (){onSelectmeal(context,meal);},
        child: Stack(
          //daha önce kullandık, üst üste gelen widgetları temsil eder. İlk widget her zaman en arkadakidir. Bu yüzden aşağıda görseli kullandık.
          children: [
            FadeInImage(
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                //FadeInImage yavaşça ekranda beliren bir görsel entegre etmemize yarar
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl))
            //kTransparentImage yukarıda anlattığım pakette bize gelen transparan görsel. MemoryImage, bellekten görsel yüklememizi sağlar
            ,
            Positioned(
                //containerın stack üzerindeki poziyosnunu ayarlar.
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap:
                            true, //yazı eğer taşarsa yeniden biçimlendirilirken güzel görünmesini sağlar
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //normalde row içinde row kullanırsan hata alırsın ama burada almadık. Çünkü Positioned() widgetı sayesinde genişliği sabit bir değer ile
                        //containera, oradan columna, oradan rowa ve ikinci rowa ilettik. Yani ikinci row, olabildiğince genişliğe zorlanmamış. Çünkü zaten sabit bir değer
                        //genişlik için belirlenmiş durumda.
                        children: [
                          MealItemTrait(
                              icon: Icons.schedule,
                              label:
                                  "${meal.duration} min") //min standart bi string, yazının devamına herhangi bir şey ekleyebilirsin
                          ,
                          const SizedBox(
                            width: 12,
                          ),
                          MealItemTrait(
                              icon: Icons.work, label: complexityText),
                          const SizedBox(
                            width: 12,
                          ),
                          MealItemTrait(
                              icon: Icons.attach_money,
                              label: affordabilityText),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
