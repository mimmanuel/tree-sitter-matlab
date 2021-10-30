// @Source https://tree-sitter.github.io/tree-sitter/creating-parsers
module.exports = grammar({
  name: "matlab",

  rules: {
    // TODO Fix source_file
    source_file: $ => repeat($._statement),
    expression: $ => seq($.identifier, $._eq, choice($._value, $._math_expression), optional(';')),
    operation: $ => seq($._value, repeat(seq($._operator, $._value))),
    _statement: $ => choice($.expression, $.function_definition, $.operation),
    _value: $ => choice($._number, $.identifier),
    _math_expression: $ => seq($._value, $._operator, $._value),
    function_definition: $ => choice(seq(
      $._function_keyword,
      $.return_variable,
      optional($._whitespace),
      $._eq,
      optional($._whitespace),
      $.function_name,
      $.parameter_list,
      optional($.block),
      $._end
    ), seq(
      $._function_keyword,
      $.function_name,
      $.parameter_list,
      optional($.block),
      $._end
    )),
    return_variable: $ => $.identifier,
    function_name: $ => $.identifier,
    parameter_list: $ => seq(
      '(',
      optional(repeat(seq($.identifier, optional(',')))),
      ')'
    ),
    block: $ => seq(
      '\n',
      repeat($._statement),
      '\n'
    ),
    identifier: $ => new RegExp("[a-zA-Z_]+"),
    _operator: $ => /[*+-/%]/,
    _eq: $ => "=",
    _number: $ => /\d+/,
    _function_keyword: $ => 'function',
    _end: $ => "end",
    _whitespace: $ => ' ',
  },
});