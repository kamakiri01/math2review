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
##�ǂݏ������p�ŊJ��
#file = open(filename, "r+")
#
## ���V�s��ǂ݂܂��B
#while line = file.gets
#puts line
#end
#
## ���V�s������������
#rescue Errno::ENOENT => ex
#puts "file not found."
#puts "exit..."
## puts ex.message
#
## �v���O�����𒆒f���܂��B
#exit 1
#
## ���̑��̗�O���N��������
#rescue => ex
#    puts ex.message
#
#ensure 
#    # ���V�s����܂��B
#    file.close unless file.nil?
#end
#
