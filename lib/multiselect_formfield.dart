library multiselect_formfield;

import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_dialog.dart';

class MultiSelectFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function change;
  final Function open;
  final Function close;
  final Widget leading;
  final Widget trailing;
  final String okButtonLabel;
  final String cancelButtonLabel;
  final Color fillColor;
  final InputBorder border;
  final Widget iconWidget;
  final TextStyle txtStyle;

  MultiSelectFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      dynamic initialValue,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Tap to select one or more',
      this.required = false,
      this.errorText = 'Please select one or more options',
      this.leading,
      this.dataSource,
      this.textField,
      this.valueField,
      this.change,
      this.open,
      this.close,
      this.okButtonLabel = 'OK',
      this.cancelButtonLabel = 'CANCEL',
      this.fillColor,
      this.border,
      this.trailing,
      this.txtStyle,
      this.iconWidget})
      : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<dynamic> state) {
            List<Widget> _buildSelectedOptions(state) {
              List<Widget> selectedOptions = [];

              if (state.value != null) {
                state.value.forEach((item) {
                  var existingItem = dataSource.singleWhere(
                      (itm) => itm[valueField] == item,
                      orElse: () => null);
                  selectedOptions.add(Chip(
                    label: Text(existingItem[textField],
                        overflow: TextOverflow.ellipsis),
                  ));
                });
              }

              return selectedOptions;
            }

            return InkWell(
              onTap: () async {
                List initialSelected = state.value;
                if (initialSelected == null) {
                  initialSelected = List();
                }

                final items = List<MultiSelectDialogItem<dynamic>>();
                dataSource.forEach((item) {
                  items.add(
                      MultiSelectDialogItem(item[valueField], item[textField]));
                });

                List selectedValues = await showDialog<List>(
                  context: state.context,
                  builder: (BuildContext context) {
                    return MultiSelectDialog(
                      title: titleText,
                      okButtonLabel: okButtonLabel,
                      cancelButtonLabel: cancelButtonLabel,
                      items: items,
                      initialSelectedValues: initialSelected,
                    );
                  },
                );

                if (selectedValues != null) {
                  state.didChange(selectedValues);
                  state.save();
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  filled: true,
                  errorText: state.hasError ? state.errorText : null,
                  errorMaxLines: 4,
                  fillColor: fillColor ?? Colors.white,
                  enabledBorder: border ??
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(16.0)),
                  border: border ??
                      OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(16.0)),
                ),
                isEmpty: state.value == null || state.value == '',
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    required
                        ? Padding(
                            padding: EdgeInsets.only(top: 5, right: 5),
                            child: Text(
                              ' *',
                              style: TextStyle(
                                color: Color(0xff006DA8),
                                fontSize: 17.0,
                              ),
                            ),
                          )
                        : Container(),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        titleText,
                        style: txtStyle ??
                            TextStyle(fontSize: 24.0, color: Colors.black54),
                      ),
                    )),
                    iconWidget ??
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 2.0),
                          child: Image.asset('assets/icons8-down-96.png'),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: Colors.blue,
                              )),
                        ),
                  ],
                ),
              ),
            );
          },
        );
}
