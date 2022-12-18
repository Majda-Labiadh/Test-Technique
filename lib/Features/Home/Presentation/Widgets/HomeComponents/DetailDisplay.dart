// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:test_tech/Core/Utils/CustomText.dart';
import 'package:test_tech/Core/Utils/colorsConstant.dart';
import 'package:test_tech/Core/Utils/constant.dart';
import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';
import 'package:test_tech/Features/Home/Presentation/Widgets/HomeComponents/ConvertTime.dart';
import 'package:test_tech/Features/Home/Presentation/bloc/home_bloc.dart';

class DetailDisplay extends StatefulWidget {
  final Data? data;
  final DataInformation? dataInformation;
  final bool isToday;
  const DetailDisplay(
      {Key? key,
      required this.data,
      required this.dataInformation,
      required this.isToday})
      : super(key: key);

  @override
  _DetailDisplayState createState() => _DetailDisplayState();
}

class _DetailDisplayState extends State<DetailDisplay> {
  String? _currentAddress;
  @override
  void initState() {
    _getAddressFromLatLng();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.whiteColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: ColorConstant.blackColor,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: ColorConstant.whiteColor,
              ),
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(
                  GoToHomeEvent(dataInformation: widget.dataInformation),
                );
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 60,
                    backgroundColor: ColorConstant.lightGrey,
                    backgroundImage: const AssetImage(
                      'assets/image.jpg',
                    )),
                const SizedBox(
                  height: 30,
                ),
                CustomText(
                    value: widget.data!.company.toString(),
                    textAlign: TextAlign.left,
                    color: ColorConstant.blackColor,
                    fontSize: font20,
                    fontWeight: FontWeight.bold),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      value: widget.isToday
                          ? 'Aujourd\'hui'.toUpperCase()
                          : DateFormat('EEEE d MMM', 'FR').format(
                              DateTime.parse(widget.data!.startAt.toString())),
                      textAlign: TextAlign.left,
                      color: widget.isToday
                          ? ColorConstant.redColor
                          : ColorConstant.greyColor,
                      fontSize: font14,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            child: CustomText(
                                value: widget.data!.postName.toString(),
                                textAlign: TextAlign.center,
                                color: ColorConstant.greyColor,
                                fontSize: font14,
                                fontWeight: FontWeight.w700),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                color: ColorConstant.lightGrey),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: CustomText(
                                value:
                                    widget.data!.buyPrice.toString() + '\$ / H',
                                color: ColorConstant.greyColor,
                                fontSize: font14,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    CustomText(
                        value: convertTime(
                            DateTime.parse(widget.data!.startAt.toString())
                                .hour
                                .toString(),
                            DateTime.parse(widget.data!.startAt.toString())
                                .minute
                                .toString(),
                            (DateTime.parse(widget.data!.endAt.toString())
                                .hour
                                .toString()),
                            (DateTime.parse(widget.data!.endAt.toString())
                                .minute
                                .toString())),
                        textAlign: TextAlign.left,
                        color: ColorConstant.greyColor,
                        fontSize: font14,
                        fontWeight: FontWeight.w500),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(BorderSide(
                                color: ColorConstant.lightBlackColor))),
                        child: Icon(
                          LineIcons.mapMarker,
                          size: 24,
                          color: ColorConstant.lightBlackColor,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomText(
                          value: _currentAddress.toString(),
                          textAlign: TextAlign.left,
                          color: ColorConstant.lightBlackColor,
                          fontSize: font16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(
                              color: ColorConstant.lightBlackColor))),
                      child: Icon(
                        Icons.attach_money,
                        size: 24,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomText(
                          value: 'Bonus au travailleur: ' +
                              widget.data!.bonus.toString() +
                              '\$ / H',
                          textAlign: TextAlign.left,
                          color: ColorConstant.lightBlackColor,
                          fontSize: font16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(
                              color: ColorConstant.lightBlackColor))),
                      child: FaIcon(
                        Icons.pause,
                        size: 24,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomText(
                          value: "Pause de 30 minutes",
                          textAlign: TextAlign.left,
                          color: ColorConstant.lightBlackColor,
                          fontSize: font16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(
                              color: ColorConstant.lightBlackColor))),
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: CustomText(value: 'P', fontSize: font18),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomText(
                          value: 'Stationnement gratuit',
                          textAlign: TextAlign.left,
                          color: ColorConstant.lightBlackColor,
                          fontSize: font16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(
                              color: ColorConstant.lightBlackColor))),
                      child: Icon(
                        LineIcons.tShirt,
                        size: 24,
                        color: ColorConstant.lightBlackColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomText(
                          value: "Pantalon noir, chemise noir",
                          textAlign: TextAlign.left,
                          color: ColorConstant.lightBlackColor,
                          fontSize: font16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      value: 'RESPONSABLE',
                      textAlign: TextAlign.left,
                      color: ColorConstant.greyColor,
                      fontSize: font14,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      value: "Fisrt Name Last Name",
                      textAlign: TextAlign.left,
                      color: ColorConstant.lightBlackColor,
                      fontSize: font16,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide.none)),
                          backgroundColor: MaterialStateProperty.all(
                              ColorConstant.blueColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomText(
                            value: 'Postuler',
                            color: ColorConstant.whiteColor,
                            fontSize: font20,
                            fontWeight: FontWeight.w600),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          widget.data!.latitude!.toDouble(),
          widget.data!.longitude!.toDouble());

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
