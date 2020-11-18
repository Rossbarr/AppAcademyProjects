class WordChainer
  def initialize(dictionary_file_name = "dictionary.txt")
    dict = Hash.new()
    File.foreach(dictionary_file_name) { |word| dict[word.chomp] = word.chomp.length }
    @dictionary = dict
  end

  def adjacent_words(word)
    words = @dictionary.select { |k, v| v == word.length }
    words = words.keys.select do |compare|
      diffs = 0
      compare.each_char.with_index do |c, i|
        if c != word[i]
          diffs += 1
        end
      end
      if diffs == 1
        true
      else
        false
      end
    end
    return words
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}
    @all_seen_words[source]
    while @current_words.length > 0
      self.explore_current_words
      if @all_seen_words.include?(target)
        break
      end
    end
    return self.build_path(target).reverse
  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |current_word|
      self.adjacent_words(current_word).each do |adjacent_word|
        if !@all_seen_words.include?(adjacent_word)
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
        end
      end
    end
    @current_words = new_current_words
  end

  def build_path(target)
    if !@all_seen_words.include?(target)
      puts "There is no path"
      return
    end
    path = []
    word = target
    while word != nil
      path << word
      word = @all_seen_words[word]
    end
    return path
  end
end
