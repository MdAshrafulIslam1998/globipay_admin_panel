import 'package:flutter/services.dart';
import 'alpha_numeric_filter.dart';
import 'beneficiary_nickname_formatter.dart';
import 'name_input_formatter.dart';
import 'no_leading_space_formatter.dart';
import 'no_special_character_filter.dart';
import 'only_english_formatter.dart';
import 'only_number.dart';

/**
 * Created by Abdullah on 20/2/24.
 */

abstract class InputFilter {
  static List<TextInputFormatter> AMOUNT_INPUT_FILTER = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'^(?![0.])\d*\.?\d{0,2}'))
  ];


  static List<TextInputFormatter> REMARKS_INPUT_FORMATTER =
      <TextInputFormatter>[
    NoLeadingSpaceFormatter(),
    NoSpecialCharacterFormatter()
  ];

  static List<TextInputFormatter> BENEFICIARY_INPUT_FORMATTER =
      <TextInputFormatter>[
    NoLeadingSpaceFormatter(),
    BeneficiaryNicknameFormatter()
  ];

  static List<TextInputFormatter> NAME_FORMATTER = <TextInputFormatter>[
    NoLeadingSpaceFormatter(),
    NameFormatter()
  ];

  static List<TextInputFormatter> USER_ID_FORMATTER = <TextInputFormatter>[
    NoLeadingSpaceFormatter(),
    AlphaNumericFormatter()
  ];
  static List<TextInputFormatter> ONLY_NUMBER = <TextInputFormatter>[
    OnlyNumberFormatter()
  ];

  static List<TextInputFormatter> AMOUNT_INPUT_FILTER_WITH_NO_FRACTION = <TextInputFormatter>[
    OnlyNumberFormatter()
  ];

  static List<TextInputFormatter> ONLY_ENGLISH = <TextInputFormatter>[
    OnlyEnglishFormatter()
  ];
}
