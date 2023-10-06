import 'package:blog_explorer/contants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Custom cache manager
final cacheManager = DefaultCacheManager();

Widget customCachedNetworkImageBG(String imageUrl) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.cover,
    cacheManager: cacheManager,
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        cacheManager: cacheManager,
        placeholder: (context, url) => Container(
          color: lmbgdark,
        ),
        errorWidget: (context, url, error) => Container(
          color: lmbgdark,
          
        ),
      );
    },
  );
}
