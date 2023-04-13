  ; highlights.scm

function_keyword: (function_keyword) @keyword.function

(function_definition
function_name: (identifier) @function
(end) @function)

function_name: (identifier) @function.call

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
    "enumeration"
    "events"
    endmethods: (end)
    endclass: (end)
    endproperties: (end)
    endevents: (end)
    endenum: (end)
] @keyword

(class_definition classname: (identifier) @type)
superclass: [(struct (identifier)) (identifier)] @type

(class_definition ["&"
                   "<"] @character)

"@" @character

(
(identifier) @constant.builtin
(#any-of? @constant.builtin "true" "false")
)

(
    (identifier) @constant.builtin
    (#eq? @constant.builtin "end")
)

;; Punctuations

[";" "," "." ":"] @punctuation.delimiter

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
