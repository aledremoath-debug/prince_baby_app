import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TipItem {
  final IconData icon;
  final String title;
  final String description;
  final String reasoning;
  final String routineTime;
  final Color color;

  const TipItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.reasoning,
    required this.routineTime,
    required this.color,
  });
}

final List<TipItem> allTips = [
  TipItem(
    icon: Icons.access_time,
    title: 'تغيير الحفاضة بانتظام',
    description: 'قم بتغيير حفاضة طفلك كل 3-4 ساعات أو فور تلوثها.',
    reasoning:
        'التغيير المتكرر يمنع تراكم الرطوبة والأمونيا التي تسبب تهيج البشرة والطفح الجلدي البكتيري.',
    routineTime: 'كل 3 ساعات',
    color: AppColors.babyBlue,
  ),
  TipItem(
    icon: Icons.shield,
    title: 'استخدام كريم الحماية',
    description: 'طِبقي طبقة رقيقة من كريم الحفاضة في كل تغيير.',
    reasoning:
        'يعمل الكريم كحاجز وقائي يمنع ملامسة الفضلات مباشرة لبشرة الطفل الحساسة، مما يقلل الاحتكاك.',
    routineTime: 'عند التغيير',
    color: AppColors.softGreen,
  ),
  TipItem(
    icon: Icons.water_drop,
    title: 'تنظيف البشرة بلطف',
    description: 'استخدمي مناديل مبللة ناعمة أو ماء دافئ وقطن.',
    reasoning:
        'المسح اللطيف يحافظ على الزيوت الطبيعية للبشرة. تجنبي الفرك القوي لمنع حدوث التسلخات.',
    routineTime: 'أثناء التنظيف',
    color: AppColors.primaryPink,
  ),
  TipItem(
    icon: Icons.wb_sunny,
    title: 'ترك البشرة تتنفس',
    description: 'اتركي بشرة طفلك مكشوفة لبعض الوقت يومياً للتهوية.',
    reasoning:
        'الهواء الطبيعي هو أفضل وسيلة لعلاج ومنع الطفح الجلدي، حيث يجفف الرطوبة المحبوسة بشكل طبيعي.',
    routineTime: 'وقت القيلولة',
    color: AppColors.coralRed,
  ),
  TipItem(
    icon: Icons.child_care,
    title: 'اختيار المقاس المناسب',
    description: 'تأكدي من اختيار مقاس الحفاضة المناسب لوزن طفلك.',
    reasoning:
        'المقاس الصغير يضغط على الدورة الدموية، والمقاس الكبير يسبب التسرب. الوزن هو المقياس الأدق.',
    routineTime: 'مرة شهرياً',
    color: AppColors.babyBlue,
  ),
];
