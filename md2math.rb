filename = ARGV[0]

puts "open " + filename + "..."

arr = []
f = open(filename)
f.each{|text|

has_single_dollar = text.index("$")
if has_single_dollar
    has_double_dollar = text.index("$$")
    if has_double_dollar
        is_surrounded_by_double_dollar = text.rindex("$$")
        if is_surrounded_by_double_dollar != has_double_dollar
            #translate to review format
            value = text[has_double_dollar+2..is_surrounded_by_double_dollar-1]
            result ="//texequation{"+value+"//}"
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
#
#open(filename,"r+") {|f|
#  f.flock(File::LOCK_EX)
#  body = f.read
#  body = body.gsub(/(^<bbb>).*(<\/bbb>$)/) do |tmp|
##    "#{$1}hogehogehoge#{$2}"
#    "//texequation{"+ +"//}"
#  end 
#  f.rewind
#  f.puts body
#  f.truncate(f.tell)
#}
#
#
#begin
#
##読み書き両用で開く
#file = open(filename, "r+")
#
## レシピを読みます。
#while line = file.gets
#puts line
#end
#
## レシピが無かった時
#rescue Errno::ENOENT => ex
#puts "file not found."
#puts "exit..."
## puts ex.message
#
## プログラムを中断します。
#exit 1
#
## その他の例外が起こった時
#rescue => ex
#    puts ex.message
#
#ensure 
#    # レシピを閉じます。
#    file.close unless file.nil?
#end
#
