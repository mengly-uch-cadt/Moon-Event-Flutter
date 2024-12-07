import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon_event/model/category.dart';
import 'package:moon_event/services/category_service.dart';
import 'package:moon_event/theme.dart';

class MoonListCategoryWidget extends StatefulWidget {
  const MoonListCategoryWidget({super.key});

  @override
  _MoonListCategoryWidgetState createState() => _MoonListCategoryWidgetState();
}
class _MoonListCategoryWidgetState extends State<MoonListCategoryWidget> {
  late Future<List<Category>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    CategoryService categoryService = CategoryService();
    categoriesFuture = categoryService.getCategories().then((responseResult) {
      if (responseResult.isSuccess) {
        return responseResult.data as List<Category>; // Return the list of categories
      } else {
        throw Exception(responseResult.message); // Handle error if failed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 0.5,
        ),
        boxShadow: const [],
      ),
      child: FutureBuilder<List<Category>>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading spinner
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories available.')); // No data available
          } else {
            final categories = snapshot.data!;
            return SizedBox(  // Wrap ListView.builder in SizedBox
              height: 120,  // Define a fixed height for the ListView
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // padding: const EdgeInsets.symmetric(horizontal: 0.0),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return MoonCategory(
                    category: category.category,  // Use category.name directly
                    icon: category.icon,          // Use category.icon directly
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

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
    final categoryWords = category.split(" ");
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular icon container
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            width: 50,
            height: 50,
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/$icon.svg',
                color: AppColors.white,
                width: 25,
                height: 25,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Text container with fixed height
          SizedBox(
            height: 36, // Ensures consistent alignment for one or two lines
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center-align text vertically
              children: List.generate(categoryWords.length, (index) {
                return Text(
                  categoryWords[index],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
