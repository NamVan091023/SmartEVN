import 'package:flutter/material.dart';

// import 'package:pollution_environment/src/commons/constants.dart';
// // import 'package:pollution_environment/src/model/all_polltion.dart';
// // import 'package:pollution_environment/src/model/report_response.dart';
// // import 'package:pollution_environment/src/screen/filter/filter_all_screen.dart';

class ManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Quản lý',
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Thống kê'),
                Tab(text: 'Quản lý'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // buildSingleChildScrollView(context),
              Scaffold(
                body: Center(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 100,
                      );
                    },
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  heroTag: "manage",
                  backgroundColor: Colors.green,
                  child: Icon(Icons.filter_alt_outlined),
                  onPressed: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(
                    //         builder: (context) => FilterAllScreen(listAll)))
                    //     .then((value) => reload(value));
                  },
                ),
              ),
              Center(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(); // _buildRow(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ManageScreen extends StatefulWidget {
//   _ManageScreenState createState() => _ManageScreenState();
// }

// class _ManageScreenState extends State<ManageScreen>
//     with AutomaticKeepAliveClientMixin<ManageScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               'Quản lý',
//             ),
//             bottom: TabBar(
//               indicatorColor: mainText,
//               tabs: [
//                 Tab(text: 'Thống kê'),
//                 Tab(text: 'Quản lý'),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               // buildSingleChildScrollView(context),
//               Scaffold(
//                 body: Center(
//                   child: ListView.builder(
//                     itemCount: listItem.length == 0
//                         ? listAll!.length
//                         : listItem.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return listItem.length == 0
//                           ? _buildRowAll(index)
//                           : _buildRow(index);
//                     },
//                   ),
//                 ),
//                 floatingActionButton: FloatingActionButton(
//                   heroTag: "manage",
//                   backgroundColor: Colors.green,
//                   child: Icon(Icons.filter_alt_outlined),
//                   onPressed: () {
//                     // Navigator.of(context)
//                     //     .push(MaterialPageRoute(
//                     //         builder: (context) => FilterAllScreen(listAll)))
//                     //     .then((value) => reload(value));
//                   },
//                 ),
//               ),
//               Center(
//                 child: ListView.builder(
//                   itemCount: list!.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return _buildRow(index);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List listItemPollution = ["Đất", "Nước", "Không khí"];
//   String? valueChoose;
//   String? valuePollution;

//   // List<ReportData>? list;
//   // List<PollutionData>? listAll;

//   Future<void> getData() async {
//     var data = null; //await PollutionNetwork().getReport();
//     setState(() {
//       list = data?.data;
//     });
//   }

//   Future<void> getDataAnalyz() async {
//     var data = null;
//     //await PollutionNetwork().getAllInforPollution();
//     setState(() {
//       listAll = data?.data;
//     });
//   }

//   @override
//   void initState() {
//     list = [];
//     listAll = [];
//     getData();
//     getDataAnalyz();
//   }

//   Widget _buildRow(int index) {
//     return Text("TODO");
//     // return Slidable(
//     //   startActionPane: ActionPane(
//     //     motion: const ScrollMotion(),
//     //     children: [SlidableDrawerActionPane()],
//     //   ),
//     //   child: Padding(
//     //     padding: const EdgeInsets.all(8.0),
//     //     child: Container(
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(10),
//     //         color: Color(0xFFF5F6F9),
//     //       ),
//     //       height: MediaQuery.of(context).size.height * 0.1,
//     //       width: double.infinity,
//     //       child: Padding(
//     //         padding: EdgeInsets.symmetric(
//     //             horizontal: MediaQuery.of(context).size.width * 0.04),
//     //         child: Row(
//     //           children: [
//     //             Image.asset(
//     //               getIconTypePollution(list[index].type),
//     //               height: MediaQuery.of(context).size.height * 0.05,
//     //             ),
//     //             SizedBox(
//     //               width: MediaQuery.of(context).size.width * 0.03,
//     //             ),
//     //             Flexible(
//     //               child: Column(
//     //                 mainAxisAlignment: MainAxisAlignment.center,
//     //                 children: [
//     //                   SizedBox(
//     //                     width: double.infinity,
//     //                     child: Text(
//     //                       list[index].address == null
//     //                           ? ""
//     //                           : list[index].address,
//     //                       style: TextStyle(color: mainText, fontSize: 17),
//     //                       maxLines: 1,
//     //                       overflow: TextOverflow.ellipsis,
//     //                       textAlign: TextAlign.left,
//     //                     ),
//     //                   ),
//     //                   SizedBox(
//     //                     height: MediaQuery.of(context).size.height * 0.01,
//     //                   ),
//     //                   SizedBox(
//     //                     width: double.infinity,
//     //                     child: Row(
//     //                       children: [
//     //                         Text(
//     //                           "Điểm tương đồng: " + list[index].like.toString(),
//     //                           style: TextStyle(color: Colors.red, fontSize: 12),
//     //                           maxLines: 1,
//     //                           textAlign: TextAlign.left,
//     //                         ),
//     //                       ],
//     //                     ),
//     //                   )
//     //                 ],
//     //               ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     //   secondaryActions: <Widget>[
//     //     IconSlideAction(
//     //       caption: 'Duyệt',
//     //       color: Colors.green,
//     //       icon: Icons.add,
//     //       onTap: () async {
//     //         showLoading();
//     //         SimpleResult data = await PollutionNetwork().removeReport();
//     //         hideLoading();
//     //         if (data.errorCode == 0) {
//     //           Fluttertoast.showToast(
//     //               msg: "Duyệt thành công",
//     //               toastLength: Toast.LENGTH_SHORT,
//     //               gravity: ToastGravity.BOTTOM,
//     //               timeInSecForIosWeb: 1,
//     //               backgroundColor: Colors.transparent,
//     //               textColor: Colors.green,
//     //               fontSize: 16.0);
//     //         } else {
//     //           Fluttertoast.showToast(
//     //               msg: data.message,
//     //               toastLength: Toast.LENGTH_SHORT,
//     //               gravity: ToastGravity.BOTTOM,
//     //               timeInSecForIosWeb: 1,
//     //               backgroundColor: Colors.transparent,
//     //               textColor: Colors.red,
//     //               fontSize: 16.0);
//     //         }
//     //       },
//     //     ),
//     //     IconSlideAction(
//     //       caption: 'Xoá',
//     //       color: Colors.red,
//     //       icon: Icons.delete,
//     //       onTap: () async {
//     //         showLoading();
//     //         SimpleResult data = await PollutionNetwork().removeReport();
//     //         hideLoading();
//     //         if (data.errorCode == 0) {
//     //           Fluttertoast.showToast(
//     //               msg: "Duyệt thành công",
//     //               toastLength: Toast.LENGTH_SHORT,
//     //               gravity: ToastGravity.BOTTOM,
//     //               timeInSecForIosWeb: 1,
//     //               backgroundColor: Colors.transparent,
//     //               textColor: Colors.green,
//     //               fontSize: 16.0);
//     //         } else {
//     //           Fluttertoast.showToast(
//     //               msg: data.message,
//     //               toastLength: Toast.LENGTH_SHORT,
//     //               gravity: ToastGravity.BOTTOM,
//     //               timeInSecForIosWeb: 1,
//     //               backgroundColor: Colors.transparent,
//     //               textColor: Colors.red,
//     //               fontSize: 16.0);
//     //         }
//     //       },
//     //     ),
//     //   ],
//     // );
//   }

//   @override
//   bool get wantKeepAlive => true;

//   Widget _buildRowAll(int index) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Color(0xFFF5F6F9),
//         ),
//         height: MediaQuery.of(context).size.height * 0.1,
//         width: double.infinity,
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.04),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.location_city,
//                 size: MediaQuery.of(context).size.height * 0.05,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.03,
//               ),
//               Flexible(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: double.infinity,
//                       child: Text(
//                         listAll![index].name!,
//                         style: TextStyle(color: mainText, fontSize: 17),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.01,
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           Text(
//                             "Số vùng nhiễm: " +
//                                 listAll![index].totalPollution.toString(),
//                             style: TextStyle(color: Colors.red, fontSize: 12),
//                             maxLines: 1,
//                             textAlign: TextAlign.left,
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: 20),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(2),
//                                 color: Colors.green),
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Text(
//                                 listAll![index].normal.toString(),
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 12),
//                                 maxLines: 1,
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: 20),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(2),
//                                 color: Colors.blue),
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Text(
//                                 listAll![index].warning.toString(),
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 12),
//                                 maxLines: 1,
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: 20),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(2),
//                                 color: Colors.pink),
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Text(
//                                 listAll![index].dangerous.toString(),
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 12),
//                                 maxLines: 1,
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Items> listItem = [];

//   reload(List<Items> values) {
//     listItem.clear();
//     listItem.addAll(values);
//     setState(() {});
//   }
// }
