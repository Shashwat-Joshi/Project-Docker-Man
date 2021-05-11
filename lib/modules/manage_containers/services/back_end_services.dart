import 'package:dockerman/data/user_data.dart';
import 'package:http/http.dart' as http;

deleteContainers(String name) async {
  var url = "http://$ip/cgi-bin/removeContainer.py?x=$name";
  var response = await http.get(url);
  var output = "${response.body}>";
  return output;
}

listContainers() async {
  var url = "http://$ip/cgi-bin/listContainers.py";
  var response = await http.get(url);
  var output = "${response.body}>";
  return output;
}

nukeDockerEnvironment() async {
  var url = "http://$ip/cgi-bin/nuke.py";
  var response = await http.get(url);
  var output = "${response.body}>";
  return output;
}

pullImage(String imageName) async {
  var url = "http://$ip/cgi-bin/pullImage.py?x=$imageName";
  var response = await http.get(url);
  var output = "${response.body}>";
  return output;
}

listImages() async {
  var url = "http://$ip/cgi-bin/listImages.py";
  var response = await http.get(url);
  var output = "${response.body}>";
  return output;
}

createNetwork(String networkName) async {
  var url = "http://$ip/cgi-bin/createNetwork.py?x=$networkName";
  var response = await http.get(url);
  var output = "${response.body}>";
  print(output);
  return output;
}

listNetworks() async {
  var url = "http://$ip/cgi-bin/listNetworks.py";
  var response = await http.get(url);
  var output = "${response.body}>";
  return output;
}

createVolume(String volumeName) async {
  var url = "http://$ip/cgi-bin/createVolume.py?x=$volumeName";
  var response = await http.get(url);
  var output = "${response.body}>";
  print(output);
  return output;
}
