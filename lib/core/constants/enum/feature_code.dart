/// Created by Abdullah on 30/11/24.
library;

enum FeatureCode{
  PRIVACY_POLICY("privacy_policy", "Privacy Policy"),
  LEVEL("level", "Level"),
  ABOUT_US("about_us", "About Us"),
  TERMS_AND_CONDITIONS("terms_and_conditions", "Terms & Conditions"),
  ;
  final String code;
  final String title;
  const FeatureCode(this.code, this.title);
}