module DateHelpers
  class ReverseWordsToDatetime
    def initialize(date_words)
      @date_words = date_words
    end

    def call
      return nil if date_words.nil?
      return DateTime.now.noon if date_words == 'Today'
      return DateTime.now.noon - 1.day if date_words == 'Yesterday'

      DateTime.now.noon - number.send(period)
    end

    private

    attr_reader :date_words

    def number
      date_words.split(' ')[0].to_i
    end

    def period
      date_words.split(' ')[1].to_sym
    end
  end
end
