import 'package:flutter/material.dart';
import 'package:areej/common/color_extension.dart';
import 'package:areej/common_widget/round_textfield.dart';
import 'package:areej/view/menu/menu_items_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  // Simulating a Stream of menu data.
  Stream<List<Map<String, dynamic>>> getMenuStream() async* {
    // Simulate loading data with a delay
    await Future.delayed(const Duration(seconds: 1));
    yield [
      {
        "name": "Food",
        "image": "assets/img/menu_1.png",
        "items_count": "120",
        "type": "food",
      },
      {
        "name": "Beverages",
        "image": "assets/img/menu_2.png",
        "items_count": "220",
        "type": "beverages",
      },
      {
        "name": "Desserts",
        "image": "assets/img/menu_3.png",
        "items_count": "155",
        "type": "desserts",
      },
      {
        "name": "Promotions",
        "image": "assets/img/menu_4.png",
        "items_count": "25",
        "type": "promotions",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: getMenuStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> menuArr = snapshot.data!;
          return MenuViewContent(menuArr: menuArr);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}

class MenuViewContent extends StatelessWidget {
  final List<Map<String, dynamic>> menuArr;

  const MenuViewContent({super.key, required this.menuArr});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Menu",
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    icon: Image.asset(
                      "assets/img/shopping_cart.png",
                      width: 25,
                      height: 25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundTextfield(
                hintText: "Search Food",
                controller: TextEditingController(),
                left: Container(
                  alignment: Alignment.center,
                  width: 30,
                  child: Image.asset(
                    "assets/img/search.png",
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Menu List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuArr.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MenuItem(item: menuArr[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const MenuItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the MenuItemsView
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuItemsView(mObj: item), // Send data to next screen
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        width: MediaQuery.of(context).size.width - 40,
        height: 90,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 7,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                item["image"].toString(),
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"].toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${item["items_count"]} items",
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17.5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Image.asset(
                "assets/img/btn_next.png",
                width: 15,
                height: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
