import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:transparent_image/transparent_image.dart'; //bunu import etme sebebimiz, yavaşça gösterilecek görsel gelirken arka plana
// tranparan bir görüntüyü place holder olarak kullanabilmek.

class MealItam extends StatelessWidget {
  const MealItam({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge, //Stacki forcelayarak yuvarlak kenar elde etmemizi sağlar
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Stack(//daha önce kullandık, üst üste gelen widgetları temsil eder. İlk widget her zaman en arkadakidir. Bu yüzden aşağıda görseli kullandık.
          children: [
            FadeInImage(fit: BoxFit.cover, height: 200, width: double.infinity,
                //FadeInImage yavaşça ekranda beliren bir görsel entegre etmemize yarar
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl))
            //kTransparentImage yukarıda anlattığım pakette bize gelen transparan görsel. MemoryImage, bellekten görsel yüklememizi sağlar
            ,
            Positioned( //containerın stack üzerindeki poziyosnunu ayarlar.
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
                        softWrap: true, //yazı eğer taşarsa yeniden biçimlendirilirken güzel görünmesini sağlar
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white, ),
                      ),
                      Row(
                        children: [],
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
