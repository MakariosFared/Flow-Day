// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoryRow extends DataClass implements Insertable<CategoryRow> {
  final String id;
  final String name;
  final String icon;
  const CategoryRow({required this.id, required this.name, required this.icon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
    );
  }

  factory CategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
    };
  }

  CategoryRow copyWith({String? id, String? name, String? icon}) => CategoryRow(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
  );
  CategoryRow copyWithCompanion(CategoriesTableCompanion data) {
    return CategoryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoryRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> rowid;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    required String id,
    required String name,
    required String icon,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       icon = Value(icon);
  static Insertable<CategoryRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<int>? rowid,
  }) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurrenceTemplatesTableTable extends RecurrenceTemplatesTable
    with TableInfo<$RecurrenceTemplatesTableTable, RecurrenceTemplateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurrenceTemplatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _estimatedDurationMinutesMeta =
      const VerificationMeta('estimatedDurationMinutes');
  @override
  late final GeneratedColumn<int> estimatedDurationMinutes =
      GeneratedColumn<int>(
        'estimated_duration_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _preferredTimeWindowMeta =
      const VerificationMeta('preferredTimeWindow');
  @override
  late final GeneratedColumn<String> preferredTimeWindow =
      GeneratedColumn<String>(
        'preferred_time_window',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('anytime'),
      );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<String> energyLevel = GeneratedColumn<String>(
    'energy_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recurrenceTypeMeta = const VerificationMeta(
    'recurrenceType',
  );
  @override
  late final GeneratedColumn<String> recurrenceType = GeneratedColumn<String>(
    'recurrence_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recurrenceDaysMeta = const VerificationMeta(
    'recurrenceDays',
  );
  @override
  late final GeneratedColumn<String> recurrenceDays = GeneratedColumn<String>(
    'recurrence_days',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    categoryId,
    priority,
    estimatedDurationMinutes,
    preferredTimeWindow,
    energyLevel,
    recurrenceType,
    recurrenceDays,
    startDate,
    endDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurrence_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurrenceTemplateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('estimated_duration_minutes')) {
      context.handle(
        _estimatedDurationMinutesMeta,
        estimatedDurationMinutes.isAcceptableOrUnknown(
          data['estimated_duration_minutes']!,
          _estimatedDurationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedDurationMinutesMeta);
    }
    if (data.containsKey('preferred_time_window')) {
      context.handle(
        _preferredTimeWindowMeta,
        preferredTimeWindow.isAcceptableOrUnknown(
          data['preferred_time_window']!,
          _preferredTimeWindowMeta,
        ),
      );
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    }
    if (data.containsKey('recurrence_type')) {
      context.handle(
        _recurrenceTypeMeta,
        recurrenceType.isAcceptableOrUnknown(
          data['recurrence_type']!,
          _recurrenceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recurrenceTypeMeta);
    }
    if (data.containsKey('recurrence_days')) {
      context.handle(
        _recurrenceDaysMeta,
        recurrenceDays.isAcceptableOrUnknown(
          data['recurrence_days']!,
          _recurrenceDaysMeta,
        ),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurrenceTemplateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurrenceTemplateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      estimatedDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_duration_minutes'],
      )!,
      preferredTimeWindow: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_time_window'],
      )!,
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}energy_level'],
      ),
      recurrenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_type'],
      )!,
      recurrenceDays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_days'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RecurrenceTemplatesTableTable createAlias(String alias) {
    return $RecurrenceTemplatesTableTable(attachedDatabase, alias);
  }
}

class RecurrenceTemplateRow extends DataClass
    implements Insertable<RecurrenceTemplateRow> {
  final String id;
  final String title;
  final String? description;
  final String? categoryId;
  final int priority;
  final int estimatedDurationMinutes;
  final String preferredTimeWindow;
  final String? energyLevel;
  final String recurrenceType;
  final String recurrenceDays;
  final String startDate;
  final String? endDate;
  final String createdAt;
  final String updatedAt;
  const RecurrenceTemplateRow({
    required this.id,
    required this.title,
    this.description,
    this.categoryId,
    required this.priority,
    required this.estimatedDurationMinutes,
    required this.preferredTimeWindow,
    this.energyLevel,
    required this.recurrenceType,
    required this.recurrenceDays,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['priority'] = Variable<int>(priority);
    map['estimated_duration_minutes'] = Variable<int>(estimatedDurationMinutes);
    map['preferred_time_window'] = Variable<String>(preferredTimeWindow);
    if (!nullToAbsent || energyLevel != null) {
      map['energy_level'] = Variable<String>(energyLevel);
    }
    map['recurrence_type'] = Variable<String>(recurrenceType);
    map['recurrence_days'] = Variable<String>(recurrenceDays);
    map['start_date'] = Variable<String>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  RecurrenceTemplatesTableCompanion toCompanion(bool nullToAbsent) {
    return RecurrenceTemplatesTableCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      priority: Value(priority),
      estimatedDurationMinutes: Value(estimatedDurationMinutes),
      preferredTimeWindow: Value(preferredTimeWindow),
      energyLevel: energyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(energyLevel),
      recurrenceType: Value(recurrenceType),
      recurrenceDays: Value(recurrenceDays),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RecurrenceTemplateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurrenceTemplateRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      priority: serializer.fromJson<int>(json['priority']),
      estimatedDurationMinutes: serializer.fromJson<int>(
        json['estimatedDurationMinutes'],
      ),
      preferredTimeWindow: serializer.fromJson<String>(
        json['preferredTimeWindow'],
      ),
      energyLevel: serializer.fromJson<String?>(json['energyLevel']),
      recurrenceType: serializer.fromJson<String>(json['recurrenceType']),
      recurrenceDays: serializer.fromJson<String>(json['recurrenceDays']),
      startDate: serializer.fromJson<String>(json['startDate']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'categoryId': serializer.toJson<String?>(categoryId),
      'priority': serializer.toJson<int>(priority),
      'estimatedDurationMinutes': serializer.toJson<int>(
        estimatedDurationMinutes,
      ),
      'preferredTimeWindow': serializer.toJson<String>(preferredTimeWindow),
      'energyLevel': serializer.toJson<String?>(energyLevel),
      'recurrenceType': serializer.toJson<String>(recurrenceType),
      'recurrenceDays': serializer.toJson<String>(recurrenceDays),
      'startDate': serializer.toJson<String>(startDate),
      'endDate': serializer.toJson<String?>(endDate),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  RecurrenceTemplateRow copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    int? priority,
    int? estimatedDurationMinutes,
    String? preferredTimeWindow,
    Value<String?> energyLevel = const Value.absent(),
    String? recurrenceType,
    String? recurrenceDays,
    String? startDate,
    Value<String?> endDate = const Value.absent(),
    String? createdAt,
    String? updatedAt,
  }) => RecurrenceTemplateRow(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    priority: priority ?? this.priority,
    estimatedDurationMinutes:
        estimatedDurationMinutes ?? this.estimatedDurationMinutes,
    preferredTimeWindow: preferredTimeWindow ?? this.preferredTimeWindow,
    energyLevel: energyLevel.present ? energyLevel.value : this.energyLevel,
    recurrenceType: recurrenceType ?? this.recurrenceType,
    recurrenceDays: recurrenceDays ?? this.recurrenceDays,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RecurrenceTemplateRow copyWithCompanion(
    RecurrenceTemplatesTableCompanion data,
  ) {
    return RecurrenceTemplateRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      priority: data.priority.present ? data.priority.value : this.priority,
      estimatedDurationMinutes: data.estimatedDurationMinutes.present
          ? data.estimatedDurationMinutes.value
          : this.estimatedDurationMinutes,
      preferredTimeWindow: data.preferredTimeWindow.present
          ? data.preferredTimeWindow.value
          : this.preferredTimeWindow,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      recurrenceType: data.recurrenceType.present
          ? data.recurrenceType.value
          : this.recurrenceType,
      recurrenceDays: data.recurrenceDays.present
          ? data.recurrenceDays.value
          : this.recurrenceDays,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurrenceTemplateRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('priority: $priority, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('preferredTimeWindow: $preferredTimeWindow, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('recurrenceDays: $recurrenceDays, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    categoryId,
    priority,
    estimatedDurationMinutes,
    preferredTimeWindow,
    energyLevel,
    recurrenceType,
    recurrenceDays,
    startDate,
    endDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurrenceTemplateRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.categoryId == this.categoryId &&
          other.priority == this.priority &&
          other.estimatedDurationMinutes == this.estimatedDurationMinutes &&
          other.preferredTimeWindow == this.preferredTimeWindow &&
          other.energyLevel == this.energyLevel &&
          other.recurrenceType == this.recurrenceType &&
          other.recurrenceDays == this.recurrenceDays &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RecurrenceTemplatesTableCompanion
    extends UpdateCompanion<RecurrenceTemplateRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> categoryId;
  final Value<int> priority;
  final Value<int> estimatedDurationMinutes;
  final Value<String> preferredTimeWindow;
  final Value<String?> energyLevel;
  final Value<String> recurrenceType;
  final Value<String> recurrenceDays;
  final Value<String> startDate;
  final Value<String?> endDate;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const RecurrenceTemplatesTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.priority = const Value.absent(),
    this.estimatedDurationMinutes = const Value.absent(),
    this.preferredTimeWindow = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.recurrenceDays = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurrenceTemplatesTableCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.priority = const Value.absent(),
    required int estimatedDurationMinutes,
    this.preferredTimeWindow = const Value.absent(),
    this.energyLevel = const Value.absent(),
    required String recurrenceType,
    this.recurrenceDays = const Value.absent(),
    required String startDate,
    this.endDate = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       estimatedDurationMinutes = Value(estimatedDurationMinutes),
       recurrenceType = Value(recurrenceType),
       startDate = Value(startDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RecurrenceTemplateRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? categoryId,
    Expression<int>? priority,
    Expression<int>? estimatedDurationMinutes,
    Expression<String>? preferredTimeWindow,
    Expression<String>? energyLevel,
    Expression<String>? recurrenceType,
    Expression<String>? recurrenceDays,
    Expression<String>? startDate,
    Expression<String>? endDate,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (categoryId != null) 'category_id': categoryId,
      if (priority != null) 'priority': priority,
      if (estimatedDurationMinutes != null)
        'estimated_duration_minutes': estimatedDurationMinutes,
      if (preferredTimeWindow != null)
        'preferred_time_window': preferredTimeWindow,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (recurrenceType != null) 'recurrence_type': recurrenceType,
      if (recurrenceDays != null) 'recurrence_days': recurrenceDays,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurrenceTemplatesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? categoryId,
    Value<int>? priority,
    Value<int>? estimatedDurationMinutes,
    Value<String>? preferredTimeWindow,
    Value<String?>? energyLevel,
    Value<String>? recurrenceType,
    Value<String>? recurrenceDays,
    Value<String>? startDate,
    Value<String?>? endDate,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return RecurrenceTemplatesTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      priority: priority ?? this.priority,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      preferredTimeWindow: preferredTimeWindow ?? this.preferredTimeWindow,
      energyLevel: energyLevel ?? this.energyLevel,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      recurrenceDays: recurrenceDays ?? this.recurrenceDays,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (estimatedDurationMinutes.present) {
      map['estimated_duration_minutes'] = Variable<int>(
        estimatedDurationMinutes.value,
      );
    }
    if (preferredTimeWindow.present) {
      map['preferred_time_window'] = Variable<String>(
        preferredTimeWindow.value,
      );
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<String>(energyLevel.value);
    }
    if (recurrenceType.present) {
      map['recurrence_type'] = Variable<String>(recurrenceType.value);
    }
    if (recurrenceDays.present) {
      map['recurrence_days'] = Variable<String>(recurrenceDays.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurrenceTemplatesTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('priority: $priority, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('preferredTimeWindow: $preferredTimeWindow, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('recurrenceDays: $recurrenceDays, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTableTable extends TasksTable
    with TableInfo<$TasksTableTable, TaskRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _estimatedDurationMinutesMeta =
      const VerificationMeta('estimatedDurationMinutes');
  @override
  late final GeneratedColumn<int> estimatedDurationMinutes =
      GeneratedColumn<int>(
        'estimated_duration_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _actualDurationSecondsMeta =
      const VerificationMeta('actualDurationSeconds');
  @override
  late final GeneratedColumn<int> actualDurationSeconds = GeneratedColumn<int>(
    'actual_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preferredTimeWindowMeta =
      const VerificationMeta('preferredTimeWindow');
  @override
  late final GeneratedColumn<String> preferredTimeWindow =
      GeneratedColumn<String>(
        'preferred_time_window',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('anytime'),
      );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<String> energyLevel = GeneratedColumn<String>(
    'energy_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recurrenceTemplateIdMeta =
      const VerificationMeta('recurrenceTemplateId');
  @override
  late final GeneratedColumn<String> recurrenceTemplateId =
      GeneratedColumn<String>(
        'recurrence_template_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES recurrence_templates (id) ON DELETE SET NULL',
        ),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<String> completedAt = GeneratedColumn<String>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    categoryId,
    priority,
    estimatedDurationMinutes,
    actualDurationSeconds,
    status,
    dueDate,
    preferredTimeWindow,
    energyLevel,
    recurrenceTemplateId,
    createdAt,
    updatedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('estimated_duration_minutes')) {
      context.handle(
        _estimatedDurationMinutesMeta,
        estimatedDurationMinutes.isAcceptableOrUnknown(
          data['estimated_duration_minutes']!,
          _estimatedDurationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedDurationMinutesMeta);
    }
    if (data.containsKey('actual_duration_seconds')) {
      context.handle(
        _actualDurationSecondsMeta,
        actualDurationSeconds.isAcceptableOrUnknown(
          data['actual_duration_seconds']!,
          _actualDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('preferred_time_window')) {
      context.handle(
        _preferredTimeWindowMeta,
        preferredTimeWindow.isAcceptableOrUnknown(
          data['preferred_time_window']!,
          _preferredTimeWindowMeta,
        ),
      );
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    }
    if (data.containsKey('recurrence_template_id')) {
      context.handle(
        _recurrenceTemplateIdMeta,
        recurrenceTemplateId.isAcceptableOrUnknown(
          data['recurrence_template_id']!,
          _recurrenceTemplateIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      estimatedDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_duration_minutes'],
      )!,
      actualDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_duration_seconds'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date'],
      ),
      preferredTimeWindow: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_time_window'],
      )!,
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}energy_level'],
      ),
      recurrenceTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_template_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $TasksTableTable createAlias(String alias) {
    return $TasksTableTable(attachedDatabase, alias);
  }
}

class TaskRow extends DataClass implements Insertable<TaskRow> {
  final String id;
  final String title;
  final String? description;
  final String? categoryId;
  final int priority;
  final int estimatedDurationMinutes;
  final int actualDurationSeconds;
  final String status;
  final String? dueDate;
  final String preferredTimeWindow;
  final String? energyLevel;
  final String? recurrenceTemplateId;
  final String createdAt;
  final String updatedAt;
  final String? completedAt;
  const TaskRow({
    required this.id,
    required this.title,
    this.description,
    this.categoryId,
    required this.priority,
    required this.estimatedDurationMinutes,
    required this.actualDurationSeconds,
    required this.status,
    this.dueDate,
    required this.preferredTimeWindow,
    this.energyLevel,
    this.recurrenceTemplateId,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['priority'] = Variable<int>(priority);
    map['estimated_duration_minutes'] = Variable<int>(estimatedDurationMinutes);
    map['actual_duration_seconds'] = Variable<int>(actualDurationSeconds);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<String>(dueDate);
    }
    map['preferred_time_window'] = Variable<String>(preferredTimeWindow);
    if (!nullToAbsent || energyLevel != null) {
      map['energy_level'] = Variable<String>(energyLevel);
    }
    if (!nullToAbsent || recurrenceTemplateId != null) {
      map['recurrence_template_id'] = Variable<String>(recurrenceTemplateId);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<String>(completedAt);
    }
    return map;
  }

  TasksTableCompanion toCompanion(bool nullToAbsent) {
    return TasksTableCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      priority: Value(priority),
      estimatedDurationMinutes: Value(estimatedDurationMinutes),
      actualDurationSeconds: Value(actualDurationSeconds),
      status: Value(status),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      preferredTimeWindow: Value(preferredTimeWindow),
      energyLevel: energyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(energyLevel),
      recurrenceTemplateId: recurrenceTemplateId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceTemplateId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory TaskRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      priority: serializer.fromJson<int>(json['priority']),
      estimatedDurationMinutes: serializer.fromJson<int>(
        json['estimatedDurationMinutes'],
      ),
      actualDurationSeconds: serializer.fromJson<int>(
        json['actualDurationSeconds'],
      ),
      status: serializer.fromJson<String>(json['status']),
      dueDate: serializer.fromJson<String?>(json['dueDate']),
      preferredTimeWindow: serializer.fromJson<String>(
        json['preferredTimeWindow'],
      ),
      energyLevel: serializer.fromJson<String?>(json['energyLevel']),
      recurrenceTemplateId: serializer.fromJson<String?>(
        json['recurrenceTemplateId'],
      ),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      completedAt: serializer.fromJson<String?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'categoryId': serializer.toJson<String?>(categoryId),
      'priority': serializer.toJson<int>(priority),
      'estimatedDurationMinutes': serializer.toJson<int>(
        estimatedDurationMinutes,
      ),
      'actualDurationSeconds': serializer.toJson<int>(actualDurationSeconds),
      'status': serializer.toJson<String>(status),
      'dueDate': serializer.toJson<String?>(dueDate),
      'preferredTimeWindow': serializer.toJson<String>(preferredTimeWindow),
      'energyLevel': serializer.toJson<String?>(energyLevel),
      'recurrenceTemplateId': serializer.toJson<String?>(recurrenceTemplateId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'completedAt': serializer.toJson<String?>(completedAt),
    };
  }

  TaskRow copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    int? priority,
    int? estimatedDurationMinutes,
    int? actualDurationSeconds,
    String? status,
    Value<String?> dueDate = const Value.absent(),
    String? preferredTimeWindow,
    Value<String?> energyLevel = const Value.absent(),
    Value<String?> recurrenceTemplateId = const Value.absent(),
    String? createdAt,
    String? updatedAt,
    Value<String?> completedAt = const Value.absent(),
  }) => TaskRow(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    priority: priority ?? this.priority,
    estimatedDurationMinutes:
        estimatedDurationMinutes ?? this.estimatedDurationMinutes,
    actualDurationSeconds: actualDurationSeconds ?? this.actualDurationSeconds,
    status: status ?? this.status,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    preferredTimeWindow: preferredTimeWindow ?? this.preferredTimeWindow,
    energyLevel: energyLevel.present ? energyLevel.value : this.energyLevel,
    recurrenceTemplateId: recurrenceTemplateId.present
        ? recurrenceTemplateId.value
        : this.recurrenceTemplateId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  TaskRow copyWithCompanion(TasksTableCompanion data) {
    return TaskRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      priority: data.priority.present ? data.priority.value : this.priority,
      estimatedDurationMinutes: data.estimatedDurationMinutes.present
          ? data.estimatedDurationMinutes.value
          : this.estimatedDurationMinutes,
      actualDurationSeconds: data.actualDurationSeconds.present
          ? data.actualDurationSeconds.value
          : this.actualDurationSeconds,
      status: data.status.present ? data.status.value : this.status,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      preferredTimeWindow: data.preferredTimeWindow.present
          ? data.preferredTimeWindow.value
          : this.preferredTimeWindow,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      recurrenceTemplateId: data.recurrenceTemplateId.present
          ? data.recurrenceTemplateId.value
          : this.recurrenceTemplateId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('priority: $priority, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('actualDurationSeconds: $actualDurationSeconds, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('preferredTimeWindow: $preferredTimeWindow, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('recurrenceTemplateId: $recurrenceTemplateId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    categoryId,
    priority,
    estimatedDurationMinutes,
    actualDurationSeconds,
    status,
    dueDate,
    preferredTimeWindow,
    energyLevel,
    recurrenceTemplateId,
    createdAt,
    updatedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.categoryId == this.categoryId &&
          other.priority == this.priority &&
          other.estimatedDurationMinutes == this.estimatedDurationMinutes &&
          other.actualDurationSeconds == this.actualDurationSeconds &&
          other.status == this.status &&
          other.dueDate == this.dueDate &&
          other.preferredTimeWindow == this.preferredTimeWindow &&
          other.energyLevel == this.energyLevel &&
          other.recurrenceTemplateId == this.recurrenceTemplateId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt);
}

class TasksTableCompanion extends UpdateCompanion<TaskRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> categoryId;
  final Value<int> priority;
  final Value<int> estimatedDurationMinutes;
  final Value<int> actualDurationSeconds;
  final Value<String> status;
  final Value<String?> dueDate;
  final Value<String> preferredTimeWindow;
  final Value<String?> energyLevel;
  final Value<String?> recurrenceTemplateId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> completedAt;
  final Value<int> rowid;
  const TasksTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.priority = const Value.absent(),
    this.estimatedDurationMinutes = const Value.absent(),
    this.actualDurationSeconds = const Value.absent(),
    this.status = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.preferredTimeWindow = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.recurrenceTemplateId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksTableCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.priority = const Value.absent(),
    required int estimatedDurationMinutes,
    this.actualDurationSeconds = const Value.absent(),
    this.status = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.preferredTimeWindow = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.recurrenceTemplateId = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       estimatedDurationMinutes = Value(estimatedDurationMinutes),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TaskRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? categoryId,
    Expression<int>? priority,
    Expression<int>? estimatedDurationMinutes,
    Expression<int>? actualDurationSeconds,
    Expression<String>? status,
    Expression<String>? dueDate,
    Expression<String>? preferredTimeWindow,
    Expression<String>? energyLevel,
    Expression<String>? recurrenceTemplateId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (categoryId != null) 'category_id': categoryId,
      if (priority != null) 'priority': priority,
      if (estimatedDurationMinutes != null)
        'estimated_duration_minutes': estimatedDurationMinutes,
      if (actualDurationSeconds != null)
        'actual_duration_seconds': actualDurationSeconds,
      if (status != null) 'status': status,
      if (dueDate != null) 'due_date': dueDate,
      if (preferredTimeWindow != null)
        'preferred_time_window': preferredTimeWindow,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (recurrenceTemplateId != null)
        'recurrence_template_id': recurrenceTemplateId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? categoryId,
    Value<int>? priority,
    Value<int>? estimatedDurationMinutes,
    Value<int>? actualDurationSeconds,
    Value<String>? status,
    Value<String?>? dueDate,
    Value<String>? preferredTimeWindow,
    Value<String?>? energyLevel,
    Value<String?>? recurrenceTemplateId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? completedAt,
    Value<int>? rowid,
  }) {
    return TasksTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      priority: priority ?? this.priority,
      estimatedDurationMinutes:
          estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      actualDurationSeconds:
          actualDurationSeconds ?? this.actualDurationSeconds,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      preferredTimeWindow: preferredTimeWindow ?? this.preferredTimeWindow,
      energyLevel: energyLevel ?? this.energyLevel,
      recurrenceTemplateId: recurrenceTemplateId ?? this.recurrenceTemplateId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (estimatedDurationMinutes.present) {
      map['estimated_duration_minutes'] = Variable<int>(
        estimatedDurationMinutes.value,
      );
    }
    if (actualDurationSeconds.present) {
      map['actual_duration_seconds'] = Variable<int>(
        actualDurationSeconds.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (preferredTimeWindow.present) {
      map['preferred_time_window'] = Variable<String>(
        preferredTimeWindow.value,
      );
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<String>(energyLevel.value);
    }
    if (recurrenceTemplateId.present) {
      map['recurrence_template_id'] = Variable<String>(
        recurrenceTemplateId.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<String>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('priority: $priority, ')
          ..write('estimatedDurationMinutes: $estimatedDurationMinutes, ')
          ..write('actualDurationSeconds: $actualDurationSeconds, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('preferredTimeWindow: $preferredTimeWindow, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('recurrenceTemplateId: $recurrenceTemplateId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyPlansTableTable extends DailyPlansTable
    with TableInfo<$DailyPlansTableTable, DailyPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyPlansTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planDateMeta = const VerificationMeta(
    'planDate',
  );
  @override
  late final GeneratedColumn<String> planDate = GeneratedColumn<String>(
    'plan_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _availableStartMinuteMeta =
      const VerificationMeta('availableStartMinute');
  @override
  late final GeneratedColumn<int> availableStartMinute = GeneratedColumn<int>(
    'available_start_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _availableEndMinuteMeta =
      const VerificationMeta('availableEndMinute');
  @override
  late final GeneratedColumn<int> availableEndMinute = GeneratedColumn<int>(
    'available_end_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedMinutesMeta = const VerificationMeta(
    'plannedMinutes',
  );
  @override
  late final GeneratedColumn<int> plannedMinutes = GeneratedColumn<int>(
    'planned_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedMinutesMeta = const VerificationMeta(
    'completedMinutes',
  );
  @override
  late final GeneratedColumn<int> completedMinutes = GeneratedColumn<int>(
    'completed_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planDate,
    availableStartMinute,
    availableEndMinute,
    plannedMinutes,
    completedMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyPlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_date')) {
      context.handle(
        _planDateMeta,
        planDate.isAcceptableOrUnknown(data['plan_date']!, _planDateMeta),
      );
    } else if (isInserting) {
      context.missing(_planDateMeta);
    }
    if (data.containsKey('available_start_minute')) {
      context.handle(
        _availableStartMinuteMeta,
        availableStartMinute.isAcceptableOrUnknown(
          data['available_start_minute']!,
          _availableStartMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_availableStartMinuteMeta);
    }
    if (data.containsKey('available_end_minute')) {
      context.handle(
        _availableEndMinuteMeta,
        availableEndMinute.isAcceptableOrUnknown(
          data['available_end_minute']!,
          _availableEndMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_availableEndMinuteMeta);
    }
    if (data.containsKey('planned_minutes')) {
      context.handle(
        _plannedMinutesMeta,
        plannedMinutes.isAcceptableOrUnknown(
          data['planned_minutes']!,
          _plannedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('completed_minutes')) {
      context.handle(
        _completedMinutesMeta,
        completedMinutes.isAcceptableOrUnknown(
          data['completed_minutes']!,
          _completedMinutesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyPlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_date'],
      )!,
      availableStartMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}available_start_minute'],
      )!,
      availableEndMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}available_end_minute'],
      )!,
      plannedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_minutes'],
      )!,
      completedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_minutes'],
      )!,
    );
  }

  @override
  $DailyPlansTableTable createAlias(String alias) {
    return $DailyPlansTableTable(attachedDatabase, alias);
  }
}

class DailyPlanRow extends DataClass implements Insertable<DailyPlanRow> {
  final String id;
  final String planDate;
  final int availableStartMinute;
  final int availableEndMinute;
  final int plannedMinutes;
  final int completedMinutes;
  const DailyPlanRow({
    required this.id,
    required this.planDate,
    required this.availableStartMinute,
    required this.availableEndMinute,
    required this.plannedMinutes,
    required this.completedMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plan_date'] = Variable<String>(planDate);
    map['available_start_minute'] = Variable<int>(availableStartMinute);
    map['available_end_minute'] = Variable<int>(availableEndMinute);
    map['planned_minutes'] = Variable<int>(plannedMinutes);
    map['completed_minutes'] = Variable<int>(completedMinutes);
    return map;
  }

  DailyPlansTableCompanion toCompanion(bool nullToAbsent) {
    return DailyPlansTableCompanion(
      id: Value(id),
      planDate: Value(planDate),
      availableStartMinute: Value(availableStartMinute),
      availableEndMinute: Value(availableEndMinute),
      plannedMinutes: Value(plannedMinutes),
      completedMinutes: Value(completedMinutes),
    );
  }

  factory DailyPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyPlanRow(
      id: serializer.fromJson<String>(json['id']),
      planDate: serializer.fromJson<String>(json['planDate']),
      availableStartMinute: serializer.fromJson<int>(
        json['availableStartMinute'],
      ),
      availableEndMinute: serializer.fromJson<int>(json['availableEndMinute']),
      plannedMinutes: serializer.fromJson<int>(json['plannedMinutes']),
      completedMinutes: serializer.fromJson<int>(json['completedMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'planDate': serializer.toJson<String>(planDate),
      'availableStartMinute': serializer.toJson<int>(availableStartMinute),
      'availableEndMinute': serializer.toJson<int>(availableEndMinute),
      'plannedMinutes': serializer.toJson<int>(plannedMinutes),
      'completedMinutes': serializer.toJson<int>(completedMinutes),
    };
  }

  DailyPlanRow copyWith({
    String? id,
    String? planDate,
    int? availableStartMinute,
    int? availableEndMinute,
    int? plannedMinutes,
    int? completedMinutes,
  }) => DailyPlanRow(
    id: id ?? this.id,
    planDate: planDate ?? this.planDate,
    availableStartMinute: availableStartMinute ?? this.availableStartMinute,
    availableEndMinute: availableEndMinute ?? this.availableEndMinute,
    plannedMinutes: plannedMinutes ?? this.plannedMinutes,
    completedMinutes: completedMinutes ?? this.completedMinutes,
  );
  DailyPlanRow copyWithCompanion(DailyPlansTableCompanion data) {
    return DailyPlanRow(
      id: data.id.present ? data.id.value : this.id,
      planDate: data.planDate.present ? data.planDate.value : this.planDate,
      availableStartMinute: data.availableStartMinute.present
          ? data.availableStartMinute.value
          : this.availableStartMinute,
      availableEndMinute: data.availableEndMinute.present
          ? data.availableEndMinute.value
          : this.availableEndMinute,
      plannedMinutes: data.plannedMinutes.present
          ? data.plannedMinutes.value
          : this.plannedMinutes,
      completedMinutes: data.completedMinutes.present
          ? data.completedMinutes.value
          : this.completedMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyPlanRow(')
          ..write('id: $id, ')
          ..write('planDate: $planDate, ')
          ..write('availableStartMinute: $availableStartMinute, ')
          ..write('availableEndMinute: $availableEndMinute, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('completedMinutes: $completedMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planDate,
    availableStartMinute,
    availableEndMinute,
    plannedMinutes,
    completedMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyPlanRow &&
          other.id == this.id &&
          other.planDate == this.planDate &&
          other.availableStartMinute == this.availableStartMinute &&
          other.availableEndMinute == this.availableEndMinute &&
          other.plannedMinutes == this.plannedMinutes &&
          other.completedMinutes == this.completedMinutes);
}

class DailyPlansTableCompanion extends UpdateCompanion<DailyPlanRow> {
  final Value<String> id;
  final Value<String> planDate;
  final Value<int> availableStartMinute;
  final Value<int> availableEndMinute;
  final Value<int> plannedMinutes;
  final Value<int> completedMinutes;
  final Value<int> rowid;
  const DailyPlansTableCompanion({
    this.id = const Value.absent(),
    this.planDate = const Value.absent(),
    this.availableStartMinute = const Value.absent(),
    this.availableEndMinute = const Value.absent(),
    this.plannedMinutes = const Value.absent(),
    this.completedMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyPlansTableCompanion.insert({
    required String id,
    required String planDate,
    required int availableStartMinute,
    required int availableEndMinute,
    this.plannedMinutes = const Value.absent(),
    this.completedMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       planDate = Value(planDate),
       availableStartMinute = Value(availableStartMinute),
       availableEndMinute = Value(availableEndMinute);
  static Insertable<DailyPlanRow> custom({
    Expression<String>? id,
    Expression<String>? planDate,
    Expression<int>? availableStartMinute,
    Expression<int>? availableEndMinute,
    Expression<int>? plannedMinutes,
    Expression<int>? completedMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planDate != null) 'plan_date': planDate,
      if (availableStartMinute != null)
        'available_start_minute': availableStartMinute,
      if (availableEndMinute != null)
        'available_end_minute': availableEndMinute,
      if (plannedMinutes != null) 'planned_minutes': plannedMinutes,
      if (completedMinutes != null) 'completed_minutes': completedMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyPlansTableCompanion copyWith({
    Value<String>? id,
    Value<String>? planDate,
    Value<int>? availableStartMinute,
    Value<int>? availableEndMinute,
    Value<int>? plannedMinutes,
    Value<int>? completedMinutes,
    Value<int>? rowid,
  }) {
    return DailyPlansTableCompanion(
      id: id ?? this.id,
      planDate: planDate ?? this.planDate,
      availableStartMinute: availableStartMinute ?? this.availableStartMinute,
      availableEndMinute: availableEndMinute ?? this.availableEndMinute,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      completedMinutes: completedMinutes ?? this.completedMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planDate.present) {
      map['plan_date'] = Variable<String>(planDate.value);
    }
    if (availableStartMinute.present) {
      map['available_start_minute'] = Variable<int>(availableStartMinute.value);
    }
    if (availableEndMinute.present) {
      map['available_end_minute'] = Variable<int>(availableEndMinute.value);
    }
    if (plannedMinutes.present) {
      map['planned_minutes'] = Variable<int>(plannedMinutes.value);
    }
    if (completedMinutes.present) {
      map['completed_minutes'] = Variable<int>(completedMinutes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyPlansTableCompanion(')
          ..write('id: $id, ')
          ..write('planDate: $planDate, ')
          ..write('availableStartMinute: $availableStartMinute, ')
          ..write('availableEndMinute: $availableEndMinute, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('completedMinutes: $completedMinutes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduleBlocksTableTable extends ScheduleBlocksTable
    with TableInfo<$ScheduleBlocksTableTable, ScheduleBlockRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleBlocksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planDateMeta = const VerificationMeta(
    'planDate',
  );
  @override
  late final GeneratedColumn<String> planDate = GeneratedColumn<String>(
    'plan_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMinuteMeta = const VerificationMeta(
    'startMinute',
  );
  @override
  late final GeneratedColumn<int> startMinute = GeneratedColumn<int>(
    'start_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMinuteMeta = const VerificationMeta(
    'endMinute',
  );
  @override
  late final GeneratedColumn<int> endMinute = GeneratedColumn<int>(
    'end_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _blockTypeMeta = const VerificationMeta(
    'blockType',
  );
  @override
  late final GeneratedColumn<String> blockType = GeneratedColumn<String>(
    'block_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tasks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planDate,
    startMinute,
    endMinute,
    blockType,
    source,
    taskId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_blocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleBlockRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_date')) {
      context.handle(
        _planDateMeta,
        planDate.isAcceptableOrUnknown(data['plan_date']!, _planDateMeta),
      );
    } else if (isInserting) {
      context.missing(_planDateMeta);
    }
    if (data.containsKey('start_minute')) {
      context.handle(
        _startMinuteMeta,
        startMinute.isAcceptableOrUnknown(
          data['start_minute']!,
          _startMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startMinuteMeta);
    }
    if (data.containsKey('end_minute')) {
      context.handle(
        _endMinuteMeta,
        endMinute.isAcceptableOrUnknown(data['end_minute']!, _endMinuteMeta),
      );
    } else if (isInserting) {
      context.missing(_endMinuteMeta);
    }
    if (data.containsKey('block_type')) {
      context.handle(
        _blockTypeMeta,
        blockType.isAcceptableOrUnknown(data['block_type']!, _blockTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_blockTypeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleBlockRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleBlockRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_date'],
      )!,
      startMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minute'],
      )!,
      endMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minute'],
      )!,
      blockType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_type'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ScheduleBlocksTableTable createAlias(String alias) {
    return $ScheduleBlocksTableTable(attachedDatabase, alias);
  }
}

class ScheduleBlockRow extends DataClass
    implements Insertable<ScheduleBlockRow> {
  final String id;
  final String planDate;
  final int startMinute;
  final int endMinute;
  final String blockType;
  final String source;
  final String? taskId;
  final String createdAt;
  final String updatedAt;
  const ScheduleBlockRow({
    required this.id,
    required this.planDate,
    required this.startMinute,
    required this.endMinute,
    required this.blockType,
    required this.source,
    this.taskId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plan_date'] = Variable<String>(planDate);
    map['start_minute'] = Variable<int>(startMinute);
    map['end_minute'] = Variable<int>(endMinute);
    map['block_type'] = Variable<String>(blockType);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  ScheduleBlocksTableCompanion toCompanion(bool nullToAbsent) {
    return ScheduleBlocksTableCompanion(
      id: Value(id),
      planDate: Value(planDate),
      startMinute: Value(startMinute),
      endMinute: Value(endMinute),
      blockType: Value(blockType),
      source: Value(source),
      taskId: taskId == null && nullToAbsent
          ? const Value.absent()
          : Value(taskId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ScheduleBlockRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleBlockRow(
      id: serializer.fromJson<String>(json['id']),
      planDate: serializer.fromJson<String>(json['planDate']),
      startMinute: serializer.fromJson<int>(json['startMinute']),
      endMinute: serializer.fromJson<int>(json['endMinute']),
      blockType: serializer.fromJson<String>(json['blockType']),
      source: serializer.fromJson<String>(json['source']),
      taskId: serializer.fromJson<String?>(json['taskId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'planDate': serializer.toJson<String>(planDate),
      'startMinute': serializer.toJson<int>(startMinute),
      'endMinute': serializer.toJson<int>(endMinute),
      'blockType': serializer.toJson<String>(blockType),
      'source': serializer.toJson<String>(source),
      'taskId': serializer.toJson<String?>(taskId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  ScheduleBlockRow copyWith({
    String? id,
    String? planDate,
    int? startMinute,
    int? endMinute,
    String? blockType,
    String? source,
    Value<String?> taskId = const Value.absent(),
    String? createdAt,
    String? updatedAt,
  }) => ScheduleBlockRow(
    id: id ?? this.id,
    planDate: planDate ?? this.planDate,
    startMinute: startMinute ?? this.startMinute,
    endMinute: endMinute ?? this.endMinute,
    blockType: blockType ?? this.blockType,
    source: source ?? this.source,
    taskId: taskId.present ? taskId.value : this.taskId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ScheduleBlockRow copyWithCompanion(ScheduleBlocksTableCompanion data) {
    return ScheduleBlockRow(
      id: data.id.present ? data.id.value : this.id,
      planDate: data.planDate.present ? data.planDate.value : this.planDate,
      startMinute: data.startMinute.present
          ? data.startMinute.value
          : this.startMinute,
      endMinute: data.endMinute.present ? data.endMinute.value : this.endMinute,
      blockType: data.blockType.present ? data.blockType.value : this.blockType,
      source: data.source.present ? data.source.value : this.source,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleBlockRow(')
          ..write('id: $id, ')
          ..write('planDate: $planDate, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('blockType: $blockType, ')
          ..write('source: $source, ')
          ..write('taskId: $taskId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planDate,
    startMinute,
    endMinute,
    blockType,
    source,
    taskId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleBlockRow &&
          other.id == this.id &&
          other.planDate == this.planDate &&
          other.startMinute == this.startMinute &&
          other.endMinute == this.endMinute &&
          other.blockType == this.blockType &&
          other.source == this.source &&
          other.taskId == this.taskId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ScheduleBlocksTableCompanion extends UpdateCompanion<ScheduleBlockRow> {
  final Value<String> id;
  final Value<String> planDate;
  final Value<int> startMinute;
  final Value<int> endMinute;
  final Value<String> blockType;
  final Value<String> source;
  final Value<String?> taskId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const ScheduleBlocksTableCompanion({
    this.id = const Value.absent(),
    this.planDate = const Value.absent(),
    this.startMinute = const Value.absent(),
    this.endMinute = const Value.absent(),
    this.blockType = const Value.absent(),
    this.source = const Value.absent(),
    this.taskId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduleBlocksTableCompanion.insert({
    required String id,
    required String planDate,
    required int startMinute,
    required int endMinute,
    required String blockType,
    required String source,
    this.taskId = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       planDate = Value(planDate),
       startMinute = Value(startMinute),
       endMinute = Value(endMinute),
       blockType = Value(blockType),
       source = Value(source),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ScheduleBlockRow> custom({
    Expression<String>? id,
    Expression<String>? planDate,
    Expression<int>? startMinute,
    Expression<int>? endMinute,
    Expression<String>? blockType,
    Expression<String>? source,
    Expression<String>? taskId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planDate != null) 'plan_date': planDate,
      if (startMinute != null) 'start_minute': startMinute,
      if (endMinute != null) 'end_minute': endMinute,
      if (blockType != null) 'block_type': blockType,
      if (source != null) 'source': source,
      if (taskId != null) 'task_id': taskId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduleBlocksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? planDate,
    Value<int>? startMinute,
    Value<int>? endMinute,
    Value<String>? blockType,
    Value<String>? source,
    Value<String?>? taskId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return ScheduleBlocksTableCompanion(
      id: id ?? this.id,
      planDate: planDate ?? this.planDate,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      blockType: blockType ?? this.blockType,
      source: source ?? this.source,
      taskId: taskId ?? this.taskId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planDate.present) {
      map['plan_date'] = Variable<String>(planDate.value);
    }
    if (startMinute.present) {
      map['start_minute'] = Variable<int>(startMinute.value);
    }
    if (endMinute.present) {
      map['end_minute'] = Variable<int>(endMinute.value);
    }
    if (blockType.present) {
      map['block_type'] = Variable<String>(blockType.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleBlocksTableCompanion(')
          ..write('id: $id, ')
          ..write('planDate: $planDate, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('blockType: $blockType, ')
          ..write('source: $source, ')
          ..write('taskId: $taskId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyStatsTableTable extends DailyStatsTable
    with TableInfo<$DailyStatsTableTable, DailyStatsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyStatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statsDateMeta = const VerificationMeta(
    'statsDate',
  );
  @override
  late final GeneratedColumn<String> statsDate = GeneratedColumn<String>(
    'stats_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _tasksPlannedMeta = const VerificationMeta(
    'tasksPlanned',
  );
  @override
  late final GeneratedColumn<int> tasksPlanned = GeneratedColumn<int>(
    'tasks_planned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tasksCompletedMeta = const VerificationMeta(
    'tasksCompleted',
  );
  @override
  late final GeneratedColumn<int> tasksCompleted = GeneratedColumn<int>(
    'tasks_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _plannedMinutesMeta = const VerificationMeta(
    'plannedMinutes',
  );
  @override
  late final GeneratedColumn<int> plannedMinutes = GeneratedColumn<int>(
    'planned_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedMinutesMeta = const VerificationMeta(
    'completedMinutes',
  );
  @override
  late final GeneratedColumn<int> completedMinutes = GeneratedColumn<int>(
    'completed_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _overloadedMinutesMeta = const VerificationMeta(
    'overloadedMinutes',
  );
  @override
  late final GeneratedColumn<int> overloadedMinutes = GeneratedColumn<int>(
    'overloaded_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _tasksRolledOverMeta = const VerificationMeta(
    'tasksRolledOver',
  );
  @override
  late final GeneratedColumn<int> tasksRolledOver = GeneratedColumn<int>(
    'tasks_rolled_over',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    statsDate,
    tasksPlanned,
    tasksCompleted,
    plannedMinutes,
    completedMinutes,
    overloadedMinutes,
    tasksRolledOver,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyStatsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('stats_date')) {
      context.handle(
        _statsDateMeta,
        statsDate.isAcceptableOrUnknown(data['stats_date']!, _statsDateMeta),
      );
    } else if (isInserting) {
      context.missing(_statsDateMeta);
    }
    if (data.containsKey('tasks_planned')) {
      context.handle(
        _tasksPlannedMeta,
        tasksPlanned.isAcceptableOrUnknown(
          data['tasks_planned']!,
          _tasksPlannedMeta,
        ),
      );
    }
    if (data.containsKey('tasks_completed')) {
      context.handle(
        _tasksCompletedMeta,
        tasksCompleted.isAcceptableOrUnknown(
          data['tasks_completed']!,
          _tasksCompletedMeta,
        ),
      );
    }
    if (data.containsKey('planned_minutes')) {
      context.handle(
        _plannedMinutesMeta,
        plannedMinutes.isAcceptableOrUnknown(
          data['planned_minutes']!,
          _plannedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('completed_minutes')) {
      context.handle(
        _completedMinutesMeta,
        completedMinutes.isAcceptableOrUnknown(
          data['completed_minutes']!,
          _completedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('overloaded_minutes')) {
      context.handle(
        _overloadedMinutesMeta,
        overloadedMinutes.isAcceptableOrUnknown(
          data['overloaded_minutes']!,
          _overloadedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('tasks_rolled_over')) {
      context.handle(
        _tasksRolledOverMeta,
        tasksRolledOver.isAcceptableOrUnknown(
          data['tasks_rolled_over']!,
          _tasksRolledOverMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyStatsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyStatsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      statsDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stats_date'],
      )!,
      tasksPlanned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tasks_planned'],
      )!,
      tasksCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tasks_completed'],
      )!,
      plannedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_minutes'],
      )!,
      completedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_minutes'],
      )!,
      overloadedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}overloaded_minutes'],
      )!,
      tasksRolledOver: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tasks_rolled_over'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyStatsTableTable createAlias(String alias) {
    return $DailyStatsTableTable(attachedDatabase, alias);
  }
}

class DailyStatsRow extends DataClass implements Insertable<DailyStatsRow> {
  final String id;
  final String statsDate;
  final int tasksPlanned;
  final int tasksCompleted;
  final int plannedMinutes;
  final int completedMinutes;
  final int overloadedMinutes;
  final int tasksRolledOver;
  final String createdAt;
  final String updatedAt;
  const DailyStatsRow({
    required this.id,
    required this.statsDate,
    required this.tasksPlanned,
    required this.tasksCompleted,
    required this.plannedMinutes,
    required this.completedMinutes,
    required this.overloadedMinutes,
    required this.tasksRolledOver,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['stats_date'] = Variable<String>(statsDate);
    map['tasks_planned'] = Variable<int>(tasksPlanned);
    map['tasks_completed'] = Variable<int>(tasksCompleted);
    map['planned_minutes'] = Variable<int>(plannedMinutes);
    map['completed_minutes'] = Variable<int>(completedMinutes);
    map['overloaded_minutes'] = Variable<int>(overloadedMinutes);
    map['tasks_rolled_over'] = Variable<int>(tasksRolledOver);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  DailyStatsTableCompanion toCompanion(bool nullToAbsent) {
    return DailyStatsTableCompanion(
      id: Value(id),
      statsDate: Value(statsDate),
      tasksPlanned: Value(tasksPlanned),
      tasksCompleted: Value(tasksCompleted),
      plannedMinutes: Value(plannedMinutes),
      completedMinutes: Value(completedMinutes),
      overloadedMinutes: Value(overloadedMinutes),
      tasksRolledOver: Value(tasksRolledOver),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyStatsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyStatsRow(
      id: serializer.fromJson<String>(json['id']),
      statsDate: serializer.fromJson<String>(json['statsDate']),
      tasksPlanned: serializer.fromJson<int>(json['tasksPlanned']),
      tasksCompleted: serializer.fromJson<int>(json['tasksCompleted']),
      plannedMinutes: serializer.fromJson<int>(json['plannedMinutes']),
      completedMinutes: serializer.fromJson<int>(json['completedMinutes']),
      overloadedMinutes: serializer.fromJson<int>(json['overloadedMinutes']),
      tasksRolledOver: serializer.fromJson<int>(json['tasksRolledOver']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'statsDate': serializer.toJson<String>(statsDate),
      'tasksPlanned': serializer.toJson<int>(tasksPlanned),
      'tasksCompleted': serializer.toJson<int>(tasksCompleted),
      'plannedMinutes': serializer.toJson<int>(plannedMinutes),
      'completedMinutes': serializer.toJson<int>(completedMinutes),
      'overloadedMinutes': serializer.toJson<int>(overloadedMinutes),
      'tasksRolledOver': serializer.toJson<int>(tasksRolledOver),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  DailyStatsRow copyWith({
    String? id,
    String? statsDate,
    int? tasksPlanned,
    int? tasksCompleted,
    int? plannedMinutes,
    int? completedMinutes,
    int? overloadedMinutes,
    int? tasksRolledOver,
    String? createdAt,
    String? updatedAt,
  }) => DailyStatsRow(
    id: id ?? this.id,
    statsDate: statsDate ?? this.statsDate,
    tasksPlanned: tasksPlanned ?? this.tasksPlanned,
    tasksCompleted: tasksCompleted ?? this.tasksCompleted,
    plannedMinutes: plannedMinutes ?? this.plannedMinutes,
    completedMinutes: completedMinutes ?? this.completedMinutes,
    overloadedMinutes: overloadedMinutes ?? this.overloadedMinutes,
    tasksRolledOver: tasksRolledOver ?? this.tasksRolledOver,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyStatsRow copyWithCompanion(DailyStatsTableCompanion data) {
    return DailyStatsRow(
      id: data.id.present ? data.id.value : this.id,
      statsDate: data.statsDate.present ? data.statsDate.value : this.statsDate,
      tasksPlanned: data.tasksPlanned.present
          ? data.tasksPlanned.value
          : this.tasksPlanned,
      tasksCompleted: data.tasksCompleted.present
          ? data.tasksCompleted.value
          : this.tasksCompleted,
      plannedMinutes: data.plannedMinutes.present
          ? data.plannedMinutes.value
          : this.plannedMinutes,
      completedMinutes: data.completedMinutes.present
          ? data.completedMinutes.value
          : this.completedMinutes,
      overloadedMinutes: data.overloadedMinutes.present
          ? data.overloadedMinutes.value
          : this.overloadedMinutes,
      tasksRolledOver: data.tasksRolledOver.present
          ? data.tasksRolledOver.value
          : this.tasksRolledOver,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyStatsRow(')
          ..write('id: $id, ')
          ..write('statsDate: $statsDate, ')
          ..write('tasksPlanned: $tasksPlanned, ')
          ..write('tasksCompleted: $tasksCompleted, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('completedMinutes: $completedMinutes, ')
          ..write('overloadedMinutes: $overloadedMinutes, ')
          ..write('tasksRolledOver: $tasksRolledOver, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    statsDate,
    tasksPlanned,
    tasksCompleted,
    plannedMinutes,
    completedMinutes,
    overloadedMinutes,
    tasksRolledOver,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyStatsRow &&
          other.id == this.id &&
          other.statsDate == this.statsDate &&
          other.tasksPlanned == this.tasksPlanned &&
          other.tasksCompleted == this.tasksCompleted &&
          other.plannedMinutes == this.plannedMinutes &&
          other.completedMinutes == this.completedMinutes &&
          other.overloadedMinutes == this.overloadedMinutes &&
          other.tasksRolledOver == this.tasksRolledOver &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyStatsTableCompanion extends UpdateCompanion<DailyStatsRow> {
  final Value<String> id;
  final Value<String> statsDate;
  final Value<int> tasksPlanned;
  final Value<int> tasksCompleted;
  final Value<int> plannedMinutes;
  final Value<int> completedMinutes;
  final Value<int> overloadedMinutes;
  final Value<int> tasksRolledOver;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const DailyStatsTableCompanion({
    this.id = const Value.absent(),
    this.statsDate = const Value.absent(),
    this.tasksPlanned = const Value.absent(),
    this.tasksCompleted = const Value.absent(),
    this.plannedMinutes = const Value.absent(),
    this.completedMinutes = const Value.absent(),
    this.overloadedMinutes = const Value.absent(),
    this.tasksRolledOver = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyStatsTableCompanion.insert({
    required String id,
    required String statsDate,
    this.tasksPlanned = const Value.absent(),
    this.tasksCompleted = const Value.absent(),
    this.plannedMinutes = const Value.absent(),
    this.completedMinutes = const Value.absent(),
    this.overloadedMinutes = const Value.absent(),
    this.tasksRolledOver = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       statsDate = Value(statsDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DailyStatsRow> custom({
    Expression<String>? id,
    Expression<String>? statsDate,
    Expression<int>? tasksPlanned,
    Expression<int>? tasksCompleted,
    Expression<int>? plannedMinutes,
    Expression<int>? completedMinutes,
    Expression<int>? overloadedMinutes,
    Expression<int>? tasksRolledOver,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (statsDate != null) 'stats_date': statsDate,
      if (tasksPlanned != null) 'tasks_planned': tasksPlanned,
      if (tasksCompleted != null) 'tasks_completed': tasksCompleted,
      if (plannedMinutes != null) 'planned_minutes': plannedMinutes,
      if (completedMinutes != null) 'completed_minutes': completedMinutes,
      if (overloadedMinutes != null) 'overloaded_minutes': overloadedMinutes,
      if (tasksRolledOver != null) 'tasks_rolled_over': tasksRolledOver,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyStatsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? statsDate,
    Value<int>? tasksPlanned,
    Value<int>? tasksCompleted,
    Value<int>? plannedMinutes,
    Value<int>? completedMinutes,
    Value<int>? overloadedMinutes,
    Value<int>? tasksRolledOver,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return DailyStatsTableCompanion(
      id: id ?? this.id,
      statsDate: statsDate ?? this.statsDate,
      tasksPlanned: tasksPlanned ?? this.tasksPlanned,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      plannedMinutes: plannedMinutes ?? this.plannedMinutes,
      completedMinutes: completedMinutes ?? this.completedMinutes,
      overloadedMinutes: overloadedMinutes ?? this.overloadedMinutes,
      tasksRolledOver: tasksRolledOver ?? this.tasksRolledOver,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (statsDate.present) {
      map['stats_date'] = Variable<String>(statsDate.value);
    }
    if (tasksPlanned.present) {
      map['tasks_planned'] = Variable<int>(tasksPlanned.value);
    }
    if (tasksCompleted.present) {
      map['tasks_completed'] = Variable<int>(tasksCompleted.value);
    }
    if (plannedMinutes.present) {
      map['planned_minutes'] = Variable<int>(plannedMinutes.value);
    }
    if (completedMinutes.present) {
      map['completed_minutes'] = Variable<int>(completedMinutes.value);
    }
    if (overloadedMinutes.present) {
      map['overloaded_minutes'] = Variable<int>(overloadedMinutes.value);
    }
    if (tasksRolledOver.present) {
      map['tasks_rolled_over'] = Variable<int>(tasksRolledOver.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyStatsTableCompanion(')
          ..write('id: $id, ')
          ..write('statsDate: $statsDate, ')
          ..write('tasksPlanned: $tasksPlanned, ')
          ..write('tasksCompleted: $tasksCompleted, ')
          ..write('plannedMinutes: $plannedMinutes, ')
          ..write('completedMinutes: $completedMinutes, ')
          ..write('overloadedMinutes: $overloadedMinutes, ')
          ..write('tasksRolledOver: $tasksRolledOver, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FocusSessionsTableTable extends FocusSessionsTable
    with TableInfo<$FocusSessionsTableTable, FocusSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FocusSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tasks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<String> startedAt = GeneratedColumn<String>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pausedAtMeta = const VerificationMeta(
    'pausedAt',
  );
  @override
  late final GeneratedColumn<String> pausedAt = GeneratedColumn<String>(
    'paused_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<String> endedAt = GeneratedColumn<String>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeDurationSecondsMeta =
      const VerificationMeta('activeDurationSeconds');
  @override
  late final GeneratedColumn<int> activeDurationSeconds = GeneratedColumn<int>(
    'active_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskId,
    state,
    startedAt,
    pausedAt,
    endedAt,
    activeDurationSeconds,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'focus_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FocusSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('paused_at')) {
      context.handle(
        _pausedAtMeta,
        pausedAt.isAcceptableOrUnknown(data['paused_at']!, _pausedAtMeta),
      );
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('active_duration_seconds')) {
      context.handle(
        _activeDurationSecondsMeta,
        activeDurationSeconds.isAcceptableOrUnknown(
          data['active_duration_seconds']!,
          _activeDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FocusSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FocusSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}started_at'],
      )!,
      pausedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paused_at'],
      ),
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ended_at'],
      ),
      activeDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}active_duration_seconds'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FocusSessionsTableTable createAlias(String alias) {
    return $FocusSessionsTableTable(attachedDatabase, alias);
  }
}

class FocusSessionRow extends DataClass implements Insertable<FocusSessionRow> {
  final String id;
  final String taskId;
  final String state;
  final String startedAt;
  final String? pausedAt;
  final String? endedAt;
  final int activeDurationSeconds;
  final String createdAt;
  final String updatedAt;
  const FocusSessionRow({
    required this.id,
    required this.taskId,
    required this.state,
    required this.startedAt,
    this.pausedAt,
    this.endedAt,
    required this.activeDurationSeconds,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['state'] = Variable<String>(state);
    map['started_at'] = Variable<String>(startedAt);
    if (!nullToAbsent || pausedAt != null) {
      map['paused_at'] = Variable<String>(pausedAt);
    }
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<String>(endedAt);
    }
    map['active_duration_seconds'] = Variable<int>(activeDurationSeconds);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  FocusSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return FocusSessionsTableCompanion(
      id: Value(id),
      taskId: Value(taskId),
      state: Value(state),
      startedAt: Value(startedAt),
      pausedAt: pausedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(pausedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      activeDurationSeconds: Value(activeDurationSeconds),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FocusSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusSessionRow(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      state: serializer.fromJson<String>(json['state']),
      startedAt: serializer.fromJson<String>(json['startedAt']),
      pausedAt: serializer.fromJson<String?>(json['pausedAt']),
      endedAt: serializer.fromJson<String?>(json['endedAt']),
      activeDurationSeconds: serializer.fromJson<int>(
        json['activeDurationSeconds'],
      ),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'state': serializer.toJson<String>(state),
      'startedAt': serializer.toJson<String>(startedAt),
      'pausedAt': serializer.toJson<String?>(pausedAt),
      'endedAt': serializer.toJson<String?>(endedAt),
      'activeDurationSeconds': serializer.toJson<int>(activeDurationSeconds),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  FocusSessionRow copyWith({
    String? id,
    String? taskId,
    String? state,
    String? startedAt,
    Value<String?> pausedAt = const Value.absent(),
    Value<String?> endedAt = const Value.absent(),
    int? activeDurationSeconds,
    String? createdAt,
    String? updatedAt,
  }) => FocusSessionRow(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    state: state ?? this.state,
    startedAt: startedAt ?? this.startedAt,
    pausedAt: pausedAt.present ? pausedAt.value : this.pausedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    activeDurationSeconds: activeDurationSeconds ?? this.activeDurationSeconds,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FocusSessionRow copyWithCompanion(FocusSessionsTableCompanion data) {
    return FocusSessionRow(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      state: data.state.present ? data.state.value : this.state,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      pausedAt: data.pausedAt.present ? data.pausedAt.value : this.pausedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      activeDurationSeconds: data.activeDurationSeconds.present
          ? data.activeDurationSeconds.value
          : this.activeDurationSeconds,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FocusSessionRow(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('state: $state, ')
          ..write('startedAt: $startedAt, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('activeDurationSeconds: $activeDurationSeconds, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    taskId,
    state,
    startedAt,
    pausedAt,
    endedAt,
    activeDurationSeconds,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusSessionRow &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.state == this.state &&
          other.startedAt == this.startedAt &&
          other.pausedAt == this.pausedAt &&
          other.endedAt == this.endedAt &&
          other.activeDurationSeconds == this.activeDurationSeconds &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FocusSessionsTableCompanion extends UpdateCompanion<FocusSessionRow> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> state;
  final Value<String> startedAt;
  final Value<String?> pausedAt;
  final Value<String?> endedAt;
  final Value<int> activeDurationSeconds;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const FocusSessionsTableCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.state = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.pausedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.activeDurationSeconds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FocusSessionsTableCompanion.insert({
    required String id,
    required String taskId,
    required String state,
    required String startedAt,
    this.pausedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.activeDurationSeconds = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       taskId = Value(taskId),
       state = Value(state),
       startedAt = Value(startedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FocusSessionRow> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? state,
    Expression<String>? startedAt,
    Expression<String>? pausedAt,
    Expression<String>? endedAt,
    Expression<int>? activeDurationSeconds,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (state != null) 'state': state,
      if (startedAt != null) 'started_at': startedAt,
      if (pausedAt != null) 'paused_at': pausedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (activeDurationSeconds != null)
        'active_duration_seconds': activeDurationSeconds,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FocusSessionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? taskId,
    Value<String>? state,
    Value<String>? startedAt,
    Value<String?>? pausedAt,
    Value<String?>? endedAt,
    Value<int>? activeDurationSeconds,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return FocusSessionsTableCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      state: state ?? this.state,
      startedAt: startedAt ?? this.startedAt,
      pausedAt: pausedAt ?? this.pausedAt,
      endedAt: endedAt ?? this.endedAt,
      activeDurationSeconds:
          activeDurationSeconds ?? this.activeDurationSeconds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<String>(startedAt.value);
    }
    if (pausedAt.present) {
      map['paused_at'] = Variable<String>(pausedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<String>(endedAt.value);
    }
    if (activeDurationSeconds.present) {
      map['active_duration_seconds'] = Variable<int>(
        activeDurationSeconds.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('state: $state, ')
          ..write('startedAt: $startedAt, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('activeDurationSeconds: $activeDurationSeconds, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTableTable categoriesTable = $CategoriesTableTable(
    this,
  );
  late final $RecurrenceTemplatesTableTable recurrenceTemplatesTable =
      $RecurrenceTemplatesTableTable(this);
  late final $TasksTableTable tasksTable = $TasksTableTable(this);
  late final $DailyPlansTableTable dailyPlansTable = $DailyPlansTableTable(
    this,
  );
  late final $ScheduleBlocksTableTable scheduleBlocksTable =
      $ScheduleBlocksTableTable(this);
  late final $DailyStatsTableTable dailyStatsTable = $DailyStatsTableTable(
    this,
  );
  late final $FocusSessionsTableTable focusSessionsTable =
      $FocusSessionsTableTable(this);
  late final Index idxTasksStatus = Index(
    'idx_tasks_status',
    'CREATE INDEX idx_tasks_status ON tasks (status)',
  );
  late final Index idxTasksDueDate = Index(
    'idx_tasks_due_date',
    'CREATE INDEX idx_tasks_due_date ON tasks (due_date)',
  );
  late final Index idxTasksCategoryId = Index(
    'idx_tasks_category_id',
    'CREATE INDEX idx_tasks_category_id ON tasks (category_id)',
  );
  late final Index idxScheduleBlocksPlanDateStart = Index(
    'idx_schedule_blocks_plan_date_start',
    'CREATE INDEX idx_schedule_blocks_plan_date_start ON schedule_blocks (plan_date, start_minute)',
  );
  late final Index idxScheduleBlocksTaskPlanDate = Index(
    'idx_schedule_blocks_task_plan_date',
    'CREATE INDEX idx_schedule_blocks_task_plan_date ON schedule_blocks (task_id, plan_date)',
  );
  late final Index idxFocusSessionsTaskId = Index(
    'idx_focus_sessions_task_id',
    'CREATE INDEX idx_focus_sessions_task_id ON focus_sessions (task_id)',
  );
  late final Index idxFocusSessionsState = Index(
    'idx_focus_sessions_state',
    'CREATE INDEX idx_focus_sessions_state ON focus_sessions (state)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categoriesTable,
    recurrenceTemplatesTable,
    tasksTable,
    dailyPlansTable,
    scheduleBlocksTable,
    dailyStatsTable,
    focusSessionsTable,
    idxTasksStatus,
    idxTasksDueDate,
    idxTasksCategoryId,
    idxScheduleBlocksPlanDateStart,
    idxScheduleBlocksTaskPlanDate,
    idxFocusSessionsTaskId,
    idxFocusSessionsState,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recurrence_templates', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recurrence_templates',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tasks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('schedule_blocks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tasks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('focus_sessions', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CategoriesTableTableCreateCompanionBuilder =
    CategoriesTableCompanion Function({
      required String id,
      required String name,
      required String icon,
      Value<int> rowid,
    });
typedef $$CategoriesTableTableUpdateCompanionBuilder =
    CategoriesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> icon,
      Value<int> rowid,
    });

final class $$CategoriesTableTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTableTable, CategoryRow> {
  $$CategoriesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $RecurrenceTemplatesTableTable,
    List<RecurrenceTemplateRow>
  >
  _recurrenceTemplatesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recurrenceTemplatesTable,
        aliasName: $_aliasNameGenerator(
          db.categoriesTable.id,
          db.recurrenceTemplatesTable.categoryId,
        ),
      );

  $$RecurrenceTemplatesTableTableProcessedTableManager
  get recurrenceTemplatesTableRefs {
    final manager = $$RecurrenceTemplatesTableTableTableManager(
      $_db,
      $_db.recurrenceTemplatesTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recurrenceTemplatesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TasksTableTable, List<TaskRow>>
  _tasksTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tasksTable,
    aliasName: $_aliasNameGenerator(
      db.categoriesTable.id,
      db.tasksTable.categoryId,
    ),
  );

  $$TasksTableTableProcessedTableManager get tasksTableRefs {
    final manager = $$TasksTableTableTableManager(
      $_db,
      $_db.tasksTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recurrenceTemplatesTableRefs(
    Expression<bool> Function($$RecurrenceTemplatesTableTableFilterComposer f)
    f,
  ) {
    final $$RecurrenceTemplatesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurrenceTemplatesTable,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurrenceTemplatesTableTableFilterComposer(
                $db: $db,
                $table: $db.recurrenceTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> tasksTableRefs(
    Expression<bool> Function($$TasksTableTableFilterComposer f) f,
  ) {
    final $$TasksTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasksTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableTableFilterComposer(
            $db: $db,
            $table: $db.tasksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  Expression<T> recurrenceTemplatesTableRefs<T extends Object>(
    Expression<T> Function($$RecurrenceTemplatesTableTableAnnotationComposer a)
    f,
  ) {
    final $$RecurrenceTemplatesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recurrenceTemplatesTable,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurrenceTemplatesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.recurrenceTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> tasksTableRefs<T extends Object>(
    Expression<T> Function($$TasksTableTableAnnotationComposer a) f,
  ) {
    final $$TasksTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasksTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableTableAnnotationComposer(
            $db: $db,
            $table: $db.tasksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTableTable,
          CategoryRow,
          $$CategoriesTableTableFilterComposer,
          $$CategoriesTableTableOrderingComposer,
          $$CategoriesTableTableAnnotationComposer,
          $$CategoriesTableTableCreateCompanionBuilder,
          $$CategoriesTableTableUpdateCompanionBuilder,
          (CategoryRow, $$CategoriesTableTableReferences),
          CategoryRow,
          PrefetchHooks Function({
            bool recurrenceTemplatesTableRefs,
            bool tasksTableRefs,
          })
        > {
  $$CategoriesTableTableTableManager(
    _$AppDatabase db,
    $CategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTableCompanion(
                id: id,
                name: name,
                icon: icon,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String icon,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesTableCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({recurrenceTemplatesTableRefs = false, tasksTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recurrenceTemplatesTableRefs)
                      db.recurrenceTemplatesTable,
                    if (tasksTableRefs) db.tasksTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recurrenceTemplatesTableRefs)
                        await $_getPrefetchedData<
                          CategoryRow,
                          $CategoriesTableTable,
                          RecurrenceTemplateRow
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableTableReferences
                              ._recurrenceTemplatesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).recurrenceTemplatesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tasksTableRefs)
                        await $_getPrefetchedData<
                          CategoryRow,
                          $CategoriesTableTable,
                          TaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableTableReferences
                              ._tasksTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).tasksTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTableTable,
      CategoryRow,
      $$CategoriesTableTableFilterComposer,
      $$CategoriesTableTableOrderingComposer,
      $$CategoriesTableTableAnnotationComposer,
      $$CategoriesTableTableCreateCompanionBuilder,
      $$CategoriesTableTableUpdateCompanionBuilder,
      (CategoryRow, $$CategoriesTableTableReferences),
      CategoryRow,
      PrefetchHooks Function({
        bool recurrenceTemplatesTableRefs,
        bool tasksTableRefs,
      })
    >;
typedef $$RecurrenceTemplatesTableTableCreateCompanionBuilder =
    RecurrenceTemplatesTableCompanion Function({
      required String id,
      required String title,
      Value<String?> description,
      Value<String?> categoryId,
      Value<int> priority,
      required int estimatedDurationMinutes,
      Value<String> preferredTimeWindow,
      Value<String?> energyLevel,
      required String recurrenceType,
      Value<String> recurrenceDays,
      required String startDate,
      Value<String?> endDate,
      required String createdAt,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $$RecurrenceTemplatesTableTableUpdateCompanionBuilder =
    RecurrenceTemplatesTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> description,
      Value<String?> categoryId,
      Value<int> priority,
      Value<int> estimatedDurationMinutes,
      Value<String> preferredTimeWindow,
      Value<String?> energyLevel,
      Value<String> recurrenceType,
      Value<String> recurrenceDays,
      Value<String> startDate,
      Value<String?> endDate,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> rowid,
    });

final class $$RecurrenceTemplatesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecurrenceTemplatesTableTable,
          RecurrenceTemplateRow
        > {
  $$RecurrenceTemplatesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(
          db.recurrenceTemplatesTable.categoryId,
          db.categoriesTable.id,
        ),
      );

  $$CategoriesTableTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TasksTableTable, List<TaskRow>>
  _tasksTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tasksTable,
    aliasName: $_aliasNameGenerator(
      db.recurrenceTemplatesTable.id,
      db.tasksTable.recurrenceTemplateId,
    ),
  );

  $$TasksTableTableProcessedTableManager get tasksTableRefs {
    final manager = $$TasksTableTableTableManager($_db, $_db.tasksTable).filter(
      (f) => f.recurrenceTemplateId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_tasksTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecurrenceTemplatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RecurrenceTemplatesTableTable> {
  $$RecurrenceTemplatesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredTimeWindow => $composableBuilder(
    column: $table.preferredTimeWindow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceDays => $composableBuilder(
    column: $table.recurrenceDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> tasksTableRefs(
    Expression<bool> Function($$TasksTableTableFilterComposer f) f,
  ) {
    final $$TasksTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasksTable,
      getReferencedColumn: (t) => t.recurrenceTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableTableFilterComposer(
            $db: $db,
            $table: $db.tasksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecurrenceTemplatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurrenceTemplatesTableTable> {
  $$RecurrenceTemplatesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredTimeWindow => $composableBuilder(
    column: $table.preferredTimeWindow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceDays => $composableBuilder(
    column: $table.recurrenceDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecurrenceTemplatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurrenceTemplatesTableTable> {
  $$RecurrenceTemplatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferredTimeWindow => $composableBuilder(
    column: $table.preferredTimeWindow,
    builder: (column) => column,
  );

  GeneratedColumn<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurrenceType => $composableBuilder(
    column: $table.recurrenceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurrenceDays => $composableBuilder(
    column: $table.recurrenceDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> tasksTableRefs<T extends Object>(
    Expression<T> Function($$TasksTableTableAnnotationComposer a) f,
  ) {
    final $$TasksTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasksTable,
      getReferencedColumn: (t) => t.recurrenceTemplateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableTableAnnotationComposer(
            $db: $db,
            $table: $db.tasksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecurrenceTemplatesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurrenceTemplatesTableTable,
          RecurrenceTemplateRow,
          $$RecurrenceTemplatesTableTableFilterComposer,
          $$RecurrenceTemplatesTableTableOrderingComposer,
          $$RecurrenceTemplatesTableTableAnnotationComposer,
          $$RecurrenceTemplatesTableTableCreateCompanionBuilder,
          $$RecurrenceTemplatesTableTableUpdateCompanionBuilder,
          (RecurrenceTemplateRow, $$RecurrenceTemplatesTableTableReferences),
          RecurrenceTemplateRow,
          PrefetchHooks Function({bool categoryId, bool tasksTableRefs})
        > {
  $$RecurrenceTemplatesTableTableTableManager(
    _$AppDatabase db,
    $RecurrenceTemplatesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurrenceTemplatesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$RecurrenceTemplatesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecurrenceTemplatesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> estimatedDurationMinutes = const Value.absent(),
                Value<String> preferredTimeWindow = const Value.absent(),
                Value<String?> energyLevel = const Value.absent(),
                Value<String> recurrenceType = const Value.absent(),
                Value<String> recurrenceDays = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<String?> endDate = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurrenceTemplatesTableCompanion(
                id: id,
                title: title,
                description: description,
                categoryId: categoryId,
                priority: priority,
                estimatedDurationMinutes: estimatedDurationMinutes,
                preferredTimeWindow: preferredTimeWindow,
                energyLevel: energyLevel,
                recurrenceType: recurrenceType,
                recurrenceDays: recurrenceDays,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                required int estimatedDurationMinutes,
                Value<String> preferredTimeWindow = const Value.absent(),
                Value<String?> energyLevel = const Value.absent(),
                required String recurrenceType,
                Value<String> recurrenceDays = const Value.absent(),
                required String startDate,
                Value<String?> endDate = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RecurrenceTemplatesTableCompanion.insert(
                id: id,
                title: title,
                description: description,
                categoryId: categoryId,
                priority: priority,
                estimatedDurationMinutes: estimatedDurationMinutes,
                preferredTimeWindow: preferredTimeWindow,
                energyLevel: energyLevel,
                recurrenceType: recurrenceType,
                recurrenceDays: recurrenceDays,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecurrenceTemplatesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false, tasksTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tasksTableRefs) db.tasksTable],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable:
                                    $$RecurrenceTemplatesTableTableReferences
                                        ._categoryIdTable(db),
                                referencedColumn:
                                    $$RecurrenceTemplatesTableTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tasksTableRefs)
                    await $_getPrefetchedData<
                      RecurrenceTemplateRow,
                      $RecurrenceTemplatesTableTable,
                      TaskRow
                    >(
                      currentTable: table,
                      referencedTable: $$RecurrenceTemplatesTableTableReferences
                          ._tasksTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RecurrenceTemplatesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).tasksTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.recurrenceTemplateId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RecurrenceTemplatesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurrenceTemplatesTableTable,
      RecurrenceTemplateRow,
      $$RecurrenceTemplatesTableTableFilterComposer,
      $$RecurrenceTemplatesTableTableOrderingComposer,
      $$RecurrenceTemplatesTableTableAnnotationComposer,
      $$RecurrenceTemplatesTableTableCreateCompanionBuilder,
      $$RecurrenceTemplatesTableTableUpdateCompanionBuilder,
      (RecurrenceTemplateRow, $$RecurrenceTemplatesTableTableReferences),
      RecurrenceTemplateRow,
      PrefetchHooks Function({bool categoryId, bool tasksTableRefs})
    >;
typedef $$TasksTableTableCreateCompanionBuilder =
    TasksTableCompanion Function({
      required String id,
      required String title,
      Value<String?> description,
      Value<String?> categoryId,
      Value<int> priority,
      required int estimatedDurationMinutes,
      Value<int> actualDurationSeconds,
      Value<String> status,
      Value<String?> dueDate,
      Value<String> preferredTimeWindow,
      Value<String?> energyLevel,
      Value<String?> recurrenceTemplateId,
      required String createdAt,
      required String updatedAt,
      Value<String?> completedAt,
      Value<int> rowid,
    });
typedef $$TasksTableTableUpdateCompanionBuilder =
    TasksTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> description,
      Value<String?> categoryId,
      Value<int> priority,
      Value<int> estimatedDurationMinutes,
      Value<int> actualDurationSeconds,
      Value<String> status,
      Value<String?> dueDate,
      Value<String> preferredTimeWindow,
      Value<String?> energyLevel,
      Value<String?> recurrenceTemplateId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> completedAt,
      Value<int> rowid,
    });

final class $$TasksTableTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTableTable, TaskRow> {
  $$TasksTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
        $_aliasNameGenerator(db.tasksTable.categoryId, db.categoriesTable.id),
      );

  $$CategoriesTableTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableTableManager(
      $_db,
      $_db.categoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecurrenceTemplatesTableTable _recurrenceTemplateIdTable(
    _$AppDatabase db,
  ) => db.recurrenceTemplatesTable.createAlias(
    $_aliasNameGenerator(
      db.tasksTable.recurrenceTemplateId,
      db.recurrenceTemplatesTable.id,
    ),
  );

  $$RecurrenceTemplatesTableTableProcessedTableManager?
  get recurrenceTemplateId {
    final $_column = $_itemColumn<String>('recurrence_template_id');
    if ($_column == null) return null;
    final manager = $$RecurrenceTemplatesTableTableTableManager(
      $_db,
      $_db.recurrenceTemplatesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _recurrenceTemplateIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ScheduleBlocksTableTable, List<ScheduleBlockRow>>
  _scheduleBlocksTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.scheduleBlocksTable,
        aliasName: $_aliasNameGenerator(
          db.tasksTable.id,
          db.scheduleBlocksTable.taskId,
        ),
      );

  $$ScheduleBlocksTableTableProcessedTableManager get scheduleBlocksTableRefs {
    final manager = $$ScheduleBlocksTableTableTableManager(
      $_db,
      $_db.scheduleBlocksTable,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scheduleBlocksTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FocusSessionsTableTable, List<FocusSessionRow>>
  _focusSessionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.focusSessionsTable,
        aliasName: $_aliasNameGenerator(
          db.tasksTable.id,
          db.focusSessionsTable.taskId,
        ),
      );

  $$FocusSessionsTableTableProcessedTableManager get focusSessionsTableRefs {
    final manager = $$FocusSessionsTableTableTableManager(
      $_db,
      $_db.focusSessionsTable,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _focusSessionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TasksTableTableFilterComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualDurationSeconds => $composableBuilder(
    column: $table.actualDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredTimeWindow => $composableBuilder(
    column: $table.preferredTimeWindow,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableFilterComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecurrenceTemplatesTableTableFilterComposer get recurrenceTemplateId {
    final $$RecurrenceTemplatesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recurrenceTemplateId,
          referencedTable: $db.recurrenceTemplatesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurrenceTemplatesTableTableFilterComposer(
                $db: $db,
                $table: $db.recurrenceTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<bool> scheduleBlocksTableRefs(
    Expression<bool> Function($$ScheduleBlocksTableTableFilterComposer f) f,
  ) {
    final $$ScheduleBlocksTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scheduleBlocksTable,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScheduleBlocksTableTableFilterComposer(
            $db: $db,
            $table: $db.scheduleBlocksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> focusSessionsTableRefs(
    Expression<bool> Function($$FocusSessionsTableTableFilterComposer f) f,
  ) {
    final $$FocusSessionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.focusSessionsTable,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FocusSessionsTableTableFilterComposer(
            $db: $db,
            $table: $db.focusSessionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TasksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualDurationSeconds => $composableBuilder(
    column: $table.actualDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredTimeWindow => $composableBuilder(
    column: $table.preferredTimeWindow,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecurrenceTemplatesTableTableOrderingComposer get recurrenceTemplateId {
    final $$RecurrenceTemplatesTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recurrenceTemplateId,
          referencedTable: $db.recurrenceTemplatesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurrenceTemplatesTableTableOrderingComposer(
                $db: $db,
                $table: $db.recurrenceTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$TasksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get estimatedDurationMinutes => $composableBuilder(
    column: $table.estimatedDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualDurationSeconds => $composableBuilder(
    column: $table.actualDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get preferredTimeWindow => $composableBuilder(
    column: $table.preferredTimeWindow,
    builder: (column) => column,
  );

  GeneratedColumn<String> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoriesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecurrenceTemplatesTableTableAnnotationComposer get recurrenceTemplateId {
    final $$RecurrenceTemplatesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.recurrenceTemplateId,
          referencedTable: $db.recurrenceTemplatesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecurrenceTemplatesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.recurrenceTemplatesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> scheduleBlocksTableRefs<T extends Object>(
    Expression<T> Function($$ScheduleBlocksTableTableAnnotationComposer a) f,
  ) {
    final $$ScheduleBlocksTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scheduleBlocksTable,
          getReferencedColumn: (t) => t.taskId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ScheduleBlocksTableTableAnnotationComposer(
                $db: $db,
                $table: $db.scheduleBlocksTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> focusSessionsTableRefs<T extends Object>(
    Expression<T> Function($$FocusSessionsTableTableAnnotationComposer a) f,
  ) {
    final $$FocusSessionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.focusSessionsTable,
          getReferencedColumn: (t) => t.taskId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FocusSessionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.focusSessionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TasksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTableTable,
          TaskRow,
          $$TasksTableTableFilterComposer,
          $$TasksTableTableOrderingComposer,
          $$TasksTableTableAnnotationComposer,
          $$TasksTableTableCreateCompanionBuilder,
          $$TasksTableTableUpdateCompanionBuilder,
          (TaskRow, $$TasksTableTableReferences),
          TaskRow,
          PrefetchHooks Function({
            bool categoryId,
            bool recurrenceTemplateId,
            bool scheduleBlocksTableRefs,
            bool focusSessionsTableRefs,
          })
        > {
  $$TasksTableTableTableManager(_$AppDatabase db, $TasksTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<int> estimatedDurationMinutes = const Value.absent(),
                Value<int> actualDurationSeconds = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> dueDate = const Value.absent(),
                Value<String> preferredTimeWindow = const Value.absent(),
                Value<String?> energyLevel = const Value.absent(),
                Value<String?> recurrenceTemplateId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksTableCompanion(
                id: id,
                title: title,
                description: description,
                categoryId: categoryId,
                priority: priority,
                estimatedDurationMinutes: estimatedDurationMinutes,
                actualDurationSeconds: actualDurationSeconds,
                status: status,
                dueDate: dueDate,
                preferredTimeWindow: preferredTimeWindow,
                energyLevel: energyLevel,
                recurrenceTemplateId: recurrenceTemplateId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<int> priority = const Value.absent(),
                required int estimatedDurationMinutes,
                Value<int> actualDurationSeconds = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> dueDate = const Value.absent(),
                Value<String> preferredTimeWindow = const Value.absent(),
                Value<String?> energyLevel = const Value.absent(),
                Value<String?> recurrenceTemplateId = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksTableCompanion.insert(
                id: id,
                title: title,
                description: description,
                categoryId: categoryId,
                priority: priority,
                estimatedDurationMinutes: estimatedDurationMinutes,
                actualDurationSeconds: actualDurationSeconds,
                status: status,
                dueDate: dueDate,
                preferredTimeWindow: preferredTimeWindow,
                energyLevel: energyLevel,
                recurrenceTemplateId: recurrenceTemplateId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TasksTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                recurrenceTemplateId = false,
                scheduleBlocksTableRefs = false,
                focusSessionsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (scheduleBlocksTableRefs) db.scheduleBlocksTable,
                    if (focusSessionsTableRefs) db.focusSessionsTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$TasksTableTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn:
                                        $$TasksTableTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (recurrenceTemplateId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.recurrenceTemplateId,
                                    referencedTable: $$TasksTableTableReferences
                                        ._recurrenceTemplateIdTable(db),
                                    referencedColumn:
                                        $$TasksTableTableReferences
                                            ._recurrenceTemplateIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (scheduleBlocksTableRefs)
                        await $_getPrefetchedData<
                          TaskRow,
                          $TasksTableTable,
                          ScheduleBlockRow
                        >(
                          currentTable: table,
                          referencedTable: $$TasksTableTableReferences
                              ._scheduleBlocksTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TasksTableTableReferences(
                                db,
                                table,
                                p0,
                              ).scheduleBlocksTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.taskId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (focusSessionsTableRefs)
                        await $_getPrefetchedData<
                          TaskRow,
                          $TasksTableTable,
                          FocusSessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$TasksTableTableReferences
                              ._focusSessionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TasksTableTableReferences(
                                db,
                                table,
                                p0,
                              ).focusSessionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.taskId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TasksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTableTable,
      TaskRow,
      $$TasksTableTableFilterComposer,
      $$TasksTableTableOrderingComposer,
      $$TasksTableTableAnnotationComposer,
      $$TasksTableTableCreateCompanionBuilder,
      $$TasksTableTableUpdateCompanionBuilder,
      (TaskRow, $$TasksTableTableReferences),
      TaskRow,
      PrefetchHooks Function({
        bool categoryId,
        bool recurrenceTemplateId,
        bool scheduleBlocksTableRefs,
        bool focusSessionsTableRefs,
      })
    >;
typedef $$DailyPlansTableTableCreateCompanionBuilder =
    DailyPlansTableCompanion Function({
      required String id,
      required String planDate,
      required int availableStartMinute,
      required int availableEndMinute,
      Value<int> plannedMinutes,
      Value<int> completedMinutes,
      Value<int> rowid,
    });
typedef $$DailyPlansTableTableUpdateCompanionBuilder =
    DailyPlansTableCompanion Function({
      Value<String> id,
      Value<String> planDate,
      Value<int> availableStartMinute,
      Value<int> availableEndMinute,
      Value<int> plannedMinutes,
      Value<int> completedMinutes,
      Value<int> rowid,
    });

class $$DailyPlansTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyPlansTableTable> {
  $$DailyPlansTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planDate => $composableBuilder(
    column: $table.planDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get availableStartMinute => $composableBuilder(
    column: $table.availableStartMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get availableEndMinute => $composableBuilder(
    column: $table.availableEndMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyPlansTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyPlansTableTable> {
  $$DailyPlansTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planDate => $composableBuilder(
    column: $table.planDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get availableStartMinute => $composableBuilder(
    column: $table.availableStartMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get availableEndMinute => $composableBuilder(
    column: $table.availableEndMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyPlansTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyPlansTableTable> {
  $$DailyPlansTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planDate =>
      $composableBuilder(column: $table.planDate, builder: (column) => column);

  GeneratedColumn<int> get availableStartMinute => $composableBuilder(
    column: $table.availableStartMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get availableEndMinute => $composableBuilder(
    column: $table.availableEndMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => column,
  );
}

class $$DailyPlansTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyPlansTableTable,
          DailyPlanRow,
          $$DailyPlansTableTableFilterComposer,
          $$DailyPlansTableTableOrderingComposer,
          $$DailyPlansTableTableAnnotationComposer,
          $$DailyPlansTableTableCreateCompanionBuilder,
          $$DailyPlansTableTableUpdateCompanionBuilder,
          (
            DailyPlanRow,
            BaseReferences<_$AppDatabase, $DailyPlansTableTable, DailyPlanRow>,
          ),
          DailyPlanRow,
          PrefetchHooks Function()
        > {
  $$DailyPlansTableTableTableManager(
    _$AppDatabase db,
    $DailyPlansTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyPlansTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyPlansTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyPlansTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> planDate = const Value.absent(),
                Value<int> availableStartMinute = const Value.absent(),
                Value<int> availableEndMinute = const Value.absent(),
                Value<int> plannedMinutes = const Value.absent(),
                Value<int> completedMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyPlansTableCompanion(
                id: id,
                planDate: planDate,
                availableStartMinute: availableStartMinute,
                availableEndMinute: availableEndMinute,
                plannedMinutes: plannedMinutes,
                completedMinutes: completedMinutes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String planDate,
                required int availableStartMinute,
                required int availableEndMinute,
                Value<int> plannedMinutes = const Value.absent(),
                Value<int> completedMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyPlansTableCompanion.insert(
                id: id,
                planDate: planDate,
                availableStartMinute: availableStartMinute,
                availableEndMinute: availableEndMinute,
                plannedMinutes: plannedMinutes,
                completedMinutes: completedMinutes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyPlansTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyPlansTableTable,
      DailyPlanRow,
      $$DailyPlansTableTableFilterComposer,
      $$DailyPlansTableTableOrderingComposer,
      $$DailyPlansTableTableAnnotationComposer,
      $$DailyPlansTableTableCreateCompanionBuilder,
      $$DailyPlansTableTableUpdateCompanionBuilder,
      (
        DailyPlanRow,
        BaseReferences<_$AppDatabase, $DailyPlansTableTable, DailyPlanRow>,
      ),
      DailyPlanRow,
      PrefetchHooks Function()
    >;
typedef $$ScheduleBlocksTableTableCreateCompanionBuilder =
    ScheduleBlocksTableCompanion Function({
      required String id,
      required String planDate,
      required int startMinute,
      required int endMinute,
      required String blockType,
      required String source,
      Value<String?> taskId,
      required String createdAt,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $$ScheduleBlocksTableTableUpdateCompanionBuilder =
    ScheduleBlocksTableCompanion Function({
      Value<String> id,
      Value<String> planDate,
      Value<int> startMinute,
      Value<int> endMinute,
      Value<String> blockType,
      Value<String> source,
      Value<String?> taskId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> rowid,
    });

final class $$ScheduleBlocksTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ScheduleBlocksTableTable,
          ScheduleBlockRow
        > {
  $$ScheduleBlocksTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TasksTableTable _taskIdTable(_$AppDatabase db) =>
      db.tasksTable.createAlias(
        $_aliasNameGenerator(db.scheduleBlocksTable.taskId, db.tasksTable.id),
      );

  $$TasksTableTableProcessedTableManager? get taskId {
    final $_column = $_itemColumn<String>('task_id');
    if ($_column == null) return null;
    final manager = $$TasksTableTableTableManager(
      $_db,
      $_db.tasksTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScheduleBlocksTableTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleBlocksTableTable> {
  $$ScheduleBlocksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planDate => $composableBuilder(
    column: $table.planDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blockType => $composableBuilder(
    column: $table.blockType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TasksTableTableFilterComposer get taskId {
    final $$TasksTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableTableFilterComposer(
            $db: $db,
            $table: $db.tasksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleBlocksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleBlocksTableTable> {
  $$ScheduleBlocksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planDate => $composableBuilder(
    column: $table.planDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockType => $composableBuilder(
    column: $table.blockType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TasksTableTableOrderingComposer get taskId {
    final $$TasksTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableTableOrderingComposer(
            $db: $db,
            $table: $db.tasksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleBlocksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleBlocksTableTable> {
  $$ScheduleBlocksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planDate =>
      $composableBuilder(column: $table.planDate, builder: (column) => column);

  GeneratedColumn<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinute =>
      $composableBuilder(column: $table.endMinute, builder: (column) => column);

  GeneratedColumn<String> get blockType =>
      $composableBuilder(column: $table.blockType, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TasksTableTableAnnotationComposer get taskId {
    final $$TasksTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableTableAnnotationComposer(
            $db: $db,
            $table: $db.tasksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScheduleBlocksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduleBlocksTableTable,
          ScheduleBlockRow,
          $$ScheduleBlocksTableTableFilterComposer,
          $$ScheduleBlocksTableTableOrderingComposer,
          $$ScheduleBlocksTableTableAnnotationComposer,
          $$ScheduleBlocksTableTableCreateCompanionBuilder,
          $$ScheduleBlocksTableTableUpdateCompanionBuilder,
          (ScheduleBlockRow, $$ScheduleBlocksTableTableReferences),
          ScheduleBlockRow,
          PrefetchHooks Function({bool taskId})
        > {
  $$ScheduleBlocksTableTableTableManager(
    _$AppDatabase db,
    $ScheduleBlocksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleBlocksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleBlocksTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ScheduleBlocksTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> planDate = const Value.absent(),
                Value<int> startMinute = const Value.absent(),
                Value<int> endMinute = const Value.absent(),
                Value<String> blockType = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> taskId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleBlocksTableCompanion(
                id: id,
                planDate: planDate,
                startMinute: startMinute,
                endMinute: endMinute,
                blockType: blockType,
                source: source,
                taskId: taskId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String planDate,
                required int startMinute,
                required int endMinute,
                required String blockType,
                required String source,
                Value<String?> taskId = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ScheduleBlocksTableCompanion.insert(
                id: id,
                planDate: planDate,
                startMinute: startMinute,
                endMinute: endMinute,
                blockType: blockType,
                source: source,
                taskId: taskId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScheduleBlocksTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.taskId,
                                referencedTable:
                                    $$ScheduleBlocksTableTableReferences
                                        ._taskIdTable(db),
                                referencedColumn:
                                    $$ScheduleBlocksTableTableReferences
                                        ._taskIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScheduleBlocksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduleBlocksTableTable,
      ScheduleBlockRow,
      $$ScheduleBlocksTableTableFilterComposer,
      $$ScheduleBlocksTableTableOrderingComposer,
      $$ScheduleBlocksTableTableAnnotationComposer,
      $$ScheduleBlocksTableTableCreateCompanionBuilder,
      $$ScheduleBlocksTableTableUpdateCompanionBuilder,
      (ScheduleBlockRow, $$ScheduleBlocksTableTableReferences),
      ScheduleBlockRow,
      PrefetchHooks Function({bool taskId})
    >;
typedef $$DailyStatsTableTableCreateCompanionBuilder =
    DailyStatsTableCompanion Function({
      required String id,
      required String statsDate,
      Value<int> tasksPlanned,
      Value<int> tasksCompleted,
      Value<int> plannedMinutes,
      Value<int> completedMinutes,
      Value<int> overloadedMinutes,
      Value<int> tasksRolledOver,
      required String createdAt,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $$DailyStatsTableTableUpdateCompanionBuilder =
    DailyStatsTableCompanion Function({
      Value<String> id,
      Value<String> statsDate,
      Value<int> tasksPlanned,
      Value<int> tasksCompleted,
      Value<int> plannedMinutes,
      Value<int> completedMinutes,
      Value<int> overloadedMinutes,
      Value<int> tasksRolledOver,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> rowid,
    });

class $$DailyStatsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyStatsTableTable> {
  $$DailyStatsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statsDate => $composableBuilder(
    column: $table.statsDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tasksPlanned => $composableBuilder(
    column: $table.tasksPlanned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tasksCompleted => $composableBuilder(
    column: $table.tasksCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get overloadedMinutes => $composableBuilder(
    column: $table.overloadedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tasksRolledOver => $composableBuilder(
    column: $table.tasksRolledOver,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyStatsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyStatsTableTable> {
  $$DailyStatsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statsDate => $composableBuilder(
    column: $table.statsDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tasksPlanned => $composableBuilder(
    column: $table.tasksPlanned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tasksCompleted => $composableBuilder(
    column: $table.tasksCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get overloadedMinutes => $composableBuilder(
    column: $table.overloadedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tasksRolledOver => $composableBuilder(
    column: $table.tasksRolledOver,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyStatsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyStatsTableTable> {
  $$DailyStatsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get statsDate =>
      $composableBuilder(column: $table.statsDate, builder: (column) => column);

  GeneratedColumn<int> get tasksPlanned => $composableBuilder(
    column: $table.tasksPlanned,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tasksCompleted => $composableBuilder(
    column: $table.tasksCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plannedMinutes => $composableBuilder(
    column: $table.plannedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get overloadedMinutes => $composableBuilder(
    column: $table.overloadedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tasksRolledOver => $composableBuilder(
    column: $table.tasksRolledOver,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyStatsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyStatsTableTable,
          DailyStatsRow,
          $$DailyStatsTableTableFilterComposer,
          $$DailyStatsTableTableOrderingComposer,
          $$DailyStatsTableTableAnnotationComposer,
          $$DailyStatsTableTableCreateCompanionBuilder,
          $$DailyStatsTableTableUpdateCompanionBuilder,
          (
            DailyStatsRow,
            BaseReferences<_$AppDatabase, $DailyStatsTableTable, DailyStatsRow>,
          ),
          DailyStatsRow,
          PrefetchHooks Function()
        > {
  $$DailyStatsTableTableTableManager(
    _$AppDatabase db,
    $DailyStatsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyStatsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyStatsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyStatsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> statsDate = const Value.absent(),
                Value<int> tasksPlanned = const Value.absent(),
                Value<int> tasksCompleted = const Value.absent(),
                Value<int> plannedMinutes = const Value.absent(),
                Value<int> completedMinutes = const Value.absent(),
                Value<int> overloadedMinutes = const Value.absent(),
                Value<int> tasksRolledOver = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyStatsTableCompanion(
                id: id,
                statsDate: statsDate,
                tasksPlanned: tasksPlanned,
                tasksCompleted: tasksCompleted,
                plannedMinutes: plannedMinutes,
                completedMinutes: completedMinutes,
                overloadedMinutes: overloadedMinutes,
                tasksRolledOver: tasksRolledOver,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String statsDate,
                Value<int> tasksPlanned = const Value.absent(),
                Value<int> tasksCompleted = const Value.absent(),
                Value<int> plannedMinutes = const Value.absent(),
                Value<int> completedMinutes = const Value.absent(),
                Value<int> overloadedMinutes = const Value.absent(),
                Value<int> tasksRolledOver = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyStatsTableCompanion.insert(
                id: id,
                statsDate: statsDate,
                tasksPlanned: tasksPlanned,
                tasksCompleted: tasksCompleted,
                plannedMinutes: plannedMinutes,
                completedMinutes: completedMinutes,
                overloadedMinutes: overloadedMinutes,
                tasksRolledOver: tasksRolledOver,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyStatsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyStatsTableTable,
      DailyStatsRow,
      $$DailyStatsTableTableFilterComposer,
      $$DailyStatsTableTableOrderingComposer,
      $$DailyStatsTableTableAnnotationComposer,
      $$DailyStatsTableTableCreateCompanionBuilder,
      $$DailyStatsTableTableUpdateCompanionBuilder,
      (
        DailyStatsRow,
        BaseReferences<_$AppDatabase, $DailyStatsTableTable, DailyStatsRow>,
      ),
      DailyStatsRow,
      PrefetchHooks Function()
    >;
typedef $$FocusSessionsTableTableCreateCompanionBuilder =
    FocusSessionsTableCompanion Function({
      required String id,
      required String taskId,
      required String state,
      required String startedAt,
      Value<String?> pausedAt,
      Value<String?> endedAt,
      Value<int> activeDurationSeconds,
      required String createdAt,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $$FocusSessionsTableTableUpdateCompanionBuilder =
    FocusSessionsTableCompanion Function({
      Value<String> id,
      Value<String> taskId,
      Value<String> state,
      Value<String> startedAt,
      Value<String?> pausedAt,
      Value<String?> endedAt,
      Value<int> activeDurationSeconds,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> rowid,
    });

final class $$FocusSessionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FocusSessionsTableTable,
          FocusSessionRow
        > {
  $$FocusSessionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TasksTableTable _taskIdTable(_$AppDatabase db) =>
      db.tasksTable.createAlias(
        $_aliasNameGenerator(db.focusSessionsTable.taskId, db.tasksTable.id),
      );

  $$TasksTableTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<String>('task_id')!;

    final manager = $$TasksTableTableTableManager(
      $_db,
      $_db.tasksTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FocusSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FocusSessionsTableTable> {
  $$FocusSessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pausedAt => $composableBuilder(
    column: $table.pausedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activeDurationSeconds => $composableBuilder(
    column: $table.activeDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TasksTableTableFilterComposer get taskId {
    final $$TasksTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableTableFilterComposer(
            $db: $db,
            $table: $db.tasksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FocusSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FocusSessionsTableTable> {
  $$FocusSessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pausedAt => $composableBuilder(
    column: $table.pausedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activeDurationSeconds => $composableBuilder(
    column: $table.activeDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TasksTableTableOrderingComposer get taskId {
    final $$TasksTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableTableOrderingComposer(
            $db: $db,
            $table: $db.tasksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FocusSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FocusSessionsTableTable> {
  $$FocusSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<String> get pausedAt =>
      $composableBuilder(column: $table.pausedAt, builder: (column) => column);

  GeneratedColumn<String> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get activeDurationSeconds => $composableBuilder(
    column: $table.activeDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TasksTableTableAnnotationComposer get taskId {
    final $$TasksTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasksTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableTableAnnotationComposer(
            $db: $db,
            $table: $db.tasksTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FocusSessionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FocusSessionsTableTable,
          FocusSessionRow,
          $$FocusSessionsTableTableFilterComposer,
          $$FocusSessionsTableTableOrderingComposer,
          $$FocusSessionsTableTableAnnotationComposer,
          $$FocusSessionsTableTableCreateCompanionBuilder,
          $$FocusSessionsTableTableUpdateCompanionBuilder,
          (FocusSessionRow, $$FocusSessionsTableTableReferences),
          FocusSessionRow,
          PrefetchHooks Function({bool taskId})
        > {
  $$FocusSessionsTableTableTableManager(
    _$AppDatabase db,
    $FocusSessionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FocusSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FocusSessionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FocusSessionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> taskId = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> startedAt = const Value.absent(),
                Value<String?> pausedAt = const Value.absent(),
                Value<String?> endedAt = const Value.absent(),
                Value<int> activeDurationSeconds = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FocusSessionsTableCompanion(
                id: id,
                taskId: taskId,
                state: state,
                startedAt: startedAt,
                pausedAt: pausedAt,
                endedAt: endedAt,
                activeDurationSeconds: activeDurationSeconds,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String taskId,
                required String state,
                required String startedAt,
                Value<String?> pausedAt = const Value.absent(),
                Value<String?> endedAt = const Value.absent(),
                Value<int> activeDurationSeconds = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FocusSessionsTableCompanion.insert(
                id: id,
                taskId: taskId,
                state: state,
                startedAt: startedAt,
                pausedAt: pausedAt,
                endedAt: endedAt,
                activeDurationSeconds: activeDurationSeconds,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FocusSessionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.taskId,
                                referencedTable:
                                    $$FocusSessionsTableTableReferences
                                        ._taskIdTable(db),
                                referencedColumn:
                                    $$FocusSessionsTableTableReferences
                                        ._taskIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FocusSessionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FocusSessionsTableTable,
      FocusSessionRow,
      $$FocusSessionsTableTableFilterComposer,
      $$FocusSessionsTableTableOrderingComposer,
      $$FocusSessionsTableTableAnnotationComposer,
      $$FocusSessionsTableTableCreateCompanionBuilder,
      $$FocusSessionsTableTableUpdateCompanionBuilder,
      (FocusSessionRow, $$FocusSessionsTableTableReferences),
      FocusSessionRow,
      PrefetchHooks Function({bool taskId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$RecurrenceTemplatesTableTableTableManager get recurrenceTemplatesTable =>
      $$RecurrenceTemplatesTableTableTableManager(
        _db,
        _db.recurrenceTemplatesTable,
      );
  $$TasksTableTableTableManager get tasksTable =>
      $$TasksTableTableTableManager(_db, _db.tasksTable);
  $$DailyPlansTableTableTableManager get dailyPlansTable =>
      $$DailyPlansTableTableTableManager(_db, _db.dailyPlansTable);
  $$ScheduleBlocksTableTableTableManager get scheduleBlocksTable =>
      $$ScheduleBlocksTableTableTableManager(_db, _db.scheduleBlocksTable);
  $$DailyStatsTableTableTableManager get dailyStatsTable =>
      $$DailyStatsTableTableTableManager(_db, _db.dailyStatsTable);
  $$FocusSessionsTableTableTableManager get focusSessionsTable =>
      $$FocusSessionsTableTableTableManager(_db, _db.focusSessionsTable);
}
