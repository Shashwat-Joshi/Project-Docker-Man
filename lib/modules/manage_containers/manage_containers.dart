import 'package:dockerman/data/user_data.dart';
import 'package:dockerman/helpers/unfocus.dart';
import 'package:dockerman/modules/batman_terminal/pages/batman.dart';
import 'package:dockerman/modules/extended_output_screen/extended_output.dart';
import 'package:dockerman/modules/manage_containers/services/back_end_services.dart';
import 'package:dockerman/modules/manage_containers/widgets/message_for_pull_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageContainers extends StatefulWidget {
  @override
  _ManageContainersState createState() => _ManageContainersState();
}

class _ManageContainersState extends State<ManageContainers> {
  //FormStates for Input fields
  GlobalKey<FormState> _deleteKey = GlobalKey<FormState>();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<FormState> _pullImageKey = GlobalKey<FormState>();
  GlobalKey<FormState> _createNetworkKey = GlobalKey<FormState>();
  GlobalKey<FormState> _createVolumeKey = GlobalKey<FormState>();

  // For validator
  bool isValidated;
  //FormFields
  String containerName, imageName, networkName, volumeName;
  //DecorData
  String deleteTextForNuke;

  List operations = [
    'Remove Container',
    'Clean all containers',
    'Pull Image',
    'Create Network',
    'Create Volume',
    'Custom Terminal',
  ];
  List description = [
    'Remove specific container ⚒',
    '☢ Nuke your docker environment ☢',
    'Download image from dockerhub/registry ☁',
    'Create personalized network 📶',
    'Create customized volume 💽',
    'May the admin be with you 👩‍💻',
  ];

  @override
  void initState() {
    super.initState();
  }

// Nuke Confirmation Widget
  showNukeConfirmation() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Color(0xFF192233),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(
            children: [
              Container(
                height: 150.0,
                width: 150.0,
                child: Image(
                  image: AssetImage("assets/nuke.png"),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    children: [
                      new TextSpan(text: 'Type '),
                      new TextSpan(
                        text: 'delete ',
                        style: new TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      new TextSpan(
                          text:
                              'to remove each and every container from your docker environment'),
                    ],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          content: Form(
            key: _deleteKey,
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              padding: EdgeInsets.all(7.0),
              height: 100.0,
              color: Colors.transparent,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Type delete here",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (String val) {
                  if (val != 'delete') {
                    return " ";
                  }
                },
                onSaved: (val) {
                  deleteTextForNuke = val;
                },
              ),
            ),
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 5.0),
              child: FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.lightBlue,
                  ),
                ),
                onPressed: () {
                  unfocus(context);
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  unfocus(context);
                  setState(() {
                    isValidated = false;
                  });
                  validator(_deleteKey);
                  if (isValidated) {
                    //TODO:
                    setState(() {
                      manageContainerOutput =
                          manageContainerOutput + ' Nuke initiated...\n';
                    });
                    var result = await nukeDockerEnvironment();
                    setState(() {
                      manageContainerOutput = manageContainerOutput + result;
                      output = output + manageContainerOutput.substring(1);
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

// Toast message
  showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  specificWidgetForEachExpansionTile(index, size) {
    switch (index) {
      // Remove Container Widget
      case 0:
        return Container(
          height: 137.0,
          width: size.width,
          color: Colors.transparent,
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Form(
                      key: _key,
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.all(7.0),
                        height: 100.0,
                        width: size.width / 1.3,
                        color: Colors.transparent,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Enter container name/ID",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (String val) {
                            if (val.isEmpty) {
                              return "Field mandatory";
                            }
                          },
                          onSaved: (val) {
                            containerName = val;
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 57.0,
                      width: size.width / 7.6,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 25.0),
                      // padding: EdgeInsets.only(right: 2.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                        ),
                        onPressed: () async {
                          unfocus(context);
                          setState(() {
                            isValidated = false;
                          });
                          //FIXME:
                          validator(_key);
                          if (isValidated == true) {
                            setState(() {
                              manageContainerOutput = manageContainerOutput +
                                  " sudo docker rm -f $containerName\n";
                            });
                            var result = await deleteContainers(containerName);
                            setState(() {
                              manageContainerOutput =
                                  manageContainerOutput + result;
                              output =
                                  output + manageContainerOutput.substring(1);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Icon(Icons.star, size: 15.0),
                    Container(
                      child: Text(" Check the running containers "),
                    ),
                    GestureDetector(
                      onTap: () async {
                        unfocus(context);
                        setState(() {
                          manageContainerOutput = manageContainerOutput +
                              " sudo docker ps --format 'table{{.Names}}\t{{.ID}}\t{{.Image}}'\n";
                        });
                        var result = await listContainers();
                        setState(() {
                          manageContainerOutput =
                              manageContainerOutput + result;
                          output = output + manageContainerOutput.substring(1);
                        });
                      },
                      child: Container(
                        child: Text(
                          "here",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        break;
      // Nuke Widget
      case 1:
        return Container(
          height: 140.0,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                width: size.width,
                child: Text(
                  "Note",
                  style: GoogleFonts.dmSans(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                width: size.width,
                child: Text(
                  "This will delete all of your containers",
                  style: GoogleFonts.dmSans(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                height: 40.0,
                width: size.width,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    unfocus(context);
                    showNukeConfirmation();
                  },
                  child: Text("Continue"),
                ),
              ),
            ],
          ),
        );
        break;
      // Pull Image Widget
      case 2:
        return Container(
          height: 137.0,
          width: size.width,
          color: Colors.transparent,
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Form(
                      key: _pullImageKey,
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.all(7.0),
                        height: 100.0,
                        width: size.width / 1.3,
                        color: Colors.transparent,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Enter image name",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (String val) {
                            if (val.isEmpty) {
                              return "Field mandatory";
                            }
                          },
                          onSaved: (val) {
                            imageName = val;
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 57.0,
                      width: size.width / 7.6,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 25.0),
                      // padding: EdgeInsets.only(right: 2.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.green,
                        child: Icon(
                          Icons.cloud_download,
                        ),
                        onPressed: () async {
                          unfocus(context);
                          setState(() {
                            isValidated = false;
                          });
                          //FIXME:
                          validator(_pullImageKey);
                          if (isValidated == true) {
                            setState(() {
                              manageContainerOutput = manageContainerOutput +
                                  ' sudo docker pull $imageName\n';
                            });
                            showMessageForPullImage(context);
                            var result = await pullImage(imageName);
                            setState(() {
                              manageContainerOutput =
                                  manageContainerOutput + result;
                              output =
                                  output + manageContainerOutput.substring(1);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Icon(Icons.star, size: 15.0),
                      Container(
                        child: Text(" Check the already downloaded images "),
                      ),
                      GestureDetector(
                        onTap: () async {
                          unfocus(context);
                          setState(() {
                            manageContainerOutput = manageContainerOutput +
                                " sudo docker images --format 'table{{.Repository}}:{{.Tag}}\t{{.Size}}'\n";
                          });
                          var result = await listImages();
                          setState(() {
                            manageContainerOutput =
                                manageContainerOutput + result;
                            output =
                                output + manageContainerOutput.substring(1);
                          });
                        },
                        child: Container(
                          child: Text(
                            "here",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      // Create Network Widget
      case 3:
        return Container(
          height: 137.0,
          width: size.width,
          color: Colors.transparent,
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Form(
                      key: _createNetworkKey,
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.all(7.0),
                        height: 100.0,
                        width: size.width / 1.3,
                        color: Colors.transparent,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Enter network name",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (String val) {
                            if (val.isEmpty) {
                              return "Field mandatory";
                            }
                          },
                          onSaved: (val) {
                            networkName = val;
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 57.0,
                      width: size.width / 7.6,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 25.0),
                      // padding: EdgeInsets.only(right: 2.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.green,
                        child: Icon(
                          Icons.network_check,
                        ),
                        onPressed: () async {
                          unfocus(context);
                          setState(() {
                            isValidated = false;
                          });
                          //FIXME:
                          validator(_createNetworkKey);
                          if (isValidated == true) {
                            setState(() {
                              manageContainerOutput = manageContainerOutput +
                                  ' sudo docker network create -d bridge $networkName\n';
                            });
                            var result = await createNetwork(networkName);
                            setState(() {
                              manageContainerOutput =
                                  manageContainerOutput + result;
                              output =
                                  output + manageContainerOutput.substring(1);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Icon(Icons.star, size: 15.0),
                      Container(
                        child: Text(" To list all networks click "),
                      ),
                      GestureDetector(
                        onTap: () async {
                          unfocus(context);
                          setState(() {
                            manageContainerOutput = manageContainerOutput +
                                " sudo docker network ls\n";
                          });
                          var result = await listNetworks();
                          setState(() {
                            manageContainerOutput =
                                manageContainerOutput + result;
                            output =
                                output + manageContainerOutput.substring(1);
                          });
                        },
                        child: Container(
                          child: Text(
                            "here",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      // Create Volume Widget
      case 4:
        return Container(
          height: 160.0,
          width: size.width,
          color: Colors.transparent,
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Form(
                      key: _createVolumeKey,
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        padding: EdgeInsets.all(7.0),
                        height: 100.0,
                        width: size.width / 1.3,
                        color: Colors.transparent,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Enter volume name",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          ),
                          validator: (String val) {
                            if (val.isEmpty) {
                              return "Field mandatory";
                            }
                          },
                          onSaved: (val) {
                            volumeName = val;
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 57.0,
                      width: size.width / 7.6,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 25.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.green,
                        child: Icon(
                          Icons.storage,
                        ),
                        onPressed: () async {
                          unfocus(context);
                          setState(() {
                            isValidated = false;
                          });
                          //FIXME:
                          validator(_createVolumeKey);
                          if (isValidated == true) {
                            setState(() {
                              manageContainerOutput = manageContainerOutput +
                                  ' sudo docker volume create $volumeName\n';
                            });
                            var result = await createVolume(volumeName);
                            setState(() {
                              manageContainerOutput =
                                  manageContainerOutput + result;
                              output =
                                  output + manageContainerOutput.substring(1);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        width: size.width,
                        child: Text(
                          "Note :",
                          style: GoogleFonts.dmSans(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        width: size.width,
                        child: Text(
                          "Volume is created using default parameters",
                          style: GoogleFonts.dmSans(
                            fontSize: 15.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      // Fire Terminal Widget
      case 5:
        return Container(
          height: 160.0,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                width: size.width,
                child: Text(
                  "Note :",
                  style: GoogleFonts.dmSans(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                width: size.width,
                child: Text(
                  "This is just a gist, use the terminal to experience the true power !",
                  style: GoogleFonts.dmSans(
                    fontSize: 15.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                height: 40.0,
                width: size.width,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.lightBlue,
                  child: Text(
                    "Fire Terminal",
                  ),
                  onPressed: () {
                    unfocus(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => BatManTerminal(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(
            color: Colors.white.withOpacity(0.8),
            height: 0.4,
          ),
          preferredSize: Size.fromHeight(2.0),
        ),
        title: Text(
          "Manage Containers",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
          ),
        ),
        backgroundColor: Color(0xFF0D101E),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF0D101E),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D101E),
              Color(0xFF192233),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width,
                height: size.height / 1.64,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: operations.length,
                        itemBuilder: (context, index) => Theme(
                          data: ThemeData(
                            brightness: Brightness.dark,
                            accentColor: Colors.blue,
                          ),
                          child: ExpansionTile(
                            initiallyExpanded: index == 0 ? true : false,
                            children: [
                              specificWidgetForEachExpansionTile(index, size),
                            ],
                            title: Text(
                              operations[index],
                            ),
                            subtitle: Text(
                              description[index],
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.white),
                  ),
                ),
                height: size.height / 3.5,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ExtendedOutputScreen(
                                          manageContainerOutput,
                                          manageContainerFontSize,
                                        ),
                                      ));
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 24.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Output',
                                style: GoogleFonts.dmSans(
                                  fontSize: 16.0, color: Colors.green,
                                  // fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (manageContainerFontSize > 7) {
                                    --manageContainerFontSize;
                                  }
                                });
                              },
                            ),
                            Text(
                              manageContainerFontSize == 7
                                  ? "Min"
                                  : manageContainerFontSize == 32
                                      ? "Max"
                                      : "${manageContainerFontSize.toInt().toString()}",
                              style: GoogleFonts.dmSans(
                                fontSize: 16.0, color: Colors.green,
                                // fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  if (manageContainerFontSize < 32) {
                                    ++manageContainerFontSize;
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  manageContainerOutput = ">";
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.5,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.all(7.0),
                          width: size.width,
                          child: Text(
                            '$manageContainerOutput',
                            style: GoogleFonts.inconsolata(
                              fontSize: manageContainerFontSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  validator(GlobalKey<FormState> key) {
    if (key.currentState.validate()) {
      key.currentState.save();
      setState(() {
        isValidated = true;
      });
    } else {
      isValidated = false;
    }
  }
}
