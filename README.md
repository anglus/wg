# wg - Word Generator 

## ABOUT WORD GENERATOR

Word Generator is a collection of programs in different programming languages and frameworks that takes a set of rules as input and constructs one or more random words based on those rules. It can be used to generate words for an invented language or names of people and places for science fiction or fantasy stories. Words generated in this manner will be consistent with the phonemic/orthographical rules you specify for your language. 

## USAGE

Word Generator operates on data provided by the user, either in the form of a "rules" file or entered directly from the keyboard to a command-line, graphical, or Web interface. Below is example usage for a command-line program. For more information on how to use a specific implementation, please refer to the README for that implementation. 

`wg [options] [infile] [outfile ...]

### Options

**-h**, **--help**
 
Show help message and exit.

**-c**, **--count** *count*
    
Display "count" lines of output, where "count" is a number. Default is to display one line of output.

**-m**, **--match** *match*
	  
Specify "match" as the first string (before the ":") in the "rules" line of the "rules" file. "Match" string is case insensitive. Default "match" string is "RULES" (or "rules").

### Arguments

*infile*
	    
Read input from specified "rules" file. Default is to read "rules" input from stdin.

*outfile ...*
		  
Write output to specified file(s). Default is to write output to stdout.

### Rules File

The "rules" file may be named anything, but my convention is, e.g. "asthai.rules", where "Asthai" is the name of the language. It must be a plain text file containing one line of rules or patterns, and one or more lines of graphemes corresponding to each character present in the patterns. Below is an example of an extremely simple rules file:

```
RULES: V VV VVV
V: a e i o u
```

The output generated from this file will be one or more words consisting of one to three vowels, e.g. "i", "aeu", "oa", etc. I usually place the "rules" line at the top of the file, but it may be located anywhere in the file, as long as it is on its own line. By default, `wg` will match a line that begins with "RULES:" or "rules:", but you can change this behavior using the `-m` option. For example, if your "latin.rules" rules line begins with "PATTERNS:", you can enter the following command:

```
$ wg -mPATTERNS latin.rules
```
The match string is case insensitive, so the following would work the same:

```
$ wg --match patterns latin.rules
```
For the rules, any uppercase or lowercase alphabetic character is allowable. My convention is to use uppercase letters for the rules: "V" for vowels, "C" for consonants,"F" for finals, or suffixes, "B" for blends, or multigraphs, and so on:

```
RULES: VCF CVCF VCF VBVCF
```

Note that you may specify the same pattern more than once (e.g. "VCF" above). The more often a pattern occurs in the rules line, the more likely a word of that form will appear in the output. The most important consideration is that, for each character in the rules ("V", "C", "F", and "B" above) there must be a corresponding graphemes line in the rules file:

```
V: a e i o u ai ei ou
C: p t k b d g f th h s l r m n w j
B: pp tt kk bb dd gg ss ll rr mm nn sl st sr sw sm sn pr pl tr tl kr kl br bl dr dl gr gl fr fl thr thl hr hl mr ml wr wl
F: am an as ar ara aran im in is ir ja jam jan jas jar jara jaran um ur wa wam wan was war wara waran
```
As with the rules line, you may specify a grapheme/morpheme more than once, and it will appear with more frequency in the output.

### Interactive Use

You can enter your rules at the keyboard if you do not specify an input "rules" file. Remember to type "CTRL-D" when you are finished entering your rules:

```
$ cwg
rules: vcv cvc vcvc cvcv cvcvc
v: a e i o u
c: p t c b d g f th ch s l r m n
CTRL-D
chelag
$
```
The output is the word(s) following CTRL-D, "chelag" in this example.

## HISTORY

Word Generator was inspired by Curt Snyder's "romulan.c" (a C port of Star Trek author Diane Duane's BASIC program) and Jeffrey Henning's "LangMaker". The former program was written in C and had the Rihannsu graphemes hard-coded in. The latter program was written in Visual Basic for Windows, and could generate words using rules provided by the user. I wanted a program that had the same functionality as LangMaker, but operated more like a proper Unix program.

I wrote `cwg` - the Constructed Word Generator - mostly in February and March of 2006. I wanted it to be portable to as many Unix-like systems as possible, so I originally attempted to write it in the Bourne shell. Due to various deficiencies of the Bourne shell (principally its lack of arrays) I rewrote `cwg` in the KornShell. I completed the first KornShell version on March 24, 2006. I didn't do much with it after that, as I was focusing on my studies and then my career teaching English as a Foreign Language. In 2015, while considering changing careers to programming, I created a GitHub account and uploaded `cwg`. In February of 2017, after brushing up on C++, Python, and Ruby, and learning the basic syntax of many more languages (see my <a href="https://github.com/anglus/fizzbuzz/">fizzbuzz</a> project), I returned to this project, renaming it `wg` (for Word Generator, because I felt the "Constructed" part added nothing to the name apart from distinguishing it from other word generator programs that are out there).   

## GOALS

My plan is to develop a collection of Word Generator programs/applications in a small set of commonly-used or increasingly-popular languages, Web frameworks, and application frameworks. Unlike my <a href="https://github.com/anglus/fizzbuzz/">fizzbuzz</a> project, in which I developed a collection of programs in a wide variety of programming languages and paradigms, my intention here is to explore a small set of languages in greater depth and gain practice developing larger applications. The languages and frameworks I am considering are:

- KSH
- BASH
- Ruby: Rails, Sinatra
- Python: Flask
- Java: Android, Play
- Groovy: Android
- Scala: Android, Play
- Elixir: Phoenix
- Elm

My goal is for each program to be (in descending order of priority):

	1. Correct
	2. Safe
	3. Readable 
	4. Idiomatic 

I welcome improvements to any of the programs, especially those that help me achieve the above goals. However, I am not inclined to make changes that further a lesser goal at the expense of a higher goal. I may add features to some of the programs over time (which of course would modify the meaning of "correct"), but for now I only intend to reproduce the features of `cwg`, adding Web or graphical interfaces as needed. 

## CHANGELOG

**2017-02-04**
Create repository for wg - Word Generator.
Release wg.rb 1.0.

**2015-04-11**
Release cwg.ksh 1.0.

**2006-03-24**
Complete first version of cwg.ksh.
