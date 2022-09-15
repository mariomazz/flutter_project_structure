/* import 'package:flutter/foundation.dart';
import '../common/models/communications_list.dart';
import '../http/http_service.dart';

class CommunicationsProvider extends ChangeNotifier {
  static const int _itemsPerPage = 10;
  static const int _initialPage = 1;
  int _communicationsReadPageNumber = _initialPage;
  int _communicationsNotReadPageNumber = _initialPage;

  CommunicationsList? _communicationsRead;
  CommunicationsList? _communicationsNotRead;
  CommunicationsList? _communicationsSearch;

  CommunicationsList? get communicationsRead => _communicationsRead;
  CommunicationsList? get communicationsNotRead => _communicationsNotRead;
  CommunicationsList? get communicationsSearch => _communicationsSearch;

  bool get viewLoading => _isLoading && viewPaginationLoading == false;

  bool get viewPaginationLoading => _onPagination;

  bool get _isLoading =>
      communicationsRead == null ||
      communicationsNotRead == null ||
      _fetchingAPI;

  bool _fetchingApi = false;
  bool _onPagination = false;

  bool get _fetchingAPI => _fetchingApi;

  bool _terminateCommunicationReadPagination = false;
  bool _terminateCommunicationNotReadPagination = false;

  Future<void> refreshCommunicationsNotRead() async {
    _communicationsNotRead = null;
    resetCommunicationsNotReadPagination();
    await _fetchCommunicationsNotRead();
  }

  Future<void> initialize() async {
    reset();
    await _fetchCommunicationsRead();
    await _fetchCommunicationsNotRead();
  }

  void reset() {
    _communicationsRead = null;
    _communicationsNotRead = null;
    _communicationsSearch = null;
    resetCommunicationsReadPagination();
    resetCommunicationsNotReadPagination();
  }

  void _setCommunicationsRead(CommunicationsList? comunicationsRead) {
    _communicationsRead = comunicationsRead;
    return notifyListeners();
  }

  void _setCommunicationsNotRead(CommunicationsList? comunicationsNotRead) {
    _communicationsNotRead = comunicationsNotRead;
    return notifyListeners();
  }

  void _setFetchingApi(bool fetchingApi) {
    _fetchingApi = fetchingApi;
    notifyListeners();
  }

  void _setCommunicationsSearch(CommunicationsList? comunicationsSearch) {
    _communicationsSearch = comunicationsSearch;
    notifyListeners();
  }

  void resetCommunicationsReadPagination() {
    _communicationsReadPageNumber = _initialPage;
    _terminateCommunicationReadPagination = false;
  }

  void resetCommunicationsNotReadPagination() {
    _communicationsNotReadPageNumber = _initialPage;
    _terminateCommunicationNotReadPagination = false;
  }

  void resetCommunicationsSearch() {
    return _setCommunicationsSearch(null);
  }

  Future<void> fetchOtherCommunicationsRead(
      {int? categoryId, String? categoryDescription}) async {
    _onPagination = true;
    _communicationsReadPageNumber += 1;
    if (kDebugMode) {
      print("page: $_communicationsReadPageNumber");
      print("filterDescription: $categoryDescription");
    }

    await _fetchCommunicationsRead(
      categoryDescription: categoryDescription,
      activatePagination: true,
      categoryId: categoryId,
      pageNumber: _communicationsReadPageNumber,
    );
    _onPagination = false;
  }

  Future<void> fetchOtherCommunicationsNotRead() async {
    _communicationsNotReadPageNumber += 1;
    if (kDebugMode) {
      print("page: $_communicationsNotReadPageNumber");
    }

    await _fetchCommunicationsNotRead(
      activatePagination: true,
      pageNumber: _communicationsNotReadPageNumber,
    );
  }

  Future<void> searchCommunications(String value) async {
    final searchKey = value;
    if (searchKey.length >= 3) {
      final communications =
          await _fetchAPIComunications({"Subject": searchKey});
      return _setCommunicationsSearch(communications);
    } else {
      resetCommunicationsSearch();
    }
  }

  Future<void> _fetchCommunicationsRead(
      {String? categoryDescription,
      int? categoryId,
      bool activatePagination = false,
      int pageNumber = _initialPage}) async {
    final Map<String, dynamic> queryParameters = {
      'IsMarkedAsRead': true,
      'Ascending': false,
      'KeySelector': 'sentAt',
      'PageNumber': activatePagination ? pageNumber.toString() : _initialPage,
      'ItemsPerPage': _itemsPerPage.toString(),
    };

    if (categoryId != null) {
      queryParameters.addAll({"CategoryId": categoryId.toString()});
    }

    if (categoryDescription != null) {
      queryParameters.addAll({"CategoryDescription": categoryDescription});
    }

    if (communicationsRead != null &&
        activatePagination &&
        _terminateCommunicationReadPagination == false) {
      if (communicationsRead!.totalCount == communicationsRead!.items.length) {
        _terminateCommunicationReadPagination = true;
        return;
      }

      final data = await _fetchAPIComunications(queryParameters);

      return _setCommunicationsRead(
        CommunicationsList(
          totalCount: communicationsRead!.totalCount,
          items: [...communicationsRead!.items, ...data.items],
        ),
      );
    } else if (activatePagination && _terminateCommunicationReadPagination) {
      return;
    }

    final data = await _fetchAPIComunications(queryParameters);
    return _setCommunicationsRead(data);
  }

  Future<void> _fetchCommunicationsNotRead(
      {bool activatePagination = false, int pageNumber = _initialPage}) async {
    final queryParameters = {
      'IsMarkedAsRead': false,
      'Ascending': false,
      'KeySelector': 'sentAt',
      'PageNumber': activatePagination ? pageNumber.toString() : _initialPage,
      'ItemsPerPage': _itemsPerPage.toString(),
    };

    if (communicationsNotRead != null &&
        activatePagination &&
        _terminateCommunicationNotReadPagination == false) {
      if (communicationsNotRead!.totalCount ==
          communicationsNotRead!.items.length) {
        _terminateCommunicationNotReadPagination = true;
        return;
      }

      final data = await _fetchAPIComunications(queryParameters);
      return _setCommunicationsNotRead(
        CommunicationsList(
          totalCount: communicationsNotRead!.totalCount,
          items: [...communicationsNotRead!.items, ...data.items],
        ),
      );
    } else if (activatePagination && _terminateCommunicationNotReadPagination) {
      return;
    }

    final data = await _fetchAPIComunications(queryParameters);
    return _setCommunicationsNotRead(data);
  }

  Future<void> filterComunications(
      String? categoryDescription, int? categoryId) async {
    await _fetchCommunicationsRead(
        categoryDescription: categoryDescription, categoryId: categoryId);
  }

  Future<void> putMarkasread(int comunicationId) async {
    try {
      await Http().put('mobileapp/communications/$comunicationId/markasread');
      return;
    } catch (e) {
      return;
    }
  }

  Future<CommunicationsList> _fetchAPIComunications(
      Map<String, dynamic> queryParameters) async {
    _setFetchingApi(true);
    final response = await Http().get(
      'mobileapp/communications',
      queryParameters: queryParameters,
    );
    _setFetchingApi(false);

    return CommunicationsList.fromMap(response.data);
  }
}
 */