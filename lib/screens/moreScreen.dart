import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar.medium(
            centerTitle: true,
            title: const Text('❄️ Ice and 🔥 Fire'),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Text(
                    'Ice and Fire is a Flutter application client that explores the API of Ice and Fire. This client is your window into the world of Game Thrones. Including Characters from the universe, the houses as well as the famous literary books by George R.R Martin that inspired the famous HBO show.  ',
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    textWidthBasis: TextWidthBasis.parent,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text('An API of Ice and Fire'),
                    subtitle: const Text(
                        'Data was sourced from the wonderful API of Ice and Fire'),
                    trailing: IconButton(
                      icon: const Icon(Icons.launch_sharp),
                      onPressed: () =>
                          launchUrlString('https://anapioficeandfire.com/'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text('Project Repository on Github'),
                    subtitle: const Text('Check out the code over at Github'),
                    trailing: IconButton(
                      icon: const Icon(Icons.launch_sharp),
                      onPressed: () => launchUrlString(
                          'https://github.com/TJMusiitwa/DartIceandFire'),
                    ),
                  ),
                  ListTile(
                    title: const Text('Open Source Licenses'),
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
                              .overline!
                              .copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kBottomNavigationBarHeight)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
