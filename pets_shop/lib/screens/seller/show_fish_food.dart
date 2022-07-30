import 'package:pets_shop/utils/style.dart';
import 'package:pets_shop/widgets/ecobutton.dart';
import 'package:pets_shop/widgets/ecotextfield.dart';
import 'package:flutter/material.dart';

List FishFoodcatagories = [
  "Natural Food",
  "Supplementary Food",
  "Complete Feed",
];

class FishFood extends StatefulWidget {
  //const FishFood({Key? key}) : super(key: key);
  // static const String id = "addproduct";

  @override
  State<FishFood> createState() => _FishFoodState();
}

class _FishFoodState extends State<FishFood> {
  TextEditingController catagoryC = TextEditingController();

  String? selectedValue;
  List naturalFood = [
    "Detritus",
    "Bacteria",
    "Plankton",
    "Worms",
    "Insects"
        "Aquatic plants",
  ];
  List supplementaryFood = [
    "Terrestrial plants",
    "Titchen wastes",
    "Agricultural by-products.",
  ];
  List completeFeed = [
    "extensive",
    "semi-intensive",
    "intensive",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 71, 207, 241),
          title: const Text(
            'Fish Food',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const ExpansionTile(
                title: Text(
                  "Natural Food",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 166, 196),
                  ),
                ),
                children: [
                  ListTile(
                    title: Text(
                      "Dertitus",
                      style: TextStyle(
                          color: Color.fromARGB(255, 250, 50, 24),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    tileColor: Color.fromARGB(255, 159, 225, 255),
                    horizontalTitleGap: 10,
                    subtitle: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                            "Detritivores (also known as detrivores, detritophages, detritus feeders, or detritus eaters) "
                            "are heterotrophs that obtain nutrients by consuming detritus (decomposing plant and animal parts as well as feces)"
                            ". There are many kinds of invertebrates, vertebrates and plants that carry out coprophagy.",
                            textAlign: TextAlign.justify)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      "Bacteria",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    tileColor: Color.fromARGB(255, 253, 165, 162),
                    subtitle: Text(
                        "Bacteria fermented in tanks has been successfully used as a protein source in fish food."
                        " A new study shows that a type of single-celled protein contained in bacteria could replace wild-caught fish"
                        " and agricultural products as an ingredient in salmon feed.",
                        textAlign: TextAlign.justify),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      "Plankton",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    tileColor: Color.fromARGB(255, 159, 225, 255),
                    subtitle: Text(
                        "In oceans, plankton are the essential source of food; the inconstancy in their composition (their diversity)"
                        " influences the fishes' food habits. Plankton community structure indicated the central role of such organisms as a vital"
                        " factor in the fishes spawning.",
                        textAlign: TextAlign.justify),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      "Worms",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    tileColor: Color.fromARGB(255, 253, 165, 162),
                    subtitle: Text(
                        "Several non‐conventional proteins have gained interest as potential alternative protein "
                        "sources for fish feeds. A number of earthworm species have been tested for fish feed production; some"
                        " have nutritional content comparable to fishmeal and are within the recommended nutritional requirements"
                        " of most fish.",
                        textAlign: TextAlign.justify),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      "Aquatic plants",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    tileColor: Color.fromARGB(255, 159, 225, 255),
                    subtitle: Text(
                        "One of the best ways to provide growing plants for fish to eat is to attach either Riccia "
                        "or Java moss (Vesicularia) to driftwood or rocks using cotton thread. As the aquatic plants grow, they"
                        " naturally adhere to the rock or driftwood and provide excellent food plants for fish.",
                        textAlign: TextAlign.justify),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      "plants",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    tileColor: Color.fromARGB(255, 253, 165, 162),
                    subtitle: Text(
                        "One of the best ways to provide growing plants for fish to eat is to attach either Riccia"
                        " or Java moss (Vesicularia) to driftwood or rocks using cotton thread. As the aquatic plants grow, they"
                        " naturally adhere to the rock or driftwood and provide excellent food plants for fish.",
                        textAlign: TextAlign.justify),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                children: const [
                  ExpansionTile(
                    title: Text(
                      "Supplementary Food",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 166, 196),
                      ),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          "Terrestrial plants",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        tileColor: Color.fromARGB(255, 159, 225, 255),
                        subtitle: Text(
                            "Terrestrial plant leaves of turi, drumstick, ipil-ipil, alfalfa, mulberry, sweet potato,"
                            " cassava, cucumber, squash, broad bean, papaya, white cowpea, green mung-bean, jackfruit, mexican fire"
                            " plant, cocoyam, black jack, banana, akee etc.",
                            textAlign: TextAlign.justify),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          "Titchen wastes",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        tileColor: Color.fromARGB(255, 253, 165, 162),
                        subtitle: Text(
                            "One of the best ways to provide growing plants for fish to eat is to attach either Riccia "
                            "or Java moss (Vesicularia) to driftwood or rocks using cotton thread. As the aquatic plants grow, they"
                            " naturally adhere to the rock or driftwood and provide excellent food plants for fish.",
                            textAlign: TextAlign.justify),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          "Agricultural by-products.",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        tileColor: Color.fromARGB(255, 159, 225, 255),
                        subtitle: Text(
                            "Modern fish feeds are made by grinding and mixing together ingredients such as fishmeal,"
                            " vegetable proteins and binding agents such as wheat.",
                            textAlign: TextAlign.justify),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: const [
                  ExpansionTile(
                    title: Text(
                      "Complete Food",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 166, 196),
                      ),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          "entensive",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        tileColor: Color.fromARGB(255, 159, 225, 255),
                        subtitle: Text(
                            "Extensive fish farming usually refers. to fish farming conducted in medium- to"
                            " large-sized ponds or water bodies; the fish production relies merely on the natural productivity"
                            " of the water which is only slightly or moderately enhanced.",
                            textAlign: TextAlign.justify),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          "semi-intensive",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        tileColor: Color.fromARGB(255, 253, 165, 162),
                        subtitle: Text(
                            "Semi-intensive farming systems account for about 70% of fish and crustacean aquaculture"
                            " production in the tropics, employing semi-intensive feeding methods ranging from the use of low-cost"
                            " pond fertilization tech- niques to high-cost complete diet feeding strategies.",
                            textAlign: TextAlign.justify),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          "intensive",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        tileColor: Color.fromARGB(255, 159, 225, 255),
                        subtitle: Text(
                            "Feeding intensity varies with size, the reproductive cycle, season and environment. "
                            "On average fish in smaller size classes feed more intensively than larger fish and in general, the"
                            "feeding intensity of juvenile is high throughout the year with a slight drop during the winter months",
                            textAlign: TextAlign.justify),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
