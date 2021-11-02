module.exports = grammar({
  name: 'matlab',

  rules: {
    source_file: ($) =>
      repeat(choice($.expression, $.function_definition, $.function_call)),

    // TODO Add function call

    function_definition: ($) =>
      prec.right(
        seq(
          $._function_keyword,
          optional(seq($.return_value, $._eq)),
          $.function_name,
          $.parameter_list,
          optional($.block)
        )
      ),

    operation: ($) => prec.right(1, seq($.factor, $._operator, $.factor)),
    expression: ($) =>
      prec(
        2,
        seq(
          $.identifier,
          $._eq,
          choice($.operation, $.factor, $.vector_definition),
          optional($._semi_colon)
        )
      ),

    parameter_list: ($) =>
      seq('(', repeat(seq($.identifier, optional(','))), ')'),
    argument_list: ($) => seq('(', repeat(seq($.factor, optional(','))), ')'),
    function_name: ($) => $.identifier,
    return_value: ($) => $.identifier,
    block: ($) => seq(repeat($.expression), $._end),

    identifier: ($) => /[a-zA-Z_]+/g, // TODO Check for more complex identifiers
    factor: ($) =>
      prec.right(choice($._number, $.identifier, $.operation, $.function_call)),
    function_call: ($) =>
      prec.right(
        seq($.function_name, $.argument_list, optional($._semi_colon))
      ),

    _semi_colon: ($) => ';',
    _eq: ($) => '=',
    _operator: ($) => new RegExp('[+\\-*/%\\^:]'),
    _number: ($) => /\d+/g,
    _end: ($) => 'end',
    _function_keyword: ($) => 'function',
    vector_definition: ($) =>
      seq('[', repeat(seq($.factor, optional(choice(',', ';')))), ']'),
  },
});
