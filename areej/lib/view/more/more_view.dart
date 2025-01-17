import 'package:flutter/material.dart';
import '../../common/color_extension.dart';
import 'package:areej/view/more/payment_details_view.dart';
import 'package:areej/view/more/notification_view.dart';
import 'package:areej/view/more/about_us_view.dart';
import 'package:areej/view/more/inbox_view.dart';
import 'package:areej/view/more/my_order_view.dart';
import 'package:areej/services/firebase_auth_implementation/firebase_auth_service.dart';
import 'package:areej/view/login_signup/welcome_view.dart';

class MoreView extends StatefulWidget {
  const MoreView({super.key});

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  List<Map<String, dynamic>> moreArr = [
    {
      "index": "1",
      "name": "Payment Details",
      "image": "assets/img/more_payment.png",
      "base": 0
    },
    {
      "index": "2",
      "name": "My Orders",
      "image": "assets/img/more_my_order.png",
      "base": 0
    },
    {
      "index": "3",
      "name": "Notifications",
      "image": "assets/img/more_notification.png",
      "base": 15
    },
    {
      "index": "4",
      "name": "Inbox",
      "image": "assets/img/more_inbox.png",
      "base": 0
    },
    {
      "index": "5",
      "name": "About Us",
      "image": "assets/img/more_info.png",
      "base": 0
    },
    {
      "index": "6",
      "name": "Logout",
      "image": "assets/img/more_info.png",
      "base": 0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "More",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    IconButton(
                      onPressed: () {
                        // You can implement cart navigation here
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
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: moreArr.length,
                itemBuilder: (context, index) {
                  var mObj = moreArr[index];
                  var countBase = mObj["base"] as int? ?? 0;

                  return InkWell(
                    onTap: () async {
                      switch (mObj["index"].toString()) {
                        case "1":
                          // Navigate to PaymentDetailsView
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentDetailsView(),
                            ),
                          );
                          break;
                        case "2":
                          // Navigate to MyOrderView
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyOrderView(),
                            ),
                          );
                          break;
                        case "3":
                          // Navigate to NotificationsView
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationsView(),
                            ),
                          );
                          break;
                        case "4":
                          // Navigate to InboxView
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InboxView(),
                            ),
                          );
                          break;
                        case "5":
                          // Navigate to AboutUsView
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUsView(),
                            ),
                          );
                          break;

                        case "6":
                          // Perform logout and navigate to the login screen or update UI
                          await FirebaseAuthService().logout();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeView(),
                            ),
                          );
                          break;

                          // Handle other cases if necessary
                          break;

                        default:
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            decoration: BoxDecoration(
                                color: TColor.textfield,
                                borderRadius: BorderRadius.circular(5)),
                            margin: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: TColor.placeholder,
                                      borderRadius: BorderRadius.circular(25)),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    mObj["image"].toString(),
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.contain,
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      // Fallback image if error loading
                                      print(
                                          'Error loading image: ${mObj["image"]}');
                                      return Icon(Icons.error,
                                          color: Colors.red);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    mObj["name"].toString(),
                                    style: TextStyle(
                                        color: TColor.primaryText,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                if (countBase > 0)
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(12.5)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      countBase.toString(),
                                      style: TextStyle(
                                          color: TColor.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: TColor.textfield,
                                borderRadius: BorderRadius.circular(15)),
                            child: Image.asset(
                              "assets/img/btn_next.png",
                              width: 10,
                              height: 10,
                              color: TColor.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
