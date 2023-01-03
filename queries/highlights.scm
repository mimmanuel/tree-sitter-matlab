  ; highlights.scm

function_keyword: (function_keyword) @keyword.function

(function_definition
function_name: (identifier) @function
(end) @function)

(parameter_list (identifier) @parameter)

[
    "if"
    "elseif"
    "else"
    "switch"
    "case"
    "otherwise"
] @conditional

(if_statement (end) @conditional)
(switch_statement (end) @conditional)

["for" "while"] @repeat
(for_statement (end) @repeat)
(while_statement (end) @repeat)

["try" "catch"] @exception
(try_statement (end) @exception)

(function_definition end: (end) @keyword)

["return" "break" "continue"] @keyword.return



;;;; Classdef
[
    "classdef"
    "properties"
    "methods"
    endmethods: (end)
    endclass: (end)
    endproperties: (end)
] @keyword

(class_definition classname: (identifier) @type)
superclass: (identifier) @type



(
(identifier) @constant.builtin
(#any-of? @constant.builtin "true" "false")
)

(
    (identifier) @constant.builtin
    (#eq? @constant.builtin "end")
)

;; Punctuations

[";" ","] @character.special
(argument_list "," @punctuation.delimiter)
(vector_definition ["," ";"] @punctuation.delimiter)
(cell_definition ["," ";"] @punctuation.delimiter)
":" @punctuation.delimiter
(parameter_list "," @punctuation.delimiter)
(return_value "," @punctuation.delimiter)

; ;; Brackets

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
] @punctuation.bracket

;; Operators
"=" @operator
(operation [ ">"
            "<"
            "=="
            "<="
            ">="
            "=<"
            "=>"
            "~="
            "*"
            ".*"
            "/"
            "\\"
            "./"
            "^"
            ".^"
            "+"] @operator)

;; boolean operator
[
    "&&"
    "||"
] @operator

;; Number
(number) @number

;; String
(string) @string
(string) @spell

;; Comment
(comment) @comment
(comment) @spell
