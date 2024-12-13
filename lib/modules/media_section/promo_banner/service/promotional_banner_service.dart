import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/data/models/promotional_banner_model.dart';


class PromotionalBannerService {
  // Dummy list of promotional banners
  final List<PromotionalBannerModel> _dummyBanners = [
    PromotionalBannerModel(
      id: '1',
      title: 'Summer Sale',
      description: 'Get up to 50% off on all items!',
      backgroundColor: '#FF6B6B',
      imageUrl: 'https://www.shutterstock.com/image-vector/digital-technology-banner-green-blue-260nw-2277275221.jpg',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 30)),
      isVisibleToAll: true,
      priority: 5,
      destinationUrl: 'https://example.com/summer-sale',
    ),
    PromotionalBannerModel(
      id: '2',
      title: 'New Product Launch',
      description: 'Introducing our latest innovation!',
      backgroundColor: '#4ECDC4',
      imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/002/006/774/small/paper-art-shopping-online-on-smartphone-and-new-buy-sale-promotion-backgroud-for-banner-market-ecommerce-free-vector.jpg',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 15)),
      isVisibleToAll: true,
      priority: 7,
      destinationUrl: 'https://example.com/new-product',
    ),


    PromotionalBannerModel(
      id: '3',
      title: 'New Product Launch',
      description: 'Introducing our latest innovation!',
      backgroundColor: '#4ECDC4',
      imageUrl: 'https://www.shutterstock.com/image-vector/ecommerce-web-banner-3d-smartphone-260nw-2069305328.jpg',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 15)),
      isVisibleToAll: true,
      priority: 7,
      destinationUrl: 'https://example.com/new-product',
    ),


    PromotionalBannerModel(
      id: '4',
      title: 'New Product Launch',
      description: 'Introducing our latest innovation!',
      backgroundColor: '#4ECDC4',
      imageUrl: 'https://www.shutterstock.com/image-vector/ecommerce-web-banner-3d-smartphone-260nw-2069305328.jpg',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 15)),
      isVisibleToAll: true,
      priority: 7,
      destinationUrl: 'https://example.com/new-product',
    ),


    PromotionalBannerModel(
      id: '5',
      title: 'New Product Launch',
      description: 'Introducing our latest innovation!',
      backgroundColor: '#4ECDC4',
      imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/002/006/774/small/paper-art-shopping-online-on-smartphone-and-new-buy-sale-promotion-backgroud-for-banner-market-ecommerce-free-vector.jpg',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 15)),
      isVisibleToAll: true,
      priority: 7,
      destinationUrl: 'https://example.com/new-product',
    ),


    PromotionalBannerModel(
      id: '6',
      title: 'New Product Launch',
      description: 'Introducing our latest innovation!',
      backgroundColor: '#4ECDC4',
      imageUrl: 'https://img.freepik.com/free-vector/fashion-banner-template_1361-1222.jpg',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 15)),
      isVisibleToAll: true,
      priority: 7,
      destinationUrl: 'https://example.com/new-product',
    ),

    PromotionalBannerModel(
      id: '7',
      title: 'New Product Launch',
      description: 'Introducing our latest innovation!',
      backgroundColor: '#4ECDC4',
      imageUrl: 'https://i.pinimg.com/736x/fa/a2/37/faa2373075f50674aa480c1f10c6cc88.jpg',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 15)),
      isVisibleToAll: true,
      priority: 7,
      destinationUrl: 'https://example.com/new-product',
    ),





  ];

  // Add new promotional banner
  Future<bool> addPromotionalBanner(PromotionalBannerModel banner) async {
    try {
      // Simulate network delay
      await Future.delayed(Duration(seconds: 1));

      // If local file exists, set a dummy image URL
      if (banner.imageFile != null) {
        banner = PromotionalBannerModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: banner.title,
          description: banner.description,
          backgroundColor: banner.backgroundColor,
          imageUrl: 'https://example.com/dummy-uploaded-image.jpg',
          startDate: banner.startDate,
          endDate: banner.endDate,
          isVisibleToAll: banner.isVisibleToAll,
          priority: banner.priority,
          destinationUrl: banner.destinationUrl,
        );
      }

      // Add to dummy list
      _dummyBanners.add(banner);
      return true;
    } catch (e) {
      print('Error adding promotional banner: $e');
      return false;
    }
  }

  // Upload banner image (dummy implementation)
  Future<String?> uploadBannerImage(File imageFile) async {
    try {
      // Simulate network delay
      await Future.delayed(Duration(seconds: 1));
      return 'https://example.com/dummy-uploaded-image.jpg';
    } catch (e) {
      print('Error uploading banner image: $e');
      return null;
    }
  }

  // Fetch active promotional banners
  Future<List<PromotionalBannerModel>> getActiveBanners({bool visibleToAll = true}) async {
    try {
      // Simulate network delay
      await Future.delayed(Duration(seconds: 1));

      // Filter banners based on current date and visibility
      final now = DateTime.now();
      return _dummyBanners.where((banner) {
        return banner.isActive &&
            banner.startDate.isBefore(now) &&
            banner.endDate.isAfter(now) &&
            banner.isVisibleToAll == visibleToAll;
      }).toList();
    } catch (e) {
      print('Error fetching active banners: $e');
      return [];
    }
  }

  // Update existing banner
  Future<bool> updatePromotionalBanner(PromotionalBannerModel banner) async {
    try {
      // Simulate network delay
      await Future.delayed(Duration(seconds: 1));

      // Find and update the banner in the dummy list
      final index = _dummyBanners.indexWhere((b) => b.id == banner.id);
      if (index != -1) {
        _dummyBanners[index] = banner;
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating promotional banner: $e');
      return false;
    }
  }

  // Delete banner
  Future<bool> deletePromotionalBanner(String bannerId) async {
    try {
      // Simulate network delay
      await Future.delayed(Duration(seconds: 1));

      // Remove banner from dummy list
      _dummyBanners.removeWhere((banner) => banner.id == bannerId);
      return true;
    } catch (e) {
      print('Error deleting promotional banner: $e');
      return false;
    }
  }
}