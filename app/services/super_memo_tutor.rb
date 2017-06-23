class SuperMemoTutor
  REVIEW_FAILS_LIMIT = 3
  PERFECT_RESPONSE = :perfect
  CORRECT_RESPONSE = :corrent
  INCORRECT_RESPONSE = :incorrent

  def initialize(card, review_status)
    @card = card
    @status = review_status
  end

  def recalculate
    up_review_date unless @status == INCORRECT_RESPONSE
    update_counters
    @card.save
  end

private

  def up_review_date
    @card.efactor = efactor
    @card.interval = interval
    @card.review_date = Time.now + @card.interval.days
  end

  def update_counters
    if @status == PERFECT_RESPONSE || @status == CORRECT_RESPONSE
      @card.review_count += 1
      @card.fail_count = 0
    else
      @card.fail_count += 1
      check_fails
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
    elsif @status == CORRECT_RESPONSE && @card.fail_count <= 1
      2
    elsif @status == CORRECT_RESPONSE && @card.fail_count == 0
      3
    elsif @status == PERFECT_RESPONSE && @card.fail_count <= 1
      4
    elsif @status == PERFECT_RESPONSE && @card.fail_count == 0
      5
    end
  end
end
