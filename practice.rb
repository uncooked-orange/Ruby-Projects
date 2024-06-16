x = [17,3,6,9,15,8,6,1,10]

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
def cypher(string,x)
    after = string.split("")
    after.map{
        |letter|
        if (letter >= 'a' && letter <= 'z' || letter >= 'A' && letter <= 'Z')
            x.times do
                letter == " " ? break :
                letter == 'z' ? letter["z"] = 'a' : letter.next!
            end
        end
        }
    return after.join("")
end

def substring(string,dict)
    hashtable = Hash.new(0)
    dict.each do
        |word|
        if string.include?(word)  
            hashtable[word] += 1  
        end
    end
    hashtable
end

def stockpicker(x)
    y = x
    buy = 0
    sell = 0
    max_profit = 0
    x.each_with_index do |buy_day,buy_index|
        y.each_with_index do |sell_day,sell_index|
            if  (sell_day - buy_day >= max_profit && sell_index > buy_index)
                buy = buy_index
                sell = sell_index
                max_profit = sell_day - buy_day
            end
        end
    end
    array = [buy, sell,max_profit]
end 

def bubblesort(x)
    for i in 0..x.length
        for j in i+1...x.length
            if x[i] > x[j]
                x[i],x[j] = x[j],x[i]
            end
        end
    end
    return x
end
puts x