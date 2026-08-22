// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VillasTable extends Villas with TableInfo<$VillasTable, Villa> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VillasTable(this.attachedDatabase, [this._alias]);
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
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ownerNameMeta = const VerificationMeta(
    'ownerName',
  );
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
    'owner_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ownerContactMeta = const VerificationMeta(
    'ownerContact',
  );
  @override
  late final GeneratedColumn<String> ownerContact = GeneratedColumn<String>(
    'owner_contact',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ownerBankMeta = const VerificationMeta(
    'ownerBank',
  );
  @override
  late final GeneratedColumn<String> ownerBank = GeneratedColumn<String>(
    'owner_bank',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _butlerNameMeta = const VerificationMeta(
    'butlerName',
  );
  @override
  late final GeneratedColumn<String> butlerName = GeneratedColumn<String>(
    'butler_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _butlerContactMeta = const VerificationMeta(
    'butlerContact',
  );
  @override
  late final GeneratedColumn<String> butlerContact = GeneratedColumn<String>(
    'butler_contact',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isButlerSameAsOwnerMeta =
      const VerificationMeta('isButlerSameAsOwner');
  @override
  late final GeneratedColumn<bool> isButlerSameAsOwner = GeneratedColumn<bool>(
    'is_butler_same_as_owner',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_butler_same_as_owner" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _uniqueSellingPointsMeta =
      const VerificationMeta('uniqueSellingPoints');
  @override
  late final GeneratedColumn<String> uniqueSellingPoints =
      GeneratedColumn<String>(
        'unique_selling_points',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _amenitiesMeta = const VerificationMeta(
    'amenities',
  );
  @override
  late final GeneratedColumn<String> amenities = GeneratedColumn<String>(
    'amenities',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _houseRulesMeta = const VerificationMeta(
    'houseRules',
  );
  @override
  late final GeneratedColumn<String> houseRules = GeneratedColumn<String>(
    'house_rules',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _priceWeekdayMeta = const VerificationMeta(
    'priceWeekday',
  );
  @override
  late final GeneratedColumn<int> priceWeekday = GeneratedColumn<int>(
    'price_weekday',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _priceWeekendMeta = const VerificationMeta(
    'priceWeekend',
  );
  @override
  late final GeneratedColumn<int> priceWeekend = GeneratedColumn<int>(
    'price_weekend',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _priceHighSeasonMeta = const VerificationMeta(
    'priceHighSeason',
  );
  @override
  late final GeneratedColumn<int> priceHighSeason = GeneratedColumn<int>(
    'price_high_season',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _commissionPercentMeta = const VerificationMeta(
    'commissionPercent',
  );
  @override
  late final GeneratedColumn<double> commissionPercent =
      GeneratedColumn<double>(
        'commission_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _commissionTypeMeta = const VerificationMeta(
    'commissionType',
  );
  @override
  late final GeneratedColumn<String> commissionType = GeneratedColumn<String>(
    'commission_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('percent'),
  );
  static const VerificationMeta _commissionFixedMeta = const VerificationMeta(
    'commissionFixed',
  );
  @override
  late final GeneratedColumn<int> commissionFixed = GeneratedColumn<int>(
    'commission_fixed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _privateNotesMeta = const VerificationMeta(
    'privateNotes',
  );
  @override
  late final GeneratedColumn<String> privateNotes = GeneratedColumn<String>(
    'private_notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    location,
    ownerName,
    ownerContact,
    ownerBank,
    butlerName,
    butlerContact,
    isButlerSameAsOwner,
    isActive,
    description,
    uniqueSellingPoints,
    amenities,
    houseRules,
    priceWeekday,
    priceWeekend,
    priceHighSeason,
    commissionPercent,
    commissionType,
    commissionFixed,
    privateNotes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'villas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Villa> instance, {
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
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('owner_name')) {
      context.handle(
        _ownerNameMeta,
        ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta),
      );
    }
    if (data.containsKey('owner_contact')) {
      context.handle(
        _ownerContactMeta,
        ownerContact.isAcceptableOrUnknown(
          data['owner_contact']!,
          _ownerContactMeta,
        ),
      );
    }
    if (data.containsKey('owner_bank')) {
      context.handle(
        _ownerBankMeta,
        ownerBank.isAcceptableOrUnknown(data['owner_bank']!, _ownerBankMeta),
      );
    }
    if (data.containsKey('butler_name')) {
      context.handle(
        _butlerNameMeta,
        butlerName.isAcceptableOrUnknown(data['butler_name']!, _butlerNameMeta),
      );
    }
    if (data.containsKey('butler_contact')) {
      context.handle(
        _butlerContactMeta,
        butlerContact.isAcceptableOrUnknown(
          data['butler_contact']!,
          _butlerContactMeta,
        ),
      );
    }
    if (data.containsKey('is_butler_same_as_owner')) {
      context.handle(
        _isButlerSameAsOwnerMeta,
        isButlerSameAsOwner.isAcceptableOrUnknown(
          data['is_butler_same_as_owner']!,
          _isButlerSameAsOwnerMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
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
    if (data.containsKey('unique_selling_points')) {
      context.handle(
        _uniqueSellingPointsMeta,
        uniqueSellingPoints.isAcceptableOrUnknown(
          data['unique_selling_points']!,
          _uniqueSellingPointsMeta,
        ),
      );
    }
    if (data.containsKey('amenities')) {
      context.handle(
        _amenitiesMeta,
        amenities.isAcceptableOrUnknown(data['amenities']!, _amenitiesMeta),
      );
    }
    if (data.containsKey('house_rules')) {
      context.handle(
        _houseRulesMeta,
        houseRules.isAcceptableOrUnknown(data['house_rules']!, _houseRulesMeta),
      );
    }
    if (data.containsKey('price_weekday')) {
      context.handle(
        _priceWeekdayMeta,
        priceWeekday.isAcceptableOrUnknown(
          data['price_weekday']!,
          _priceWeekdayMeta,
        ),
      );
    }
    if (data.containsKey('price_weekend')) {
      context.handle(
        _priceWeekendMeta,
        priceWeekend.isAcceptableOrUnknown(
          data['price_weekend']!,
          _priceWeekendMeta,
        ),
      );
    }
    if (data.containsKey('price_high_season')) {
      context.handle(
        _priceHighSeasonMeta,
        priceHighSeason.isAcceptableOrUnknown(
          data['price_high_season']!,
          _priceHighSeasonMeta,
        ),
      );
    }
    if (data.containsKey('commission_percent')) {
      context.handle(
        _commissionPercentMeta,
        commissionPercent.isAcceptableOrUnknown(
          data['commission_percent']!,
          _commissionPercentMeta,
        ),
      );
    }
    if (data.containsKey('commission_type')) {
      context.handle(
        _commissionTypeMeta,
        commissionType.isAcceptableOrUnknown(
          data['commission_type']!,
          _commissionTypeMeta,
        ),
      );
    }
    if (data.containsKey('commission_fixed')) {
      context.handle(
        _commissionFixedMeta,
        commissionFixed.isAcceptableOrUnknown(
          data['commission_fixed']!,
          _commissionFixedMeta,
        ),
      );
    }
    if (data.containsKey('private_notes')) {
      context.handle(
        _privateNotesMeta,
        privateNotes.isAcceptableOrUnknown(
          data['private_notes']!,
          _privateNotesMeta,
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
  Villa map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Villa(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      ownerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_name'],
      )!,
      ownerContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_contact'],
      )!,
      ownerBank: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_bank'],
      )!,
      butlerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}butler_name'],
      )!,
      butlerContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}butler_contact'],
      )!,
      isButlerSameAsOwner: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_butler_same_as_owner'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      uniqueSellingPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unique_selling_points'],
      )!,
      amenities: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amenities'],
      )!,
      houseRules: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}house_rules'],
      )!,
      priceWeekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_weekday'],
      )!,
      priceWeekend: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_weekend'],
      )!,
      priceHighSeason: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_high_season'],
      )!,
      commissionPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission_percent'],
      )!,
      commissionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}commission_type'],
      )!,
      commissionFixed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}commission_fixed'],
      )!,
      privateNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}private_notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VillasTable createAlias(String alias) {
    return $VillasTable(attachedDatabase, alias);
  }
}

class Villa extends DataClass implements Insertable<Villa> {
  final String id;
  final String name;
  final String location;
  final String ownerName;
  final String ownerContact;
  final String ownerBank;
  final String butlerName;
  final String butlerContact;
  final bool isButlerSameAsOwner;
  final bool isActive;
  final String description;
  final String uniqueSellingPoints;
  final String amenities;
  final String houseRules;
  final int priceWeekday;
  final int priceWeekend;
  final int priceHighSeason;
  final double commissionPercent;

  /// `percent` | `fixed`
  final String commissionType;
  final int commissionFixed;
  final String privateNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Villa({
    required this.id,
    required this.name,
    required this.location,
    required this.ownerName,
    required this.ownerContact,
    required this.ownerBank,
    required this.butlerName,
    required this.butlerContact,
    required this.isButlerSameAsOwner,
    required this.isActive,
    required this.description,
    required this.uniqueSellingPoints,
    required this.amenities,
    required this.houseRules,
    required this.priceWeekday,
    required this.priceWeekend,
    required this.priceHighSeason,
    required this.commissionPercent,
    required this.commissionType,
    required this.commissionFixed,
    required this.privateNotes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['location'] = Variable<String>(location);
    map['owner_name'] = Variable<String>(ownerName);
    map['owner_contact'] = Variable<String>(ownerContact);
    map['owner_bank'] = Variable<String>(ownerBank);
    map['butler_name'] = Variable<String>(butlerName);
    map['butler_contact'] = Variable<String>(butlerContact);
    map['is_butler_same_as_owner'] = Variable<bool>(isButlerSameAsOwner);
    map['is_active'] = Variable<bool>(isActive);
    map['description'] = Variable<String>(description);
    map['unique_selling_points'] = Variable<String>(uniqueSellingPoints);
    map['amenities'] = Variable<String>(amenities);
    map['house_rules'] = Variable<String>(houseRules);
    map['price_weekday'] = Variable<int>(priceWeekday);
    map['price_weekend'] = Variable<int>(priceWeekend);
    map['price_high_season'] = Variable<int>(priceHighSeason);
    map['commission_percent'] = Variable<double>(commissionPercent);
    map['commission_type'] = Variable<String>(commissionType);
    map['commission_fixed'] = Variable<int>(commissionFixed);
    map['private_notes'] = Variable<String>(privateNotes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VillasCompanion toCompanion(bool nullToAbsent) {
    return VillasCompanion(
      id: Value(id),
      name: Value(name),
      location: Value(location),
      ownerName: Value(ownerName),
      ownerContact: Value(ownerContact),
      ownerBank: Value(ownerBank),
      butlerName: Value(butlerName),
      butlerContact: Value(butlerContact),
      isButlerSameAsOwner: Value(isButlerSameAsOwner),
      isActive: Value(isActive),
      description: Value(description),
      uniqueSellingPoints: Value(uniqueSellingPoints),
      amenities: Value(amenities),
      houseRules: Value(houseRules),
      priceWeekday: Value(priceWeekday),
      priceWeekend: Value(priceWeekend),
      priceHighSeason: Value(priceHighSeason),
      commissionPercent: Value(commissionPercent),
      commissionType: Value(commissionType),
      commissionFixed: Value(commissionFixed),
      privateNotes: Value(privateNotes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Villa.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Villa(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      location: serializer.fromJson<String>(json['location']),
      ownerName: serializer.fromJson<String>(json['ownerName']),
      ownerContact: serializer.fromJson<String>(json['ownerContact']),
      ownerBank: serializer.fromJson<String>(json['ownerBank']),
      butlerName: serializer.fromJson<String>(json['butlerName']),
      butlerContact: serializer.fromJson<String>(json['butlerContact']),
      isButlerSameAsOwner: serializer.fromJson<bool>(
        json['isButlerSameAsOwner'],
      ),
      isActive: serializer.fromJson<bool>(json['isActive']),
      description: serializer.fromJson<String>(json['description']),
      uniqueSellingPoints: serializer.fromJson<String>(
        json['uniqueSellingPoints'],
      ),
      amenities: serializer.fromJson<String>(json['amenities']),
      houseRules: serializer.fromJson<String>(json['houseRules']),
      priceWeekday: serializer.fromJson<int>(json['priceWeekday']),
      priceWeekend: serializer.fromJson<int>(json['priceWeekend']),
      priceHighSeason: serializer.fromJson<int>(json['priceHighSeason']),
      commissionPercent: serializer.fromJson<double>(json['commissionPercent']),
      commissionType: serializer.fromJson<String>(json['commissionType']),
      commissionFixed: serializer.fromJson<int>(json['commissionFixed']),
      privateNotes: serializer.fromJson<String>(json['privateNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'location': serializer.toJson<String>(location),
      'ownerName': serializer.toJson<String>(ownerName),
      'ownerContact': serializer.toJson<String>(ownerContact),
      'ownerBank': serializer.toJson<String>(ownerBank),
      'butlerName': serializer.toJson<String>(butlerName),
      'butlerContact': serializer.toJson<String>(butlerContact),
      'isButlerSameAsOwner': serializer.toJson<bool>(isButlerSameAsOwner),
      'isActive': serializer.toJson<bool>(isActive),
      'description': serializer.toJson<String>(description),
      'uniqueSellingPoints': serializer.toJson<String>(uniqueSellingPoints),
      'amenities': serializer.toJson<String>(amenities),
      'houseRules': serializer.toJson<String>(houseRules),
      'priceWeekday': serializer.toJson<int>(priceWeekday),
      'priceWeekend': serializer.toJson<int>(priceWeekend),
      'priceHighSeason': serializer.toJson<int>(priceHighSeason),
      'commissionPercent': serializer.toJson<double>(commissionPercent),
      'commissionType': serializer.toJson<String>(commissionType),
      'commissionFixed': serializer.toJson<int>(commissionFixed),
      'privateNotes': serializer.toJson<String>(privateNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Villa copyWith({
    String? id,
    String? name,
    String? location,
    String? ownerName,
    String? ownerContact,
    String? ownerBank,
    String? butlerName,
    String? butlerContact,
    bool? isButlerSameAsOwner,
    bool? isActive,
    String? description,
    String? uniqueSellingPoints,
    String? amenities,
    String? houseRules,
    int? priceWeekday,
    int? priceWeekend,
    int? priceHighSeason,
    double? commissionPercent,
    String? commissionType,
    int? commissionFixed,
    String? privateNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Villa(
    id: id ?? this.id,
    name: name ?? this.name,
    location: location ?? this.location,
    ownerName: ownerName ?? this.ownerName,
    ownerContact: ownerContact ?? this.ownerContact,
    ownerBank: ownerBank ?? this.ownerBank,
    butlerName: butlerName ?? this.butlerName,
    butlerContact: butlerContact ?? this.butlerContact,
    isButlerSameAsOwner: isButlerSameAsOwner ?? this.isButlerSameAsOwner,
    isActive: isActive ?? this.isActive,
    description: description ?? this.description,
    uniqueSellingPoints: uniqueSellingPoints ?? this.uniqueSellingPoints,
    amenities: amenities ?? this.amenities,
    houseRules: houseRules ?? this.houseRules,
    priceWeekday: priceWeekday ?? this.priceWeekday,
    priceWeekend: priceWeekend ?? this.priceWeekend,
    priceHighSeason: priceHighSeason ?? this.priceHighSeason,
    commissionPercent: commissionPercent ?? this.commissionPercent,
    commissionType: commissionType ?? this.commissionType,
    commissionFixed: commissionFixed ?? this.commissionFixed,
    privateNotes: privateNotes ?? this.privateNotes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Villa copyWithCompanion(VillasCompanion data) {
    return Villa(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      location: data.location.present ? data.location.value : this.location,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      ownerContact: data.ownerContact.present
          ? data.ownerContact.value
          : this.ownerContact,
      ownerBank: data.ownerBank.present ? data.ownerBank.value : this.ownerBank,
      butlerName: data.butlerName.present
          ? data.butlerName.value
          : this.butlerName,
      butlerContact: data.butlerContact.present
          ? data.butlerContact.value
          : this.butlerContact,
      isButlerSameAsOwner: data.isButlerSameAsOwner.present
          ? data.isButlerSameAsOwner.value
          : this.isButlerSameAsOwner,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      description: data.description.present
          ? data.description.value
          : this.description,
      uniqueSellingPoints: data.uniqueSellingPoints.present
          ? data.uniqueSellingPoints.value
          : this.uniqueSellingPoints,
      amenities: data.amenities.present ? data.amenities.value : this.amenities,
      houseRules: data.houseRules.present
          ? data.houseRules.value
          : this.houseRules,
      priceWeekday: data.priceWeekday.present
          ? data.priceWeekday.value
          : this.priceWeekday,
      priceWeekend: data.priceWeekend.present
          ? data.priceWeekend.value
          : this.priceWeekend,
      priceHighSeason: data.priceHighSeason.present
          ? data.priceHighSeason.value
          : this.priceHighSeason,
      commissionPercent: data.commissionPercent.present
          ? data.commissionPercent.value
          : this.commissionPercent,
      commissionType: data.commissionType.present
          ? data.commissionType.value
          : this.commissionType,
      commissionFixed: data.commissionFixed.present
          ? data.commissionFixed.value
          : this.commissionFixed,
      privateNotes: data.privateNotes.present
          ? data.privateNotes.value
          : this.privateNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Villa(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('ownerName: $ownerName, ')
          ..write('ownerContact: $ownerContact, ')
          ..write('ownerBank: $ownerBank, ')
          ..write('butlerName: $butlerName, ')
          ..write('butlerContact: $butlerContact, ')
          ..write('isButlerSameAsOwner: $isButlerSameAsOwner, ')
          ..write('isActive: $isActive, ')
          ..write('description: $description, ')
          ..write('uniqueSellingPoints: $uniqueSellingPoints, ')
          ..write('amenities: $amenities, ')
          ..write('houseRules: $houseRules, ')
          ..write('priceWeekday: $priceWeekday, ')
          ..write('priceWeekend: $priceWeekend, ')
          ..write('priceHighSeason: $priceHighSeason, ')
          ..write('commissionPercent: $commissionPercent, ')
          ..write('commissionType: $commissionType, ')
          ..write('commissionFixed: $commissionFixed, ')
          ..write('privateNotes: $privateNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    location,
    ownerName,
    ownerContact,
    ownerBank,
    butlerName,
    butlerContact,
    isButlerSameAsOwner,
    isActive,
    description,
    uniqueSellingPoints,
    amenities,
    houseRules,
    priceWeekday,
    priceWeekend,
    priceHighSeason,
    commissionPercent,
    commissionType,
    commissionFixed,
    privateNotes,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Villa &&
          other.id == this.id &&
          other.name == this.name &&
          other.location == this.location &&
          other.ownerName == this.ownerName &&
          other.ownerContact == this.ownerContact &&
          other.ownerBank == this.ownerBank &&
          other.butlerName == this.butlerName &&
          other.butlerContact == this.butlerContact &&
          other.isButlerSameAsOwner == this.isButlerSameAsOwner &&
          other.isActive == this.isActive &&
          other.description == this.description &&
          other.uniqueSellingPoints == this.uniqueSellingPoints &&
          other.amenities == this.amenities &&
          other.houseRules == this.houseRules &&
          other.priceWeekday == this.priceWeekday &&
          other.priceWeekend == this.priceWeekend &&
          other.priceHighSeason == this.priceHighSeason &&
          other.commissionPercent == this.commissionPercent &&
          other.commissionType == this.commissionType &&
          other.commissionFixed == this.commissionFixed &&
          other.privateNotes == this.privateNotes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VillasCompanion extends UpdateCompanion<Villa> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> location;
  final Value<String> ownerName;
  final Value<String> ownerContact;
  final Value<String> ownerBank;
  final Value<String> butlerName;
  final Value<String> butlerContact;
  final Value<bool> isButlerSameAsOwner;
  final Value<bool> isActive;
  final Value<String> description;
  final Value<String> uniqueSellingPoints;
  final Value<String> amenities;
  final Value<String> houseRules;
  final Value<int> priceWeekday;
  final Value<int> priceWeekend;
  final Value<int> priceHighSeason;
  final Value<double> commissionPercent;
  final Value<String> commissionType;
  final Value<int> commissionFixed;
  final Value<String> privateNotes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const VillasCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.location = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.ownerContact = const Value.absent(),
    this.ownerBank = const Value.absent(),
    this.butlerName = const Value.absent(),
    this.butlerContact = const Value.absent(),
    this.isButlerSameAsOwner = const Value.absent(),
    this.isActive = const Value.absent(),
    this.description = const Value.absent(),
    this.uniqueSellingPoints = const Value.absent(),
    this.amenities = const Value.absent(),
    this.houseRules = const Value.absent(),
    this.priceWeekday = const Value.absent(),
    this.priceWeekend = const Value.absent(),
    this.priceHighSeason = const Value.absent(),
    this.commissionPercent = const Value.absent(),
    this.commissionType = const Value.absent(),
    this.commissionFixed = const Value.absent(),
    this.privateNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VillasCompanion.insert({
    required String id,
    required String name,
    this.location = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.ownerContact = const Value.absent(),
    this.ownerBank = const Value.absent(),
    this.butlerName = const Value.absent(),
    this.butlerContact = const Value.absent(),
    this.isButlerSameAsOwner = const Value.absent(),
    this.isActive = const Value.absent(),
    this.description = const Value.absent(),
    this.uniqueSellingPoints = const Value.absent(),
    this.amenities = const Value.absent(),
    this.houseRules = const Value.absent(),
    this.priceWeekday = const Value.absent(),
    this.priceWeekend = const Value.absent(),
    this.priceHighSeason = const Value.absent(),
    this.commissionPercent = const Value.absent(),
    this.commissionType = const Value.absent(),
    this.commissionFixed = const Value.absent(),
    this.privateNotes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Villa> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? location,
    Expression<String>? ownerName,
    Expression<String>? ownerContact,
    Expression<String>? ownerBank,
    Expression<String>? butlerName,
    Expression<String>? butlerContact,
    Expression<bool>? isButlerSameAsOwner,
    Expression<bool>? isActive,
    Expression<String>? description,
    Expression<String>? uniqueSellingPoints,
    Expression<String>? amenities,
    Expression<String>? houseRules,
    Expression<int>? priceWeekday,
    Expression<int>? priceWeekend,
    Expression<int>? priceHighSeason,
    Expression<double>? commissionPercent,
    Expression<String>? commissionType,
    Expression<int>? commissionFixed,
    Expression<String>? privateNotes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      if (ownerName != null) 'owner_name': ownerName,
      if (ownerContact != null) 'owner_contact': ownerContact,
      if (ownerBank != null) 'owner_bank': ownerBank,
      if (butlerName != null) 'butler_name': butlerName,
      if (butlerContact != null) 'butler_contact': butlerContact,
      if (isButlerSameAsOwner != null)
        'is_butler_same_as_owner': isButlerSameAsOwner,
      if (isActive != null) 'is_active': isActive,
      if (description != null) 'description': description,
      if (uniqueSellingPoints != null)
        'unique_selling_points': uniqueSellingPoints,
      if (amenities != null) 'amenities': amenities,
      if (houseRules != null) 'house_rules': houseRules,
      if (priceWeekday != null) 'price_weekday': priceWeekday,
      if (priceWeekend != null) 'price_weekend': priceWeekend,
      if (priceHighSeason != null) 'price_high_season': priceHighSeason,
      if (commissionPercent != null) 'commission_percent': commissionPercent,
      if (commissionType != null) 'commission_type': commissionType,
      if (commissionFixed != null) 'commission_fixed': commissionFixed,
      if (privateNotes != null) 'private_notes': privateNotes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VillasCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? location,
    Value<String>? ownerName,
    Value<String>? ownerContact,
    Value<String>? ownerBank,
    Value<String>? butlerName,
    Value<String>? butlerContact,
    Value<bool>? isButlerSameAsOwner,
    Value<bool>? isActive,
    Value<String>? description,
    Value<String>? uniqueSellingPoints,
    Value<String>? amenities,
    Value<String>? houseRules,
    Value<int>? priceWeekday,
    Value<int>? priceWeekend,
    Value<int>? priceHighSeason,
    Value<double>? commissionPercent,
    Value<String>? commissionType,
    Value<int>? commissionFixed,
    Value<String>? privateNotes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return VillasCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      ownerName: ownerName ?? this.ownerName,
      ownerContact: ownerContact ?? this.ownerContact,
      ownerBank: ownerBank ?? this.ownerBank,
      butlerName: butlerName ?? this.butlerName,
      butlerContact: butlerContact ?? this.butlerContact,
      isButlerSameAsOwner: isButlerSameAsOwner ?? this.isButlerSameAsOwner,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
      uniqueSellingPoints: uniqueSellingPoints ?? this.uniqueSellingPoints,
      amenities: amenities ?? this.amenities,
      houseRules: houseRules ?? this.houseRules,
      priceWeekday: priceWeekday ?? this.priceWeekday,
      priceWeekend: priceWeekend ?? this.priceWeekend,
      priceHighSeason: priceHighSeason ?? this.priceHighSeason,
      commissionPercent: commissionPercent ?? this.commissionPercent,
      commissionType: commissionType ?? this.commissionType,
      commissionFixed: commissionFixed ?? this.commissionFixed,
      privateNotes: privateNotes ?? this.privateNotes,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (ownerContact.present) {
      map['owner_contact'] = Variable<String>(ownerContact.value);
    }
    if (ownerBank.present) {
      map['owner_bank'] = Variable<String>(ownerBank.value);
    }
    if (butlerName.present) {
      map['butler_name'] = Variable<String>(butlerName.value);
    }
    if (butlerContact.present) {
      map['butler_contact'] = Variable<String>(butlerContact.value);
    }
    if (isButlerSameAsOwner.present) {
      map['is_butler_same_as_owner'] = Variable<bool>(
        isButlerSameAsOwner.value,
      );
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (uniqueSellingPoints.present) {
      map['unique_selling_points'] = Variable<String>(
        uniqueSellingPoints.value,
      );
    }
    if (amenities.present) {
      map['amenities'] = Variable<String>(amenities.value);
    }
    if (houseRules.present) {
      map['house_rules'] = Variable<String>(houseRules.value);
    }
    if (priceWeekday.present) {
      map['price_weekday'] = Variable<int>(priceWeekday.value);
    }
    if (priceWeekend.present) {
      map['price_weekend'] = Variable<int>(priceWeekend.value);
    }
    if (priceHighSeason.present) {
      map['price_high_season'] = Variable<int>(priceHighSeason.value);
    }
    if (commissionPercent.present) {
      map['commission_percent'] = Variable<double>(commissionPercent.value);
    }
    if (commissionType.present) {
      map['commission_type'] = Variable<String>(commissionType.value);
    }
    if (commissionFixed.present) {
      map['commission_fixed'] = Variable<int>(commissionFixed.value);
    }
    if (privateNotes.present) {
      map['private_notes'] = Variable<String>(privateNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VillasCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('ownerName: $ownerName, ')
          ..write('ownerContact: $ownerContact, ')
          ..write('ownerBank: $ownerBank, ')
          ..write('butlerName: $butlerName, ')
          ..write('butlerContact: $butlerContact, ')
          ..write('isButlerSameAsOwner: $isButlerSameAsOwner, ')
          ..write('isActive: $isActive, ')
          ..write('description: $description, ')
          ..write('uniqueSellingPoints: $uniqueSellingPoints, ')
          ..write('amenities: $amenities, ')
          ..write('houseRules: $houseRules, ')
          ..write('priceWeekday: $priceWeekday, ')
          ..write('priceWeekend: $priceWeekend, ')
          ..write('priceHighSeason: $priceHighSeason, ')
          ..write('commissionPercent: $commissionPercent, ')
          ..write('commissionType: $commissionType, ')
          ..write('commissionFixed: $commissionFixed, ')
          ..write('privateNotes: $privateNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VillaPhotosTable extends VillaPhotos
    with TableInfo<$VillaPhotosTable, VillaPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VillaPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _villaIdMeta = const VerificationMeta(
    'villaId',
  );
  @override
  late final GeneratedColumn<String> villaId = GeneratedColumn<String>(
    'villa_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES villas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediaTypeMeta = const VerificationMeta(
    'mediaType',
  );
  @override
  late final GeneratedColumn<String> mediaType = GeneratedColumn<String>(
    'media_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('photo'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    villaId,
    filePath,
    mediaType,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'villa_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<VillaPhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('villa_id')) {
      context.handle(
        _villaIdMeta,
        villaId.isAcceptableOrUnknown(data['villa_id']!, _villaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_villaIdMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('media_type')) {
      context.handle(
        _mediaTypeMeta,
        mediaType.isAcceptableOrUnknown(data['media_type']!, _mediaTypeMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VillaPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VillaPhoto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      villaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}villa_id'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      mediaType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_type'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $VillaPhotosTable createAlias(String alias) {
    return $VillaPhotosTable(attachedDatabase, alias);
  }
}

class VillaPhoto extends DataClass implements Insertable<VillaPhoto> {
  final String id;
  final String villaId;
  final String filePath;

  /// `photo` | `video`
  final String mediaType;
  final int sortOrder;
  const VillaPhoto({
    required this.id,
    required this.villaId,
    required this.filePath,
    required this.mediaType,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['villa_id'] = Variable<String>(villaId);
    map['file_path'] = Variable<String>(filePath);
    map['media_type'] = Variable<String>(mediaType);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  VillaPhotosCompanion toCompanion(bool nullToAbsent) {
    return VillaPhotosCompanion(
      id: Value(id),
      villaId: Value(villaId),
      filePath: Value(filePath),
      mediaType: Value(mediaType),
      sortOrder: Value(sortOrder),
    );
  }

  factory VillaPhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VillaPhoto(
      id: serializer.fromJson<String>(json['id']),
      villaId: serializer.fromJson<String>(json['villaId']),
      filePath: serializer.fromJson<String>(json['filePath']),
      mediaType: serializer.fromJson<String>(json['mediaType']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'villaId': serializer.toJson<String>(villaId),
      'filePath': serializer.toJson<String>(filePath),
      'mediaType': serializer.toJson<String>(mediaType),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  VillaPhoto copyWith({
    String? id,
    String? villaId,
    String? filePath,
    String? mediaType,
    int? sortOrder,
  }) => VillaPhoto(
    id: id ?? this.id,
    villaId: villaId ?? this.villaId,
    filePath: filePath ?? this.filePath,
    mediaType: mediaType ?? this.mediaType,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  VillaPhoto copyWithCompanion(VillaPhotosCompanion data) {
    return VillaPhoto(
      id: data.id.present ? data.id.value : this.id,
      villaId: data.villaId.present ? data.villaId.value : this.villaId,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VillaPhoto(')
          ..write('id: $id, ')
          ..write('villaId: $villaId, ')
          ..write('filePath: $filePath, ')
          ..write('mediaType: $mediaType, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, villaId, filePath, mediaType, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VillaPhoto &&
          other.id == this.id &&
          other.villaId == this.villaId &&
          other.filePath == this.filePath &&
          other.mediaType == this.mediaType &&
          other.sortOrder == this.sortOrder);
}

class VillaPhotosCompanion extends UpdateCompanion<VillaPhoto> {
  final Value<String> id;
  final Value<String> villaId;
  final Value<String> filePath;
  final Value<String> mediaType;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const VillaPhotosCompanion({
    this.id = const Value.absent(),
    this.villaId = const Value.absent(),
    this.filePath = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VillaPhotosCompanion.insert({
    required String id,
    required String villaId,
    required String filePath,
    this.mediaType = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       villaId = Value(villaId),
       filePath = Value(filePath);
  static Insertable<VillaPhoto> custom({
    Expression<String>? id,
    Expression<String>? villaId,
    Expression<String>? filePath,
    Expression<String>? mediaType,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (villaId != null) 'villa_id': villaId,
      if (filePath != null) 'file_path': filePath,
      if (mediaType != null) 'media_type': mediaType,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VillaPhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? villaId,
    Value<String>? filePath,
    Value<String>? mediaType,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return VillaPhotosCompanion(
      id: id ?? this.id,
      villaId: villaId ?? this.villaId,
      filePath: filePath ?? this.filePath,
      mediaType: mediaType ?? this.mediaType,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (villaId.present) {
      map['villa_id'] = Variable<String>(villaId.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(mediaType.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VillaPhotosCompanion(')
          ..write('id: $id, ')
          ..write('villaId: $villaId, ')
          ..write('filePath: $filePath, ')
          ..write('mediaType: $mediaType, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VillaFaqsTable extends VillaFaqs
    with TableInfo<$VillaFaqsTable, VillaFaq> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VillaFaqsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _villaIdMeta = const VerificationMeta(
    'villaId',
  );
  @override
  late final GeneratedColumn<String> villaId = GeneratedColumn<String>(
    'villa_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES villas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, villaId, question, answer];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'villa_faqs';
  @override
  VerificationContext validateIntegrity(
    Insertable<VillaFaq> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('villa_id')) {
      context.handle(
        _villaIdMeta,
        villaId.isAcceptableOrUnknown(data['villa_id']!, _villaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_villaIdMeta);
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(
        _answerMeta,
        answer.isAcceptableOrUnknown(data['answer']!, _answerMeta),
      );
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VillaFaq map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VillaFaq(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      villaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}villa_id'],
      )!,
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      )!,
      answer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer'],
      )!,
    );
  }

  @override
  $VillaFaqsTable createAlias(String alias) {
    return $VillaFaqsTable(attachedDatabase, alias);
  }
}

class VillaFaq extends DataClass implements Insertable<VillaFaq> {
  final String id;
  final String villaId;
  final String question;
  final String answer;
  const VillaFaq({
    required this.id,
    required this.villaId,
    required this.question,
    required this.answer,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['villa_id'] = Variable<String>(villaId);
    map['question'] = Variable<String>(question);
    map['answer'] = Variable<String>(answer);
    return map;
  }

  VillaFaqsCompanion toCompanion(bool nullToAbsent) {
    return VillaFaqsCompanion(
      id: Value(id),
      villaId: Value(villaId),
      question: Value(question),
      answer: Value(answer),
    );
  }

  factory VillaFaq.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VillaFaq(
      id: serializer.fromJson<String>(json['id']),
      villaId: serializer.fromJson<String>(json['villaId']),
      question: serializer.fromJson<String>(json['question']),
      answer: serializer.fromJson<String>(json['answer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'villaId': serializer.toJson<String>(villaId),
      'question': serializer.toJson<String>(question),
      'answer': serializer.toJson<String>(answer),
    };
  }

  VillaFaq copyWith({
    String? id,
    String? villaId,
    String? question,
    String? answer,
  }) => VillaFaq(
    id: id ?? this.id,
    villaId: villaId ?? this.villaId,
    question: question ?? this.question,
    answer: answer ?? this.answer,
  );
  VillaFaq copyWithCompanion(VillaFaqsCompanion data) {
    return VillaFaq(
      id: data.id.present ? data.id.value : this.id,
      villaId: data.villaId.present ? data.villaId.value : this.villaId,
      question: data.question.present ? data.question.value : this.question,
      answer: data.answer.present ? data.answer.value : this.answer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VillaFaq(')
          ..write('id: $id, ')
          ..write('villaId: $villaId, ')
          ..write('question: $question, ')
          ..write('answer: $answer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, villaId, question, answer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VillaFaq &&
          other.id == this.id &&
          other.villaId == this.villaId &&
          other.question == this.question &&
          other.answer == this.answer);
}

class VillaFaqsCompanion extends UpdateCompanion<VillaFaq> {
  final Value<String> id;
  final Value<String> villaId;
  final Value<String> question;
  final Value<String> answer;
  final Value<int> rowid;
  const VillaFaqsCompanion({
    this.id = const Value.absent(),
    this.villaId = const Value.absent(),
    this.question = const Value.absent(),
    this.answer = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VillaFaqsCompanion.insert({
    required String id,
    required String villaId,
    required String question,
    required String answer,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       villaId = Value(villaId),
       question = Value(question),
       answer = Value(answer);
  static Insertable<VillaFaq> custom({
    Expression<String>? id,
    Expression<String>? villaId,
    Expression<String>? question,
    Expression<String>? answer,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (villaId != null) 'villa_id': villaId,
      if (question != null) 'question': question,
      if (answer != null) 'answer': answer,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VillaFaqsCompanion copyWith({
    Value<String>? id,
    Value<String>? villaId,
    Value<String>? question,
    Value<String>? answer,
    Value<int>? rowid,
  }) {
    return VillaFaqsCompanion(
      id: id ?? this.id,
      villaId: villaId ?? this.villaId,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (villaId.present) {
      map['villa_id'] = Variable<String>(villaId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VillaFaqsCompanion(')
          ..write('id: $id, ')
          ..write('villaId: $villaId, ')
          ..write('question: $question, ')
          ..write('answer: $answer, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookingsTable extends Bookings with TableInfo<$BookingsTable, Booking> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _villaIdMeta = const VerificationMeta(
    'villaId',
  );
  @override
  late final GeneratedColumn<String> villaId = GeneratedColumn<String>(
    'villa_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES villas (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _guestNameMeta = const VerificationMeta(
    'guestName',
  );
  @override
  late final GeneratedColumn<String> guestName = GeneratedColumn<String>(
    'guest_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _guestContactMeta = const VerificationMeta(
    'guestContact',
  );
  @override
  late final GeneratedColumn<String> guestContact = GeneratedColumn<String>(
    'guest_contact',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _checkInMeta = const VerificationMeta(
    'checkIn',
  );
  @override
  late final GeneratedColumn<DateTime> checkIn = GeneratedColumn<DateTime>(
    'check_in',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkOutMeta = const VerificationMeta(
    'checkOut',
  );
  @override
  late final GeneratedColumn<DateTime> checkOut = GeneratedColumn<DateTime>(
    'check_out',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerNightSnapshotMeta =
      const VerificationMeta('pricePerNightSnapshot');
  @override
  late final GeneratedColumn<int> pricePerNightSnapshot = GeneratedColumn<int>(
    'price_per_night_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _commissionTypeSnapshotMeta =
      const VerificationMeta('commissionTypeSnapshot');
  @override
  late final GeneratedColumn<String> commissionTypeSnapshot =
      GeneratedColumn<String>(
        'commission_type_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('percent'),
      );
  static const VerificationMeta _commissionPercentSnapshotMeta =
      const VerificationMeta('commissionPercentSnapshot');
  @override
  late final GeneratedColumn<double> commissionPercentSnapshot =
      GeneratedColumn<double>(
        'commission_percent_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _commissionFixedSnapshotMeta =
      const VerificationMeta('commissionFixedSnapshot');
  @override
  late final GeneratedColumn<int> commissionFixedSnapshot =
      GeneratedColumn<int>(
        'commission_fixed_snapshot',
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
    defaultValue: const Constant('confirmed'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    villaId,
    guestName,
    guestContact,
    checkIn,
    checkOut,
    pricePerNightSnapshot,
    commissionTypeSnapshot,
    commissionPercentSnapshot,
    commissionFixedSnapshot,
    status,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Booking> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('villa_id')) {
      context.handle(
        _villaIdMeta,
        villaId.isAcceptableOrUnknown(data['villa_id']!, _villaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_villaIdMeta);
    }
    if (data.containsKey('guest_name')) {
      context.handle(
        _guestNameMeta,
        guestName.isAcceptableOrUnknown(data['guest_name']!, _guestNameMeta),
      );
    } else if (isInserting) {
      context.missing(_guestNameMeta);
    }
    if (data.containsKey('guest_contact')) {
      context.handle(
        _guestContactMeta,
        guestContact.isAcceptableOrUnknown(
          data['guest_contact']!,
          _guestContactMeta,
        ),
      );
    }
    if (data.containsKey('check_in')) {
      context.handle(
        _checkInMeta,
        checkIn.isAcceptableOrUnknown(data['check_in']!, _checkInMeta),
      );
    } else if (isInserting) {
      context.missing(_checkInMeta);
    }
    if (data.containsKey('check_out')) {
      context.handle(
        _checkOutMeta,
        checkOut.isAcceptableOrUnknown(data['check_out']!, _checkOutMeta),
      );
    } else if (isInserting) {
      context.missing(_checkOutMeta);
    }
    if (data.containsKey('price_per_night_snapshot')) {
      context.handle(
        _pricePerNightSnapshotMeta,
        pricePerNightSnapshot.isAcceptableOrUnknown(
          data['price_per_night_snapshot']!,
          _pricePerNightSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('commission_type_snapshot')) {
      context.handle(
        _commissionTypeSnapshotMeta,
        commissionTypeSnapshot.isAcceptableOrUnknown(
          data['commission_type_snapshot']!,
          _commissionTypeSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('commission_percent_snapshot')) {
      context.handle(
        _commissionPercentSnapshotMeta,
        commissionPercentSnapshot.isAcceptableOrUnknown(
          data['commission_percent_snapshot']!,
          _commissionPercentSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('commission_fixed_snapshot')) {
      context.handle(
        _commissionFixedSnapshotMeta,
        commissionFixedSnapshot.isAcceptableOrUnknown(
          data['commission_fixed_snapshot']!,
          _commissionFixedSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Booking map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Booking(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      villaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}villa_id'],
      )!,
      guestName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guest_name'],
      )!,
      guestContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guest_contact'],
      )!,
      checkIn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_in'],
      )!,
      checkOut: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_out'],
      )!,
      pricePerNightSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_per_night_snapshot'],
      )!,
      commissionTypeSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}commission_type_snapshot'],
      )!,
      commissionPercentSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission_percent_snapshot'],
      )!,
      commissionFixedSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}commission_fixed_snapshot'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookingsTable createAlias(String alias) {
    return $BookingsTable(attachedDatabase, alias);
  }
}

class Booking extends DataClass implements Insertable<Booking> {
  final String id;
  final String villaId;
  final String guestName;
  final String guestContact;
  final DateTime checkIn;
  final DateTime checkOut;
  final int pricePerNightSnapshot;
  final String commissionTypeSnapshot;
  final double commissionPercentSnapshot;
  final int commissionFixedSnapshot;

  /// `confirmed` | `cancelled`
  final String status;
  final String notes;
  final DateTime createdAt;
  const Booking({
    required this.id,
    required this.villaId,
    required this.guestName,
    required this.guestContact,
    required this.checkIn,
    required this.checkOut,
    required this.pricePerNightSnapshot,
    required this.commissionTypeSnapshot,
    required this.commissionPercentSnapshot,
    required this.commissionFixedSnapshot,
    required this.status,
    required this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['villa_id'] = Variable<String>(villaId);
    map['guest_name'] = Variable<String>(guestName);
    map['guest_contact'] = Variable<String>(guestContact);
    map['check_in'] = Variable<DateTime>(checkIn);
    map['check_out'] = Variable<DateTime>(checkOut);
    map['price_per_night_snapshot'] = Variable<int>(pricePerNightSnapshot);
    map['commission_type_snapshot'] = Variable<String>(commissionTypeSnapshot);
    map['commission_percent_snapshot'] = Variable<double>(
      commissionPercentSnapshot,
    );
    map['commission_fixed_snapshot'] = Variable<int>(commissionFixedSnapshot);
    map['status'] = Variable<String>(status);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookingsCompanion toCompanion(bool nullToAbsent) {
    return BookingsCompanion(
      id: Value(id),
      villaId: Value(villaId),
      guestName: Value(guestName),
      guestContact: Value(guestContact),
      checkIn: Value(checkIn),
      checkOut: Value(checkOut),
      pricePerNightSnapshot: Value(pricePerNightSnapshot),
      commissionTypeSnapshot: Value(commissionTypeSnapshot),
      commissionPercentSnapshot: Value(commissionPercentSnapshot),
      commissionFixedSnapshot: Value(commissionFixedSnapshot),
      status: Value(status),
      notes: Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Booking.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Booking(
      id: serializer.fromJson<String>(json['id']),
      villaId: serializer.fromJson<String>(json['villaId']),
      guestName: serializer.fromJson<String>(json['guestName']),
      guestContact: serializer.fromJson<String>(json['guestContact']),
      checkIn: serializer.fromJson<DateTime>(json['checkIn']),
      checkOut: serializer.fromJson<DateTime>(json['checkOut']),
      pricePerNightSnapshot: serializer.fromJson<int>(
        json['pricePerNightSnapshot'],
      ),
      commissionTypeSnapshot: serializer.fromJson<String>(
        json['commissionTypeSnapshot'],
      ),
      commissionPercentSnapshot: serializer.fromJson<double>(
        json['commissionPercentSnapshot'],
      ),
      commissionFixedSnapshot: serializer.fromJson<int>(
        json['commissionFixedSnapshot'],
      ),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'villaId': serializer.toJson<String>(villaId),
      'guestName': serializer.toJson<String>(guestName),
      'guestContact': serializer.toJson<String>(guestContact),
      'checkIn': serializer.toJson<DateTime>(checkIn),
      'checkOut': serializer.toJson<DateTime>(checkOut),
      'pricePerNightSnapshot': serializer.toJson<int>(pricePerNightSnapshot),
      'commissionTypeSnapshot': serializer.toJson<String>(
        commissionTypeSnapshot,
      ),
      'commissionPercentSnapshot': serializer.toJson<double>(
        commissionPercentSnapshot,
      ),
      'commissionFixedSnapshot': serializer.toJson<int>(
        commissionFixedSnapshot,
      ),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Booking copyWith({
    String? id,
    String? villaId,
    String? guestName,
    String? guestContact,
    DateTime? checkIn,
    DateTime? checkOut,
    int? pricePerNightSnapshot,
    String? commissionTypeSnapshot,
    double? commissionPercentSnapshot,
    int? commissionFixedSnapshot,
    String? status,
    String? notes,
    DateTime? createdAt,
  }) => Booking(
    id: id ?? this.id,
    villaId: villaId ?? this.villaId,
    guestName: guestName ?? this.guestName,
    guestContact: guestContact ?? this.guestContact,
    checkIn: checkIn ?? this.checkIn,
    checkOut: checkOut ?? this.checkOut,
    pricePerNightSnapshot: pricePerNightSnapshot ?? this.pricePerNightSnapshot,
    commissionTypeSnapshot:
        commissionTypeSnapshot ?? this.commissionTypeSnapshot,
    commissionPercentSnapshot:
        commissionPercentSnapshot ?? this.commissionPercentSnapshot,
    commissionFixedSnapshot:
        commissionFixedSnapshot ?? this.commissionFixedSnapshot,
    status: status ?? this.status,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Booking copyWithCompanion(BookingsCompanion data) {
    return Booking(
      id: data.id.present ? data.id.value : this.id,
      villaId: data.villaId.present ? data.villaId.value : this.villaId,
      guestName: data.guestName.present ? data.guestName.value : this.guestName,
      guestContact: data.guestContact.present
          ? data.guestContact.value
          : this.guestContact,
      checkIn: data.checkIn.present ? data.checkIn.value : this.checkIn,
      checkOut: data.checkOut.present ? data.checkOut.value : this.checkOut,
      pricePerNightSnapshot: data.pricePerNightSnapshot.present
          ? data.pricePerNightSnapshot.value
          : this.pricePerNightSnapshot,
      commissionTypeSnapshot: data.commissionTypeSnapshot.present
          ? data.commissionTypeSnapshot.value
          : this.commissionTypeSnapshot,
      commissionPercentSnapshot: data.commissionPercentSnapshot.present
          ? data.commissionPercentSnapshot.value
          : this.commissionPercentSnapshot,
      commissionFixedSnapshot: data.commissionFixedSnapshot.present
          ? data.commissionFixedSnapshot.value
          : this.commissionFixedSnapshot,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Booking(')
          ..write('id: $id, ')
          ..write('villaId: $villaId, ')
          ..write('guestName: $guestName, ')
          ..write('guestContact: $guestContact, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('pricePerNightSnapshot: $pricePerNightSnapshot, ')
          ..write('commissionTypeSnapshot: $commissionTypeSnapshot, ')
          ..write('commissionPercentSnapshot: $commissionPercentSnapshot, ')
          ..write('commissionFixedSnapshot: $commissionFixedSnapshot, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    villaId,
    guestName,
    guestContact,
    checkIn,
    checkOut,
    pricePerNightSnapshot,
    commissionTypeSnapshot,
    commissionPercentSnapshot,
    commissionFixedSnapshot,
    status,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Booking &&
          other.id == this.id &&
          other.villaId == this.villaId &&
          other.guestName == this.guestName &&
          other.guestContact == this.guestContact &&
          other.checkIn == this.checkIn &&
          other.checkOut == this.checkOut &&
          other.pricePerNightSnapshot == this.pricePerNightSnapshot &&
          other.commissionTypeSnapshot == this.commissionTypeSnapshot &&
          other.commissionPercentSnapshot == this.commissionPercentSnapshot &&
          other.commissionFixedSnapshot == this.commissionFixedSnapshot &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class BookingsCompanion extends UpdateCompanion<Booking> {
  final Value<String> id;
  final Value<String> villaId;
  final Value<String> guestName;
  final Value<String> guestContact;
  final Value<DateTime> checkIn;
  final Value<DateTime> checkOut;
  final Value<int> pricePerNightSnapshot;
  final Value<String> commissionTypeSnapshot;
  final Value<double> commissionPercentSnapshot;
  final Value<int> commissionFixedSnapshot;
  final Value<String> status;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BookingsCompanion({
    this.id = const Value.absent(),
    this.villaId = const Value.absent(),
    this.guestName = const Value.absent(),
    this.guestContact = const Value.absent(),
    this.checkIn = const Value.absent(),
    this.checkOut = const Value.absent(),
    this.pricePerNightSnapshot = const Value.absent(),
    this.commissionTypeSnapshot = const Value.absent(),
    this.commissionPercentSnapshot = const Value.absent(),
    this.commissionFixedSnapshot = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookingsCompanion.insert({
    required String id,
    required String villaId,
    required String guestName,
    this.guestContact = const Value.absent(),
    required DateTime checkIn,
    required DateTime checkOut,
    this.pricePerNightSnapshot = const Value.absent(),
    this.commissionTypeSnapshot = const Value.absent(),
    this.commissionPercentSnapshot = const Value.absent(),
    this.commissionFixedSnapshot = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       villaId = Value(villaId),
       guestName = Value(guestName),
       checkIn = Value(checkIn),
       checkOut = Value(checkOut),
       createdAt = Value(createdAt);
  static Insertable<Booking> custom({
    Expression<String>? id,
    Expression<String>? villaId,
    Expression<String>? guestName,
    Expression<String>? guestContact,
    Expression<DateTime>? checkIn,
    Expression<DateTime>? checkOut,
    Expression<int>? pricePerNightSnapshot,
    Expression<String>? commissionTypeSnapshot,
    Expression<double>? commissionPercentSnapshot,
    Expression<int>? commissionFixedSnapshot,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (villaId != null) 'villa_id': villaId,
      if (guestName != null) 'guest_name': guestName,
      if (guestContact != null) 'guest_contact': guestContact,
      if (checkIn != null) 'check_in': checkIn,
      if (checkOut != null) 'check_out': checkOut,
      if (pricePerNightSnapshot != null)
        'price_per_night_snapshot': pricePerNightSnapshot,
      if (commissionTypeSnapshot != null)
        'commission_type_snapshot': commissionTypeSnapshot,
      if (commissionPercentSnapshot != null)
        'commission_percent_snapshot': commissionPercentSnapshot,
      if (commissionFixedSnapshot != null)
        'commission_fixed_snapshot': commissionFixedSnapshot,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookingsCompanion copyWith({
    Value<String>? id,
    Value<String>? villaId,
    Value<String>? guestName,
    Value<String>? guestContact,
    Value<DateTime>? checkIn,
    Value<DateTime>? checkOut,
    Value<int>? pricePerNightSnapshot,
    Value<String>? commissionTypeSnapshot,
    Value<double>? commissionPercentSnapshot,
    Value<int>? commissionFixedSnapshot,
    Value<String>? status,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BookingsCompanion(
      id: id ?? this.id,
      villaId: villaId ?? this.villaId,
      guestName: guestName ?? this.guestName,
      guestContact: guestContact ?? this.guestContact,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      pricePerNightSnapshot:
          pricePerNightSnapshot ?? this.pricePerNightSnapshot,
      commissionTypeSnapshot:
          commissionTypeSnapshot ?? this.commissionTypeSnapshot,
      commissionPercentSnapshot:
          commissionPercentSnapshot ?? this.commissionPercentSnapshot,
      commissionFixedSnapshot:
          commissionFixedSnapshot ?? this.commissionFixedSnapshot,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (villaId.present) {
      map['villa_id'] = Variable<String>(villaId.value);
    }
    if (guestName.present) {
      map['guest_name'] = Variable<String>(guestName.value);
    }
    if (guestContact.present) {
      map['guest_contact'] = Variable<String>(guestContact.value);
    }
    if (checkIn.present) {
      map['check_in'] = Variable<DateTime>(checkIn.value);
    }
    if (checkOut.present) {
      map['check_out'] = Variable<DateTime>(checkOut.value);
    }
    if (pricePerNightSnapshot.present) {
      map['price_per_night_snapshot'] = Variable<int>(
        pricePerNightSnapshot.value,
      );
    }
    if (commissionTypeSnapshot.present) {
      map['commission_type_snapshot'] = Variable<String>(
        commissionTypeSnapshot.value,
      );
    }
    if (commissionPercentSnapshot.present) {
      map['commission_percent_snapshot'] = Variable<double>(
        commissionPercentSnapshot.value,
      );
    }
    if (commissionFixedSnapshot.present) {
      map['commission_fixed_snapshot'] = Variable<int>(
        commissionFixedSnapshot.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookingsCompanion(')
          ..write('id: $id, ')
          ..write('villaId: $villaId, ')
          ..write('guestName: $guestName, ')
          ..write('guestContact: $guestContact, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('pricePerNightSnapshot: $pricePerNightSnapshot, ')
          ..write('commissionTypeSnapshot: $commissionTypeSnapshot, ')
          ..write('commissionPercentSnapshot: $commissionPercentSnapshot, ')
          ..write('commissionFixedSnapshot: $commissionFixedSnapshot, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookingIdMeta = const VerificationMeta(
    'bookingId',
  );
  @override
  late final GeneratedColumn<String> bookingId = GeneratedColumn<String>(
    'booking_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bookings (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _guestNameMeta = const VerificationMeta(
    'guestName',
  );
  @override
  late final GeneratedColumn<String> guestName = GeneratedColumn<String>(
    'guest_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _villaNameMeta = const VerificationMeta(
    'villaName',
  );
  @override
  late final GeneratedColumn<String> villaName = GeneratedColumn<String>(
    'villa_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkInMeta = const VerificationMeta(
    'checkIn',
  );
  @override
  late final GeneratedColumn<DateTime> checkIn = GeneratedColumn<DateTime>(
    'check_in',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkOutMeta = const VerificationMeta(
    'checkOut',
  );
  @override
  late final GeneratedColumn<DateTime> checkOut = GeneratedColumn<DateTime>(
    'check_out',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commissionTypeSnapshotMeta =
      const VerificationMeta('commissionTypeSnapshot');
  @override
  late final GeneratedColumn<String> commissionTypeSnapshot =
      GeneratedColumn<String>(
        'commission_type_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('percent'),
      );
  static const VerificationMeta _commissionPercentSnapshotMeta =
      const VerificationMeta('commissionPercentSnapshot');
  @override
  late final GeneratedColumn<double> commissionPercentSnapshot =
      GeneratedColumn<double>(
        'commission_percent_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _commissionFixedSnapshotMeta =
      const VerificationMeta('commissionFixedSnapshot');
  @override
  late final GeneratedColumn<int> commissionFixedSnapshot =
      GeneratedColumn<int>(
        'commission_fixed_snapshot',
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
    defaultValue: const Constant('unpaid'),
  );
  static const VerificationMeta _dateIssuedMeta = const VerificationMeta(
    'dateIssued',
  );
  @override
  late final GeneratedColumn<DateTime> dateIssued = GeneratedColumn<DateTime>(
    'date_issued',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _datePaidMeta = const VerificationMeta(
    'datePaid',
  );
  @override
  late final GeneratedColumn<DateTime> datePaid = GeneratedColumn<DateTime>(
    'date_paid',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderSentAtMeta = const VerificationMeta(
    'reminderSentAt',
  );
  @override
  late final GeneratedColumn<DateTime> reminderSentAt =
      GeneratedColumn<DateTime>(
        'reminder_sent_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceNumber,
    bookingId,
    guestName,
    villaName,
    checkIn,
    checkOut,
    commissionTypeSnapshot,
    commissionPercentSnapshot,
    commissionFixedSnapshot,
    status,
    dateIssued,
    datePaid,
    reminderSentAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('booking_id')) {
      context.handle(
        _bookingIdMeta,
        bookingId.isAcceptableOrUnknown(data['booking_id']!, _bookingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookingIdMeta);
    }
    if (data.containsKey('guest_name')) {
      context.handle(
        _guestNameMeta,
        guestName.isAcceptableOrUnknown(data['guest_name']!, _guestNameMeta),
      );
    } else if (isInserting) {
      context.missing(_guestNameMeta);
    }
    if (data.containsKey('villa_name')) {
      context.handle(
        _villaNameMeta,
        villaName.isAcceptableOrUnknown(data['villa_name']!, _villaNameMeta),
      );
    } else if (isInserting) {
      context.missing(_villaNameMeta);
    }
    if (data.containsKey('check_in')) {
      context.handle(
        _checkInMeta,
        checkIn.isAcceptableOrUnknown(data['check_in']!, _checkInMeta),
      );
    } else if (isInserting) {
      context.missing(_checkInMeta);
    }
    if (data.containsKey('check_out')) {
      context.handle(
        _checkOutMeta,
        checkOut.isAcceptableOrUnknown(data['check_out']!, _checkOutMeta),
      );
    } else if (isInserting) {
      context.missing(_checkOutMeta);
    }
    if (data.containsKey('commission_type_snapshot')) {
      context.handle(
        _commissionTypeSnapshotMeta,
        commissionTypeSnapshot.isAcceptableOrUnknown(
          data['commission_type_snapshot']!,
          _commissionTypeSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('commission_percent_snapshot')) {
      context.handle(
        _commissionPercentSnapshotMeta,
        commissionPercentSnapshot.isAcceptableOrUnknown(
          data['commission_percent_snapshot']!,
          _commissionPercentSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('commission_fixed_snapshot')) {
      context.handle(
        _commissionFixedSnapshotMeta,
        commissionFixedSnapshot.isAcceptableOrUnknown(
          data['commission_fixed_snapshot']!,
          _commissionFixedSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('date_issued')) {
      context.handle(
        _dateIssuedMeta,
        dateIssued.isAcceptableOrUnknown(data['date_issued']!, _dateIssuedMeta),
      );
    } else if (isInserting) {
      context.missing(_dateIssuedMeta);
    }
    if (data.containsKey('date_paid')) {
      context.handle(
        _datePaidMeta,
        datePaid.isAcceptableOrUnknown(data['date_paid']!, _datePaidMeta),
      );
    }
    if (data.containsKey('reminder_sent_at')) {
      context.handle(
        _reminderSentAtMeta,
        reminderSentAt.isAcceptableOrUnknown(
          data['reminder_sent_at']!,
          _reminderSentAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {invoiceNumber},
    {bookingId},
  ];
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      bookingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}booking_id'],
      )!,
      guestName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guest_name'],
      )!,
      villaName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}villa_name'],
      )!,
      checkIn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_in'],
      )!,
      checkOut: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_out'],
      )!,
      commissionTypeSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}commission_type_snapshot'],
      )!,
      commissionPercentSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}commission_percent_snapshot'],
      )!,
      commissionFixedSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}commission_fixed_snapshot'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      dateIssued: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_issued'],
      )!,
      datePaid: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_paid'],
      ),
      reminderSentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reminder_sent_at'],
      ),
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final String id;
  final String invoiceNumber;
  final String bookingId;
  final String guestName;
  final String villaName;
  final DateTime checkIn;
  final DateTime checkOut;
  final String commissionTypeSnapshot;
  final double commissionPercentSnapshot;
  final int commissionFixedSnapshot;

  /// `unpaid` | `partial` | `paid`
  final String status;
  final DateTime dateIssued;
  final DateTime? datePaid;
  final DateTime? reminderSentAt;
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.bookingId,
    required this.guestName,
    required this.villaName,
    required this.checkIn,
    required this.checkOut,
    required this.commissionTypeSnapshot,
    required this.commissionPercentSnapshot,
    required this.commissionFixedSnapshot,
    required this.status,
    required this.dateIssued,
    this.datePaid,
    this.reminderSentAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['booking_id'] = Variable<String>(bookingId);
    map['guest_name'] = Variable<String>(guestName);
    map['villa_name'] = Variable<String>(villaName);
    map['check_in'] = Variable<DateTime>(checkIn);
    map['check_out'] = Variable<DateTime>(checkOut);
    map['commission_type_snapshot'] = Variable<String>(commissionTypeSnapshot);
    map['commission_percent_snapshot'] = Variable<double>(
      commissionPercentSnapshot,
    );
    map['commission_fixed_snapshot'] = Variable<int>(commissionFixedSnapshot);
    map['status'] = Variable<String>(status);
    map['date_issued'] = Variable<DateTime>(dateIssued);
    if (!nullToAbsent || datePaid != null) {
      map['date_paid'] = Variable<DateTime>(datePaid);
    }
    if (!nullToAbsent || reminderSentAt != null) {
      map['reminder_sent_at'] = Variable<DateTime>(reminderSentAt);
    }
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      invoiceNumber: Value(invoiceNumber),
      bookingId: Value(bookingId),
      guestName: Value(guestName),
      villaName: Value(villaName),
      checkIn: Value(checkIn),
      checkOut: Value(checkOut),
      commissionTypeSnapshot: Value(commissionTypeSnapshot),
      commissionPercentSnapshot: Value(commissionPercentSnapshot),
      commissionFixedSnapshot: Value(commissionFixedSnapshot),
      status: Value(status),
      dateIssued: Value(dateIssued),
      datePaid: datePaid == null && nullToAbsent
          ? const Value.absent()
          : Value(datePaid),
      reminderSentAt: reminderSentAt == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderSentAt),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<String>(json['id']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      bookingId: serializer.fromJson<String>(json['bookingId']),
      guestName: serializer.fromJson<String>(json['guestName']),
      villaName: serializer.fromJson<String>(json['villaName']),
      checkIn: serializer.fromJson<DateTime>(json['checkIn']),
      checkOut: serializer.fromJson<DateTime>(json['checkOut']),
      commissionTypeSnapshot: serializer.fromJson<String>(
        json['commissionTypeSnapshot'],
      ),
      commissionPercentSnapshot: serializer.fromJson<double>(
        json['commissionPercentSnapshot'],
      ),
      commissionFixedSnapshot: serializer.fromJson<int>(
        json['commissionFixedSnapshot'],
      ),
      status: serializer.fromJson<String>(json['status']),
      dateIssued: serializer.fromJson<DateTime>(json['dateIssued']),
      datePaid: serializer.fromJson<DateTime?>(json['datePaid']),
      reminderSentAt: serializer.fromJson<DateTime?>(json['reminderSentAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'bookingId': serializer.toJson<String>(bookingId),
      'guestName': serializer.toJson<String>(guestName),
      'villaName': serializer.toJson<String>(villaName),
      'checkIn': serializer.toJson<DateTime>(checkIn),
      'checkOut': serializer.toJson<DateTime>(checkOut),
      'commissionTypeSnapshot': serializer.toJson<String>(
        commissionTypeSnapshot,
      ),
      'commissionPercentSnapshot': serializer.toJson<double>(
        commissionPercentSnapshot,
      ),
      'commissionFixedSnapshot': serializer.toJson<int>(
        commissionFixedSnapshot,
      ),
      'status': serializer.toJson<String>(status),
      'dateIssued': serializer.toJson<DateTime>(dateIssued),
      'datePaid': serializer.toJson<DateTime?>(datePaid),
      'reminderSentAt': serializer.toJson<DateTime?>(reminderSentAt),
    };
  }

  Invoice copyWith({
    String? id,
    String? invoiceNumber,
    String? bookingId,
    String? guestName,
    String? villaName,
    DateTime? checkIn,
    DateTime? checkOut,
    String? commissionTypeSnapshot,
    double? commissionPercentSnapshot,
    int? commissionFixedSnapshot,
    String? status,
    DateTime? dateIssued,
    Value<DateTime?> datePaid = const Value.absent(),
    Value<DateTime?> reminderSentAt = const Value.absent(),
  }) => Invoice(
    id: id ?? this.id,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    bookingId: bookingId ?? this.bookingId,
    guestName: guestName ?? this.guestName,
    villaName: villaName ?? this.villaName,
    checkIn: checkIn ?? this.checkIn,
    checkOut: checkOut ?? this.checkOut,
    commissionTypeSnapshot:
        commissionTypeSnapshot ?? this.commissionTypeSnapshot,
    commissionPercentSnapshot:
        commissionPercentSnapshot ?? this.commissionPercentSnapshot,
    commissionFixedSnapshot:
        commissionFixedSnapshot ?? this.commissionFixedSnapshot,
    status: status ?? this.status,
    dateIssued: dateIssued ?? this.dateIssued,
    datePaid: datePaid.present ? datePaid.value : this.datePaid,
    reminderSentAt: reminderSentAt.present
        ? reminderSentAt.value
        : this.reminderSentAt,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      bookingId: data.bookingId.present ? data.bookingId.value : this.bookingId,
      guestName: data.guestName.present ? data.guestName.value : this.guestName,
      villaName: data.villaName.present ? data.villaName.value : this.villaName,
      checkIn: data.checkIn.present ? data.checkIn.value : this.checkIn,
      checkOut: data.checkOut.present ? data.checkOut.value : this.checkOut,
      commissionTypeSnapshot: data.commissionTypeSnapshot.present
          ? data.commissionTypeSnapshot.value
          : this.commissionTypeSnapshot,
      commissionPercentSnapshot: data.commissionPercentSnapshot.present
          ? data.commissionPercentSnapshot.value
          : this.commissionPercentSnapshot,
      commissionFixedSnapshot: data.commissionFixedSnapshot.present
          ? data.commissionFixedSnapshot.value
          : this.commissionFixedSnapshot,
      status: data.status.present ? data.status.value : this.status,
      dateIssued: data.dateIssued.present
          ? data.dateIssued.value
          : this.dateIssued,
      datePaid: data.datePaid.present ? data.datePaid.value : this.datePaid,
      reminderSentAt: data.reminderSentAt.present
          ? data.reminderSentAt.value
          : this.reminderSentAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('bookingId: $bookingId, ')
          ..write('guestName: $guestName, ')
          ..write('villaName: $villaName, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('commissionTypeSnapshot: $commissionTypeSnapshot, ')
          ..write('commissionPercentSnapshot: $commissionPercentSnapshot, ')
          ..write('commissionFixedSnapshot: $commissionFixedSnapshot, ')
          ..write('status: $status, ')
          ..write('dateIssued: $dateIssued, ')
          ..write('datePaid: $datePaid, ')
          ..write('reminderSentAt: $reminderSentAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceNumber,
    bookingId,
    guestName,
    villaName,
    checkIn,
    checkOut,
    commissionTypeSnapshot,
    commissionPercentSnapshot,
    commissionFixedSnapshot,
    status,
    dateIssued,
    datePaid,
    reminderSentAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.invoiceNumber == this.invoiceNumber &&
          other.bookingId == this.bookingId &&
          other.guestName == this.guestName &&
          other.villaName == this.villaName &&
          other.checkIn == this.checkIn &&
          other.checkOut == this.checkOut &&
          other.commissionTypeSnapshot == this.commissionTypeSnapshot &&
          other.commissionPercentSnapshot == this.commissionPercentSnapshot &&
          other.commissionFixedSnapshot == this.commissionFixedSnapshot &&
          other.status == this.status &&
          other.dateIssued == this.dateIssued &&
          other.datePaid == this.datePaid &&
          other.reminderSentAt == this.reminderSentAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<String> id;
  final Value<String> invoiceNumber;
  final Value<String> bookingId;
  final Value<String> guestName;
  final Value<String> villaName;
  final Value<DateTime> checkIn;
  final Value<DateTime> checkOut;
  final Value<String> commissionTypeSnapshot;
  final Value<double> commissionPercentSnapshot;
  final Value<int> commissionFixedSnapshot;
  final Value<String> status;
  final Value<DateTime> dateIssued;
  final Value<DateTime?> datePaid;
  final Value<DateTime?> reminderSentAt;
  final Value<int> rowid;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.bookingId = const Value.absent(),
    this.guestName = const Value.absent(),
    this.villaName = const Value.absent(),
    this.checkIn = const Value.absent(),
    this.checkOut = const Value.absent(),
    this.commissionTypeSnapshot = const Value.absent(),
    this.commissionPercentSnapshot = const Value.absent(),
    this.commissionFixedSnapshot = const Value.absent(),
    this.status = const Value.absent(),
    this.dateIssued = const Value.absent(),
    this.datePaid = const Value.absent(),
    this.reminderSentAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicesCompanion.insert({
    required String id,
    required String invoiceNumber,
    required String bookingId,
    required String guestName,
    required String villaName,
    required DateTime checkIn,
    required DateTime checkOut,
    this.commissionTypeSnapshot = const Value.absent(),
    this.commissionPercentSnapshot = const Value.absent(),
    this.commissionFixedSnapshot = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime dateIssued,
    this.datePaid = const Value.absent(),
    this.reminderSentAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       invoiceNumber = Value(invoiceNumber),
       bookingId = Value(bookingId),
       guestName = Value(guestName),
       villaName = Value(villaName),
       checkIn = Value(checkIn),
       checkOut = Value(checkOut),
       dateIssued = Value(dateIssued);
  static Insertable<Invoice> custom({
    Expression<String>? id,
    Expression<String>? invoiceNumber,
    Expression<String>? bookingId,
    Expression<String>? guestName,
    Expression<String>? villaName,
    Expression<DateTime>? checkIn,
    Expression<DateTime>? checkOut,
    Expression<String>? commissionTypeSnapshot,
    Expression<double>? commissionPercentSnapshot,
    Expression<int>? commissionFixedSnapshot,
    Expression<String>? status,
    Expression<DateTime>? dateIssued,
    Expression<DateTime>? datePaid,
    Expression<DateTime>? reminderSentAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (bookingId != null) 'booking_id': bookingId,
      if (guestName != null) 'guest_name': guestName,
      if (villaName != null) 'villa_name': villaName,
      if (checkIn != null) 'check_in': checkIn,
      if (checkOut != null) 'check_out': checkOut,
      if (commissionTypeSnapshot != null)
        'commission_type_snapshot': commissionTypeSnapshot,
      if (commissionPercentSnapshot != null)
        'commission_percent_snapshot': commissionPercentSnapshot,
      if (commissionFixedSnapshot != null)
        'commission_fixed_snapshot': commissionFixedSnapshot,
      if (status != null) 'status': status,
      if (dateIssued != null) 'date_issued': dateIssued,
      if (datePaid != null) 'date_paid': datePaid,
      if (reminderSentAt != null) 'reminder_sent_at': reminderSentAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicesCompanion copyWith({
    Value<String>? id,
    Value<String>? invoiceNumber,
    Value<String>? bookingId,
    Value<String>? guestName,
    Value<String>? villaName,
    Value<DateTime>? checkIn,
    Value<DateTime>? checkOut,
    Value<String>? commissionTypeSnapshot,
    Value<double>? commissionPercentSnapshot,
    Value<int>? commissionFixedSnapshot,
    Value<String>? status,
    Value<DateTime>? dateIssued,
    Value<DateTime?>? datePaid,
    Value<DateTime?>? reminderSentAt,
    Value<int>? rowid,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      bookingId: bookingId ?? this.bookingId,
      guestName: guestName ?? this.guestName,
      villaName: villaName ?? this.villaName,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      commissionTypeSnapshot:
          commissionTypeSnapshot ?? this.commissionTypeSnapshot,
      commissionPercentSnapshot:
          commissionPercentSnapshot ?? this.commissionPercentSnapshot,
      commissionFixedSnapshot:
          commissionFixedSnapshot ?? this.commissionFixedSnapshot,
      status: status ?? this.status,
      dateIssued: dateIssued ?? this.dateIssued,
      datePaid: datePaid ?? this.datePaid,
      reminderSentAt: reminderSentAt ?? this.reminderSentAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (bookingId.present) {
      map['booking_id'] = Variable<String>(bookingId.value);
    }
    if (guestName.present) {
      map['guest_name'] = Variable<String>(guestName.value);
    }
    if (villaName.present) {
      map['villa_name'] = Variable<String>(villaName.value);
    }
    if (checkIn.present) {
      map['check_in'] = Variable<DateTime>(checkIn.value);
    }
    if (checkOut.present) {
      map['check_out'] = Variable<DateTime>(checkOut.value);
    }
    if (commissionTypeSnapshot.present) {
      map['commission_type_snapshot'] = Variable<String>(
        commissionTypeSnapshot.value,
      );
    }
    if (commissionPercentSnapshot.present) {
      map['commission_percent_snapshot'] = Variable<double>(
        commissionPercentSnapshot.value,
      );
    }
    if (commissionFixedSnapshot.present) {
      map['commission_fixed_snapshot'] = Variable<int>(
        commissionFixedSnapshot.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dateIssued.present) {
      map['date_issued'] = Variable<DateTime>(dateIssued.value);
    }
    if (datePaid.present) {
      map['date_paid'] = Variable<DateTime>(datePaid.value);
    }
    if (reminderSentAt.present) {
      map['reminder_sent_at'] = Variable<DateTime>(reminderSentAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('bookingId: $bookingId, ')
          ..write('guestName: $guestName, ')
          ..write('villaName: $villaName, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('commissionTypeSnapshot: $commissionTypeSnapshot, ')
          ..write('commissionPercentSnapshot: $commissionPercentSnapshot, ')
          ..write('commissionFixedSnapshot: $commissionFixedSnapshot, ')
          ..write('status: $status, ')
          ..write('dateIssued: $dateIssued, ')
          ..write('datePaid: $datePaid, ')
          ..write('reminderSentAt: $reminderSentAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoiceItemsTable extends InvoiceItems
    with TableInfo<$InvoiceItemsTable, InvoiceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    description,
    qty,
    price,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price'],
      )!,
    );
  }

  @override
  $InvoiceItemsTable createAlias(String alias) {
    return $InvoiceItemsTable(attachedDatabase, alias);
  }
}

class InvoiceItem extends DataClass implements Insertable<InvoiceItem> {
  final String id;
  final String invoiceId;
  final String description;
  final int qty;
  final int price;
  const InvoiceItem({
    required this.id,
    required this.invoiceId,
    required this.description,
    required this.qty,
    required this.price,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['description'] = Variable<String>(description);
    map['qty'] = Variable<int>(qty);
    map['price'] = Variable<int>(price);
    return map;
  }

  InvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      description: Value(description),
      qty: Value(qty),
      price: Value(price),
    );
  }

  factory InvoiceItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItem(
      id: serializer.fromJson<String>(json['id']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      description: serializer.fromJson<String>(json['description']),
      qty: serializer.fromJson<int>(json['qty']),
      price: serializer.fromJson<int>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'description': serializer.toJson<String>(description),
      'qty': serializer.toJson<int>(qty),
      'price': serializer.toJson<int>(price),
    };
  }

  InvoiceItem copyWith({
    String? id,
    String? invoiceId,
    String? description,
    int? qty,
    int? price,
  }) => InvoiceItem(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    description: description ?? this.description,
    qty: qty ?? this.qty,
    price: price ?? this.price,
  );
  InvoiceItem copyWithCompanion(InvoiceItemsCompanion data) {
    return InvoiceItem(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      description: data.description.present
          ? data.description.value
          : this.description,
      qty: data.qty.present ? data.qty.value : this.qty,
      price: data.price.present ? data.price.value : this.price,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItem(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('description: $description, ')
          ..write('qty: $qty, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, invoiceId, description, qty, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItem &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.description == this.description &&
          other.qty == this.qty &&
          other.price == this.price);
}

class InvoiceItemsCompanion extends UpdateCompanion<InvoiceItem> {
  final Value<String> id;
  final Value<String> invoiceId;
  final Value<String> description;
  final Value<int> qty;
  final Value<int> price;
  final Value<int> rowid;
  const InvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.description = const Value.absent(),
    this.qty = const Value.absent(),
    this.price = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoiceItemsCompanion.insert({
    required String id,
    required String invoiceId,
    required String description,
    this.qty = const Value.absent(),
    this.price = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       invoiceId = Value(invoiceId),
       description = Value(description);
  static Insertable<InvoiceItem> custom({
    Expression<String>? id,
    Expression<String>? invoiceId,
    Expression<String>? description,
    Expression<int>? qty,
    Expression<int>? price,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (description != null) 'description': description,
      if (qty != null) 'qty': qty,
      if (price != null) 'price': price,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoiceItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? invoiceId,
    Value<String>? description,
    Value<int>? qty,
    Value<int>? price,
    Value<int>? rowid,
  }) {
    return InvoiceItemsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      description: description ?? this.description,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('description: $description, ')
          ..write('qty: $qty, ')
          ..write('price: $price, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoicePaymentsTable extends InvoicePayments
    with TableInfo<$InvoicePaymentsTable, InvoicePayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicePaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _datePaidMeta = const VerificationMeta(
    'datePaid',
  );
  @override
  late final GeneratedColumn<DateTime> datePaid = GeneratedColumn<DateTime>(
    'date_paid',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Transfer Bank'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    amount,
    datePaid,
    paymentMethod,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoicePayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('date_paid')) {
      context.handle(
        _datePaidMeta,
        datePaid.isAcceptableOrUnknown(data['date_paid']!, _datePaidMeta),
      );
    } else if (isInserting) {
      context.missing(_datePaidMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoicePayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoicePayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      datePaid: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_paid'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $InvoicePaymentsTable createAlias(String alias) {
    return $InvoicePaymentsTable(attachedDatabase, alias);
  }
}

class InvoicePayment extends DataClass implements Insertable<InvoicePayment> {
  final String id;
  final String invoiceId;
  final int amount;
  final DateTime datePaid;
  final String paymentMethod;
  final String notes;
  const InvoicePayment({
    required this.id,
    required this.invoiceId,
    required this.amount,
    required this.datePaid,
    required this.paymentMethod,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['amount'] = Variable<int>(amount);
    map['date_paid'] = Variable<DateTime>(datePaid);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  InvoicePaymentsCompanion toCompanion(bool nullToAbsent) {
    return InvoicePaymentsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      amount: Value(amount),
      datePaid: Value(datePaid),
      paymentMethod: Value(paymentMethod),
      notes: Value(notes),
    );
  }

  factory InvoicePayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoicePayment(
      id: serializer.fromJson<String>(json['id']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      amount: serializer.fromJson<int>(json['amount']),
      datePaid: serializer.fromJson<DateTime>(json['datePaid']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'amount': serializer.toJson<int>(amount),
      'datePaid': serializer.toJson<DateTime>(datePaid),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'notes': serializer.toJson<String>(notes),
    };
  }

  InvoicePayment copyWith({
    String? id,
    String? invoiceId,
    int? amount,
    DateTime? datePaid,
    String? paymentMethod,
    String? notes,
  }) => InvoicePayment(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    amount: amount ?? this.amount,
    datePaid: datePaid ?? this.datePaid,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    notes: notes ?? this.notes,
  );
  InvoicePayment copyWithCompanion(InvoicePaymentsCompanion data) {
    return InvoicePayment(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      amount: data.amount.present ? data.amount.value : this.amount,
      datePaid: data.datePaid.present ? data.datePaid.value : this.datePaid,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoicePayment(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amount: $amount, ')
          ..write('datePaid: $datePaid, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, invoiceId, amount, datePaid, paymentMethod, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoicePayment &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.amount == this.amount &&
          other.datePaid == this.datePaid &&
          other.paymentMethod == this.paymentMethod &&
          other.notes == this.notes);
}

class InvoicePaymentsCompanion extends UpdateCompanion<InvoicePayment> {
  final Value<String> id;
  final Value<String> invoiceId;
  final Value<int> amount;
  final Value<DateTime> datePaid;
  final Value<String> paymentMethod;
  final Value<String> notes;
  final Value<int> rowid;
  const InvoicePaymentsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.amount = const Value.absent(),
    this.datePaid = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicePaymentsCompanion.insert({
    required String id,
    required String invoiceId,
    this.amount = const Value.absent(),
    required DateTime datePaid,
    this.paymentMethod = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       invoiceId = Value(invoiceId),
       datePaid = Value(datePaid);
  static Insertable<InvoicePayment> custom({
    Expression<String>? id,
    Expression<String>? invoiceId,
    Expression<int>? amount,
    Expression<DateTime>? datePaid,
    Expression<String>? paymentMethod,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (amount != null) 'amount': amount,
      if (datePaid != null) 'date_paid': datePaid,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicePaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? invoiceId,
    Value<int>? amount,
    Value<DateTime>? datePaid,
    Value<String>? paymentMethod,
    Value<String>? notes,
    Value<int>? rowid,
  }) {
    return InvoicePaymentsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      amount: amount ?? this.amount,
      datePaid: datePaid ?? this.datePaid,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (datePaid.present) {
      map['date_paid'] = Variable<DateTime>(datePaid.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicePaymentsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amount: $amount, ')
          ..write('datePaid: $datePaid, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('default'),
  );
  static const VerificationMeta _businessNameMeta = const VerificationMeta(
    'businessName',
  );
  @override
  late final GeneratedColumn<String> businessName = GeneratedColumn<String>(
    'business_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Villa Management & Reservations'),
  );
  static const VerificationMeta _taglineMeta = const VerificationMeta(
    'tagline',
  );
  @override
  late final GeneratedColumn<String> tagline = GeneratedColumn<String>(
    'tagline',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('GUEST FOLIO & OFFICIAL INVOICE'),
  );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _adminNameMeta = const VerificationMeta(
    'adminName',
  );
  @override
  late final GeneratedColumn<String> adminName = GeneratedColumn<String>(
    'admin_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Admin'),
  );
  static const VerificationMeta _adminContactMeta = const VerificationMeta(
    'adminContact',
  );
  @override
  late final GeneratedColumn<String> adminContact = GeneratedColumn<String>(
    'admin_contact',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bankAccountsMeta = const VerificationMeta(
    'bankAccounts',
  );
  @override
  late final GeneratedColumn<String> bankAccounts = GeneratedColumn<String>(
    'bank_accounts',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _invoiceFooterNoteMeta = const VerificationMeta(
    'invoiceFooterNote',
  );
  @override
  late final GeneratedColumn<String> invoiceFooterNote =
      GeneratedColumn<String>(
        'invoice_footer_note',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(
          'Harap simpan bukti pembayaran dan tunjukkan saat proses check-in.',
        ),
      );
  static const VerificationMeta _templateTeaserMeta = const VerificationMeta(
    'templateTeaser',
  );
  @override
  late final GeneratedColumn<String> templateTeaser = GeneratedColumn<String>(
    'template_teaser',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(
      '{nama_villa} - {lokasi}\nHarga mulai {harga_weekday}/malam\n{keunggulan}\nMau info lengkap? Chat aja ya kak 🙏',
    ),
  );
  static const VerificationMeta _templateDetailMeta = const VerificationMeta(
    'templateDetail',
  );
  @override
  late final GeneratedColumn<String> templateDetail = GeneratedColumn<String>(
    'template_detail',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(
      '*{nama_villa}*\n📍 {lokasi}\n\n{deskripsi}\n\n✨ *Keunggulan:*\n{keunggulan}\n\n🏠 *Fasilitas:*\n{fasilitas}\n\n💰 *Tarif Sewa:*\n- Weekday: {harga_weekday}/malam\n- Weekend: {harga_weekend}/malam\n- High season: {harga_high_season}/malam\n\n📋 *Aturan Menginap:*\n{aturan}\n\nInfo booking & ketersediaan:\nHubungi {nama_admin} ({kontak_admin})',
    ),
  );
  static const VerificationMeta _templateButlerNotificationMeta =
      const VerificationMeta('templateButlerNotification');
  @override
  late final GeneratedColumn<String>
  templateButlerNotification = GeneratedColumn<String>(
    'template_butler_notification',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(
      'Halo {nama_penjaga}, ada tamu yang akan check-in:\n• Villa: {nama_villa}\n• Tamu: {nama_tamu} ({kontak_tamu})\n• Jadwal: {tgl_checkin} s.d {tgl_checkout} ({jumlah_malam} malam)\nMohon dibantu persiapan villa & kunci ya. Terima kasih 🙏',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    businessName,
    tagline,
    logoPath,
    adminName,
    adminContact,
    bankAccounts,
    invoiceFooterNote,
    templateTeaser,
    templateDetail,
    templateButlerNotification,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('business_name')) {
      context.handle(
        _businessNameMeta,
        businessName.isAcceptableOrUnknown(
          data['business_name']!,
          _businessNameMeta,
        ),
      );
    }
    if (data.containsKey('tagline')) {
      context.handle(
        _taglineMeta,
        tagline.isAcceptableOrUnknown(data['tagline']!, _taglineMeta),
      );
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
      );
    }
    if (data.containsKey('admin_name')) {
      context.handle(
        _adminNameMeta,
        adminName.isAcceptableOrUnknown(data['admin_name']!, _adminNameMeta),
      );
    }
    if (data.containsKey('admin_contact')) {
      context.handle(
        _adminContactMeta,
        adminContact.isAcceptableOrUnknown(
          data['admin_contact']!,
          _adminContactMeta,
        ),
      );
    }
    if (data.containsKey('bank_accounts')) {
      context.handle(
        _bankAccountsMeta,
        bankAccounts.isAcceptableOrUnknown(
          data['bank_accounts']!,
          _bankAccountsMeta,
        ),
      );
    }
    if (data.containsKey('invoice_footer_note')) {
      context.handle(
        _invoiceFooterNoteMeta,
        invoiceFooterNote.isAcceptableOrUnknown(
          data['invoice_footer_note']!,
          _invoiceFooterNoteMeta,
        ),
      );
    }
    if (data.containsKey('template_teaser')) {
      context.handle(
        _templateTeaserMeta,
        templateTeaser.isAcceptableOrUnknown(
          data['template_teaser']!,
          _templateTeaserMeta,
        ),
      );
    }
    if (data.containsKey('template_detail')) {
      context.handle(
        _templateDetailMeta,
        templateDetail.isAcceptableOrUnknown(
          data['template_detail']!,
          _templateDetailMeta,
        ),
      );
    }
    if (data.containsKey('template_butler_notification')) {
      context.handle(
        _templateButlerNotificationMeta,
        templateButlerNotification.isAcceptableOrUnknown(
          data['template_butler_notification']!,
          _templateButlerNotificationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      businessName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_name'],
      )!,
      tagline: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tagline'],
      )!,
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      )!,
      adminName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admin_name'],
      )!,
      adminContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admin_contact'],
      )!,
      bankAccounts: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_accounts'],
      )!,
      invoiceFooterNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_footer_note'],
      )!,
      templateTeaser: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_teaser'],
      )!,
      templateDetail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_detail'],
      )!,
      templateButlerNotification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_butler_notification'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String id;
  final String businessName;
  final String tagline;
  final String logoPath;
  final String adminName;
  final String adminContact;
  final String bankAccounts;
  final String invoiceFooterNote;
  final String templateTeaser;
  final String templateDetail;
  final String templateButlerNotification;
  const AppSetting({
    required this.id,
    required this.businessName,
    required this.tagline,
    required this.logoPath,
    required this.adminName,
    required this.adminContact,
    required this.bankAccounts,
    required this.invoiceFooterNote,
    required this.templateTeaser,
    required this.templateDetail,
    required this.templateButlerNotification,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['business_name'] = Variable<String>(businessName);
    map['tagline'] = Variable<String>(tagline);
    map['logo_path'] = Variable<String>(logoPath);
    map['admin_name'] = Variable<String>(adminName);
    map['admin_contact'] = Variable<String>(adminContact);
    map['bank_accounts'] = Variable<String>(bankAccounts);
    map['invoice_footer_note'] = Variable<String>(invoiceFooterNote);
    map['template_teaser'] = Variable<String>(templateTeaser);
    map['template_detail'] = Variable<String>(templateDetail);
    map['template_butler_notification'] = Variable<String>(
      templateButlerNotification,
    );
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      businessName: Value(businessName),
      tagline: Value(tagline),
      logoPath: Value(logoPath),
      adminName: Value(adminName),
      adminContact: Value(adminContact),
      bankAccounts: Value(bankAccounts),
      invoiceFooterNote: Value(invoiceFooterNote),
      templateTeaser: Value(templateTeaser),
      templateDetail: Value(templateDetail),
      templateButlerNotification: Value(templateButlerNotification),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<String>(json['id']),
      businessName: serializer.fromJson<String>(json['businessName']),
      tagline: serializer.fromJson<String>(json['tagline']),
      logoPath: serializer.fromJson<String>(json['logoPath']),
      adminName: serializer.fromJson<String>(json['adminName']),
      adminContact: serializer.fromJson<String>(json['adminContact']),
      bankAccounts: serializer.fromJson<String>(json['bankAccounts']),
      invoiceFooterNote: serializer.fromJson<String>(json['invoiceFooterNote']),
      templateTeaser: serializer.fromJson<String>(json['templateTeaser']),
      templateDetail: serializer.fromJson<String>(json['templateDetail']),
      templateButlerNotification: serializer.fromJson<String>(
        json['templateButlerNotification'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'businessName': serializer.toJson<String>(businessName),
      'tagline': serializer.toJson<String>(tagline),
      'logoPath': serializer.toJson<String>(logoPath),
      'adminName': serializer.toJson<String>(adminName),
      'adminContact': serializer.toJson<String>(adminContact),
      'bankAccounts': serializer.toJson<String>(bankAccounts),
      'invoiceFooterNote': serializer.toJson<String>(invoiceFooterNote),
      'templateTeaser': serializer.toJson<String>(templateTeaser),
      'templateDetail': serializer.toJson<String>(templateDetail),
      'templateButlerNotification': serializer.toJson<String>(
        templateButlerNotification,
      ),
    };
  }

  AppSetting copyWith({
    String? id,
    String? businessName,
    String? tagline,
    String? logoPath,
    String? adminName,
    String? adminContact,
    String? bankAccounts,
    String? invoiceFooterNote,
    String? templateTeaser,
    String? templateDetail,
    String? templateButlerNotification,
  }) => AppSetting(
    id: id ?? this.id,
    businessName: businessName ?? this.businessName,
    tagline: tagline ?? this.tagline,
    logoPath: logoPath ?? this.logoPath,
    adminName: adminName ?? this.adminName,
    adminContact: adminContact ?? this.adminContact,
    bankAccounts: bankAccounts ?? this.bankAccounts,
    invoiceFooterNote: invoiceFooterNote ?? this.invoiceFooterNote,
    templateTeaser: templateTeaser ?? this.templateTeaser,
    templateDetail: templateDetail ?? this.templateDetail,
    templateButlerNotification:
        templateButlerNotification ?? this.templateButlerNotification,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      businessName: data.businessName.present
          ? data.businessName.value
          : this.businessName,
      tagline: data.tagline.present ? data.tagline.value : this.tagline,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      adminName: data.adminName.present ? data.adminName.value : this.adminName,
      adminContact: data.adminContact.present
          ? data.adminContact.value
          : this.adminContact,
      bankAccounts: data.bankAccounts.present
          ? data.bankAccounts.value
          : this.bankAccounts,
      invoiceFooterNote: data.invoiceFooterNote.present
          ? data.invoiceFooterNote.value
          : this.invoiceFooterNote,
      templateTeaser: data.templateTeaser.present
          ? data.templateTeaser.value
          : this.templateTeaser,
      templateDetail: data.templateDetail.present
          ? data.templateDetail.value
          : this.templateDetail,
      templateButlerNotification: data.templateButlerNotification.present
          ? data.templateButlerNotification.value
          : this.templateButlerNotification,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('businessName: $businessName, ')
          ..write('tagline: $tagline, ')
          ..write('logoPath: $logoPath, ')
          ..write('adminName: $adminName, ')
          ..write('adminContact: $adminContact, ')
          ..write('bankAccounts: $bankAccounts, ')
          ..write('invoiceFooterNote: $invoiceFooterNote, ')
          ..write('templateTeaser: $templateTeaser, ')
          ..write('templateDetail: $templateDetail, ')
          ..write('templateButlerNotification: $templateButlerNotification')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    businessName,
    tagline,
    logoPath,
    adminName,
    adminContact,
    bankAccounts,
    invoiceFooterNote,
    templateTeaser,
    templateDetail,
    templateButlerNotification,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.businessName == this.businessName &&
          other.tagline == this.tagline &&
          other.logoPath == this.logoPath &&
          other.adminName == this.adminName &&
          other.adminContact == this.adminContact &&
          other.bankAccounts == this.bankAccounts &&
          other.invoiceFooterNote == this.invoiceFooterNote &&
          other.templateTeaser == this.templateTeaser &&
          other.templateDetail == this.templateDetail &&
          other.templateButlerNotification == this.templateButlerNotification);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> id;
  final Value<String> businessName;
  final Value<String> tagline;
  final Value<String> logoPath;
  final Value<String> adminName;
  final Value<String> adminContact;
  final Value<String> bankAccounts;
  final Value<String> invoiceFooterNote;
  final Value<String> templateTeaser;
  final Value<String> templateDetail;
  final Value<String> templateButlerNotification;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.businessName = const Value.absent(),
    this.tagline = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.adminName = const Value.absent(),
    this.adminContact = const Value.absent(),
    this.bankAccounts = const Value.absent(),
    this.invoiceFooterNote = const Value.absent(),
    this.templateTeaser = const Value.absent(),
    this.templateDetail = const Value.absent(),
    this.templateButlerNotification = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.businessName = const Value.absent(),
    this.tagline = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.adminName = const Value.absent(),
    this.adminContact = const Value.absent(),
    this.bankAccounts = const Value.absent(),
    this.invoiceFooterNote = const Value.absent(),
    this.templateTeaser = const Value.absent(),
    this.templateDetail = const Value.absent(),
    this.templateButlerNotification = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<String>? id,
    Expression<String>? businessName,
    Expression<String>? tagline,
    Expression<String>? logoPath,
    Expression<String>? adminName,
    Expression<String>? adminContact,
    Expression<String>? bankAccounts,
    Expression<String>? invoiceFooterNote,
    Expression<String>? templateTeaser,
    Expression<String>? templateDetail,
    Expression<String>? templateButlerNotification,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (businessName != null) 'business_name': businessName,
      if (tagline != null) 'tagline': tagline,
      if (logoPath != null) 'logo_path': logoPath,
      if (adminName != null) 'admin_name': adminName,
      if (adminContact != null) 'admin_contact': adminContact,
      if (bankAccounts != null) 'bank_accounts': bankAccounts,
      if (invoiceFooterNote != null) 'invoice_footer_note': invoiceFooterNote,
      if (templateTeaser != null) 'template_teaser': templateTeaser,
      if (templateDetail != null) 'template_detail': templateDetail,
      if (templateButlerNotification != null)
        'template_butler_notification': templateButlerNotification,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? id,
    Value<String>? businessName,
    Value<String>? tagline,
    Value<String>? logoPath,
    Value<String>? adminName,
    Value<String>? adminContact,
    Value<String>? bankAccounts,
    Value<String>? invoiceFooterNote,
    Value<String>? templateTeaser,
    Value<String>? templateDetail,
    Value<String>? templateButlerNotification,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      tagline: tagline ?? this.tagline,
      logoPath: logoPath ?? this.logoPath,
      adminName: adminName ?? this.adminName,
      adminContact: adminContact ?? this.adminContact,
      bankAccounts: bankAccounts ?? this.bankAccounts,
      invoiceFooterNote: invoiceFooterNote ?? this.invoiceFooterNote,
      templateTeaser: templateTeaser ?? this.templateTeaser,
      templateDetail: templateDetail ?? this.templateDetail,
      templateButlerNotification:
          templateButlerNotification ?? this.templateButlerNotification,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (businessName.present) {
      map['business_name'] = Variable<String>(businessName.value);
    }
    if (tagline.present) {
      map['tagline'] = Variable<String>(tagline.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (adminName.present) {
      map['admin_name'] = Variable<String>(adminName.value);
    }
    if (adminContact.present) {
      map['admin_contact'] = Variable<String>(adminContact.value);
    }
    if (bankAccounts.present) {
      map['bank_accounts'] = Variable<String>(bankAccounts.value);
    }
    if (invoiceFooterNote.present) {
      map['invoice_footer_note'] = Variable<String>(invoiceFooterNote.value);
    }
    if (templateTeaser.present) {
      map['template_teaser'] = Variable<String>(templateTeaser.value);
    }
    if (templateDetail.present) {
      map['template_detail'] = Variable<String>(templateDetail.value);
    }
    if (templateButlerNotification.present) {
      map['template_butler_notification'] = Variable<String>(
        templateButlerNotification.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('businessName: $businessName, ')
          ..write('tagline: $tagline, ')
          ..write('logoPath: $logoPath, ')
          ..write('adminName: $adminName, ')
          ..write('adminContact: $adminContact, ')
          ..write('bankAccounts: $bankAccounts, ')
          ..write('invoiceFooterNote: $invoiceFooterNote, ')
          ..write('templateTeaser: $templateTeaser, ')
          ..write('templateDetail: $templateDetail, ')
          ..write('templateButlerNotification: $templateButlerNotification, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VillasTable villas = $VillasTable(this);
  late final $VillaPhotosTable villaPhotos = $VillaPhotosTable(this);
  late final $VillaFaqsTable villaFaqs = $VillaFaqsTable(this);
  late final $BookingsTable bookings = $BookingsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InvoiceItemsTable invoiceItems = $InvoiceItemsTable(this);
  late final $InvoicePaymentsTable invoicePayments = $InvoicePaymentsTable(
    this,
  );
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final Index villaPhotosVillaOrder = Index(
    'villa_photos_villa_order',
    'CREATE INDEX villa_photos_villa_order ON villa_photos (villa_id, sort_order)',
  );
  late final Index villaFaqsVilla = Index(
    'villa_faqs_villa',
    'CREATE INDEX villa_faqs_villa ON villa_faqs (villa_id)',
  );
  late final Index bookingsVillaDates = Index(
    'bookings_villa_dates',
    'CREATE INDEX bookings_villa_dates ON bookings (villa_id, check_in, check_out)',
  );
  late final Index bookingsStatus = Index(
    'bookings_status',
    'CREATE INDEX bookings_status ON bookings (status)',
  );
  late final Index invoicesStatusDate = Index(
    'invoices_status_date',
    'CREATE INDEX invoices_status_date ON invoices (status, date_issued)',
  );
  late final Index invoiceItemsInvoice = Index(
    'invoice_items_invoice',
    'CREATE INDEX invoice_items_invoice ON invoice_items (invoice_id)',
  );
  late final Index invoicePaymentsInvoiceDate = Index(
    'invoice_payments_invoice_date',
    'CREATE INDEX invoice_payments_invoice_date ON invoice_payments (invoice_id, date_paid)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    villas,
    villaPhotos,
    villaFaqs,
    bookings,
    invoices,
    invoiceItems,
    invoicePayments,
    appSettings,
    villaPhotosVillaOrder,
    villaFaqsVilla,
    bookingsVillaDates,
    bookingsStatus,
    invoicesStatusDate,
    invoiceItemsInvoice,
    invoicePaymentsInvoiceDate,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'villas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('villa_photos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'villas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('villa_faqs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'invoices',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoice_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'invoices',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoice_payments', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$VillasTableCreateCompanionBuilder =
    VillasCompanion Function({
      required String id,
      required String name,
      Value<String> location,
      Value<String> ownerName,
      Value<String> ownerContact,
      Value<String> ownerBank,
      Value<String> butlerName,
      Value<String> butlerContact,
      Value<bool> isButlerSameAsOwner,
      Value<bool> isActive,
      Value<String> description,
      Value<String> uniqueSellingPoints,
      Value<String> amenities,
      Value<String> houseRules,
      Value<int> priceWeekday,
      Value<int> priceWeekend,
      Value<int> priceHighSeason,
      Value<double> commissionPercent,
      Value<String> commissionType,
      Value<int> commissionFixed,
      Value<String> privateNotes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$VillasTableUpdateCompanionBuilder =
    VillasCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> location,
      Value<String> ownerName,
      Value<String> ownerContact,
      Value<String> ownerBank,
      Value<String> butlerName,
      Value<String> butlerContact,
      Value<bool> isButlerSameAsOwner,
      Value<bool> isActive,
      Value<String> description,
      Value<String> uniqueSellingPoints,
      Value<String> amenities,
      Value<String> houseRules,
      Value<int> priceWeekday,
      Value<int> priceWeekend,
      Value<int> priceHighSeason,
      Value<double> commissionPercent,
      Value<String> commissionType,
      Value<int> commissionFixed,
      Value<String> privateNotes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$VillasTableReferences
    extends BaseReferences<_$AppDatabase, $VillasTable, Villa> {
  $$VillasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VillaPhotosTable, List<VillaPhoto>>
  _villaPhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.villaPhotos,
    aliasName: 'villas__id__villa_photos__villa_id',
  );

  $$VillaPhotosTableProcessedTableManager get villaPhotosRefs {
    final manager = $$VillaPhotosTableTableManager(
      $_db,
      $_db.villaPhotos,
    ).filter((f) => f.villaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_villaPhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VillaFaqsTable, List<VillaFaq>>
  _villaFaqsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.villaFaqs,
    aliasName: 'villas__id__villa_faqs__villa_id',
  );

  $$VillaFaqsTableProcessedTableManager get villaFaqsRefs {
    final manager = $$VillaFaqsTableTableManager(
      $_db,
      $_db.villaFaqs,
    ).filter((f) => f.villaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_villaFaqsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BookingsTable, List<Booking>> _bookingsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.bookings,
    aliasName: 'villas__id__bookings__villa_id',
  );

  $$BookingsTableProcessedTableManager get bookingsRefs {
    final manager = $$BookingsTableTableManager(
      $_db,
      $_db.bookings,
    ).filter((f) => f.villaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VillasTableFilterComposer
    extends Composer<_$AppDatabase, $VillasTable> {
  $$VillasTableFilterComposer({
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

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerContact => $composableBuilder(
    column: $table.ownerContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerBank => $composableBuilder(
    column: $table.ownerBank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get butlerName => $composableBuilder(
    column: $table.butlerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get butlerContact => $composableBuilder(
    column: $table.butlerContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isButlerSameAsOwner => $composableBuilder(
    column: $table.isButlerSameAsOwner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uniqueSellingPoints => $composableBuilder(
    column: $table.uniqueSellingPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amenities => $composableBuilder(
    column: $table.amenities,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get houseRules => $composableBuilder(
    column: $table.houseRules,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceWeekday => $composableBuilder(
    column: $table.priceWeekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceWeekend => $composableBuilder(
    column: $table.priceWeekend,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priceHighSeason => $composableBuilder(
    column: $table.priceHighSeason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commissionType => $composableBuilder(
    column: $table.commissionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get commissionFixed => $composableBuilder(
    column: $table.commissionFixed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get privateNotes => $composableBuilder(
    column: $table.privateNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> villaPhotosRefs(
    Expression<bool> Function($$VillaPhotosTableFilterComposer f) f,
  ) {
    final $$VillaPhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.villaPhotos,
      getReferencedColumn: (t) => t.villaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillaPhotosTableFilterComposer(
            $db: $db,
            $table: $db.villaPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> villaFaqsRefs(
    Expression<bool> Function($$VillaFaqsTableFilterComposer f) f,
  ) {
    final $$VillaFaqsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.villaFaqs,
      getReferencedColumn: (t) => t.villaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillaFaqsTableFilterComposer(
            $db: $db,
            $table: $db.villaFaqs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bookingsRefs(
    Expression<bool> Function($$BookingsTableFilterComposer f) f,
  ) {
    final $$BookingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.villaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableFilterComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VillasTableOrderingComposer
    extends Composer<_$AppDatabase, $VillasTable> {
  $$VillasTableOrderingComposer({
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

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerContact => $composableBuilder(
    column: $table.ownerContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerBank => $composableBuilder(
    column: $table.ownerBank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get butlerName => $composableBuilder(
    column: $table.butlerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get butlerContact => $composableBuilder(
    column: $table.butlerContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isButlerSameAsOwner => $composableBuilder(
    column: $table.isButlerSameAsOwner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uniqueSellingPoints => $composableBuilder(
    column: $table.uniqueSellingPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amenities => $composableBuilder(
    column: $table.amenities,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get houseRules => $composableBuilder(
    column: $table.houseRules,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceWeekday => $composableBuilder(
    column: $table.priceWeekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceWeekend => $composableBuilder(
    column: $table.priceWeekend,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priceHighSeason => $composableBuilder(
    column: $table.priceHighSeason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commissionType => $composableBuilder(
    column: $table.commissionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get commissionFixed => $composableBuilder(
    column: $table.commissionFixed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get privateNotes => $composableBuilder(
    column: $table.privateNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VillasTableAnnotationComposer
    extends Composer<_$AppDatabase, $VillasTable> {
  $$VillasTableAnnotationComposer({
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

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get ownerContact => $composableBuilder(
    column: $table.ownerContact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ownerBank =>
      $composableBuilder(column: $table.ownerBank, builder: (column) => column);

  GeneratedColumn<String> get butlerName => $composableBuilder(
    column: $table.butlerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get butlerContact => $composableBuilder(
    column: $table.butlerContact,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isButlerSameAsOwner => $composableBuilder(
    column: $table.isButlerSameAsOwner,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get uniqueSellingPoints => $composableBuilder(
    column: $table.uniqueSellingPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get amenities =>
      $composableBuilder(column: $table.amenities, builder: (column) => column);

  GeneratedColumn<String> get houseRules => $composableBuilder(
    column: $table.houseRules,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priceWeekday => $composableBuilder(
    column: $table.priceWeekday,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priceWeekend => $composableBuilder(
    column: $table.priceWeekend,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priceHighSeason => $composableBuilder(
    column: $table.priceHighSeason,
    builder: (column) => column,
  );

  GeneratedColumn<double> get commissionPercent => $composableBuilder(
    column: $table.commissionPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get commissionType => $composableBuilder(
    column: $table.commissionType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get commissionFixed => $composableBuilder(
    column: $table.commissionFixed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get privateNotes => $composableBuilder(
    column: $table.privateNotes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> villaPhotosRefs<T extends Object>(
    Expression<T> Function($$VillaPhotosTableAnnotationComposer a) f,
  ) {
    final $$VillaPhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.villaPhotos,
      getReferencedColumn: (t) => t.villaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillaPhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.villaPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> villaFaqsRefs<T extends Object>(
    Expression<T> Function($$VillaFaqsTableAnnotationComposer a) f,
  ) {
    final $$VillaFaqsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.villaFaqs,
      getReferencedColumn: (t) => t.villaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillaFaqsTableAnnotationComposer(
            $db: $db,
            $table: $db.villaFaqs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> bookingsRefs<T extends Object>(
    Expression<T> Function($$BookingsTableAnnotationComposer a) f,
  ) {
    final $$BookingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.villaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableAnnotationComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VillasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VillasTable,
          Villa,
          $$VillasTableFilterComposer,
          $$VillasTableOrderingComposer,
          $$VillasTableAnnotationComposer,
          $$VillasTableCreateCompanionBuilder,
          $$VillasTableUpdateCompanionBuilder,
          (Villa, $$VillasTableReferences),
          Villa,
          PrefetchHooks Function({
            bool villaPhotosRefs,
            bool villaFaqsRefs,
            bool bookingsRefs,
          })
        > {
  $$VillasTableTableManager(_$AppDatabase db, $VillasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VillasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VillasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VillasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> ownerName = const Value.absent(),
                Value<String> ownerContact = const Value.absent(),
                Value<String> ownerBank = const Value.absent(),
                Value<String> butlerName = const Value.absent(),
                Value<String> butlerContact = const Value.absent(),
                Value<bool> isButlerSameAsOwner = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> uniqueSellingPoints = const Value.absent(),
                Value<String> amenities = const Value.absent(),
                Value<String> houseRules = const Value.absent(),
                Value<int> priceWeekday = const Value.absent(),
                Value<int> priceWeekend = const Value.absent(),
                Value<int> priceHighSeason = const Value.absent(),
                Value<double> commissionPercent = const Value.absent(),
                Value<String> commissionType = const Value.absent(),
                Value<int> commissionFixed = const Value.absent(),
                Value<String> privateNotes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VillasCompanion(
                id: id,
                name: name,
                location: location,
                ownerName: ownerName,
                ownerContact: ownerContact,
                ownerBank: ownerBank,
                butlerName: butlerName,
                butlerContact: butlerContact,
                isButlerSameAsOwner: isButlerSameAsOwner,
                isActive: isActive,
                description: description,
                uniqueSellingPoints: uniqueSellingPoints,
                amenities: amenities,
                houseRules: houseRules,
                priceWeekday: priceWeekday,
                priceWeekend: priceWeekend,
                priceHighSeason: priceHighSeason,
                commissionPercent: commissionPercent,
                commissionType: commissionType,
                commissionFixed: commissionFixed,
                privateNotes: privateNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> location = const Value.absent(),
                Value<String> ownerName = const Value.absent(),
                Value<String> ownerContact = const Value.absent(),
                Value<String> ownerBank = const Value.absent(),
                Value<String> butlerName = const Value.absent(),
                Value<String> butlerContact = const Value.absent(),
                Value<bool> isButlerSameAsOwner = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> uniqueSellingPoints = const Value.absent(),
                Value<String> amenities = const Value.absent(),
                Value<String> houseRules = const Value.absent(),
                Value<int> priceWeekday = const Value.absent(),
                Value<int> priceWeekend = const Value.absent(),
                Value<int> priceHighSeason = const Value.absent(),
                Value<double> commissionPercent = const Value.absent(),
                Value<String> commissionType = const Value.absent(),
                Value<int> commissionFixed = const Value.absent(),
                Value<String> privateNotes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => VillasCompanion.insert(
                id: id,
                name: name,
                location: location,
                ownerName: ownerName,
                ownerContact: ownerContact,
                ownerBank: ownerBank,
                butlerName: butlerName,
                butlerContact: butlerContact,
                isButlerSameAsOwner: isButlerSameAsOwner,
                isActive: isActive,
                description: description,
                uniqueSellingPoints: uniqueSellingPoints,
                amenities: amenities,
                houseRules: houseRules,
                priceWeekday: priceWeekday,
                priceWeekend: priceWeekend,
                priceHighSeason: priceHighSeason,
                commissionPercent: commissionPercent,
                commissionType: commissionType,
                commissionFixed: commissionFixed,
                privateNotes: privateNotes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$VillasTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                villaPhotosRefs = false,
                villaFaqsRefs = false,
                bookingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (villaPhotosRefs) db.villaPhotos,
                    if (villaFaqsRefs) db.villaFaqs,
                    if (bookingsRefs) db.bookings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (villaPhotosRefs)
                        await $_getPrefetchedData<
                          Villa,
                          $VillasTable,
                          VillaPhoto
                        >(
                          currentTable: table,
                          referencedTable: $$VillasTableReferences
                              ._villaPhotosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VillasTableReferences(
                                db,
                                table,
                                p0,
                              ).villaPhotosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.villaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (villaFaqsRefs)
                        await $_getPrefetchedData<
                          Villa,
                          $VillasTable,
                          VillaFaq
                        >(
                          currentTable: table,
                          referencedTable: $$VillasTableReferences
                              ._villaFaqsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VillasTableReferences(
                                db,
                                table,
                                p0,
                              ).villaFaqsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.villaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (bookingsRefs)
                        await $_getPrefetchedData<Villa, $VillasTable, Booking>(
                          currentTable: table,
                          referencedTable: $$VillasTableReferences
                              ._bookingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VillasTableReferences(
                                db,
                                table,
                                p0,
                              ).bookingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.villaId == item.id,
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

typedef $$VillasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VillasTable,
      Villa,
      $$VillasTableFilterComposer,
      $$VillasTableOrderingComposer,
      $$VillasTableAnnotationComposer,
      $$VillasTableCreateCompanionBuilder,
      $$VillasTableUpdateCompanionBuilder,
      (Villa, $$VillasTableReferences),
      Villa,
      PrefetchHooks Function({
        bool villaPhotosRefs,
        bool villaFaqsRefs,
        bool bookingsRefs,
      })
    >;
typedef $$VillaPhotosTableCreateCompanionBuilder =
    VillaPhotosCompanion Function({
      required String id,
      required String villaId,
      required String filePath,
      Value<String> mediaType,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$VillaPhotosTableUpdateCompanionBuilder =
    VillaPhotosCompanion Function({
      Value<String> id,
      Value<String> villaId,
      Value<String> filePath,
      Value<String> mediaType,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$VillaPhotosTableReferences
    extends BaseReferences<_$AppDatabase, $VillaPhotosTable, VillaPhoto> {
  $$VillaPhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VillasTable _villaIdTable(_$AppDatabase db) =>
      db.villas.createAlias('villa_photos__villa_id__villas__id');

  $$VillasTableProcessedTableManager get villaId {
    final $_column = $_itemColumn<String>('villa_id')!;

    final manager = $$VillasTableTableManager(
      $_db,
      $_db.villas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_villaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VillaPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $VillaPhotosTable> {
  $$VillaPhotosTableFilterComposer({
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

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$VillasTableFilterComposer get villaId {
    final $$VillasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villaId,
      referencedTable: $db.villas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillasTableFilterComposer(
            $db: $db,
            $table: $db.villas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VillaPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $VillaPhotosTable> {
  $$VillaPhotosTableOrderingComposer({
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

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$VillasTableOrderingComposer get villaId {
    final $$VillasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villaId,
      referencedTable: $db.villas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillasTableOrderingComposer(
            $db: $db,
            $table: $db.villas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VillaPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $VillaPhotosTable> {
  $$VillaPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$VillasTableAnnotationComposer get villaId {
    final $$VillasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villaId,
      referencedTable: $db.villas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillasTableAnnotationComposer(
            $db: $db,
            $table: $db.villas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VillaPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VillaPhotosTable,
          VillaPhoto,
          $$VillaPhotosTableFilterComposer,
          $$VillaPhotosTableOrderingComposer,
          $$VillaPhotosTableAnnotationComposer,
          $$VillaPhotosTableCreateCompanionBuilder,
          $$VillaPhotosTableUpdateCompanionBuilder,
          (VillaPhoto, $$VillaPhotosTableReferences),
          VillaPhoto,
          PrefetchHooks Function({bool villaId})
        > {
  $$VillaPhotosTableTableManager(_$AppDatabase db, $VillaPhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VillaPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VillaPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VillaPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> villaId = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> mediaType = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VillaPhotosCompanion(
                id: id,
                villaId: villaId,
                filePath: filePath,
                mediaType: mediaType,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String villaId,
                required String filePath,
                Value<String> mediaType = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VillaPhotosCompanion.insert(
                id: id,
                villaId: villaId,
                filePath: filePath,
                mediaType: mediaType,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VillaPhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({villaId = false}) {
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
                    if (villaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.villaId,
                                referencedTable: $$VillaPhotosTableReferences
                                    ._villaIdTable(db),
                                referencedColumn: $$VillaPhotosTableReferences
                                    ._villaIdTable(db)
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

typedef $$VillaPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VillaPhotosTable,
      VillaPhoto,
      $$VillaPhotosTableFilterComposer,
      $$VillaPhotosTableOrderingComposer,
      $$VillaPhotosTableAnnotationComposer,
      $$VillaPhotosTableCreateCompanionBuilder,
      $$VillaPhotosTableUpdateCompanionBuilder,
      (VillaPhoto, $$VillaPhotosTableReferences),
      VillaPhoto,
      PrefetchHooks Function({bool villaId})
    >;
typedef $$VillaFaqsTableCreateCompanionBuilder =
    VillaFaqsCompanion Function({
      required String id,
      required String villaId,
      required String question,
      required String answer,
      Value<int> rowid,
    });
typedef $$VillaFaqsTableUpdateCompanionBuilder =
    VillaFaqsCompanion Function({
      Value<String> id,
      Value<String> villaId,
      Value<String> question,
      Value<String> answer,
      Value<int> rowid,
    });

final class $$VillaFaqsTableReferences
    extends BaseReferences<_$AppDatabase, $VillaFaqsTable, VillaFaq> {
  $$VillaFaqsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VillasTable _villaIdTable(_$AppDatabase db) =>
      db.villas.createAlias('villa_faqs__villa_id__villas__id');

  $$VillasTableProcessedTableManager get villaId {
    final $_column = $_itemColumn<String>('villa_id')!;

    final manager = $$VillasTableTableManager(
      $_db,
      $_db.villas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_villaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VillaFaqsTableFilterComposer
    extends Composer<_$AppDatabase, $VillaFaqsTable> {
  $$VillaFaqsTableFilterComposer({
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

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnFilters(column),
  );

  $$VillasTableFilterComposer get villaId {
    final $$VillasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villaId,
      referencedTable: $db.villas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillasTableFilterComposer(
            $db: $db,
            $table: $db.villas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VillaFaqsTableOrderingComposer
    extends Composer<_$AppDatabase, $VillaFaqsTable> {
  $$VillaFaqsTableOrderingComposer({
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

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnOrderings(column),
  );

  $$VillasTableOrderingComposer get villaId {
    final $$VillasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villaId,
      referencedTable: $db.villas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillasTableOrderingComposer(
            $db: $db,
            $table: $db.villas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VillaFaqsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VillaFaqsTable> {
  $$VillaFaqsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  $$VillasTableAnnotationComposer get villaId {
    final $$VillasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villaId,
      referencedTable: $db.villas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillasTableAnnotationComposer(
            $db: $db,
            $table: $db.villas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VillaFaqsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VillaFaqsTable,
          VillaFaq,
          $$VillaFaqsTableFilterComposer,
          $$VillaFaqsTableOrderingComposer,
          $$VillaFaqsTableAnnotationComposer,
          $$VillaFaqsTableCreateCompanionBuilder,
          $$VillaFaqsTableUpdateCompanionBuilder,
          (VillaFaq, $$VillaFaqsTableReferences),
          VillaFaq,
          PrefetchHooks Function({bool villaId})
        > {
  $$VillaFaqsTableTableManager(_$AppDatabase db, $VillaFaqsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VillaFaqsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VillaFaqsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VillaFaqsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> villaId = const Value.absent(),
                Value<String> question = const Value.absent(),
                Value<String> answer = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VillaFaqsCompanion(
                id: id,
                villaId: villaId,
                question: question,
                answer: answer,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String villaId,
                required String question,
                required String answer,
                Value<int> rowid = const Value.absent(),
              }) => VillaFaqsCompanion.insert(
                id: id,
                villaId: villaId,
                question: question,
                answer: answer,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VillaFaqsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({villaId = false}) {
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
                    if (villaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.villaId,
                                referencedTable: $$VillaFaqsTableReferences
                                    ._villaIdTable(db),
                                referencedColumn: $$VillaFaqsTableReferences
                                    ._villaIdTable(db)
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

typedef $$VillaFaqsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VillaFaqsTable,
      VillaFaq,
      $$VillaFaqsTableFilterComposer,
      $$VillaFaqsTableOrderingComposer,
      $$VillaFaqsTableAnnotationComposer,
      $$VillaFaqsTableCreateCompanionBuilder,
      $$VillaFaqsTableUpdateCompanionBuilder,
      (VillaFaq, $$VillaFaqsTableReferences),
      VillaFaq,
      PrefetchHooks Function({bool villaId})
    >;
typedef $$BookingsTableCreateCompanionBuilder =
    BookingsCompanion Function({
      required String id,
      required String villaId,
      required String guestName,
      Value<String> guestContact,
      required DateTime checkIn,
      required DateTime checkOut,
      Value<int> pricePerNightSnapshot,
      Value<String> commissionTypeSnapshot,
      Value<double> commissionPercentSnapshot,
      Value<int> commissionFixedSnapshot,
      Value<String> status,
      Value<String> notes,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$BookingsTableUpdateCompanionBuilder =
    BookingsCompanion Function({
      Value<String> id,
      Value<String> villaId,
      Value<String> guestName,
      Value<String> guestContact,
      Value<DateTime> checkIn,
      Value<DateTime> checkOut,
      Value<int> pricePerNightSnapshot,
      Value<String> commissionTypeSnapshot,
      Value<double> commissionPercentSnapshot,
      Value<int> commissionFixedSnapshot,
      Value<String> status,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$BookingsTableReferences
    extends BaseReferences<_$AppDatabase, $BookingsTable, Booking> {
  $$BookingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VillasTable _villaIdTable(_$AppDatabase db) =>
      db.villas.createAlias('bookings__villa_id__villas__id');

  $$VillasTableProcessedTableManager get villaId {
    final $_column = $_itemColumn<String>('villa_id')!;

    final manager = $$VillasTableTableManager(
      $_db,
      $_db.villas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_villaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'bookings__id__invoices__booking_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.bookingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BookingsTableFilterComposer
    extends Composer<_$AppDatabase, $BookingsTable> {
  $$BookingsTableFilterComposer({
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

  ColumnFilters<String> get guestName => $composableBuilder(
    column: $table.guestName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get guestContact => $composableBuilder(
    column: $table.guestContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkIn => $composableBuilder(
    column: $table.checkIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkOut => $composableBuilder(
    column: $table.checkOut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pricePerNightSnapshot => $composableBuilder(
    column: $table.pricePerNightSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commissionTypeSnapshot => $composableBuilder(
    column: $table.commissionTypeSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commissionPercentSnapshot => $composableBuilder(
    column: $table.commissionPercentSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get commissionFixedSnapshot => $composableBuilder(
    column: $table.commissionFixedSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VillasTableFilterComposer get villaId {
    final $$VillasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villaId,
      referencedTable: $db.villas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillasTableFilterComposer(
            $db: $db,
            $table: $db.villas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.bookingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BookingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BookingsTable> {
  $$BookingsTableOrderingComposer({
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

  ColumnOrderings<String> get guestName => $composableBuilder(
    column: $table.guestName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get guestContact => $composableBuilder(
    column: $table.guestContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkIn => $composableBuilder(
    column: $table.checkIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkOut => $composableBuilder(
    column: $table.checkOut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pricePerNightSnapshot => $composableBuilder(
    column: $table.pricePerNightSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commissionTypeSnapshot => $composableBuilder(
    column: $table.commissionTypeSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commissionPercentSnapshot => $composableBuilder(
    column: $table.commissionPercentSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get commissionFixedSnapshot => $composableBuilder(
    column: $table.commissionFixedSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VillasTableOrderingComposer get villaId {
    final $$VillasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villaId,
      referencedTable: $db.villas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillasTableOrderingComposer(
            $db: $db,
            $table: $db.villas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookingsTable> {
  $$BookingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get guestName =>
      $composableBuilder(column: $table.guestName, builder: (column) => column);

  GeneratedColumn<String> get guestContact => $composableBuilder(
    column: $table.guestContact,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get checkIn =>
      $composableBuilder(column: $table.checkIn, builder: (column) => column);

  GeneratedColumn<DateTime> get checkOut =>
      $composableBuilder(column: $table.checkOut, builder: (column) => column);

  GeneratedColumn<int> get pricePerNightSnapshot => $composableBuilder(
    column: $table.pricePerNightSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get commissionTypeSnapshot => $composableBuilder(
    column: $table.commissionTypeSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<double> get commissionPercentSnapshot => $composableBuilder(
    column: $table.commissionPercentSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<int> get commissionFixedSnapshot => $composableBuilder(
    column: $table.commissionFixedSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VillasTableAnnotationComposer get villaId {
    final $$VillasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.villaId,
      referencedTable: $db.villas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VillasTableAnnotationComposer(
            $db: $db,
            $table: $db.villas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.bookingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BookingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookingsTable,
          Booking,
          $$BookingsTableFilterComposer,
          $$BookingsTableOrderingComposer,
          $$BookingsTableAnnotationComposer,
          $$BookingsTableCreateCompanionBuilder,
          $$BookingsTableUpdateCompanionBuilder,
          (Booking, $$BookingsTableReferences),
          Booking,
          PrefetchHooks Function({bool villaId, bool invoicesRefs})
        > {
  $$BookingsTableTableManager(_$AppDatabase db, $BookingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> villaId = const Value.absent(),
                Value<String> guestName = const Value.absent(),
                Value<String> guestContact = const Value.absent(),
                Value<DateTime> checkIn = const Value.absent(),
                Value<DateTime> checkOut = const Value.absent(),
                Value<int> pricePerNightSnapshot = const Value.absent(),
                Value<String> commissionTypeSnapshot = const Value.absent(),
                Value<double> commissionPercentSnapshot = const Value.absent(),
                Value<int> commissionFixedSnapshot = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookingsCompanion(
                id: id,
                villaId: villaId,
                guestName: guestName,
                guestContact: guestContact,
                checkIn: checkIn,
                checkOut: checkOut,
                pricePerNightSnapshot: pricePerNightSnapshot,
                commissionTypeSnapshot: commissionTypeSnapshot,
                commissionPercentSnapshot: commissionPercentSnapshot,
                commissionFixedSnapshot: commissionFixedSnapshot,
                status: status,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String villaId,
                required String guestName,
                Value<String> guestContact = const Value.absent(),
                required DateTime checkIn,
                required DateTime checkOut,
                Value<int> pricePerNightSnapshot = const Value.absent(),
                Value<String> commissionTypeSnapshot = const Value.absent(),
                Value<double> commissionPercentSnapshot = const Value.absent(),
                Value<int> commissionFixedSnapshot = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> notes = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => BookingsCompanion.insert(
                id: id,
                villaId: villaId,
                guestName: guestName,
                guestContact: guestContact,
                checkIn: checkIn,
                checkOut: checkOut,
                pricePerNightSnapshot: pricePerNightSnapshot,
                commissionTypeSnapshot: commissionTypeSnapshot,
                commissionPercentSnapshot: commissionPercentSnapshot,
                commissionFixedSnapshot: commissionFixedSnapshot,
                status: status,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({villaId = false, invoicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (invoicesRefs) db.invoices],
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
                    if (villaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.villaId,
                                referencedTable: $$BookingsTableReferences
                                    ._villaIdTable(db),
                                referencedColumn: $$BookingsTableReferences
                                    ._villaIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (invoicesRefs)
                    await $_getPrefetchedData<Booking, $BookingsTable, Invoice>(
                      currentTable: table,
                      referencedTable: $$BookingsTableReferences
                          ._invoicesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BookingsTableReferences(db, table, p0).invoicesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.bookingId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BookingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookingsTable,
      Booking,
      $$BookingsTableFilterComposer,
      $$BookingsTableOrderingComposer,
      $$BookingsTableAnnotationComposer,
      $$BookingsTableCreateCompanionBuilder,
      $$BookingsTableUpdateCompanionBuilder,
      (Booking, $$BookingsTableReferences),
      Booking,
      PrefetchHooks Function({bool villaId, bool invoicesRefs})
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      required String id,
      required String invoiceNumber,
      required String bookingId,
      required String guestName,
      required String villaName,
      required DateTime checkIn,
      required DateTime checkOut,
      Value<String> commissionTypeSnapshot,
      Value<double> commissionPercentSnapshot,
      Value<int> commissionFixedSnapshot,
      Value<String> status,
      required DateTime dateIssued,
      Value<DateTime?> datePaid,
      Value<DateTime?> reminderSentAt,
      Value<int> rowid,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<String> id,
      Value<String> invoiceNumber,
      Value<String> bookingId,
      Value<String> guestName,
      Value<String> villaName,
      Value<DateTime> checkIn,
      Value<DateTime> checkOut,
      Value<String> commissionTypeSnapshot,
      Value<double> commissionPercentSnapshot,
      Value<int> commissionFixedSnapshot,
      Value<String> status,
      Value<DateTime> dateIssued,
      Value<DateTime?> datePaid,
      Value<DateTime?> reminderSentAt,
      Value<int> rowid,
    });

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BookingsTable _bookingIdTable(_$AppDatabase db) =>
      db.bookings.createAlias('invoices__booking_id__bookings__id');

  $$BookingsTableProcessedTableManager get bookingId {
    final $_column = $_itemColumn<String>('booking_id')!;

    final manager = $$BookingsTableTableManager(
      $_db,
      $_db.bookings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoiceItemsTable, List<InvoiceItem>>
  _invoiceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceItems,
    aliasName: 'invoices__id__invoice_items__invoice_id',
  );

  $$InvoiceItemsTableProcessedTableManager get invoiceItemsRefs {
    final manager = $$InvoiceItemsTableTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicePaymentsTable, List<InvoicePayment>>
  _invoicePaymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoicePayments,
    aliasName: 'invoices__id__invoice_payments__invoice_id',
  );

  $$InvoicePaymentsTableProcessedTableManager get invoicePaymentsRefs {
    final manager = $$InvoicePaymentsTableTableManager(
      $_db,
      $_db.invoicePayments,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _invoicePaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
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

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get guestName => $composableBuilder(
    column: $table.guestName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get villaName => $composableBuilder(
    column: $table.villaName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkIn => $composableBuilder(
    column: $table.checkIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkOut => $composableBuilder(
    column: $table.checkOut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commissionTypeSnapshot => $composableBuilder(
    column: $table.commissionTypeSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get commissionPercentSnapshot => $composableBuilder(
    column: $table.commissionPercentSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get commissionFixedSnapshot => $composableBuilder(
    column: $table.commissionFixedSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateIssued => $composableBuilder(
    column: $table.dateIssued,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get datePaid => $composableBuilder(
    column: $table.datePaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reminderSentAt => $composableBuilder(
    column: $table.reminderSentAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BookingsTableFilterComposer get bookingId {
    final $$BookingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookingId,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableFilterComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoiceItemsRefs(
    Expression<bool> Function($$InvoiceItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicePaymentsRefs(
    Expression<bool> Function($$InvoicePaymentsTableFilterComposer f) f,
  ) {
    final $$InvoicePaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoicePayments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicePaymentsTableFilterComposer(
            $db: $db,
            $table: $db.invoicePayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
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

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get guestName => $composableBuilder(
    column: $table.guestName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get villaName => $composableBuilder(
    column: $table.villaName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkIn => $composableBuilder(
    column: $table.checkIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkOut => $composableBuilder(
    column: $table.checkOut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commissionTypeSnapshot => $composableBuilder(
    column: $table.commissionTypeSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get commissionPercentSnapshot => $composableBuilder(
    column: $table.commissionPercentSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get commissionFixedSnapshot => $composableBuilder(
    column: $table.commissionFixedSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateIssued => $composableBuilder(
    column: $table.dateIssued,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get datePaid => $composableBuilder(
    column: $table.datePaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reminderSentAt => $composableBuilder(
    column: $table.reminderSentAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BookingsTableOrderingComposer get bookingId {
    final $$BookingsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookingId,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableOrderingComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get guestName =>
      $composableBuilder(column: $table.guestName, builder: (column) => column);

  GeneratedColumn<String> get villaName =>
      $composableBuilder(column: $table.villaName, builder: (column) => column);

  GeneratedColumn<DateTime> get checkIn =>
      $composableBuilder(column: $table.checkIn, builder: (column) => column);

  GeneratedColumn<DateTime> get checkOut =>
      $composableBuilder(column: $table.checkOut, builder: (column) => column);

  GeneratedColumn<String> get commissionTypeSnapshot => $composableBuilder(
    column: $table.commissionTypeSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<double> get commissionPercentSnapshot => $composableBuilder(
    column: $table.commissionPercentSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<int> get commissionFixedSnapshot => $composableBuilder(
    column: $table.commissionFixedSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get dateIssued => $composableBuilder(
    column: $table.dateIssued,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get datePaid =>
      $composableBuilder(column: $table.datePaid, builder: (column) => column);

  GeneratedColumn<DateTime> get reminderSentAt => $composableBuilder(
    column: $table.reminderSentAt,
    builder: (column) => column,
  );

  $$BookingsTableAnnotationComposer get bookingId {
    final $$BookingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookingId,
      referencedTable: $db.bookings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookingsTableAnnotationComposer(
            $db: $db,
            $table: $db.bookings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoiceItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicePaymentsRefs<T extends Object>(
    Expression<T> Function($$InvoicePaymentsTableAnnotationComposer a) f,
  ) {
    final $$InvoicePaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoicePayments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicePaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoicePayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, $$InvoicesTableReferences),
          Invoice,
          PrefetchHooks Function({
            bool bookingId,
            bool invoiceItemsRefs,
            bool invoicePaymentsRefs,
          })
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<String> bookingId = const Value.absent(),
                Value<String> guestName = const Value.absent(),
                Value<String> villaName = const Value.absent(),
                Value<DateTime> checkIn = const Value.absent(),
                Value<DateTime> checkOut = const Value.absent(),
                Value<String> commissionTypeSnapshot = const Value.absent(),
                Value<double> commissionPercentSnapshot = const Value.absent(),
                Value<int> commissionFixedSnapshot = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> dateIssued = const Value.absent(),
                Value<DateTime?> datePaid = const Value.absent(),
                Value<DateTime?> reminderSentAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                invoiceNumber: invoiceNumber,
                bookingId: bookingId,
                guestName: guestName,
                villaName: villaName,
                checkIn: checkIn,
                checkOut: checkOut,
                commissionTypeSnapshot: commissionTypeSnapshot,
                commissionPercentSnapshot: commissionPercentSnapshot,
                commissionFixedSnapshot: commissionFixedSnapshot,
                status: status,
                dateIssued: dateIssued,
                datePaid: datePaid,
                reminderSentAt: reminderSentAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String invoiceNumber,
                required String bookingId,
                required String guestName,
                required String villaName,
                required DateTime checkIn,
                required DateTime checkOut,
                Value<String> commissionTypeSnapshot = const Value.absent(),
                Value<double> commissionPercentSnapshot = const Value.absent(),
                Value<int> commissionFixedSnapshot = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime dateIssued,
                Value<DateTime?> datePaid = const Value.absent(),
                Value<DateTime?> reminderSentAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                invoiceNumber: invoiceNumber,
                bookingId: bookingId,
                guestName: guestName,
                villaName: villaName,
                checkIn: checkIn,
                checkOut: checkOut,
                commissionTypeSnapshot: commissionTypeSnapshot,
                commissionPercentSnapshot: commissionPercentSnapshot,
                commissionFixedSnapshot: commissionFixedSnapshot,
                status: status,
                dateIssued: dateIssued,
                datePaid: datePaid,
                reminderSentAt: reminderSentAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                bookingId = false,
                invoiceItemsRefs = false,
                invoicePaymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceItemsRefs) db.invoiceItems,
                    if (invoicePaymentsRefs) db.invoicePayments,
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
                        if (bookingId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.bookingId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._bookingIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._bookingIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceItemsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          InvoiceItem
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._invoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicePaymentsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          InvoicePayment
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._invoicePaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicePaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
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

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, $$InvoicesTableReferences),
      Invoice,
      PrefetchHooks Function({
        bool bookingId,
        bool invoiceItemsRefs,
        bool invoicePaymentsRefs,
      })
    >;
typedef $$InvoiceItemsTableCreateCompanionBuilder =
    InvoiceItemsCompanion Function({
      required String id,
      required String invoiceId,
      required String description,
      Value<int> qty,
      Value<int> price,
      Value<int> rowid,
    });
typedef $$InvoiceItemsTableUpdateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<String> id,
      Value<String> invoiceId,
      Value<String> description,
      Value<int> qty,
      Value<int> price,
      Value<int> rowid,
    });

final class $$InvoiceItemsTableReferences
    extends BaseReferences<_$AppDatabase, $InvoiceItemsTable, InvoiceItem> {
  $$InvoiceItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('invoice_items__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceItemsTable,
          InvoiceItem,
          $$InvoiceItemsTableFilterComposer,
          $$InvoiceItemsTableOrderingComposer,
          $$InvoiceItemsTableAnnotationComposer,
          $$InvoiceItemsTableCreateCompanionBuilder,
          $$InvoiceItemsTableUpdateCompanionBuilder,
          (InvoiceItem, $$InvoiceItemsTableReferences),
          InvoiceItem,
          PrefetchHooks Function({bool invoiceId})
        > {
  $$InvoiceItemsTableTableManager(_$AppDatabase db, $InvoiceItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> price = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoiceItemsCompanion(
                id: id,
                invoiceId: invoiceId,
                description: description,
                qty: qty,
                price: price,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String invoiceId,
                required String description,
                Value<int> qty = const Value.absent(),
                Value<int> price = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoiceItemsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                description: description,
                qty: qty,
                price: price,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoiceItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
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
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $$InvoiceItemsTableReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $$InvoiceItemsTableReferences
                                    ._invoiceIdTable(db)
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

typedef $$InvoiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceItemsTable,
      InvoiceItem,
      $$InvoiceItemsTableFilterComposer,
      $$InvoiceItemsTableOrderingComposer,
      $$InvoiceItemsTableAnnotationComposer,
      $$InvoiceItemsTableCreateCompanionBuilder,
      $$InvoiceItemsTableUpdateCompanionBuilder,
      (InvoiceItem, $$InvoiceItemsTableReferences),
      InvoiceItem,
      PrefetchHooks Function({bool invoiceId})
    >;
typedef $$InvoicePaymentsTableCreateCompanionBuilder =
    InvoicePaymentsCompanion Function({
      required String id,
      required String invoiceId,
      Value<int> amount,
      required DateTime datePaid,
      Value<String> paymentMethod,
      Value<String> notes,
      Value<int> rowid,
    });
typedef $$InvoicePaymentsTableUpdateCompanionBuilder =
    InvoicePaymentsCompanion Function({
      Value<String> id,
      Value<String> invoiceId,
      Value<int> amount,
      Value<DateTime> datePaid,
      Value<String> paymentMethod,
      Value<String> notes,
      Value<int> rowid,
    });

final class $$InvoicePaymentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $InvoicePaymentsTable, InvoicePayment> {
  $$InvoicePaymentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('invoice_payments__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvoicePaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicePaymentsTable> {
  $$InvoicePaymentsTableFilterComposer({
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

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get datePaid => $composableBuilder(
    column: $table.datePaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicePaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicePaymentsTable> {
  $$InvoicePaymentsTableOrderingComposer({
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

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get datePaid => $composableBuilder(
    column: $table.datePaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicePaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicePaymentsTable> {
  $$InvoicePaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get datePaid =>
      $composableBuilder(column: $table.datePaid, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicePaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicePaymentsTable,
          InvoicePayment,
          $$InvoicePaymentsTableFilterComposer,
          $$InvoicePaymentsTableOrderingComposer,
          $$InvoicePaymentsTableAnnotationComposer,
          $$InvoicePaymentsTableCreateCompanionBuilder,
          $$InvoicePaymentsTableUpdateCompanionBuilder,
          (InvoicePayment, $$InvoicePaymentsTableReferences),
          InvoicePayment,
          PrefetchHooks Function({bool invoiceId})
        > {
  $$InvoicePaymentsTableTableManager(
    _$AppDatabase db,
    $InvoicePaymentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicePaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicePaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicePaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> datePaid = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicePaymentsCompanion(
                id: id,
                invoiceId: invoiceId,
                amount: amount,
                datePaid: datePaid,
                paymentMethod: paymentMethod,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String invoiceId,
                Value<int> amount = const Value.absent(),
                required DateTime datePaid,
                Value<String> paymentMethod = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicePaymentsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                amount: amount,
                datePaid: datePaid,
                paymentMethod: paymentMethod,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoicePaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
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
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable:
                                    $$InvoicePaymentsTableReferences
                                        ._invoiceIdTable(db),
                                referencedColumn:
                                    $$InvoicePaymentsTableReferences
                                        ._invoiceIdTable(db)
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

typedef $$InvoicePaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicePaymentsTable,
      InvoicePayment,
      $$InvoicePaymentsTableFilterComposer,
      $$InvoicePaymentsTableOrderingComposer,
      $$InvoicePaymentsTableAnnotationComposer,
      $$InvoicePaymentsTableCreateCompanionBuilder,
      $$InvoicePaymentsTableUpdateCompanionBuilder,
      (InvoicePayment, $$InvoicePaymentsTableReferences),
      InvoicePayment,
      PrefetchHooks Function({bool invoiceId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> id,
      Value<String> businessName,
      Value<String> tagline,
      Value<String> logoPath,
      Value<String> adminName,
      Value<String> adminContact,
      Value<String> bankAccounts,
      Value<String> invoiceFooterNote,
      Value<String> templateTeaser,
      Value<String> templateDetail,
      Value<String> templateButlerNotification,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> id,
      Value<String> businessName,
      Value<String> tagline,
      Value<String> logoPath,
      Value<String> adminName,
      Value<String> adminContact,
      Value<String> bankAccounts,
      Value<String> invoiceFooterNote,
      Value<String> templateTeaser,
      Value<String> templateDetail,
      Value<String> templateButlerNotification,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
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

  ColumnFilters<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagline => $composableBuilder(
    column: $table.tagline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adminName => $composableBuilder(
    column: $table.adminName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adminContact => $composableBuilder(
    column: $table.adminContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankAccounts => $composableBuilder(
    column: $table.bankAccounts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceFooterNote => $composableBuilder(
    column: $table.invoiceFooterNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateTeaser => $composableBuilder(
    column: $table.templateTeaser,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateDetail => $composableBuilder(
    column: $table.templateDetail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateButlerNotification => $composableBuilder(
    column: $table.templateButlerNotification,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
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

  ColumnOrderings<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagline => $composableBuilder(
    column: $table.tagline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adminName => $composableBuilder(
    column: $table.adminName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adminContact => $composableBuilder(
    column: $table.adminContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankAccounts => $composableBuilder(
    column: $table.bankAccounts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceFooterNote => $composableBuilder(
    column: $table.invoiceFooterNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateTeaser => $composableBuilder(
    column: $table.templateTeaser,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateDetail => $composableBuilder(
    column: $table.templateDetail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateButlerNotification => $composableBuilder(
    column: $table.templateButlerNotification,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagline =>
      $composableBuilder(column: $table.tagline, builder: (column) => column);

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<String> get adminName =>
      $composableBuilder(column: $table.adminName, builder: (column) => column);

  GeneratedColumn<String> get adminContact => $composableBuilder(
    column: $table.adminContact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bankAccounts => $composableBuilder(
    column: $table.bankAccounts,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoiceFooterNote => $composableBuilder(
    column: $table.invoiceFooterNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get templateTeaser => $composableBuilder(
    column: $table.templateTeaser,
    builder: (column) => column,
  );

  GeneratedColumn<String> get templateDetail => $composableBuilder(
    column: $table.templateDetail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get templateButlerNotification => $composableBuilder(
    column: $table.templateButlerNotification,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> businessName = const Value.absent(),
                Value<String> tagline = const Value.absent(),
                Value<String> logoPath = const Value.absent(),
                Value<String> adminName = const Value.absent(),
                Value<String> adminContact = const Value.absent(),
                Value<String> bankAccounts = const Value.absent(),
                Value<String> invoiceFooterNote = const Value.absent(),
                Value<String> templateTeaser = const Value.absent(),
                Value<String> templateDetail = const Value.absent(),
                Value<String> templateButlerNotification = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                businessName: businessName,
                tagline: tagline,
                logoPath: logoPath,
                adminName: adminName,
                adminContact: adminContact,
                bankAccounts: bankAccounts,
                invoiceFooterNote: invoiceFooterNote,
                templateTeaser: templateTeaser,
                templateDetail: templateDetail,
                templateButlerNotification: templateButlerNotification,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> businessName = const Value.absent(),
                Value<String> tagline = const Value.absent(),
                Value<String> logoPath = const Value.absent(),
                Value<String> adminName = const Value.absent(),
                Value<String> adminContact = const Value.absent(),
                Value<String> bankAccounts = const Value.absent(),
                Value<String> invoiceFooterNote = const Value.absent(),
                Value<String> templateTeaser = const Value.absent(),
                Value<String> templateDetail = const Value.absent(),
                Value<String> templateButlerNotification = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                businessName: businessName,
                tagline: tagline,
                logoPath: logoPath,
                adminName: adminName,
                adminContact: adminContact,
                bankAccounts: bankAccounts,
                invoiceFooterNote: invoiceFooterNote,
                templateTeaser: templateTeaser,
                templateDetail: templateDetail,
                templateButlerNotification: templateButlerNotification,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VillasTableTableManager get villas =>
      $$VillasTableTableManager(_db, _db.villas);
  $$VillaPhotosTableTableManager get villaPhotos =>
      $$VillaPhotosTableTableManager(_db, _db.villaPhotos);
  $$VillaFaqsTableTableManager get villaFaqs =>
      $$VillaFaqsTableTableManager(_db, _db.villaFaqs);
  $$BookingsTableTableManager get bookings =>
      $$BookingsTableTableManager(_db, _db.bookings);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$InvoiceItemsTableTableManager get invoiceItems =>
      $$InvoiceItemsTableTableManager(_db, _db.invoiceItems);
  $$InvoicePaymentsTableTableManager get invoicePayments =>
      $$InvoicePaymentsTableTableManager(_db, _db.invoicePayments);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
