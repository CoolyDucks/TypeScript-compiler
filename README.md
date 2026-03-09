
# TypeScript-compiler 

Introduction

This language, TypeScript-compiler, doth serve to transform Ruby scripts into TypeScript. Its design alloweth programmers to write code in familiar Ruby syntax and execute it as TypeScript upon compilation. The language retaineth Ruby style for methods, loops, conditionals, classes, and basic modules.

# Language Features

Define methods with def which convert to TypeScript functions

Use instance variables with @ which convert to this properties

Employ puts to print to console, becoming console.log

Conditional statements if, elsif, else convert to TypeScript

Loops while and for convert appropriately

Classes and simple modules are converted with typing where possible

Arrays and hashes become typed TypeScript arrays and objects


# Limitations

Dynamic metaprogramming such as define_method or method_missing is not supported

Monkey patching and open classes are not supported fully

Duck typing requires explicit interfaces in TypeScript

Advanced dynamic features may require manual adjustments


# Writing a Script

- Create a file ending with .rb and write your Ruby code using the supported features. Example:

```Ruby
class Printer
  def print_word(word)
    puts "There an thift on The Vent"
  end
end

printer = Printer.new
printer.print_word("Furry Cat")
```
Compiling a Script

To compile the Ruby script to TypeScript, use the compiler as follows:

```shell
ruby TypeScript-compiler.rb your_script.rb your_script.ts
```

The resulting .ts file may be executed in any TypeScript environment.

- Info Command

To learn about this language, one may call:

```shell
ruby TypeScript-compiler.rb info
```
It will display a brief description of the language and its purpose.


---
