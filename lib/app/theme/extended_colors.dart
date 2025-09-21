import 'dart:ui';

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

/// Success
const success = ExtendedColor(
  seed: Color(0xff00966d),
  value: Color(0xff00966d),
  light: ColorFamily(
    color: Color(0xff00694b),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff008560),
    onColorContainer: Color(0xfff5fff7),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff00694b),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff008560),
    onColorContainer: Color(0xfff5fff7),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff00694b),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff008560),
    onColorContainer: Color(0xfff5fff7),
  ),
  dark: ColorFamily(
    color: Color(0xff67dbad),
    onColor: Color(0xff003827),
    colorContainer: Color(0xff23a479),
    onColorContainer: Color(0xff002115),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xff67dbad),
    onColor: Color(0xff003827),
    colorContainer: Color(0xff23a479),
    onColorContainer: Color(0xff002115),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xff67dbad),
    onColor: Color(0xff003827),
    colorContainer: Color(0xff23a479),
    onColorContainer: Color(0xff002115),
  ),
);

/// Warning
const warning = ExtendedColor(
  seed: Color(0xffa9791c),
  value: Color(0xffa9791c),
  light: ColorFamily(
    color: Color(0xff7b5500),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff9a6c0c),
    onColorContainer: Color(0xfffffbff),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff7b5500),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff9a6c0c),
    onColorContainer: Color(0xfffffbff),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff7b5500),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff9a6c0c),
    onColorContainer: Color(0xfffffbff),
  ),
  dark: ColorFamily(
    color: Color(0xfff6bd5b),
    onColor: Color(0xff432c00),
    colorContainer: Color(0xffba882b),
    onColorContainer: Color(0xff251700),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xfff6bd5b),
    onColor: Color(0xff432c00),
    colorContainer: Color(0xffba882b),
    onColorContainer: Color(0xff251700),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xfff6bd5b),
    onColor: Color(0xff432c00),
    colorContainer: Color(0xffba882b),
    onColorContainer: Color(0xff251700),
  ),
);

/// Yellow
const yellow = ExtendedColor(
  seed: Color(0xfff1dd1e),
  value: Color(0xfff1dd1e),
  light: ColorFamily(
    color: Color(0xff695f00),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xfff1dd1e),
    onColorContainer: Color(0xff6a6100),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff695f00),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xfff1dd1e),
    onColorContainer: Color(0xff6a6100),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff695f00),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xfff1dd1e),
    onColorContainer: Color(0xff6a6100),
  ),
  dark: ColorFamily(
    color: Color(0xfffff8d6),
    onColor: Color(0xff363100),
    colorContainer: Color(0xfff1dd1e),
    onColorContainer: Color(0xff6a6100),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xfffff8d6),
    onColor: Color(0xff363100),
    colorContainer: Color(0xfff1dd1e),
    onColorContainer: Color(0xff6a6100),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xfffff8d6),
    onColor: Color(0xff363100),
    colorContainer: Color(0xfff1dd1e),
    onColorContainer: Color(0xff6a6100),
  ),
);

/// Yellow orange
const yellowOrange = ExtendedColor(
  seed: Color(0xfff5b426),
  value: Color(0xfff5b426),
  light: ColorFamily(
    color: Color(0xff7c5800),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xfff5b426),
    onColorContainer: Color(0xff674800),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff7c5800),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xfff5b426),
    onColorContainer: Color(0xff674800),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff7c5800),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xfff5b426),
    onColorContainer: Color(0xff674800),
  ),
  dark: ColorFamily(
    color: Color(0xffffd58d),
    onColor: Color(0xff422d00),
    colorContainer: Color(0xfff5b426),
    onColorContainer: Color(0xff674800),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xffffd58d),
    onColor: Color(0xff422d00),
    colorContainer: Color(0xfff5b426),
    onColorContainer: Color(0xff674800),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xffffd58d),
    onColor: Color(0xff422d00),
    colorContainer: Color(0xfff5b426),
    onColorContainer: Color(0xff674800),
  ),
);

/// Orange
const orange = ExtendedColor(
  seed: Color(0xfff2832a),
  value: Color(0xfff2832a),
  light: ColorFamily(
    color: Color(0xff964900),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xfff2832a),
    onColorContainer: Color(0xff5b2a00),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff964900),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xfff2832a),
    onColorContainer: Color(0xff5b2a00),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff964900),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xfff2832a),
    onColorContainer: Color(0xff5b2a00),
  ),
  dark: ColorFamily(
    color: Color(0xffffb787),
    onColor: Color(0xff502400),
    colorContainer: Color(0xfff2832a),
    onColorContainer: Color(0xff5b2a00),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xffffb787),
    onColor: Color(0xff502400),
    colorContainer: Color(0xfff2832a),
    onColorContainer: Color(0xff5b2a00),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xffffb787),
    onColor: Color(0xff502400),
    colorContainer: Color(0xfff2832a),
    onColorContainer: Color(0xff5b2a00),
  ),
);

/// Red orange
const redOrange = ExtendedColor(
  seed: Color(0xfff0522b),
  value: Color(0xfff0522b),
  light: ColorFamily(
    color: Color(0xffb02700),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xffd43f19),
    onColorContainer: Color(0xfffffbff),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xffb02700),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xffd43f19),
    onColorContainer: Color(0xfffffbff),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xffb02700),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xffd43f19),
    onColorContainer: Color(0xfffffbff),
  ),
  dark: ColorFamily(
    color: Color(0xffffb4a2),
    onColor: Color(0xff621100),
    colorContainer: Color(0xfffb5a32),
    onColorContainer: Color(0xff470a00),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xffffb4a2),
    onColor: Color(0xff621100),
    colorContainer: Color(0xfffb5a32),
    onColorContainer: Color(0xff470a00),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xffffb4a2),
    onColor: Color(0xff621100),
    colorContainer: Color(0xfffb5a32),
    onColorContainer: Color(0xff470a00),
  ),
);

/// Red
const red = ExtendedColor(
  seed: Color(0xffeb2d37),
  value: Color(0xffeb2d37),
  light: ColorFamily(
    color: Color(0xffbb001e),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xffe12531),
    onColorContainer: Color(0xfffffbff),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xffbb001e),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xffe12531),
    onColorContainer: Color(0xfffffbff),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xffbb001e),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xffe12531),
    onColorContainer: Color(0xfffffbff),
  ),
  dark: ColorFamily(
    color: Color(0xffffb3ae),
    onColor: Color(0xff68000c),
    colorContainer: Color(0xffff5353),
    onColorContainer: Color(0xff290002),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xffffb3ae),
    onColor: Color(0xff68000c),
    colorContainer: Color(0xffff5353),
    onColorContainer: Color(0xff290002),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xffffb3ae),
    onColor: Color(0xff68000c),
    colorContainer: Color(0xffff5353),
    onColorContainer: Color(0xff290002),
  ),
);

/// Red violet
const redViolet = ExtendedColor(
  seed: Color(0xff9e5ca4),
  value: Color(0xff9e5ca4),
  light: ColorFamily(
    color: Color(0xff834389),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff9e5ca4),
    onColorContainer: Color(0xfffffbff),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff834389),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff9e5ca4),
    onColorContainer: Color(0xfffffbff),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff834389),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff9e5ca4),
    onColorContainer: Color(0xfffffbff),
  ),
  dark: ColorFamily(
    color: Color(0xfff8adfb),
    onColor: Color(0xff51145a),
    colorContainer: Color(0xff9e5ca4),
    onColorContainer: Color(0xfffffbff),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xfff8adfb),
    onColor: Color(0xff51145a),
    colorContainer: Color(0xff9e5ca4),
    onColorContainer: Color(0xfffffbff),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xfff8adfb),
    onColor: Color(0xff51145a),
    colorContainer: Color(0xff9e5ca4),
    onColorContainer: Color(0xfffffbff),
  ),
);

/// Violet
const violet = ExtendedColor(
  seed: Color(0xff6f58a6),
  value: Color(0xff6f58a6),
  light: ColorFamily(
    color: Color(0xff56408c),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff6f58a6),
    onColorContainer: Color(0xffebdfff),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff56408c),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff6f58a6),
    onColorContainer: Color(0xffebdfff),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff56408c),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff6f58a6),
    onColorContainer: Color(0xffebdfff),
  ),
  dark: ColorFamily(
    color: Color(0xffd0bcff),
    onColor: Color(0xff38206c),
    colorContainer: Color(0xff6f58a6),
    onColorContainer: Color(0xffebdfff),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xffd0bcff),
    onColor: Color(0xff38206c),
    colorContainer: Color(0xff6f58a6),
    onColorContainer: Color(0xffebdfff),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xffd0bcff),
    onColor: Color(0xff38206c),
    colorContainer: Color(0xff6f58a6),
    onColorContainer: Color(0xffebdfff),
  ),
);

/// Blue violet
const blueViolet = ExtendedColor(
  seed: Color(0xff4959a6),
  value: Color(0xff4959a6),
  light: ColorFamily(
    color: Color(0xff30418c),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff4959a6),
    onColorContainer: Color(0xffd1d7ff),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff30418c),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff4959a6),
    onColorContainer: Color(0xffd1d7ff),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff30418c),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff4959a6),
    onColorContainer: Color(0xffd1d7ff),
  ),
  dark: ColorFamily(
    color: Color(0xffb9c3ff),
    onColor: Color(0xff162875),
    colorContainer: Color(0xff4959a6),
    onColorContainer: Color(0xffd1d7ff),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xffb9c3ff),
    onColor: Color(0xff162875),
    colorContainer: Color(0xff4959a6),
    onColorContainer: Color(0xffd1d7ff),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xffb9c3ff),
    onColor: Color(0xff162875),
    colorContainer: Color(0xff4959a6),
    onColorContainer: Color(0xffd1d7ff),
  ),
);

/// Blue
const blue = ExtendedColor(
  seed: Color(0xff4570b5),
  value: Color(0xff4570b5),
  light: ColorFamily(
    color: Color(0xff29579b),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff4570b5),
    onColorContainer: Color(0xfff3f5ff),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff29579b),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff4570b5),
    onColorContainer: Color(0xfff3f5ff),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff29579b),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff4570b5),
    onColorContainer: Color(0xfff3f5ff),
  ),
  dark: ColorFamily(
    color: Color(0xffaac7ff),
    onColor: Color(0xff002f65),
    colorContainer: Color(0xff4570b5),
    onColorContainer: Color(0xfff3f5ff),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xffaac7ff),
    onColor: Color(0xff002f65),
    colorContainer: Color(0xff4570b5),
    onColorContainer: Color(0xfff3f5ff),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xffaac7ff),
    onColor: Color(0xff002f65),
    colorContainer: Color(0xff4570b5),
    onColorContainer: Color(0xfff3f5ff),
  ),
);

/// Blue green
const blueGreen = ExtendedColor(
  seed: Color(0xff1aa7ae),
  value: Color(0xff1aa7ae),
  light: ColorFamily(
    color: Color(0xff00696e),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff1aa7ae),
    onColorContainer: Color(0xff003638),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff00696e),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff1aa7ae),
    onColorContainer: Color(0xff003638),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff00696e),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff1aa7ae),
    onColorContainer: Color(0xff003638),
  ),
  dark: ColorFamily(
    color: Color(0xff60d8df),
    onColor: Color(0xff003739),
    colorContainer: Color(0xff1aa7ae),
    onColorContainer: Color(0xff003638),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xff60d8df),
    onColor: Color(0xff003739),
    colorContainer: Color(0xff1aa7ae),
    onColorContainer: Color(0xff003638),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xff60d8df),
    onColor: Color(0xff003739),
    colorContainer: Color(0xff1aa7ae),
    onColorContainer: Color(0xff003638),
  ),
);

/// Green
const green = ExtendedColor(
  seed: Color(0xff4eb84c),
  value: Color(0xff4eb84c),
  light: ColorFamily(
    color: Color(0xff006e15),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff4eb84c),
    onColorContainer: Color(0xff004309),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff006e15),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff4eb84c),
    onColorContainer: Color(0xff004309),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff006e15),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff4eb84c),
    onColorContainer: Color(0xff004309),
  ),
  dark: ColorFamily(
    color: Color(0xff73de6c),
    onColor: Color(0xff003906),
    colorContainer: Color(0xff4eb84c),
    onColorContainer: Color(0xff004309),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xff73de6c),
    onColor: Color(0xff003906),
    colorContainer: Color(0xff4eb84c),
    onColorContainer: Color(0xff004309),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xff73de6c),
    onColor: Color(0xff003906),
    colorContainer: Color(0xff4eb84c),
    onColorContainer: Color(0xff004309),
  ),
);

/// Yellow green
const yellowGreen = ExtendedColor(
  seed: Color(0xff95c940),
  value: Color(0xff95c940),
  light: ColorFamily(
    color: Color(0xff456800),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff95c940),
    onColorContainer: Color(0xff355100),
  ),
  lightMediumContrast: ColorFamily(
    color: Color(0xff456800),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff95c940),
    onColorContainer: Color(0xff355100),
  ),
  lightHighContrast: ColorFamily(
    color: Color(0xff456800),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff95c940),
    onColorContainer: Color(0xff355100),
  ),
  dark: ColorFamily(
    color: Color(0xffb0e659),
    onColor: Color(0xff223600),
    colorContainer: Color(0xff95c940),
    onColorContainer: Color(0xff355100),
  ),
  darkMediumContrast: ColorFamily(
    color: Color(0xffb0e659),
    onColor: Color(0xff223600),
    colorContainer: Color(0xff95c940),
    onColorContainer: Color(0xff355100),
  ),
  darkHighContrast: ColorFamily(
    color: Color(0xffb0e659),
    onColor: Color(0xff223600),
    colorContainer: Color(0xff95c940),
    onColorContainer: Color(0xff355100),
  ),
);
