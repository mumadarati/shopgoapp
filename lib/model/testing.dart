class Testing{

  int _brandID = 0;
  List<String> _hiddenDiv = [];
  List<String> _valueGetDiv = [];
  List<String> _noActionDiv = [];

  int get brandID => _brandID;

  set brandID(int value) {
    _brandID = value;
  }

  List<String> get hiddenDiv => _hiddenDiv;

  List<String> get noActionDiv => _noActionDiv;

  set noActionDiv(List<String> value) {
    _noActionDiv = value;
  }

  List<String> get valueGetDiv => _valueGetDiv;

  set valueGetDiv(List<String> value) {
    _valueGetDiv = value;
  }

  set hiddenDiv(List<String> value) {
    _hiddenDiv = value;
  }
}