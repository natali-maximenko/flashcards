class SuperMemoTutor
  attr_reader :card, :status, :time
  REVIEW_FAILS_LIMIT = 3
  PERFECT_RESPONSE = :perfect
  CORRECT_RESPONSE = :corrent
  INCORRECT_RESPONSE = :incorrent

  def initialize(card:, review_status:, response_time: 0)
    raise ArgumentError, 'is not a Card object' unless card.is_a? Card
    @card = card
    raise ArgumentError, 'unknown status' unless allowed_status?(review_status)
    @status = review_status
    @time = response_time
  end

  def update_card
    update_counters
    up_review_date unless @status == INCORRECT_RESPONSE
    check_fails
    @card.save
  end

  def allowed_status?(status)
    [PERFECT_RESPONSE, CORRECT_RESPONSE, INCORRECT_RESPONSE].include?(status)
  end

  def correct_status?(status)
    [PERFECT_RESPONSE, CORRECT_RESPONSE].include?(status)
  end

private

  def up_review_date
    @card.efactor = efactor
    @card.interval = interval
    @card.review_date = Time.now + @card.interval.days
  end

  def update_counters
    if correct_status?(@status)
      @card.review_count += 1
      @card.fail_count = 0
    else
      @card.fail_count += 1
    end
  end

  def check_fails
    clean_card if @card.fail_count == REVIEW_FAILS_LIMIT
  end

  # when many fails, return card to first review state
  def clean_card
    @card.fail_count = 0
    @card.review_count = 1
    @card.set_review_date
  end

  def interval
    case @card.review_count
    when 1
      1
    when 2
      6
    else
      @card.interval * @card.efactor
    end
  end

  def efactor
    efactor_new = @card.efactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    efactor_new < 1.3 ? 1.3 : efactor_new
  end

  def quality
    if @card.fail_count == REVIEW_FAILS_LIMIT
      0
    elsif @card.fail_count < REVIEW_FAILS_LIMIT
      1
    elsif @status == CORRECT_RESPONSE && @time <= 60
      2
    elsif @status == CORRECT_RESPONSE && @time <= 30
      3
    elsif @status == PERFECT_RESPONSE && @time <= 60
      4
    elsif @status == PERFECT_RESPONSE && @card.fail_count <= 1 && @time <= 30
      5
    end
  end
end
