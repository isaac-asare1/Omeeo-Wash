import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class ShareToSocials extends StatefulWidget {
  const ShareToSocials({
    super.key,
    this.subject = "this is google",
    this.text = "google is a good platform for searching",
    this.urlToShare = "https://www.google.com/",
  });

  final String? subject;
  final String? text;
  final String? urlToShare;

  @override
  State<ShareToSocials> createState() => _ShareToSocialsState();
}

class _ShareToSocialsState extends State<ShareToSocials> {
  Widget buildSocialButtons() {
    return Container();
  }

  Future share(SocialMedia socialMediaPlatform) async {
    final subject = widget.subject;
    final text = widget.text;
    final urlToShare = widget.urlToShare;

    final urls = {
      SocialMedia.facebook:
          'https://www.facebook.com/sharer/sharer.php?u=$urlToShare&t=$text',
      SocialMedia.twitter:
          'https://twitter.com/intent/tweet?url=$urlToShare&text=$text',
      SocialMedia.email: 'mailto:?subject=$subject&body=$text\n\n$urlToShare',
      SocialMedia.linkedIn:
          'https://www.linkedin.com/sharing/share-offsite/?url=$urlToShare',
      SocialMedia.whatsapp: 'https://wa.me/?text=$text\n$urlToShare',
    };

    final url = urls[socialMediaPlatform]!;

    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              share(SocialMedia.facebook);
            },
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(FontAwesomeIcons.facebook, color: Colors.black),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              share(SocialMedia.twitter);
            },
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(FontAwesomeIcons.twitter, color: Colors.black),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              share(SocialMedia.linkedIn);
            },
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(FontAwesomeIcons.linkedin, color: Colors.black),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              share(SocialMedia.whatsapp);
            },
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(FontAwesomeIcons.whatsapp, color: Colors.black),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {},
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(FontAwesomeIcons.link, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

enum SocialMedia { facebook, twitter, linkedIn, url, email, whatsapp }
