import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon_event/model/category.dart';
import 'package:moon_event/services/category_service.dart';
import 'package:moon_event/state/category_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MoonListCategoryWidget extends ConsumerStatefulWidget {
  const MoonListCategoryWidget({super.key});

  @override
  ConsumerState<MoonListCategoryWidget> createState() =>
      _MoonListCategoryWidgetState();
}

class _MoonListCategoryWidgetState
    extends ConsumerState<MoonListCategoryWidget> {
  bool isLoading = true; // Control the loading state

  @override
  void initState() {
    super.initState();
    _getCategoryData(); // Fetch categories when the widget is first built
  }

  // Fetch category data from the service
  void _getCategoryData() async {
    CategoryService categoryService = CategoryService();
    ResponseResult responseResult = await categoryService.getCategories();
    if (responseResult.isSuccess) {
      List<Category> categoryData = responseResult.data as List<Category>;
      ref.read(categoryProvider.notifier).setCategoryData(categoryData);
      setState(() {
        isLoading = false; // Set loading to false after data is fetched
      });
    } else {
      // Handle the error if the API request fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseResult.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = ref.watch(categoryProvider);

    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 0.5,
        ),
        boxShadow: const [],
      ),
      child: Skeletonizer(
        enabled: isLoading, // Show skeleton while loading
        child: categoryData.isNotEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categoryData.length, (index) {
                    return SizedBox(
                      width: 80,
                      child: MoonCategory(
                        category: categoryData[index].category,
                        icon: categoryData[index].icon,
                      ),
                    );
                  }),
                ),
              )
            : SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4, // Number of skeleton items
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 60,
                          height: 12,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 40,
                          height: 12,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ) // Empty widget when there is no category data
      ),
    );
  }
}

// Widget to display each category
class MoonCategory extends StatelessWidget {
  const MoonCategory({
    super.key,
    required this.category,
    required this.icon,
  });

  final String category;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final categoryWords = category.split(" "); // Split the category name by space

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary, // Primary color for category circle
            borderRadius: BorderRadius.circular(50),
          ),
          width: 50,
          height: 50,
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/$icon.svg', // Category icon
              color: AppColors.white,
              width: 25,
              height: 25,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 36,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(categoryWords.length, (index) {
              return Text(
                categoryWords[index], // Display each word in the category name
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            }),
          ),
        ),
      ],
    );
  }
}
