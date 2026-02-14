class Partner {
  final String name;
  final String initials;
  const Partner({required this.name, required this.initials});
}

final List<Partner> allPartners = [
  Partner(name: 'هايبر شملان', initials: 'HS'),
  Partner(name: 'سيتي ماكس', initials: 'CM'),
  Partner(name: 'هايبر المستهلك', initials: 'HM'),
  Partner(name: 'صيدليات المجتمع', initials: 'CP'),
  Partner(name: 'أسواق الجند', initials: 'GA'),
  Partner(name: 'توفير هايبر', initials: 'TH'),
  Partner(name: 'المركز التجاري', initials: 'TC'),
  Partner(name: 'المؤسسة العامة', initials: 'GE'),
];

class SizeInfo {
  final int size;
  final String label;
  final String weight;
  final double minWeight;
  final double maxWeight;
  final int count;
  final String price;
  final String ageRange;
  final String emoji;
  const SizeInfo({
    required this.size,
    required this.label,
    required this.weight,
    required this.minWeight,
    required this.maxWeight,
    required this.count,
    required this.price,
    required this.ageRange,
    required this.emoji,
  });
}

final List<SizeInfo> allSizes = [
  SizeInfo(
    size: 1,
    label: 'حديثي الولادة',
    weight: '2-5 كجم',
    minWeight: 2,
    maxWeight: 5,
    count: 42,
    price: '45 ر.س',
    ageRange: '0-3 أشهر',
    emoji: '👶',
  ),
  SizeInfo(
    size: 2,
    label: 'صغير',
    weight: '3-6 كجم',
    minWeight: 3,
    maxWeight: 6,
    count: 40,
    price: '50 ر.س',
    ageRange: '3-6 أشهر',
    emoji: '👶',
  ),
  SizeInfo(
    size: 3,
    label: 'متوسط',
    weight: '4-9 كجم',
    minWeight: 4,
    maxWeight: 9,
    count: 36,
    price: '55 ر.س',
    ageRange: '6-12 شهر',
    emoji: '🧒',
  ),
  SizeInfo(
    size: 4,
    label: 'كبير',
    weight: '7-18 كجم',
    minWeight: 7,
    maxWeight: 18,
    count: 32,
    price: '60 ر.س',
    ageRange: '1-2 سنة',
    emoji: '🧒',
  ),
  SizeInfo(
    size: 5,
    label: 'كبير جداً',
    weight: '11-25 كجم',
    minWeight: 11,
    maxWeight: 25,
    count: 28,
    price: '65 ر.س',
    ageRange: '2-3 سنوات',
    emoji: '🧒',
  ),
  SizeInfo(
    size: 6,
    label: 'جامبو',
    weight: '16+ كجم',
    minWeight: 16,
    maxWeight: 35,
    count: 24,
    price: '70 ر.س',
    ageRange: '3+ سنوات',
    emoji: '👦',
  ),
];

class LayerInfo {
  final String iconName;
  final String title;
  final String description;
  final String color;
  final int step;
  const LayerInfo({
    required this.iconName,
    required this.title,
    required this.description,
    required this.color,
    required this.step,
  });
}
