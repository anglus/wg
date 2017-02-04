#!/usr/bin/env ruby

=begin
wg.rb - Word Generator (Ruby version) 1.0 - 2017/02/04

This is free software under the terms of the ISC License:
________________________________________________________________________

Copyright (c) 2017, Matthew Morris <https://github.com/anglus/>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
________________________________________________________________________
=end

require 'optparse'

#### Parse options ####

options = {count: 1, match: "RULES"}

OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options] [infile] [outfile ...]"

  opts.on("-c", "--count [COUNT]", Integer,
          "Number of output words (default is one)") do |c|
    options[:count] = c
  end

  opts.on("-m", "--match [MATCH]", String,
          "String indicating beginning of rules list") do |m|
    options[:match] = m
  end
end.parse!

#### Read input and specify output ####

input = []

=begin
Read input from the file specified by the first non-option argument
or STDIN if no filename is specified. Set output to the filename(s)
specified by any argument after the first non-option argument.
=end

if ARGV.length > 0
  infile = ARGV.shift
  input = File.readlines(infile)
else
  input = $stdin.readlines
end

if ARGV.length > 0
  outfiles = ARGV
end

#### Main logic ####

count = options[:count]
match = options[:match]
output = ""

=begin
Arguments are a string and an array of strings. If the string matches
the beginning of one of the strings in the array, the rest of the
string is split on whitespace and returned as a new array.
=end

def match_line(pattern, arr)
  arr.each do |a|
    if a.downcase.start_with?(pattern.downcase)
      new_arr = a.chomp.split.drop(1)
      return new_arr
    end
  end
end

=begin
Create N words where N is the value of "count":
Find the rules line in the input and select a random rule (e.g. "CVC").
For each character in the rule pattern, find the matching line in the
input, select a random character or character cluster, and add to the
output text. End each word with a newline character.
=end

(1..count).each do
  rules = match_line("#{match}:", input)
  rand_rule = rules.sample.split('')

  rand_rule.each do |r|
    graphemes = match_line("#{r}:", input)
    output << graphemes.sample 
  end
  output << "\n"
end

#### Write output ####

=begin
Write output to the file(s) specified above. Otherwise write to STDOUT.
=end

if outfiles
  outfiles.each do |o|
    open(o, 'a') do |f|
      f << output
	end
  end	
else
  $stdout << output
end
