import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('❄️ Ice and 🔥 Fire'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Ice and Fire is a Flutter application client that explores the API of Ice and Fire. This client is your window into the world of Game Thrones. Including Characters from the universe, the houses as well as the famous literary books by George R.R Martin that inspired the famous HBO show.  ",
              textAlign: TextAlign.justify,
              softWrap: true,
              textWidthBasis: TextWidthBasis.parent,
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text('An API of Ice and Fire'),
              subtitle: Text(
                  'Data was sourced from the wonderful API of Ice and Fire'),
              trailing: IconButton(
                icon: Icon(Icons.launch_sharp),
                onPressed: () => launch('https://anapioficeandfire.com/'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text('Project Repository on Github'),
              subtitle: Text('Check out the code over at Github'),
              trailing: IconButton(
                icon: Icon(Icons.launch_sharp),
                onPressed: () => launch('https://github.com/TJMusiitwa'),
              ),
            ),
            ListTile(
              title: Text('Open Source Licenses'),
              onTap: () => showLicensePage(
                context: context,
                applicationName: 'Dart Ice and Fire',
                applicationLegalese: 'Open Source and Free to Share',
              ),
            ),
            Expanded(child: Container()),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Created by Jonathan Thomas Musiitwa',
                      style: Theme.of(context).textTheme.overline),
                  Text(
                    'Built with ❤ in Flutter ',
                    style: Theme.of(context)
                        .textTheme
                        .overline
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: kBottomNavigationBarHeight,
            )
          ],
        ),
      ),
    );
  }
}
