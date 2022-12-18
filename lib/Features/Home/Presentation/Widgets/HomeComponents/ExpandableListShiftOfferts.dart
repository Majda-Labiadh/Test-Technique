import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_tech/Core/Utils/CustomText.dart';
import 'package:test_tech/Core/Utils/colorsConstant.dart';
import 'package:test_tech/Core/Utils/constant.dart';
import 'package:test_tech/Features/Home/Domain/Entities/offertsEntity.dart';
import 'package:test_tech/Features/Home/Presentation/Widgets/HomeComponents/ConvertTime.dart';
import 'package:test_tech/Features/Home/Presentation/bloc/home_bloc.dart';

class ExpandableListOfferts extends StatefulWidget {
  final Data data;
  final bool isToday;
  final DataInformation? dataInformation;
  const ExpandableListOfferts(
      {Key? key,
      required this.data,
      required this.isToday,
      required this.dataInformation})
      : super(key: key);

  @override
  State<ExpandableListOfferts> createState() => _ExpandableListOffertsState();
}

class _ExpandableListOffertsState extends State<ExpandableListOfferts> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HomeBloc>(context).add(
          GoToDetailDisplayEvent(
              data: widget.data,
              dataInformation: widget.dataInformation,
              isToday: widget.isToday),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 8),
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, right: 15, left: 15),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: const Offset(0.0, 3.0),
                //  spreadRadius: 7.0,
                blurRadius: 6.0,
              ),
            ],
            color: ColorConstant.whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                value: widget.data.company.toString(),
                textAlign: TextAlign.left,
                color: ColorConstant.blackColor,
                fontSize: font16,
                fontWeight: FontWeight.w700),
            const SizedBox(
              height: 8,
            ),
            CustomText(
                value: widget.isToday
                    ? 'Aujourd\'hui'.toUpperCase()
                    : DateFormat('EEEE d MMM', 'FR')
                        .format(DateTime.parse(widget.data.startAt.toString())),
                textAlign: TextAlign.left,
                color: widget.isToday
                    ? ColorConstant.redColor
                    : ColorConstant.greyColor,
                fontSize: font14,
                fontWeight: FontWeight.w700),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Container(
                        child: CustomText(
                            value: widget.data.postName.toString(),
                            textAlign: TextAlign.center,
                            color: ColorConstant.greyColor,
                            fontSize: font14,
                            fontWeight: FontWeight.w500),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: ColorConstant.lightGrey),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              text: widget.data.buyPrice.toString() + '\$ / H',
                              style: TextStyle(
                                  color: ColorConstant.greyColor,
                                  fontSize: font14,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                  text:
                                      ' + ${widget.data.bonus.toString()}\$ / H',
                                  style: TextStyle(
                                      color: ColorConstant.greenColor,
                                      fontSize: font14,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CustomText(
                      value: convertTime(
                          DateTime.parse(widget.data.startAt.toString())
                              .hour
                              .toString(),
                          DateTime.parse(widget.data.startAt.toString())
                              .minute
                              .toString(),
                          (DateTime.parse(widget.data.endAt.toString())
                              .hour
                              .toString()),
                          (DateTime.parse(widget.data.endAt.toString())
                              .minute
                              .toString())),
                      textAlign: TextAlign.right,
                      color: widget.isToday
                          ? ColorConstant.redColor
                          : ColorConstant.greyColor,
                      fontSize: font14,
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
