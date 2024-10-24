/**
 * Created by Abdullah on 20/8/24.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/core/widgets/app_loader.dart';
import 'package:globipay_admin_panel/flavors/app_properties.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'base_page_state.dart';

/// A base class for all views/screens in the app.
abstract class BaseView<B extends BaseController> extends StatelessWidget {
  B controller = Injector.resolve<B>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  late BuildContext context;
  var showBackButton;

  BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    controller.currentPath = GoRouterState.of(context).path!;
    return wrapScaffold(body(context));
  }

  Widget body(BuildContext context);

  Widget _getPageContent() {
    return Padding(padding: setPadding(), child: body(context));
  }

  PreferredSizeWidget? appBar() {}

  Widget? floatingActionButton() {
    return null;
  }

  FloatingActionButtonLocation? floatingActionButtonLocation() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  Widget? bottomSheet() {
    return null;
  }

  bool resizeToAvoidBottomInset() {
    return true;
  }

  Widget? drawer() {
    return null;
  }

  Widget setBackground() {
    return const SizedBox();
  }

  EdgeInsets setPadding() {
    return const EdgeInsets.all(8);
  }

  wrapScaffold(Widget body) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawerEnableOpenDragGesture: false,
      key: globalKey,
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: floatingActionButtonLocation(),
      bottomNavigationBar: bottomNavigationBar(),
      bottomSheet: bottomSheet(),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
      drawer: drawer(),
      body: Stack(
        children: [
          setBackground(),
          SafeArea(child: _getPageContent()),
          Obx(() => controller.pageState == PageState.LOADING
              ? _showLoader()
              : const SizedBox()),
        ],
      ),
    );
  }

  Widget _showLoader() {
    return const AppLoader();
  }
}
