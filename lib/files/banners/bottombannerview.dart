import 'package:etisalat/files/reusable_widgets/custom_text.dart';
import 'package:etisalat/files/utility/colors.dart';
import 'package:etisalat/files/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';



class BottomBannerView extends StatelessWidget {
  const BottomBannerView({super.key});
  @override
  Widget build(BuildContext context) {
    return
     Padding(
       padding: const EdgeInsets.only(left: 4.0,right: 4.0,bottom: 4),
       child: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
            return _buildMobileFooter();
          } else {
            return _buildDesktopFooter();
          }
        },
           ),
     );
  }

  Widget _buildDesktopFooter() {
    return Container(
     
     
      color: black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              CustomText(title: 
                 privacyPolicyStr,color: white,
                ),
                InkWell(
                  onTap: () {},
                  child: CustomText(title: 
                   termsAndConditions,color: white,
                   
                  ),
                ),
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Divider(color: white),
          ),
           Padding(
            padding: EdgeInsets.only(left: 20.0,bottom: 10),
            child:CustomText(title: 
             copyrightStr,color: white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileFooter() {
    return Container(
      color: black,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         CustomText(
            title: privacyPolicyStr,color: white,
           
          ),
          InkWell(
            onTap: () {},
            child:  CustomText(
              title: termsAndConditions,color: white,
            
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),
         
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: white),
          ),
          CustomText(
            title: copyrightStr,color: white,
          ),
        ],
      ),
    );
  }
}
