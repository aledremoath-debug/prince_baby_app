import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prince_baby_app/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_colors.dart';
import '../data/faq_data.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});
  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'الكل';
  int _expandedIndex = -1;
  final Map<int, int> _ratings = {};
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _loadRatings();
  }

  Future<void> _loadRatings() async {
    _prefs ??= await SharedPreferences.getInstance();
    for (int i = 0; i < allFaqs.length; i++) {
      final val = _prefs!.getInt('faq_rating_$i');
      if (val != null) setState(() => _ratings[i] = val);
    }
  }

  Future<void> _setRating(int index, int val) async {
    setState(() => _ratings[index] = val);
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setInt('faq_rating_$index', val);
  }

  List<FaqItem> get _filteredFaqs {
    return allFaqs.where((faq) {
      final matchSearch =
          faq.question.contains(_searchQuery) ||
          faq.answer.contains(_searchQuery);
      final matchCat =
          _selectedCategory == 'الكل' || faq.category == _selectedCategory;
      return matchSearch && matchCat;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final filtered = _filteredFaqs;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(16.r),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Header
              Text(
                l.faqTitle,
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w900),
              ).animate().fadeIn(),
              SizedBox(height: 4.h),
              Text(
                l.faqSubtitle,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
              SizedBox(height: 20.h),

              // Search
              TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: l.searchFaq,
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
              SizedBox(height: 14.h),

              // Categories
              SizedBox(
                height: 38.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: faqCategories.length,
                  itemBuilder: (context, index) {
                    final cat = faqCategories[index];
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (_) =>
                            setState(() => _selectedCategory = cat),
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
              SizedBox(height: 8.h),
              Text(
                '${filtered.length} ${l.questionsFound}',
                style: TextStyle(fontSize: 11.sp, color: Colors.grey),
              ),
              SizedBox(height: 16.h),
            ]),
          ),
        ),
        if (filtered.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.help_outline, size: 56.sp, color: Colors.grey),
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
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
                final faq = filtered[i];
                final isExpanded = _expandedIndex == i;
                final originalIndex = allFaqs.indexOf(
                  faq,
                ); // Get original index for rating
                return RepaintBoundary(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: isExpanded
                            ? AppColors.primaryPink.withOpacity(0.3)
                            : Colors.transparent,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6.r,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 4.h,
                          ),
                          title: Text(
                            faq.question,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          trailing: AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0,
                            duration: const Duration(milliseconds: 300),
                            child: Icon(Icons.expand_more, size: 24.sp),
                          ),
                          onTap: () => setState(
                            () => _expandedIndex = isExpanded ? -1 : i,
                          ),
                        ),
                        AnimatedCrossFade(
                          firstChild: const SizedBox.shrink(),
                          secondChild: Padding(
                            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(),
                                SizedBox(height: 8.h),
                                Text(
                                  faq.answer,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    height: 1.6,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    Text(
                                      l.wasHelpful,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    _ratingButton(
                                      originalIndex,
                                      1,
                                      Icons.thumb_up,
                                      l.helpful,
                                    ),
                                    SizedBox(width: 6.w),
                                    _ratingButton(
                                      originalIndex,
                                      -1,
                                      Icons.thumb_down,
                                      l.notHelpful,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          crossFadeState: isExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: (80 * i).ms),
                );
              }, childCount: filtered.length),
            ),
          ),
        SliverPadding(
          padding: EdgeInsets.all(16.r),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20.h),
              // Contact CTA
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: AppColors.primaryPink.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.primaryPink.withOpacity(0.12),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      l.notFoundQuestion,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.mail_outline, size: 18.sp),
                      label: Text(l.navContact),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _ratingButton(int index, int value, IconData icon, String label) {
    final isSelected = _ratings[index] == value;
    return GestureDetector(
      onTap: () => _setRating(index, value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (value == 1
                    ? Colors.green.withOpacity(0.15)
                    : Colors.red.withOpacity(0.15))
              : Colors.grey.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? (value == 1 ? Colors.green : Colors.red)
                : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14.sp,
              color: isSelected
                  ? (value == 1 ? Colors.green : Colors.red)
                  : Colors.grey,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? (value == 1 ? Colors.green : Colors.red)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
