import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/home/events_bloc.dart';

import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final _bloc = EventsBloc();

  @override
  void initState() {
    super.initState();
    _bloc.changeStartDate(Timestamp.fromDate(DateTime.now()));
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
                  StringResources.newEventTitle,
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
                            label: Text(StringResources.newEventName),
                            prefixIcon: Icon(Icons.event_outlined),
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
                            label:
                                Text(StringResources.newEventDescription),
                            prefixIcon: Icon(Icons.description_outlined),
                          ),
                          onChanged: (value) {
                            _bloc.changeDescription(value);
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                SizeResources.buttonTextSize * 8,
                          ),
                          decoration: const InputDecoration(
                            label: Text(StringResources.newEventEntryFee),
                            prefixIcon: Icon(Icons.monetization_on_outlined),
                          ),
                          onChanged: (value) {
                            _bloc.changePoints(value);
                          },
                        ),
                        const SizedBox(
                          height: SizeResources.buttonHeight,
                        ),
                        StreamBuilder<Timestamp>(
                            stream: _bloc.startDate,
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
                                    label:
                                        Text(StringResources.newEventStartDate),
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
                        TextFormField(
                          keyboardType: TextInputType.url,
                          scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                SizeResources.buttonTextSize * 8,
                          ),
                          decoration: const InputDecoration(
                            label: Text(StringResources.newEventPlace),
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
                            _bloc.addNewEvent().then((value) => {
                                  Navigator.pop(context),
                                });
                          },
                          child: const Text(
                            StringResources.newEventSubmit,
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
