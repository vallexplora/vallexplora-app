import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vallexplora/src/blocs/home/challenges_bloc.dart';
import 'package:vallexplora/src/constants/sizes.dart';

import '../../../constants/text_strings.dart';

class NewChallengeScreen extends StatefulWidget {
  const NewChallengeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewChallengeScreenState();
}

class _NewChallengeScreenState extends State<NewChallengeScreen> {
  final _bloc = ChallengesBloc();

  @override
  void initState() {
    super.initState();
    _bloc.changeStartDate(Timestamp.fromDate(DateTime.now()));
    _bloc.changeExpiration(Timestamp.fromDate(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.close),
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
                  StringResources.newChallengeTitle,
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
                            label: Text(StringResources.newChallengeName),
                            prefixIcon: Icon(Icons.workspace_premium_outlined),
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
                                Text(StringResources.newChallengeDescription),
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
                            label: Text(StringResources.newChallengePoints),
                            prefixIcon: Icon(Icons.star_border_rounded),
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
                                        Text(StringResources.newChallengeFrom),
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
                        StreamBuilder<Timestamp>(
                            stream: _bloc.expiration,
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
                                    label: Text(StringResources.newChallengeTo),
                                    prefixIcon:
                                        Icon(Icons.sports_score_outlined),
                                    suffixIcon:
                                        Icon(Icons.calendar_month_outlined),
                                  ),
                                  onTap: () =>
                                      _bloc.selectDate(context, endMode: true),
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
                            label: Text(StringResources.newChallengePlace),
                            prefixIcon: Icon(Icons.pin_drop_outlined),
                          ),
                          onChanged: (value) {
                            _bloc.changePlace(value);
                          },
                        ),
                        const SizedBox(
                          height: SizeResources.buttonHeight,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _bloc.addNewChallenge().then((value) => {
                                  Navigator.pop(context),
                                });
                          },
                          child: const Text(
                            StringResources.signUpFormSubmit,
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
