# math2review

math2review is a support tool for [md2review](https://github.com/takahashim/md2review "md2review").

    this is block expression $$y = x^2 + C$$

    this is linear expression $y = x + C$

there convert to:

    this is block expression 
    //texequation{
    y = x^2 + C
    //}

    this is linear expression @<m>{y = x^2 + C}

## Usage

    $ ruby math2review file.md
    $ md2review file.md > dile.re
    $ review-pdfmaker config.yml

## Information

If use Windows console, type command before use this tool:
    $ chcp 65001

