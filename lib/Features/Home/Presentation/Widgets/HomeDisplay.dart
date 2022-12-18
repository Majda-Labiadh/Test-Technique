import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_tech/Core/Utils/CustomText.dart';
import 'package:test_tech/Core/Utils/colorsConstant.dart';
import 'package:test_tech/Core/Utils/constant.dart';
import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';
import 'package:test_tech/Features/Home/Presentation/Widgets/HomeComponents/ExpandableListShiftOfferts.dart';

// ignore: must_be_immutable
class HomeDisplay extends StatefulWidget {
  late DataInformation? dataInformation;

  HomeDisplay({Key? key, required this.dataInformation}) : super(key: key);

  @override
  _HomeDisplayState createState() => _HomeDisplayState();
}

class _HomeDisplayState extends State<HomeDisplay> {
  List<Data> today = [];
  List<Data> aVenir = [];
  var thisInstant = DateTime.now();

  @override
  void initState() {
    shilftOfferts();
    super.initState();
  }

// function to test the shifts offered today as well as test the start time
// test the rest of the shifts to display only the shifts to come (eliminate the old ones offered)
  shilftOfferts() {
    widget.dataInformation?.data?.forEach((element) {
      if (DateTime(
                  DateTime.parse(element.startAt.toString()).year,
                  DateTime.parse(element.startAt.toString()).month,
                  DateTime.parse(element.startAt.toString()).day)
              .compareTo(
            DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day),
          ) ==
          0) {
        if (DateTime.now().hour <
            DateTime.parse(element.startAt.toString()).hour) {
          today.add(element);
        }
      } else {
        if (DateTime.parse(element.startAt.toString())
                .compareTo(DateTime.now()) !=
            -1) {
          aVenir.add(element);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.lightGrey,
      bottomNavigationBar: Container(
        color: ColorConstant.lightGrey,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 20.0, left: 6, right: 6, top: 10),
          child: Container(
            decoration: BoxDecoration(
                color: ColorConstant.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    offset: const Offset(0.0, 3.0),
                    //  spreadRadius: 7.0,
                    blurRadius: 6.0,
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        height: 48.0,
                        margin: const EdgeInsets.only(top: 8.0, bottom: 8),
                        decoration: BoxDecoration(
                            color: ColorConstant.blueColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Center(
                          child: IntrinsicWidth(
                              child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: ColorConstant.whiteColor,
                              ),
                              hintText: 'Shifts offerts',
                              hintStyle: TextStyle(
                                color: ColorConstant.whiteColor,
                              ),
                              border: InputBorder.none,
                            ),
                            onTap: () {},
                          )),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: ColorConstant.lightGrey,
                    radius: 25,
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.fileLines,
                        color: ColorConstant.greyColor,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: ColorConstant.lightGrey,
                    radius: 25,
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.user,
                        color: ColorConstant.greyColor,
                        size: 20,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    value: 'Shifts offerts',
                    textAlign: TextAlign.left,
                    color: ColorConstant.blackColor,
                    fontSize: font24,
                    fontWeight: FontWeight.bold),
                const SizedBox(
                  height: 30,
                ),
                CustomText(
                    value: 'DERNIERE MINUTE',
                    textAlign: TextAlign.left,
                    color: ColorConstant.greyColor,
                    fontSize: font14,
                    fontWeight: FontWeight.w600),
                const SizedBox(
                  height: 8,
                ),
                ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: today.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExpandableListOfferts(
                        data: today[index],
                        dataInformation: widget.dataInformation,
                        isToday: true,
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
                CustomText(
                    value: 'CHIFTS A VENIR',
                    textAlign: TextAlign.left,
                    color: ColorConstant.greyColor,
                    fontSize: font14,
                    fontWeight: FontWeight.w600),
                const SizedBox(
                  height: 8,
                ),
                ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: aVenir.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExpandableListOfferts(
                        data: aVenir[index],
                        dataInformation: widget.dataInformation,
                        isToday: false,
                      );
                    }),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
