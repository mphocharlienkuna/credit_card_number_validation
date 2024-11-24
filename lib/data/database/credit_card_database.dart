import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/credit_card.dart';

/// A database provider for managing credit card data.
@immutable
class CreditCardDatabase {
  /// The name of the credit card database.
  static const _databaseName = 'credit_card.db';

  /// The version of the credit card database.
  static const _databaseVersion = 1;

  /// Creates a new [CreditCardDatabase] instance.
  ///
  /// This is a private constructor to enforce the singleton pattern.
  CreditCardDatabase._privateConstructor();

  /// The singleton instance of the [CreditCardDatabase].
  static CreditCardDatabase instance = CreditCardDatabase._privateConstructor();

  /// The database instance.
  static Database? _database;

  /// A stream controller for notifying listeners of database changes.
  final _changesController = StreamController<void>.broadcast();

  /// A stream of database changes.
  Stream<void> get changes => _changesController.stream;

  /// Gets the database instance.
  ///
  /// If the database has not been initialized, it will be opened and
  /// initialized before being returned.
  Future<Database> get database async => _database ??= await openDatabase(
        join(await getDatabasesPath(), _databaseName),
        version: _databaseVersion,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE $creditCardTable (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              cardNumber TEXT NOT NULL,
              cardType TEXT NOT NULL,
              expiredDate TEXT NOT NULL,
              cvv TEXT NOT NULL,
              cardHolder TEXT NOT NULL,
              issuingCountry TEXT NOT NULL
            )
          ''');
        },
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys =ON');
        },
      );

  /// Creates a new credit card in the database.
  ///
  /// [creditCard] The credit card to create.
  ///
  /// Throws an [Exception] if a credit card with the same card number
  /// already exists.
  Future<CreditCard> createCreditCard(CreditCard creditCard) async {
    final db = await database;

    // Check if a credit card with the same card number already exists
    final existingCard = await db.query(
      creditCardTable,
      where: 'cardNumber = ?',
      whereArgs: [creditCard.cardNumber],
    );

    if (existingCard.isNotEmpty) {
      throw Exception('Credit card with this card number already exists');
    } else {
      final id = await db.insert(creditCardTable, creditCard.toMap());
      _changesController.add(null);
      return creditCard.copyWith(id: id);
    }
  }

  /// Reads a credit card from the database by its ID.
  ///
  /// [id] The ID of the credit card to read.
  ///
  /// Returns the credit card with the given ID, or `null` if not found.
  Future<CreditCard?> readCreditCard(int id) async {
    final db = await database;
    final maps = await db.query(
      creditCardTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? CreditCard.fromMap(maps.first) : null;
  }

  /// Reads all credit cards from the database.
  ///
  /// Returns a list of all credit cards in the database.
  Future<List<CreditCard>> readAllCreditCard() async {
    final db = await database;
    final maps = await db.query(creditCardTable);
    return maps.map(CreditCard.fromMap).toList();
  }

  /// Closes the database and the stream controller.
  Future<void> close() async {
    await (await database).close();
    _changesController.close();
  }
}
