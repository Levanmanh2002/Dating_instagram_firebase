import 'package:dattings/datings/models/data.dart';
import 'package:flutter/material.dart';

class ItemUserCard extends StatelessWidget {
  final Data data;
  final int index;
  const ItemUserCard(
    this.data, {
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/avatar.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.sentiment_satisfied_alt,
                                size: 15,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                data.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.pink,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 14,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                "${data.sex} - ${data.age} tuổi - ${data.marriage}",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.pink,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                data.address,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.pink,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
