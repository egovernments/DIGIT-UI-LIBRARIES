import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_cart.dart';
import 'package:digit_ui_components/widgets/molecules/header_molecule.dart';
import 'package:digit_ui_components/widgets/molecules/pop_up.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:flutter/material.dart';

List<Story> headerMoleculeStories() {
  return [
    Story(
      name: 'Molecule/Header',
      builder: (context) =>  CustomHeaderMolecule(
        title: 'My Custom Header',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
        leadingImageUrl: 'https://s3-alpha-sig.figma.com/img/1d0d/d20b/17bba4d1a5b09a0840e516227bbe9364?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kCzBVvYwPETCwHpSAAaIFB1MZQisvQ1avryik4YbCCH0HDVfJp1dxdl8UNPrDgf34YYKgyA~nNbNeGJ8N9eurZz3JbjCzdLdJiGnJL9ANqQgAOdZV4c9TAroinpq9RhTdTOjJg2U4f00PCM8jYTErO2WvNGAlXx~SqSBIj~SuiwYR2Xf2mozObFIDAjyW2gyDa6HbVLPkdINrnDJnm73S3HrqdL3q6DZkYEmEYd7qtZW0XJ3ywZBbXEuRnhumX6Ylf9RTzLdJqlfP5WaQDwjdxhQTNmIUjBYMqaF-SWqR31gZWISkKjK3uXdtfjAQBW2CYzMu-n~Alh9FwD3dx-SZQ__',
        trailingImageUrl: 'https://s3-alpha-sig.figma.com/img/8e44/2aa6/1629060fccf8839a367125285c3c972a?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=kCH5839dBgaKZ3NWEmhJrqcPY~ehbFLd8BP628ejUHGwS8qTkRZH2WEOGPXFhSlagNOlYfnt1MrT9VRgDm99fnKFI0reiuWv6-FABJxh14b-ek8~qbw3jrrGPp~INtJygG8o-UslIqUgyM-jm8g781gkulu8ePcmpi0yR~dj3gHaA2gFOP1R6NVHxS7vYuNyCUq8zB3ByjhvSh5BBshlOCpVHn2f6is5sqp2MpraVRBPV25Q~WWgsXJlKQHGWKB~IEKkJfvv2nxuR3akgJTIAD-mMafPMCBuMYMjpw~-p29izJ8UmGskkPw3pV80n2dRqts1GWCO5Eq3z2t2gDh~Pg__',
      ),
    ),
  ];
}
