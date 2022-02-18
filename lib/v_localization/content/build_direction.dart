import 'package:appclientes/packages/address_card/address_card.dart';
import 'package:appclientes/shared/common.dart';
import 'package:flutter/material.dart';

class BuildDirection extends StatelessWidget {
  final AddressModel address;
  final int index;
  final AddressModel selected;
  final Function(AddressModel) onPress;
  final Function(AddressModel) onDelete;
  final Function(AddressModel) onLongPress;

  const BuildDirection({
    Key key,
    this.address,
    this.index,
    this.selected,
    this.onPress,
    this.onDelete,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(address),
      onLongPress: () => onLongPress(address),
      child: Container(
        margin: EdgeInset.vertical(5.0),
        child: EdgeInset.appDecoration(
          radius: BorderRadius.circular(8),
          border: Border.all(
              width: 1,
              color: address.code == (selected?.code ?? '')
                  ? AppColors.yellow
                  : AppColors.graySoft1),
          vertical: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.gray,
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.66,
                        child: Texts.blackBold(address?.name ?? "Mi Casa", maxLines: 2,fontSize: 15, overflow: TextOverflow.ellipsis,),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.67,
                        ),
                        child: Texts.black(address?.shortAddress ?? "",
                            fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              XButton(
                onDelete: onDelete,
                model: address,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
