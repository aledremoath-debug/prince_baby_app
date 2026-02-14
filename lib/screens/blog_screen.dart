import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prince_baby_app/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../data/blog_data.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});
  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'الكل';
  int? _expandedPost;

  List<BlogPost> get _filteredPosts {
    return allBlogPosts.where((post) {
      final matchSearch =
          post.title.contains(_searchQuery) ||
          post.excerpt.contains(_searchQuery);
      final matchCat =
          _selectedCategory == 'الكل' || post.category == _selectedCategory;
      return matchSearch && matchCat;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final filtered = _filteredPosts;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.primaryPink.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.newspaper,
                  size: 16.sp,
                  color: AppColors.primaryPink,
                ),
                SizedBox(width: 6.w),
                Text(
                  l.blogTitle,
                  style: TextStyle(
                    color: AppColors.primaryPink,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            l.blogSubtitle,
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w900),
          ).animate().fadeIn(),
          SizedBox(height: 20.h),

          // Search
          TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(
              hintText: l.searchArticles,
              prefixIcon: Icon(Icons.search, size: 24.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 14.h,
                horizontal: 16.w,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Category filter
          SizedBox(
            height: 38.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: blogCategories.length,
              itemBuilder: (context, index) {
                final cat = blogCategories[index];
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    selectedColor: AppColors.primaryPink,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide.none,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.h),

          // Blog posts
          if (filtered.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Column(
                children: [
                  Icon(Icons.newspaper, size: 56.sp, color: Colors.grey),
                  SizedBox(height: 12.h),
                  Text(
                    l.noResults,
                    style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      _searchQuery = '';
                      _selectedCategory = 'الكل';
                    }),
                    child: Text(
                      l.resetSearch,
                      style: const TextStyle(color: AppColors.primaryPink),
                    ),
                  ),
                ],
              ),
            )
          else
            ...filtered.asMap().entries.map((entry) {
              final i = entry.key;
              final post = entry.value;
              final isExpanded = _expandedPost == post.id;
              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: post.image,
                          height: 160.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          memCacheWidth: 800,
                          memCacheHeight: 320,
                          placeholder: (_, __) => Container(
                            height: 160.h,
                            color: post.color.withValues(alpha: 0.1),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            height: 160.h,
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 40.sp,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(height: 4.h, color: post.color),
                        ),
                        Positioned(
                          top: 12.h,
                          right: 12.w,
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              post.icon,
                              color: post.color,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: post.color.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  post.category,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: post.color,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 12.sp,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    post.readTime,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            post.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            post.excerpt,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                          // Expanded content
                          AnimatedCrossFade(
                            firstChild: const SizedBox.shrink(),
                            secondChild: Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: Column(
                                children: post.content
                                    .map(
                                      (p) => Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '•',
                                              style: TextStyle(
                                                color: AppColors.primaryPink,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Expanded(
                                              child: Text(
                                                p,
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  height: 1.5,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            crossFadeState: isExpanded
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 300),
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton.icon(
                              onPressed: () => setState(
                                () =>
                                    _expandedPost = isExpanded ? null : post.id,
                              ),
                              icon: Text(
                                isExpanded ? l.hide : l.readMore,
                                style: TextStyle(
                                  color: AppColors.primaryPink,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                              ),
                              label: AnimatedRotation(
                                turns: isExpanded ? 0.25 : 0,
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  Icons.chevron_left,
                                  color: AppColors.primaryPink,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: (150 * i).ms).slideY(begin: 0.1);
            }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
