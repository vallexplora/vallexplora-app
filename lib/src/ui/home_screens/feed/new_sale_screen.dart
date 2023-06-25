import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/constants/colors.dart';

import '../../../blocs/home/sales_bloc.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';

class NewSaleScreen extends StatefulWidget {
  const NewSaleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  final _bloc = SalesBloc();

  @override
  void initState() {
    super.initState();
    _bloc.changeExpirationDate(Timestamp.fromDate(DateTime.now()));
    _bloc.changeStackable(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast,
          ),
          child: Container(
            padding: const EdgeInsets.all(SizeResources.defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  StringResources.newSaleTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: SizeResources.buttonHeight,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: SizeResources.formHeight,
                  ),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                SizeResources.buttonTextSize * 8,
                          ),
                          decoration: const InputDecoration(
                            label: Text(StringResources.newSaleName),
                            prefixIcon: Icon(Icons.local_activity_outlined),
                          ),
                          onChanged: (value) {
                            _bloc.changeName(value);
                          },
                        ),
                        const SizedBox(
                          height: SizeResources.buttonHeight,
                        ),
                        TextFormField(
                          maxLength: 500,
                          minLines: 1,
                          maxLines: 8,
                          keyboardType: TextInputType.multiline,
                          scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                SizeResources.buttonTextSize * 8,
                          ),
                          decoration: const InputDecoration(
                            label: Text(StringResources.newSaleDescription),
                            prefixIcon: Icon(Icons.description_outlined),
                          ),
                          onChanged: (value) {
                            _bloc.changeDescription(value);
                          },
                        ),
                        const SizedBox(
                          height: SizeResources.buttonHeight,
                        ),
                        TextFormField(
                          scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                SizeResources.buttonTextSize * 8,
                          ),
                          decoration: const InputDecoration(
                            label: Text(StringResources.newSaleCompanyID),
                            prefixIcon: Icon(Icons.domain_outlined),
                          ),
                          onChanged: (value) {
                            _bloc.changeCompanyID(value);
                          },
                        ),
                        const SizedBox(
                          height: SizeResources.buttonHeight,
                        ),
                        StreamBuilder<Timestamp>(
                            stream: _bloc.expirationDate,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return TextFormField(
                                  readOnly: true,
                                  scrollPadding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        SizeResources.buttonTextSize * 8,
                                  ),
                                  decoration: const InputDecoration(
                                    label: Text(
                                        StringResources.newSaleExpirationDate),
                                    prefixIcon: Icon(Icons.timer_outlined),
                                    suffixIcon:
                                        Icon(Icons.calendar_month_outlined),
                                  ),
                                  onTap: () => _bloc.selectDate(context),
                                  controller: TextEditingController(
                                    text:
                                        "${snapshot.data!.toDate().day}/${snapshot.data!.toDate().month}/${snapshot.data!.toDate().year} ${snapshot.data!.toDate().hour}:${snapshot.data!.toDate().minute}",
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        const SizedBox(
                          height: SizeResources.buttonHeight,
                        ),
                        StreamBuilder<bool>(
                            stream: _bloc.stackable,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SwitchListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: ColorResources.twNeutral[300]!,
                                      width: 2,
                                    ),
                                  ),
                                  title: const Text(
                                    StringResources.newSaleStackable,
                                  ),
                                  secondary: Icon(
                                    Icons.add_card_outlined,
                                    color: ColorResources.mayaBlue[500],
                                  ),
                                  value: snapshot.data!,
                                  onChanged: (value) {
                                    _bloc.changeStackable(value);
                                  },
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        const SizedBox(
                          height: SizeResources.buttonHeight,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.url,
                          scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                SizeResources.buttonTextSize * 8,
                          ),
                          decoration: const InputDecoration(
                            label: Text(StringResources.newSalePlace),
                            prefixIcon: Icon(Icons.pin_drop_outlined),
                          ),
                          onChanged: (value) {
                            _bloc.changeCity(value);
                          },
                        ),
                        const SizedBox(
                          height: SizeResources.buttonHeight,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _bloc.addNewSale().then((value) => {
                                  Navigator.pop(context),
                                });
                          },
                          child: const Text(
                            StringResources.newSaleSubmit,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeResources.buttonTextSize,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
