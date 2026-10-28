import 'package:flutter/material.dart';

enum TaskStatus { pending, scheduled, inProgress, completed, cancelled }

enum TaskPriority {
  low(1, 'منخفضة', Color(0xFF8A9896)),
  medium(2, 'متوسطة', Color(0xFFA96717)),
  high(3, 'عالية', Color(0xFFB84D57));

  const TaskPriority(this.rank, this.labelAr, this.color);
  final int rank;
  final String labelAr;
  final Color color;
}

enum EnergyLevel {
  low('طاقة هادئة', Icons.battery_charging_full_rounded),
  medium('طاقة متوسطة', Icons.bolt_rounded),
  high('طاقة عالية', Icons.electric_bolt_rounded);

  const EnergyLevel(this.labelAr, this.icon);
  final String labelAr;
  final IconData icon;
}

enum PreferredTimeWindow {
  anytime('أي وقت في اليوم'),
  morning('صباحًا (09:00 - 12:00)'),
  afternoon('بعد الظهر (12:00 - 16:00)'),
  evening('مساءً (16:00 - 20:00)');

  const PreferredTimeWindow(this.labelAr);
  final String labelAr;
}

class Category {
  const Category({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  final String id;
  final String name;
  final String nameAr;
  final String icon;
  final Color color;
  final Color bgColor;

  static const List<Category> defaultCategories = [
    Category(
      id: 'cat-work',
      name: 'Work',
      nameAr: 'العمل',
      icon: '💻',
      color: Color(0xFF2B6680),
      bgColor: Color(0xFFE8F3F8),
    ),
    Category(
      id: 'cat-learning',
      name: 'Learning',
      nameAr: 'التعلم',
      icon: '📚',
      color: Color(0xFF7451A3),
      bgColor: Color(0xFFF2ECFA),
    ),
    Category(
      id: 'cat-health',
      name: 'Health',
      nameAr: 'الصحة والرياضة',
      icon: '🏋️',
      color: Color(0xFF4C7B58),
      bgColor: Color(0xFFEAF4EA),
    ),
    Category(
      id: 'cat-personal',
      name: 'Personal',
      nameAr: 'حياة شخصية',
      icon: '🏠',
      color: Color(0xFFA8583B),
      bgColor: Color(0xFFFBEDE8),
    ),
    Category(
      id: 'cat-reading',
      name: 'Reading',
      nameAr: 'القراءة',
      icon: '📖',
      color: Color(0xFF357A7B),
      bgColor: Color(0xFFE6F5F4),
    ),
  ];
}

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.estimatedDuration,
    this.status = TaskStatus.pending,
    required this.createdAt,
    this.updatedAt,
    this.description,
    this.categoryId,
    this.priority = TaskPriority.medium,
    this.actualDuration = Duration.zero,
    this.dueDate,
    this.preferredTimeWindow = PreferredTimeWindow.anytime,
    this.energyLevel,
    this.completedAt,
  });

  final String id;
  final String title;
  final String? description;
  final String? categoryId;
  final TaskPriority priority;
  final Duration estimatedDuration;
  final Duration actualDuration;
  final TaskStatus status;
  final DateTime? dueDate;
  final PreferredTimeWindow preferredTimeWindow;
  final EnergyLevel? energyLevel;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? completedAt;

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? categoryId,
    TaskPriority? priority,
    Duration? estimatedDuration,
    Duration? actualDuration,
    TaskStatus? status,
    DateTime? dueDate,
    PreferredTimeWindow? preferredTimeWindow,
    EnergyLevel? energyLevel,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      priority: priority ?? this.priority,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      actualDuration: actualDuration ?? this.actualDuration,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      preferredTimeWindow: preferredTimeWindow ?? this.preferredTimeWindow,
      energyLevel: energyLevel ?? this.energyLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
