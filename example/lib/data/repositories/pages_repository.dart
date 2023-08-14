import 'package:example/data/data_sources/i_file_data_source.dart';
import 'package:example/data/repositories/interfaces/i_pages_repository.dart';
import 'package:example/entities/page.dart';

class PagesRepository implements IPagesRepository {
  final IFileDataSource _fileDataSource;

  PagesRepository(this._fileDataSource);

  @override
  Future<List<Page>> get pages async => await _fileDataSource.pages;
}
