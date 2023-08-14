import 'package:example/entities/page.dart';

abstract class IPagesRepository{
  Future<List<Page>> get pages;
}