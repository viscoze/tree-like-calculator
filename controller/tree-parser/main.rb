require './rdparse'

parser = RDParser.new do |g|
  g.main                'line(s)'
  g.line                'expression separator(?) comment(?)'
  g.comment             '"#" rest_of_line'
  g.rest_of_line        /.+$/
  g.separator           /;/
  g.expression          'term operation expression | term'
  g.term                'number | variable | string | brkt_expression'
  g.brkt_expression     '"(" expression ")"'
  g.number              /d+(.d+)?/
  g.operation           /[\+\-\*\/]/
  g.variable            /[a-z][a-z0-9]*/
end

content = %q{ (34 - 3) * 42 }

syntax_tree = parser.parse(:main, content)
puts RDParser.text_syntax_tree(syntax_tree)
