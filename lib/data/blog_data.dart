import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BlogPost {
  final int id;
  final String title;
  final String excerpt;
  final String category;
  final String readTime;
  final String date;
  final Color color;
  final IconData icon;
  final String image;
  final List<String> content;

  const BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.category,
    required this.readTime,
    required this.date,
    required this.color,
    required this.icon,
    required this.image,
    required this.content,
  });
}

final List<BlogPost> allBlogPosts = [
  BlogPost(
    id: 1,
    title: 'كيف تختارين الحفاضة المناسبة لطفلك؟',
    excerpt:
        'دليل شامل لاختيار الحفاضة الأنسب بناءً على عمر ووزن طفلك ونوع بشرته.',
    category: 'نصائح الأمهات',
    readTime: '5 دقائق',
    date: '2024-12-15',
    color: AppColors.primaryPink,
    icon: Icons.child_care,
    image:
        'https://images.unsplash.com/photo-1544126592-807daa2b565b?auto=format&fit=crop&q=80&w=800',
    content: [
      'يجب أن تكون الحفاضة مناسبة لوزن طفلك وليس عمره. راجعي دليل المقاسات لمعرفة المقاس الأنسب.',
      'تأكدي من أن الحفاضة لا تترك علامات حمراء على بشرة طفلك - هذا يعني أن المقاس صغير.',
      'اختاري حفاضات خالية من العطور والمواد الكيميائية الضارة لحماية البشرة الحساسة.',
      'جربي ماركات مختلفة حتى تجدي الأنسب لطفلك - كل طفل فريد!',
    ],
  ),
  BlogPost(
    id: 2,
    title: '7 علامات تدل على حاجة طفلك لتغيير مقاس الحفاضة',
    excerpt:
        'تعرفي على العلامات التي تدل على أن طفلك يحتاج لمقاس أكبر من الحفاضات.',
    category: 'العناية بالطفل',
    readTime: '4 دقائق',
    date: '2024-12-10',
    color: AppColors.babyBlue,
    icon: Icons.child_care,
    image:
        'https://images.unsplash.com/photo-1622290291468-a28f7a7dc6a8?auto=format&fit=crop&q=80&w=800',
    content: [
      'تسرب متكرر رغم التغيير المنتظم - علامة واضحة على الحاجة لمقاس أكبر.',
      'علامات حمراء على الفخذين أو الخصر - الحفاضة ضيقة جداً.',
      'صعوبة في إغلاق اللاصق - حان وقت الانتقال للمقاس التالي.',
      'عدم راحة الطفل وبكاءه المستمر قد يكون بسبب ضيق الحفاضة.',
    ],
  ),
  BlogPost(
    id: 3,
    title: 'الفرق بين أنواع الحفاضات وتقنيات الامتصاص',
    excerpt: 'شرح مفصل لتقنيات الامتصاص المختلفة وكيف تؤثر على راحة طفلك.',
    category: 'تعليمي',
    readTime: '6 دقائق',
    date: '2024-12-05',
    color: AppColors.softGreen,
    icon: Icons.newspaper,
    image:
        'https://images.unsplash.com/photo-1531983412531-1f49a365ff67?auto=format&fit=crop&q=80&w=800',
    content: [
      'تقنية الامتصاص الفائق تحول السائل إلى جل، مما يحافظ على جفاف البشرة.',
      'الطبقة الداخلية الناعمة تحمي بشرة الطفل من التهيج والرطوبة.',
      'حواجز التسرب الجانبية تمنع التسرب حتى أثناء الحركة الكثيرة.',
      'حفاضات برنس بيبي تستخدم أحدث تقنيات الامتصاص لحماية تدوم حتى 12 ساعة.',
    ],
  ),
  BlogPost(
    id: 4,
    title: 'العناية ببشرة الطفل في فصل الشتاء',
    excerpt:
        'نصائح ذهبية للحفاظ على بشرة طفلك ناعمة ومحمية خلال أشهر الشتاء الباردة.',
    category: 'العناية بالطفل',
    readTime: '4 دقائق',
    date: '2024-11-28',
    color: AppColors.coralRed,
    icon: Icons.child_care,
    image:
        'https://images.unsplash.com/photo-1519689680058-324335c77eba?auto=format&fit=crop&q=80&w=800',
    content: [
      'استخدمي مرطب خاص بالأطفال بعد كل حمام للحفاظ على رطوبة البشرة.',
      'قللي من عدد مرات الاستحمام في الشتاء - مرتين إلى ثلاث مرات أسبوعياً تكفي.',
      'اختاري ملابس قطنية ناعمة لتجنب تهيج البشرة.',
      'غيري الحفاضة فوراً عند البلل لمنع التهيج الذي يزداد في الطقس البارد.',
    ],
  ),
  BlogPost(
    id: 5,
    title: 'متى يبدأ التدريب على استخدام الحمام؟',
    excerpt:
        'دليلك الشامل لمعرفة الوقت المناسب للبدء في تدريب طفلك على الحمام.',
    category: 'نصائح الأمهات',
    readTime: '7 دقائق',
    date: '2024-11-20',
    color: AppColors.primaryPink,
    icon: Icons.access_time,
    image:
        'https://images.unsplash.com/photo-1563212693-0248873752e2?auto=format&fit=crop&q=80&w=800',
    content: [
      'معظم الأطفال يكونون جاهزين بين عمر سنتين وثلاث سنوات.',
      'علامات الاستعداد: يخبرك عندما تكون الحفاضة مبللة، يمكنه الجلوس بثبات.',
      'لا تستعجلي - كل طفل يتعلم بوتيرته الخاصة.',
      'استخدمي حفاضات التدريب كمرحلة انتقالية بين الحفاضات والملابس الداخلية.',
    ],
  ),
  BlogPost(
    id: 6,
    title: 'أفضل ممارسات تخزين الحفاضات',
    excerpt:
        'كيف تحافظين على جودة الحفاضات والمناديل المبللة لأطول فترة ممكنة.',
    category: 'تعليمي',
    readTime: '3 دقائق',
    date: '2024-11-15',
    color: AppColors.babyBlue,
    icon: Icons.newspaper,
    image:
        'https://images.unsplash.com/photo-1614859324967-bdf471bba561?auto=format&fit=crop&q=80&w=800',
    content: [
      'خزني الحفاضات في مكان جاف وبارد بعيداً عن أشعة الشمس المباشرة.',
      'أغلقي عبوة المناديل المبللة بإحكام بعد كل استخدام لمنع الجفاف.',
      'لا تخزني الحفاضات في الحمام - الرطوبة تؤثر على جودة الامتصاص.',
      'تحققي دائماً من تاريخ الصلاحية قبل الاستخدام.',
    ],
  ),
];

final List<String> blogCategories = [
  'الكل',
  'نصائح الأمهات',
  'العناية بالطفل',
  'تعليمي',
];
