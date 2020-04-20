import 'package:flutter/material.dart';
import 'package:br/models/category_model.dart';

class ChipsComponent extends StatefulWidget {

  final List<CategoryType> listChips;
  final ValueChanged<CategoryType> onTapChip;

  ChipsComponent({
    @required this.listChips,
    @required this.onTapChip
  });

  @override
  _ChipsComponentState createState() => _ChipsComponentState();
}

class _ChipsComponentState extends State<ChipsComponent> {

  int _chipIndex = 0;

  void _onSelected(bool selected, int index, CategoryType name) {
    setState(() {
      _chipIndex = selected ? index : null;
    });

    widget.onTapChip(name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Categories:", textAlign: TextAlign.left),
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.listChips.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(widget.listChips[index].toString().split('.').last),
                  backgroundColor: Category.colorByName(widget.listChips[index]),
                  selected: _chipIndex == index,
                  onSelected: (selected) => _onSelected(
                      selected,
                      index,
                      widget.listChips[index]
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
