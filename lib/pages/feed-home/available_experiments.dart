import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/pages/providers/experiment_mv.dart';
import 'package:senior_project/pages/providers/request_mv.dart';
import 'package:senior_project/repo/base_client.dart';
import 'package:senior_project/widgets/cards/joinable_card.dart';
import 'package:senior_project/repo/api_client.dart';
import 'package:http/http.dart' as http;

class AvailableExperiments extends StatefulWidget {
  const AvailableExperiments({Key? key}) : super(key: key);

  @override
  State<AvailableExperiments> createState() => _AvailableExperimentsState();
}

class _AvailableExperimentsState extends State<AvailableExperiments> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    bool isShow = context.select((RequestedExperimentsMV mv) => mv.isShow);

    final model = Provider.of<ExperimentParametersMV>(context);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                height: 50.0,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(222, 222, 222, 1),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Search by email',
                          hintStyle: TextStyle(fontSize: 18),
                          border: InputBorder.none,
                        ),
                        // onEditingComplete:() {
                        //   // print(value);
                        //   _apiClient.getExperimentsByEmail(_controller.text);
                        // },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, size: 30),
                      onPressed: () async {
                        // print(_controller.text);
                        _apiClient.getExperimentsByEmail(_controller.text);
                        //  var response = await BaseClient().getExperimentsByEmail(_controller.text);
                        //  print(jsonDecode(response));
                        Provider.of<RequestedExperimentsMV>(context,
                                listen: false)
                            .changeShowStatus();
                        // widget.onSearch(_controller.text);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              // FutureBuilder(
              //     future: model.getMyCreatedexperiments(),
              //     builder: (BuildContext context,
              //         AsyncSnapshot<http.Response> snapshot) {
              //       var experiments = jsonDecode(snapshot.data!.body);
              //       return Column(
              //         children: [
              //           const SizedBox(
              //             height: 32,
              //           ),
              //           ListView.builder(
              //             physics: const NeverScrollableScrollPhysics(),
              //             shrinkWrap: true,
              //             itemCount: experiments.length,
              //             itemBuilder: (context, index) {
              //               var experiment = MyCreatedExperiments.fromJson(
              //                   experiments[index]);
              //               return ExperimentWidget(
              //                 title: experiment.experimentName,
              //                 description: experiment.description,
              //               );
              //             },
              //           )
              //         ],
              //       );
              //     }),
              isShow == true
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return const JoinableCard();
                      },
                    )
                  : const Text('No available experiments',
                      style: TextStyle(color: Colors.grey, fontSize: 18))
            ],
          ),
        ));
  }
}
