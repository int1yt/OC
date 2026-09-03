import 'package:flutter/material.dart';

/// 默认六维能力维度（作品级模板初始值）
const List<String> kDefaultDimensions = ['战力', '智力', '魔力', '敏捷', '魅力', '幸运'];

/// 关系标签预设
const List<String> kPresetRelationLabels = [
  '血缘',
  '宿敌',
  '恋人',
  '君臣',
  '单相思',
  '师徒',
  '挚友',
  '仇敌',
  '同事',
  '路人',
];

/// 关系强度五档：固定，不可增删（撞色渐变 + 线型编码）
class RelationStrength {
  const RelationStrength(
      this.label, this.isBold, this.isDashed, this.color, this.color2);

  final String label;
  final bool isBold;
  final bool isDashed;
  final Color color;
  final Color color2;

  static const List<RelationStrength> all = [
    RelationStrength('亲密', true, false, Color(0xFFF06292), Color(0xFFFFB74D)),
    RelationStrength('友好', false, false, Color(0xFF66BB6A), Color(0xFFD4E157)),
    RelationStrength('疏远', false, true, Color(0xFF9E9E9E), Color(0xFFB0BEC5)),
    RelationStrength('敌对', false, true, Color(0xFF8E44AD), Color(0xFFF06292)),
    RelationStrength('仇视', true, true, Color(0xFF4A148C), Color(0xFFE91E63)),
  ];

  static RelationStrength fromLabel(String label) =>
      all.firstWhere((s) => s.label == label, orElse: () => all[1]);
}

/// 预设撞色搭配（用户在设置里可选）
const List<(Color, Color)> kColorPairs = [
  (Color(0xFFF06292), Color(0xFFFFB74D)), // 粉→橙
  (Color(0xFF8E44AD), Color(0xFFF06292)), // 紫→粉
  (Color(0xFF42A5F5), Color(0xFF26C6DA)), // 蓝→青
  (Color(0xFF66BB6A), Color(0xFFD4E157)), // 绿→黄绿
  (Color(0xFFEF5350), Color(0xFFFF7043)), // 红→橙
  (Color(0xFF4A148C), Color(0xFFE91E63)), // 深紫→红
  (Color(0xFF78909C), Color(0xFFB0BEC5)), // 灰→蓝灰
  (Color(0xFF26C6DA), Color(0xFF8E44AD)), // 青→紫
];

/// 关系方向：0 双向、1 A→B、2 B→A
const int kDirectionBidirectional = 0;
const int kDirectionForward = 1;
const int kDirectionBackward = 2;

/// 关系标签 → 颜色（预设固定色，自定义按哈希取色）
Color labelColor(String label) {
  const palette = [
    Color(0xFFE85D75), // 血缘 红
    Color(0xFF8E44AD), // 宿敌 紫
    Color(0xFFE91E63), // 恋人 粉红
    Color(0xFF5B8DEF), // 君臣 蓝
    Color(0xFFF39C12), // 单相思 橙
    Color(0xFF16A085), // 师徒 青绿
    Color(0xFF27AE60), // 挚友 绿
    Color(0xFFC0392B), // 仇敌 深红
    Color(0xFF7F8C8D), // 同事 灰
    Color(0xFF607D8B), // 路人 蓝灰
  ];
  final idx = kPresetRelationLabels.indexOf(label);
  if (idx >= 0 && idx < palette.length) return palette[idx];
  final h = label.codeUnits.fold<int>(0, (a, b) => a + b);
  return palette[h % palette.length];
}

/// 16 型 MBTI
const List<String> kMbtiTypes = [
  'ISTJ', 'ISFJ', 'INFJ', 'INTJ',
  'ISTP', 'ISFP', 'INFP', 'INTP',
  'ESTP', 'ESFP', 'ENFP', 'ENTP',
  'ESTJ', 'ESFJ', 'ENFJ', 'ENTJ',
];

/// MBTI 一句话解读
const Map<String, String> kMbtiDescriptions = {
  'ISTJ': '可靠务实的检查者',
  'ISFJ': '温暖尽责的守护者',
  'INFJ': '洞察人心的理想主义者',
  'INTJ': '独立果断的战略家',
  'ISTP': '冷静灵巧的实干家',
  'ISFP': '细腻随性的艺术家',
  'INFP': '富有理想的治愈者',
  'INTP': '理性探究的思考者',
  'ESTP': '精力充沛的实干派',
  'ESFP': '热情外向的表演者',
  'ENFP': '自由热情的追梦人',
  'ENTP': '机敏善辩的创新者',
  'ESTJ': '雷厉风行的管理者',
  'ESFJ': '热心周到的协调者',
  'ENFJ': '鼓舞人心的领导者',
  'ENTJ': '强势高效的统帅者',
};

/// 外貌分区
const List<String> kAppearanceSections = ['体型', '发色瞳色', '服饰风格', '特殊标志'];

/// 规则书分区
const List<String> kRuleSections = [
  '魔法 / 科技体系',
  '社会制度',
  '货币 / 度量衡',
  '种族 / 阵营',
  '历史大事件',
  '地理 / 气候',
];

/// 自检清单分类
const List<String> kChecklistCategories = ['地理', '经济', '政治 / 社会'];

/// 星座（按阳历月日区间自动推算）
const List<(String, int, int)> _zodiacRanges = [
  ('摩羯座', 1, 19),
  ('水瓶座', 2, 18),
  ('双鱼座', 3, 20),
  ('白羊座', 4, 19),
  ('金牛座', 5, 20),
  ('双子座', 6, 21),
  ('巨蟹座', 7, 22),
  ('狮子座', 8, 22),
  ('处女座', 9, 22),
  ('天秤座', 10, 23),
  ('天蝎座', 11, 22),
  ('射手座', 12, 21),
];

String zodiacFromDate(DateTime d) {
  for (int i = 0; i < _zodiacRanges.length; i++) {
    final (name, month, day) = _zodiacRanges[i];
    if (d.month == month && d.day <= day) return name;
  }
  return '摩羯座';
}
