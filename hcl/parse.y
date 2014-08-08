// This is the yacc input for creating the parser for HCL.

%{
package hcl

import (
	"fmt"
	"strconv"

	"github.com/hashicorp/hcl/ast"
)

%}

%union {
	b        bool
	item     ast.Node
	list     ast.ListNode
	alist    []ast.AssignmentNode
	aitem    ast.AssignmentNode
	listitem ast.Node
	nodes    []ast.Node
	num      int
	obj      ast.ObjectNode
	str      string
}

%type   <item> number
%type   <list> list
%type   <alist> objectlist
%type   <aitem> objectitem block
%type   <listitem> listitem
%type   <nodes> listitems
%type   <num> int
%type   <obj> object
%type   <str> blockId frac

%token  <b> BOOL
%token  <num> NUMBER
%token  <str> COMMA IDENTIFIER EQUAL NEWLINE STRING MINUS
%token  <str> LEFTBRACE RIGHTBRACE LEFTBRACKET RIGHTBRACKET PERIOD

%%

top:
	objectlist
	{
		hclResult = &ast.ObjectNode{
			K:    "",
			Elem: $1,
		}
	}

objectlist:
	objectitem
	{
		$$ = []ast.AssignmentNode{$1}
	}
|	objectlist objectitem
	{
		$$ = append($1, $2)
	}

object:
	LEFTBRACE objectlist RIGHTBRACE
	{
		$$ = ast.ObjectNode{Elem: $2}
	}
|	LEFTBRACE RIGHTBRACE
	{
		$$ = ast.ObjectNode{}
	}

objectitem:
	IDENTIFIER EQUAL number
	{
		$$ = ast.AssignmentNode{
			K:     $1,
			Value: $3,
		}
	}
|	IDENTIFIER EQUAL BOOL
	{
		$$ = ast.AssignmentNode{
			K:     $1,
			Value: ast.LiteralNode{
				Type:  ast.ValueTypeBool,
				Value: $3,
			},
		}
	}
|	IDENTIFIER EQUAL STRING
	{
		$$ = ast.AssignmentNode{
			K:     $1,
			Value: ast.LiteralNode{
				Type:  ast.ValueTypeString,
				Value: $3,
			},
		}
	}
|	IDENTIFIER EQUAL object
	{
		$$ = ast.AssignmentNode{
			K:     $1,
			Value: $3,
		}
	}
|	IDENTIFIER EQUAL list
	{
		$$ = ast.AssignmentNode{
			K:     $1,
			Value: $3,
		}
	}
|	block
	{
		$$ = $1
	}

block:
	blockId object
	{
		$2.K = $1
		$$ = ast.AssignmentNode{
			K:     $1,
			Value: $2,
		}
	}
|	blockId block
	{
		obj := ast.ObjectNode{
			K:    $1,
			Elem: []ast.AssignmentNode{$2},
		}

		$$ = ast.AssignmentNode{
			K:     $1,
			Value: obj,
		}
	}

blockId:
	IDENTIFIER
	{
		$$ = $1
	}
|	STRING
	{
		$$ = $1
	}

list:
	LEFTBRACKET listitems RIGHTBRACKET
	{
		$$ = ast.ListNode{
			Elem: $2,
		}
	}
|	LEFTBRACKET RIGHTBRACKET
	{
		$$ = ast.ListNode{}
	}

listitems:
	listitem
	{
		$$ = []ast.Node{$1}
	}
|	listitems COMMA listitem
	{
		$$ = append($1, $3)
	}

listitem:
	number
	{
		$$ = $1
	}
|	STRING
	{
		$$ = ast.LiteralNode{
			Type:  ast.ValueTypeString,
			Value: $1,
		}
	}

number:
	int
	{
		$$ = ast.LiteralNode{
			Type:  ast.ValueTypeInt,
			Value: $1,
		}
	}
|	int frac
	{
		fs := fmt.Sprintf("%d.%s", $1, $2)
		f, err := strconv.ParseFloat(fs, 64)
		if err != nil {
			panic(err)
		}

		$$ = ast.LiteralNode{
			Type:  ast.ValueTypeFloat,
			Value: f,
		}
	}

int:
	MINUS int
	{
		$$ = $2 * -1
	}
|	NUMBER
	{
		$$ = $1
	}

frac:
	PERIOD NUMBER
	{
		$$ = strconv.FormatInt(int64($2), 10)
	}

%%