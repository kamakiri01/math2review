filename = ARGV[0]

puts "open " + filename + "..."

is_surrounded_comment_out = 0
arr = []
f = open(filename)
f.each{|text|

is_comment_out = text.index("```")
if is_comment_out
    is_surrounded_comment_out += 1
end

has_single_dollar = text.index("$")
if has_single_dollar && (is_surrounded_comment_out%2 == 0)
    has_double_dollar = text.index("$$")
    if has_double_dollar
        is_surrounded_by_double_dollar = text.rindex("$$")
        if is_surrounded_by_double_dollar != has_double_dollar
            #translate to review format
            value = text[has_double_dollar+2..is_surrounded_by_double_dollar-1]
            result ="\n//texequation{\n"+value+"\n//}\n"
            if has_double_dollar != 0
                result = text[0..has_double_dollar-1] + result
            end
            if is_surrounded_by_double_dollar != text.length
                result = result + text[is_surrounded_by_double_dollar+2..text.length]
            end
            arr << result

        end
    else
        is_surrounded_by_single_dollar = text.rindex("$") 
        if is_surrounded_by_single_dollar != has_single_dollar
            #translate to review format
            value = text[has_single_dollar+1..is_surrounded_by_single_dollar-1]
            result ="@<m>{"+value+"}"
            if has_single_dollar != 0
                result = text[0..has_single_dollar-1] + result
            end
            if is_surrounded_by_single_dollar != text.length
                result = result + text[is_surrounded_by_single_dollar+1..text.length]
            end
            arr << result
        end
    end
else 
arr << text
end

}
f.close
open(filename, "w").puts arr.join()
