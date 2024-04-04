import 'package:flutter/material.dart';
import 'package:pollution_environment/new_base/commons/app_colors.dart';

class SearchFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchFieldComponent({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2.0),
        color: AppColors.whiteLight,
        borderRadius: const BorderRadius.all(Radius.circular(15.5)),
      ),
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: controller,
                textInputAction: TextInputAction.search,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                  hintText: 'Tìm kiếm…',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 13),
                ),
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                autofocus: true,
                onFieldSubmitted: (value) {
                  onSearch(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
