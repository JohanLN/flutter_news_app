import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {

  final String cardTitle;
  final IconData cardIcon;

  ProfileCard({Key key, this.cardTitle, this.cardIcon}) : super(key: key);

  @override
  _ProfileCardSTate createState() => _ProfileCardSTate();

}

class _ProfileCardSTate extends State<ProfileCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 20.0),
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Center(
          child: ListTile(
            leading: Icon(widget.cardIcon, size: 40,),
            title: Text("${widget.cardTitle}", style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }
}