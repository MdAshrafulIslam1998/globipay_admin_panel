import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globipay_admin_panel/core/base/base_view.dart';
import 'package:globipay_admin_panel/modules/media_section/promo_banner/controller/promotional_banner_controller.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';


class PromotionalBannerScreenBuilder extends BaseView<PromotionalBannerController> {
  PromotionalBannerScreenBuilder() {
    controller.onInit();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade50,
        child: Row(
          children: [
            // Sidebar

            // Main Content Area
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    _buildHeader(context),

                    SizedBox(height: 24),

                    // Banner List
                    Expanded(
                      child: _buildBannerList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Promotional Banners',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.add, color: Colors.white),
          label: Text('Create Banner', style: TextStyle(color: Colors.white)),
          onPressed: () {
            AppRoutes.pushNamed(RoutePath.addPromoBanner);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade600,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBannerList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
          ),
        );
      }

      if (controller.errorMessage.isNotEmpty) {
        return _buildErrorState();
      }

      if (controller.banners.isEmpty) {
        return _buildEmptyState();
      }

      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 350,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: controller.banners.length,
        itemBuilder: (context, index) {
          final banner = controller.banners[index];
          return _buildBannerCard(banner, context);
        },
      );
    });
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/error.svg',
            height: 100,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.fetchActiveBanners(),
            child: Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/empty_state.svg',
            height: 150,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16),
          Text(
            'No Promotional Banners',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Create your first promotional banner',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCard(banner, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: banner.imageUrl != null
                ? CachedNetworkImage(
              imageUrl: banner.imageUrl!,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error),
            )
                : Container(
              height: 180,
              color: Colors.grey.shade200,
              child: Center(child: Icon(Icons.image_not_supported)),
            ),
          ),

          // Banner Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  banner.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  banner.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Active: ${banner.startDate.toLocal().toString().split(' ')[0]} - ${banner.endDate.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red.shade400),
                      onPressed: () => _showDeleteConfirmation(context, banner.id),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String bannerId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Banner'),
        content: Text('Are you sure you want to delete this banner?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteBanner(bannerId);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}