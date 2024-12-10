/**
 * Created by Abdullah on 30/11/24.
 */

enum FeatureCode{
  PRIVACY_POLICY("notification", "Privacy Policy"),
  LEVEL("level", "Level"),
  ABOUT_US("about_us", "About Us"),
  TERMS_AND_CONDITIONS("terms_and_conditions", "Terms & Conditions"),
  CUSTOMER_SERVICE("customer_service", "Customer Service"),
  ;
  final String code;
  final String title;
  const FeatureCode(this.code, this.title);
}