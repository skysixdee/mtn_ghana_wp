import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_pack_detail_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/tune_setting_api/tune_setting_dedicated_api.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/model/pack_detail_model.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MySubscriptionView extends StatefulWidget {
  const MySubscriptionView({super.key});

  @override
  State<MySubscriptionView> createState() => _MySubscriptionViewState();
}

class _MySubscriptionViewState extends State<MySubscriptionView> {
  List<Offer> offers = [];
  RxBool isLoading = false.obs;
  @override
  void initState() {
    getSubscriptionDetails();
    super.initState();
  }

  getSubscriptionDetails() async {
    isLoading.value = true;
    PackDetailModel model = await getPackDetailApi();
    offers = model.offers ?? [];
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, si) {
        return Container(
            color: isDarkTheme(context) ? blackTest : white,
            child: Obx(
              () {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 2,
                      color: isDarkTheme(context) ? whiteD : white,
                    ),
                    isLoading.value
                        ? loadingIndicator()
                        : Container(
                            height: 50,
                            color: isDarkTheme(context) ? blackTest : lightGrey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  CustomText(
                                    colorD: whiteD,
                                    title: mySubscriptionPlanStr,
                                    fontName: FontName.bold,
                                    fontSize: si.isMobile ? 14 : 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                    packDetailWidget(si)
                  ],
                );
              },
            ));
      },
    );
  }

  Widget packDetailWidget(SizingInformation si) {
    return Container(
        constraints: const BoxConstraints(minHeight: 200, maxHeight: 250),
        padding: EdgeInsets.symmetric(
            horizontal: si.isMobile ? 10 : 20, vertical: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: offers.length,
          itemBuilder: (context, index) {
            var offer = offers[index];
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                constraints: BoxConstraints(
                    minWidth: 150, maxWidth: si.isMobile ? 320 : 380),
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 14,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color:
                                    isDarkTheme(context) ? whiteD : lightGrey),
                            color: isDarkTheme(context) ? blackTest : white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 14),
                          child: Column(
                            children: [
                              Row(
                                spacing: 20,
                                //mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        title: offer.offerName,
                                      ),
                                      CustomText(
                                        title: offer.chargedAmount,
                                      )
                                    ],
                                  ),
                                  Flexible(
                                    child: Column(
                                      spacing: 4,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GenericButton(
                                              borderColor: grey,
                                              title: unSubscribeStr,
                                            ),
                                          ],
                                        ),
                                        CustomText(
                                          fontSize: 12,
                                          title:
                                              "${autorenewStr} ${formatDate(offer.expiryDate ?? '')}",
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Divider(),
                              ),
                              Text(subscriptionDescriptionStr
                                  .replaceAll("DATE",
                                      formatDate(offer.chargedDate ?? ''))
                                  .replaceAll(
                                      "PRICE", offer.chargedAmount ?? '')
                                  .replaceAll("BILLING_CYCLE",
                                      offer.chargedValidity ?? '')),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  String formatDate(String expiryDate) {
    DateTime dateTime = DateTime.parse(expiryDate);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
