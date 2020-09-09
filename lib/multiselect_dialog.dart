import 'package:flutter/material.dart';

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog(
      {Key key,
      this.items,
      this.initialSelectedValues,
      this.title,
      this.okButtonLabel,
      this.cancelButtonLabel})
      : super(key: key);

  final List<MultiSelectDialogItem<V>> items;
  final List<V> initialSelectedValues;
  final String title;
  final String okButtonLabel;
  final String cancelButtonLabel;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = List<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 50.0),
      actionsPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(4),
      content: SingleChildScrollView(
        child: ListTileTheme(
          //contentPadding: EdgeInsets.fromLTRB(4.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: FlatButton(
                  child: Text(
                    widget.cancelButtonLabel,
                    style:
                        TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _onCancelTap,
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Color(0xff006DA8),
                  child: Text(
                    widget.okButtonLabel,
                    style:
                        TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _onSubmitTap,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return Column(
      children: [
        CheckboxListTile(
          checkColor: Colors.white,
          activeColor: Colors.green,
          value: checked,
          title: Text(
            item.label,
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Color(0xff006DA8), fontSize: 28),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (checked) => _onItemCheckedChange(item.value, checked),
        ),
        Divider(
          color: Color(0xff006DA8),
        )
      ],
    );
  }
}
